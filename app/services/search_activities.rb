require "ostruct"

class SearchActivities
  def self.run search_term:
    model = OpenStruct.new(errors: [], data: nil)

    if search_term.nil? || search_term.strip == ''
      model.errors = ['search_term_blank']
    else
      #results = [{
      #  handle:  'Andrew Brown',
      #  message: 'Cloud is fun!',
      #  created_at: Time.now.iso8601
      #}]
      search = search_term
      r = Mongo::Database.search_document Mongo::Database.db[:activities], search 
      model.data = r
    end    
    return model
  end
end