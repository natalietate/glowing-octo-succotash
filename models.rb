class User < ActiveRecord::Base
  has_many :lists # one user has many lists
end

class List < ActiveRecord::Base
  belongs_to :user # each list has one only user
  has_many :items
end

class Item < ActiveRecord::Base
  belongs_to :list
end
