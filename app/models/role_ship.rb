class RoleShip < ApplicationRecord
  belongs_to :role
  belongs_to :user
end
