User.destroy_all
List.destroy_all
user = User.create(username: 'tater')
user.lists.create(title: 'Books to Read')
user.lists.create(title: 'Projects')
user.lists.create(title: 'Grocery List')
