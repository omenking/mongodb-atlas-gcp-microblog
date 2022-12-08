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



users = []

user = User.new
user.uuid = SecureRandom.uuid
user.display_name = 'Andrew Brown'
user.handle = 'andrewbrown'
user.email = 'andrew@exampro.co'
user.url = 'https://www.exampro.co'
user.save!

100.times.each do |i|
  name = Faker::Name.name.truncate(24)
  email = Faker::Internet.email(name: name, separators: '+')
  handle = Faker::Internet.username(specifier: name, separators: %w(_ -))
  url = Faker::Internet.url(host: 'example.com')

  user = User.new
  user.uuid = SecureRandom.uuid
  user.display_name = name
  user.handle = handle
  user.email = email
  user.url = url
  user.save!
  users.push user
end

users.each do |user|
  rand(0...20).times.each do 
    message = Faker::Lorem.sentence(word_count: 50)
    truncate_size = rand(20..480)
    truncated_message = message.truncate(truncate_size)



    crud = Crud.new(
      uuid: SecureRandom.uuid,
      display_name: user.display_name,
      handle: user.handle,
      user_uuid: user.uuid,
      posted_at: rand(5.days.ago..Time.now),
      message: truncated_message
    )
    crud.save!
  end
end