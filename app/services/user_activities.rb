require "ostruct"

class UserActivities
  def self.run user_handle:
    model = OpenStruct.new

    if user_handle.nil? || user_handle.strip == ''
      model.errors = ['blank_user_handle']
    else
      results = [{
        handle:  'Andrew Brown',
        message: 'Cloud is fun!',
        created_at: Time.now
      }]
      model.data = results
    end    
    return model
  end
end