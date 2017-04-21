class Role < ApplicationRecord
  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name

  has_many :role_ships
  has_many :users, through: :role_ships
end
