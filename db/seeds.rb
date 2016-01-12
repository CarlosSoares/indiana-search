# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c = Company.create(name: "Awesome Company")
User.create(email: "admin@example.com", password: "adminadmin", password_confirmation: "adminadmin", company_id: c.id)
