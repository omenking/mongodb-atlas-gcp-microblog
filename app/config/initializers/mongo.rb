require 'mongo'

module Mongo
  class Database
    MONGO_ATLAS_URL = ENV['MONGO_ATLAS_URL'] # 'mongodb+srv://<user>:<pass>@<cluster>.<id>.mongodb.net/?retryWrites=true&w=majority'  
    MONGO_DATABASE = ENV['MONGO_DATABASE'] # '<database>' # database on the atlas cluster to work with
    TIMEOUT_SECONDS = 5
    class << self
      def db
        @db ||= begin
          connect()
        end
      end

      def query_collection collection
        puts collection.find( { name: 'Sally' } ).first
      end

      def insert_document collection, document
        doc = document.to_hash
        result = collection.insert_one(doc)
        return result.n 
      end
      
      def insert_documents collection, documents
        result = collection.insert_many(documents)
        return result.inserted_count
      end

      # https://www.mongodb.com/docs/atlas/atlas-search/tutorial/run-query/
      def search_document collection, document
        attrs = [{
          '$search': {
            'index': 'default',
            'text': {
              'query': document,
              'path': 'message'
            }
          }
        },{ 
          '$limit': 10 
        }]
        result = []
        collection.aggregate(attrs).each do |document|
          result.push document
        end
        return result
      end

      def destroy_document collection, document
        result = collection.delete_one( document )
        return result.deleted_count
      end
      
      private

      def connect()
        try_connect()
      end

      def try_connect()
        timeout = TIMEOUT_SECONDS
        while timeout.positive?
          begin
            return Mongo::Client.new(MONGO_ATLAS_URL, server_api: {version: "1"}, :database => MONGO_DATABASE)
          rescue StandardError => e
            timeout -= 1
            sleep(1)
            raise "Database timeout: #{e}" if timeout <= 0
          end
        end
      end

    end
  end
end
