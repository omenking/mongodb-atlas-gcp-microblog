require "ostruct"

class CreateActivity
  def self.run message:, user_handle:
    model = OpenStruct.new(errors: [], data: nil)

    model.errors = ['user_handle_blank'] if user_handle.nil? || user_handle.strip == ''
    
    puts "USER_HANDLE: #{user_handle}"
    puts "MESSAGE: #{message}"
    if message.nil? || message.strip == ''
      model.errors = ['message_blank'] 
    else
      message.size > 280
      model.errors = ['message_exceed_max_chars'] 
    end

    if model.errors.any?
      # return what we provided
      model.data = {
        handle:  user_handle,
        message: message
      }   
    else
      # return the committed payload
      model.data = {
        handle:  user_handle,
        message: message,
        created_at: Time.now
      }   
    end
    return model
  end
end