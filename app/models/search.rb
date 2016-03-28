# Search ActiveRecord
class Search < ActiveRecord::Base
  belongs_to :consumer

  def self.to_graph(consumer)
    sql = consumer.searches.select('to_char(created_at, \'YYYY-MM-DD\'), count(created_at), consumer_id')
                     .where(consumer_id: consumer.id)
                     .where('created_at > ?', Date.today.at_beginning_of_month)
                     .group('to_char(created_at, \'YYYY-MM-DD\'), consumer_id').to_sql
   ActiveRecord::Base.connection.select_all(sql).rows
  end
end
