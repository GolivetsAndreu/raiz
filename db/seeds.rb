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

teams_list = [
	{ name: 'Msterbandb' },
	{ name: 'Raiz' }]

users_list.each do |user|
	user = User.create(user)
	user.build_account({balance: 1000}).save
end

teams_list.each do |team|
	team = Team.create(team)
	team.build_account({balance: 1000}).save
end

%w[1 2 3 4 5].each do |id|
	TeamUser.create({user_id: id, team_id: 1})
end

%w[6 7 8 9 10].each do |id|
	TeamUser.create({user_id: id, team_id: 2})
end
