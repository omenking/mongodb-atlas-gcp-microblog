class HomeActivities
  def self.run
    collection = Mongo::Database.db[:activities]
    documents = collection.find({}).sort(created_at: -1).limit(100)
    results = documents.map do |document|
      document.slice(:handle,:message,:created_at)
    end
    return results
  end
end