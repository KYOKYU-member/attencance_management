# Company.create!(
#   name: "KYOKYU",
#   email: "kyokyu@test.com", 
#   address: "東京都渋谷区",
#   phone_number: 0311112222,
#   password: "111111",
# )

User.create!(
  name: "白松",
  name_kana: "シラマツ",
  employee_number: "k0001",
  password: "111111",
  company_id: 1
)

User.create!(
  name: "鈴木",
  name_kana: "スズキ",
  employee_number: "k0002",
  password: "111111",
  company_id: 1
)