class UserActivities
  def self.run user_handle:
    results = [{
      handle:  'Andrew Brown',
      message: 'Cloud is fun!',
      created_at: Time.now
    }]
    return results
  end
end