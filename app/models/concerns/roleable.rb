module Roleable
  extend ActiveSupport::Concern

  included do
    scope :with_role, ->(role) { joins(role_ships: :role).where(roles: { code: role } ) }
  end

  def roles_name
    roles.pluck(:name)
  end

  def roles_code
    roles.pluck(:code)
  end

  def role?(role)
    roles_code.include? role.to_s
  end

  def admin?
    roles_code.include?('admin')
  end

  def common?
    roles_code.include?('user')
  end
end
