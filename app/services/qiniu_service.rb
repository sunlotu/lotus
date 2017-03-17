class QiniuService
  attr_reader :filePath, :key
  def initialize(filePath = nil, key)
    @filePath = filePath
    @key = key
    @bucket = 'lotus'
  end

  def upload
    put_policy = Qiniu::Auth::PutPolicy.new(@bucket, nil, 3600)
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    code, result, response_headers = Qiniu::Storage.upload_with_token_2(
                                       uptoken,
                                       @filePath,
                                       nil,
                                       nil,
                                       bucket: @bucket
    )
    if code == 200
      Rails.logger.info 'success'
      return { success: true, data: result }
    else
      Rails.logger.info 'error'
      return { success: false, message: '上传失败' }
    end
  end

  def download
    download_url = Qiniu::Auth.authorize_download_url_2(domain, @key)
    return { download_url: download_url }
  end

  private

    def domain
      @domain = 'ol1rqfn9r.bkt.clouddn.com'
    end

end