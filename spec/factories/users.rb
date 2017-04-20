FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "nm#{n}"}
    sequence(:login) {|n| "lg#{n}"}
    sequence(:email) {|n| "em#{n}@qq.com"}
    password '123456'
    password_confirmation '123456'
  end
end