class ElasticSearch
  URL = "http://#{ENV['INDIANASEARCH_ELASTICSEARCH_1_PORT_9200_TCP_ADDR']}:#{ENV['INDIANASEARCH_ELASTICSEARCH_1_PORT_9200_TCP_PORT']}"


  class << self

    def search(namespace, resource_type, field, query)
      response = RestClient.post(URL + "/#{namespace}/#{resource_type}/_search", {
        "query": {
          "match": {
            "#{field}": {
              "query": query,
              "fuzziness": 5
            }
          }
        }
      }.to_json, content_type: "text/plain")

      to_response(response.body)
    rescue RestClient::Exception => ex
      {
        success: false,
        message: ex.response
      }
    end

    ##
    # Allow create a single index
    ##
    def create_index(namespace, resource_type, data = {})
      response = RestClient.post(URL + "/#{namespace}/#{resource_type}/#{data[:id]}", data.to_json, content_type: "text/plain")
      JSON.parse response.body
    rescue RestClient::BadRequest => ex
      ex
    end

    ##
    # Allow create a multiple index
    ##
    def create_multiple_index(namespace, resource_type, data = [])
      RestClient.post(URL + "/#{namespace}/#{resource_type}/_bulk", build_index(namespace, resource_type, data))
    rescue RestClient::BadRequest => ex
      ex
    end

    ##
    # Build the object for sending data to elastic cache
    ##
    def build_index(namespace, resource_type, indexex = [])
      data = []
      indexex.each do |index|
        data << "{ \"create\" : {\"_index\":\"#{namespace}\",\"_type\":\"#{resource_type}\",\"_id\":\"#{index[:id]}\"} }"
        data << index.to_json
      end
      puts data.join("\n")
      data.join("\n")
    end

    ##
    # Prepare the response from the search result
    ##
    def to_response(body)
      body = JSON.parse(body)

      # Success response
      if body["hits"].present?
        data = body["hits"]

        {
          success: true,
          total: data["total"],
          results: to_results(data["hits"])
        }
      else # Error response
        {
          success: false
        }
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
