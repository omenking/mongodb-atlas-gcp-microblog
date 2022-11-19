require "ostruct"

class CreateActivity
  def self.run message:, user_handle:
    data = {
      handle:  user_handle,
      message: message,
      created_at: Time.now
    }   

    model = OpenStruct.new
    model.errors = []
    model.data = data

    return model
  end
end