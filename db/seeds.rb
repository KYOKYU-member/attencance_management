User.create!(
  name: "管理者",
  name_kana: "カンリシャ",
  email: "admin@test.com", 
  employee_number: "k1001",
  admin: true,
  password: "111111",
)

User.create!(
  name: "鈴木さん",
  name_kana: "スズキサン",
  email: "suzuki@test.com", 
  employee_number: "k0002",
  password: "111111",
)