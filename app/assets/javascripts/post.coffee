$(document).on 'turbolinks:load', ->
  Dropzone.autoDiscover = false  # disable the built-in autodiscovery

  # 上传文件
  $('[data-provider=dropzone]').each ->
    previewTemplateHtml = $(this).find('.dz-preview-template').html()
    myDropzone = new Dropzone(this,{
      paramName: 'file',
      maxFilesize: 2,
      previewTemplate: previewTemplateHtml
    })

    myDropzone.on 'success', (status, resp)->
      if resp.success
        WarningAlert(resp.message)
      else
        htmlStr = "<div class='imgbox'>" +
          "<a data-lightbox='roadtrip' data-title='tree.jpg' href='http://ol1rqfn9r.bkt.clouddn.com/FustG1nS4L7Ozv4x4NyiQKMtAgWh?attname=#{resp.filename}'>" +
          "<img src='http://ol1rqfn9r.bkt.clouddn.com/#{resp.qiniu_hash}?imageView2/1/w/300/h/300/q/90' alt='90' width='130' height='130' class='img-thumbnail'>" +
          "</a>" +
          "<div class='operation'>" +
          "<a data-confirm='确定删除图片吗？' rel='nofollow' data-method='DELETE' href='/posts/#{resp.id}'>" +
          "<i class='fa fa-trash trash'></i>" +
          "</a>" +
          "<a data-proc='#{resp.id}' href='javascript:;' data-behaivor='lb-download'>" +
          "<i class='fa fa-download download'></i>" +
          "</a>" +
          "</div>"
        $('.post-images').append(htmlStr)

    myDropzone.on 'error', (file, resp)->
      ErrorAlert('上传失败！')

    myDropzone.on 'complete', (file)->
      myDropzone.removeFile(file)

  # 下载文件
  $('[data-behaivor=lb-download]').on 'click', (e) ->
    postId = $(this).data('proc')
    document.location.href = "/api/posts/download?pid=#{postId}"
