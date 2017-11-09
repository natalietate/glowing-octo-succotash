class User < ActiveRecord::Base
  has_many :lists # one user has many lists
end

class List < ActiveRecord::Base
  belongs_to :user # each list has one only user
end
