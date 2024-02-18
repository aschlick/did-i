# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

u = User.create(
  email: 'test@test.com',
  password: '123456',
  password_confirmation: '123456'
)
u.confirm

(1..10).each do |i|
  item = Item.create!(user: u, name: "test#{i}", period_type: 'weeks', period_count: 1)
  item.replacements.create!(replaced_at: (i - 1).hours.ago)
end
