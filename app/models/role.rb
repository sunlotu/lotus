class Role < ApplicationRecord
  has_many :role_ships
  has_many :users, through: :role_ships
end
