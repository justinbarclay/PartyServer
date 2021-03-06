# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


admin = Admin.new(first_name: 'Justin', last_name: 'Barclay', email: 'jbarclay@ualberta.ca', password: 'password', password_confirmation: 'password')

unit1 = Unit.new(name: 'U32')
unit2 = Unit.new(name: 'D43')
unit1.save
unit2.save

part = Part.new(name: :Gasket, room: 'Mechanical Room', shelf: :A3, count: 204, units: [unit1, unit2])

# not exactly sure how party history works
part.save
admin.save

PartHistory.new(user: admin, part: part, change: 10).save
PartHistory.new(user: admin, part: part, change: -15).save
PartHistory.new(user: admin, part: part, change: 7).save
