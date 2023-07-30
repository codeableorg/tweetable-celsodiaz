puts "Start seeding"

User.destroy_all
Tweet.destroy_all
Like.destroy_all

puts "Seeding users"
admin = User.new(
  email: 'admin@mail.com',
  password: 'supersecret',
  name: 'Admin User',
  username: 'admin',
  role: 'admin'
)
puts "admin_member not created. Errors: #{admin.errors.full_messages}" unless admin.save

members = []
4.times do |n|
  user = User.new(
    email: "member#{n + 1}@mail.com",
    password: 'password',
    name: "Member User #{n + 1}",
    username: "member#{n + 1}",
    role: 'member'
  )
  puts "member not created. Errors: #{user.errors.full_messages}" unless user.save
  members << user
end

puts "Seeding tweets"
members.each do |member|
  3.times do |n|
    Tweet.create!(
      user: member,
      body: "Tweet #{n + 1} by #{member.username}"
    )
  end
end

puts "Seeding tweets replais"
members.each do |member|
  tweets = Tweet.where.not(user_id: member.id).sample(2)
  tweets.each do |tweet|
    Tweet.create!(
      user: member,
      body: "Reply to #{tweet.body}",
      replied_to_id: tweet.id
    )
  end
end

puts "Seeding likes"
members.each do |member|
  tweets = Tweet.where.not(user_id: member.id).sample(3)
  tweets.each do |tweet|
    Like.create!(
      user: member,
      tweet: tweet
    )
  end
end

puts "Ending of seeds"
