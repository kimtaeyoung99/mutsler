require 'csv'    

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 관리자 계정의 생성 및 역할지정(관리자가 생성된 후 보안상의 이유로 비밀번호는 반드시 다른 것으로 변경하기 바람.)

admin_user = User.create( nickname: "관리자", email: 'admin@email.com', password: '12345678', weight: 70, height: 180 , is_female: false,  )
admin_user.add_role :admin

#admin_user = User.create( name: "관리자", email: 'admin@email.com', password: '12345678', confirmed_at: Time.now )
#admin_user.add_role :admin
#after_create :set_default_role, if: Proc.new { User.count > 1 }

#vedio seed
csv_text = File.read('vedios.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
Video.create!(row.to_hash)
end


#food seed

csv_text = File.read('food.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
Food.create!(row.to_hash)
end

#csv_text = File.read('vedios.csv')
#csv = CSV.parse(csv_text, :headers => true)
#csv.each do |row|
#  Video.create!(row.to_hash)
#end
