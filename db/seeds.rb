# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users_list = [
	{ name: 'Jon' },
	{ name: 'Jack' },
	{ name: 'Bill' },
	{ name: 'Alex' },
	{ name: 'Andreu' },
	{ name: 'Slavik' },
	{ name: 'Oleg' },
	{ name: 'Den' },
	{ name: 'Dima' },
	{ name: 'Vasia' }]

teems_list = [
	{ name: 'Msterbandb' },
	{ name: 'Raiz' }]

users_list.each do |user|
	user = User.create(user)
	Score.create({object_id: user.id, balans: 1000, type_object: 'user'})
end

teems_list.each do |teem|
	teem = Teem.create(teem)
	Score.create({object_id: teem.id, balans: 1000, type_object: 'teem'})
end

%w[1 2 3 4 5].each do |id|
	TeemUser.create({ user_id: id, teem_id: 1})
end

%w[6 7 8 9 10].each do |id|
	TeemUser.create({ user_id: id, teem_id: 1})
end
