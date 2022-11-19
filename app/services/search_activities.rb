class SearchActivities
  def self.run search_term:
    results = [{
      handle:  'Andrew Brown',
      message: 'Cloud is fun!',
      created_at: Time.now
    }]
    return results
  end
end