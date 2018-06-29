user = User.new
user.email = "john.doe@example.com"
user.password = "johndoe123"
user.save!

admin = User.new
admin.email = "admin@example.com"
admin.password = "admin123"
admin.save!