FactoryGirl.define do
  factory :post do
    title 'title'
    filename 'filename'
    qiniu_hash 'yes'
  end
end