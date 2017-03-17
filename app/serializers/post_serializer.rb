class PostSerializer < BaseSerializer
  attributes :id, :title, :filename, :qiniu_hash
end