Product.create!([
  { code: "D01", name: "Doritos", sale_price: 0.75, stock_quantity: 10 },
  { code: "G90", name: "Galleta de granola", sale_price: 1.99, stock_quantity: 15 },
  { code: "P22", name: "Protein Bar", sale_price: 4.75, stock_quantity: 20 },
  { code: "N80", name: "Nuts", sale_price: 1.25, stock_quantity: 30 },
  { code: "Y66", name: "Yogurt", sale_price: 0.80, stock_quantity: 50 },
  { code: "C02", name: "Chips", sale_price: 0.50, stock_quantity: 60 },
  { code: "C03", name: "Dark chocolate", sale_price: 0.90, stock_quantity: 70 },
  { code: "C04", name: "Crackers", sale_price: 1.10, stock_quantity: 35 },
  { code: "C05", name: "Pop corn", sale_price: 2.50, stock_quantity: 40 },
  { code: "P06", name: "Pringles", sale_price: 1.35, stock_quantity: 55 },
  { code: "F07", name: "Fritos", sale_price: 0.45, stock_quantity: 10 },
  { code: "A88", name: "Animal Cookies", sale_price: 1.60, stock_quantity: 20 },
  { code: "P99", name: "Pudding", sale_price: 0.60, stock_quantity: 40 },
  { code: "S10", name: "Sardines", sale_price: 2.00, stock_quantity: 30 }
])

user = User.new
user.email = "john.doe@example.com"
user.password = "johndoe123"
user.save!

token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id, expires_in: 256.days)
puts "TOKEN: #{token.token}"

admin = User.new
admin.email = "admin@example.com"
admin.password = "admin123"
admin.save!