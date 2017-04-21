class Post < ApplicationRecord
  validates_presence_of :filename, :qiniu_hash

  scope :files, -> { where.not(filename: nil, qiniu_hash: nil) }
end
