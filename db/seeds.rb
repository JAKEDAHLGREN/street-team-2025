# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear existing data (use with caution in production)
puts 'Clearing existing data...'
User.destroy_all
puts 'Data cleared.'

# Seed Users
puts 'Creating users...'
users = [
  { first_name: 'Casey', last_name: 'Dahlgren', email: 'auggiedahlgren@gmail.com', password: '123456', role: :admin },
  { first_name: 'Jake', last_name: 'Dahlgren', email: 'jake.dahlgrendev@gmail.com', password: '123456', role: :admin },
  { first_name: 'Jim', last_name: 'Murray', email: 'moresun26@gmail.com', password: '123456', role: :user },
  { first_name: 'Wyatt', last_name: 'King', email: 'wnk0722@gmail.com', password: '123456', role: :user },
  { first_name: 'Tori', last_name: 'Thomas', email: 'tori.thomas0430@gmail.com', password: '123456', role: :user },
  { first_name: 'Madison', last_name: 'Warner', email: 'mpwarner94@gmail.com', password: '123456', role: :user },
  { first_name: 'Justin', last_name: 'Videen', email: 'videenjustin@gmail.com', password: '123456', role: :user }
]
users.each do |user|
  User.create!(user)
end
puts 'Users created.'
