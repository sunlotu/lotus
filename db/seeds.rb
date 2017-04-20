# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  users = User.create([{ name: 'admin', password: '123123', email: 'admin@qq.com', status: User.statuses[:online] },
  { name: 'test', password: '123123',email: 'test@qq.com', status: User.statuses[:offline] }])
  roles = Role.create([{code: 'admin', name: '管理员'}, {code: 'user', name: '普通用户'}])
  role_ship = RoleShip.create(user_id: users.first.id, role_id: roles.first.id)
