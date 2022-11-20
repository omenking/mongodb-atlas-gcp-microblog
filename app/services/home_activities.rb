class HomeActivities
  def self.run
    results = [{
      handle:  'Andrew Brown',
      message: 'Cloud is fun!',
      created_at: Time.now.iso8601
    }]
    return results
  end
end