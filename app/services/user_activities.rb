require "ostruct"

class UserActivities
  def self.run user_handle:
    model = OpenStruct.new(errors: [], data: nil)

    if user_handle.nil? || user_handle.strip == ''
      model.errors = ['blank_user_handle']
    else
      collection = Mongo::Database.db[:activities]
      documents = collection.find(handle: user_handle).sort(created_at: -1).limit(100)
      results = documents.map do |document|
        document.slice(:handle,:message,:created_at)
      end
      model.data = results
    end    
    return model
  end
end