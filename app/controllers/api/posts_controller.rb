class Api::PostsController < Api::BaseController
  def download
    @post = Post.find(params[:pid])
    key = @post.qiniu_hash
    filename = @post.filename
    result = QiniuService.new(key).download
    img_data = open(result[:download_url])
    send_data img_data.read, type: img_data.content_type, filename: filename
  end
end
