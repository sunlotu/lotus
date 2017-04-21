class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all.files
  end

  # def show
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: PostSerializer.new(@post) }
  #   end
  # end

  def create
    file = params[:file]
    fpath, filename = file.path, file.original_filename
    post = Post.find_by_filename(filename)
    render json: { success: false, message: '此文件已存在！' } and return if post
    result = QiniuService.new(fpath,filename).upload
    if result[:success]
      @post = Post.new
      @post.filename = filename
      @post.qiniu_hash = result[:data]['key']
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: '上传成功!' }
          format.json { render json: PostSerializer.new(@post), status: :created }
        else
          format.html { render :index }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    set_post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '图片删除成功！' }
      format.json { head :no_content }
    end
  end

  private

    def set_post
      @post ||= Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :filename)
    end
end
