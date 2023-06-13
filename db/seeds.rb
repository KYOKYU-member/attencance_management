require 'faker/japanese'

Company.create!(
  name: "KYOKYU",
  email: "test@test.com",
  address: "東京都渋谷区渋谷#{rand(100..500)}-#{rand(1..100)}-#{rand(1..50)}",
  phone_number: 1011110000 + rand(1000..9999),
  password: "111111"
)

5.times do
  Company.create!(
    name: Faker::Name.name + "会社",
    email: Faker::Internet.email,
    address: "東京都渋谷区渋谷#{rand(100..500)}-#{rand(1..100)}-#{rand(1..50)}",
    phone_number: 1011110000 + rand(1000..9999),
    password: "111111"
  )
end

prefix = "K"
100.times do |i|
  employee_number = "#{prefix}#{(1 + i).to_s.rjust(4, '0')}"
  name = Faker::Japanese::Name.name
  User.create!(
    name: name,
    name_kana: name.yomi,
    employee_number: employee_number,
    password: "111111",
    company_id: rand(1..6)
  )
end

@users = User.all
@users.each do |user|
  TimeCard.create!(
    work_day: Date.today - 2,
    start_time: Time.current,
    end_time: (Time.current) + 8.hours,
    working_time: 480,
    break_time: 60,
    user_id: user.id
  )
end
