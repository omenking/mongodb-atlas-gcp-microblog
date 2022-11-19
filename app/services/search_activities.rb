require "ostruct"

class SearchActivities
  def self.run search_term:
    model = OpenStruct.new(errors: [], data: nil)

    if search_term.nil? || search_term.strip == ''
      model.errors = ['search_term_blank']
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