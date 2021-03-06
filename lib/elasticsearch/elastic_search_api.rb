require 'elasticsearch'

# Allows search using elasticsearch
class ElasticSearchApi
  class << self
    def client
      @client ||= Elasticsearch::Client.new(host: ENV['INDIANASEARCH_ELASTICSEARCH_1_PORT_9200_TCP_ADDR'],
                                            port: ENV['INDIANASEARCH_ELASTICSEARCH_1_PORT_9200_TCP_PORT'])
    end

    def info(namespace)
      response = ElasticSearchApi.client.indices.get_mapping(index: namespace)
      response.fetch(namespace).try(:fetch, 'mappings')
    rescue
      {}
    end

    def to_search_query(field, query)
      if field.present?
        { query: { match: { field.to_s => { query: query, operator: 'or', fuzziness: 10, type: 'phrase_prefix' } } } }
      else
        { query: { match: { _all: { query: query, fuzziness: 10, type: 'phrase_prefix' } } } }
      end
    end

    def search(namespace, resource_type, field, query)
      response = ElasticSearchApi.client.search type: namespace, index: resource_type, body: to_search_query(field, query)
      to_response(response)
    rescue StandardError => ex
      { success: false, message: ex }
    end

    ##
    # Allow create a single or mutliple indexes
    ##
    def create_index(namespace, resource_type, data)
      Rails.logger.info [namespace, resource_type, data].inspect

      if data.is_a?(Array)
        ElasticSearchApi.client.bulk body: build_index(namespace, resource_type, data)
      else
        ElasticSearchApi.client.index index: namespace, _type: resource_type , id: data['id'], body: data
      end
    rescue StandardError => ex
      byebug

      ex
    end

    ##
    # Build the object for sending data to elastic cache
    ##
    def build_index(namespace, resource_type, indexex = [])
      data = []
      indexex.each do |index|
        data << { create: { _index: namespace, _type: resource_type, _id: index[:id] } }
        data << index
      end
      data
    end

    ##
    # Prepare the response from the search result
    ##
    def to_response(body)

      # Success response
      if body['hits'].present?
        data = body['hits']
        { success: true, total: data['total'], results: to_results(data['hits']) }
      else # Error response
        { success: false }
      end
    end

    def to_results(results)
      (results || []).map do |result|
        {
          id: result['_id']
        }.merge(result['_source']).symbolize_keys
      end
    end
  end
end
