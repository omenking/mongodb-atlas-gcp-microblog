require "ostruct"

class CreateActivity
  def self.run message:, user_handle:
    model = OpenStruct.new(errors: [], data: nil)

    model.errors = ['user_handle_blank'] if user_handle.nil? || user_handle.strip == ''
    
    if message.nil? || message.strip == ''
      model.errors = ['message_blank'] 
    elsif message.size > 280
      model.errors = ['message_exceed_max_chars'] 
    end

    model.data = {
      handle:  user_handle,
      message: message,
      created_at: Time.now.iso8601
    }   
    response = Mongo::Database.insert_document Mongo::Database.db[:activities], model.data

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
        created_at: Time.now.iso8601,
        records_created: response
      }
    end
    return model
  end
end