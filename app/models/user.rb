class User < ApplicationRecord
  # :registerable　处理用户注册过程，编辑\摧毁帐号
  # :lockable　　　失败登录尝试后锁定账户．通过电子邮件或指定时间段解锁
  # :recoverable  重置用户密码并且发送重置指令
  # :rememberable 管理产生和清楚表示来自用户保存的cookie的标记(token)
  # :trackable    追踪登录的次数　时间戳和IP地址
  # :validatable　有效性：提供的电子邮件及密码鉴定．可选可定制
  # :confirmable　注册后邮箱验证
  # :omniauthable 三方平台 OAuth 验证登录
  # :timeoutable
  ACCESSABLE_ATTRS = [:name, :email, :password, :password_confirmation, :remember_me]


  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  attr_accessor :login
  validates :name, presence: true, uniqueness: true


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where("lower(name) = :value OR lower(email) = :value", { value: login.downcase }).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end