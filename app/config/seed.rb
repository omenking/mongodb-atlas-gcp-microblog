require_relative 'initializers/mongo'

def random_message length
  length.times.map { (0...(rand(10))).map { ('a'..'z').to_a[rand(26)] }.join }.join(" ")
end

def random_handle
  ['andrewbrown', 'andrewbayko', 'cindyle', 'peterle', 'samjose'].sample
end

def random_document
  {
    handle: random_handle,
    message: random_message(rand(10)),
    created_at: Time.now.iso8601
  }
end

payload = []
100.times { payload.push random_document }

result = Mongo::Database.insert_documents Mongo::Database.db[:activities], payload

puts "inserted #{result} documents"