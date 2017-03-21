module ApplicationHelper
  EMPTY_STRING=''.freeze

  FLASH_CSS_MAP = {
      success: "alert alert-dismissible alert-success",
      error:   "alert alert-dismissible alert-danger",
      alert:   "alert alert-dismissible alert-warning",
      notice:  "alert alert-dismissible alert-success",
  }

  def flash_css(flash_type)
    FLASH_CSS_MAP[flash_type.to_sym] || flash_type.to_s
  end

  def title_tag(str)
    content_for :title, raw("#{str}")
  end

  def render_list(opts = {})
    list = []
    yield(list)
    items = []
    list.each do |link|
      item_class = EMPTY_STRING
      urls = link.match(/href=(["'])(.*?)(\1)/) || []
      url = urls.length > 2 ? urls[2] : nil
      if url && current_page?(url) || (@current && @current.include?(url))
        item_class = 'active'
      end
      items << content_tag('li', raw(link), class: item_class)
    end
    content_tag('ul', raw(items.join(EMPTY_STRING)), opts)
  end

  def curr_ctrl?(ctrl)
    ctrl.to_s.underscore == controller_path || controller_path.include?(ctrl)
  end

  def active_tag?(opts={})
    controller = opts.delete :controller
    if controller.is_a? Array
      controller.flatten.compact.any?{ |ctrl| curr_ctrl?(ctrl) }
    else
      curr_ctrl?(controller)
    end
  end

  def nav_tag(opts={}, &block)
    html_options = opts.delete(:html) || {}
    html_options[:class] ||= ''
    html_options[:class] << 'active' if active_tag?(opts)
    content_tag :li, capture(&block), html_options
  end


  def qiniu_image_url(post, format= :raw)
    key = post.respond_to?(:qiniu_hash) ? post.qiniu_hash : post
    url = "http://ol1rqfn9r.bkt.clouddn.com/#{key}"
    case format
    when :square
      url << '?imageView2/1/w/300/h/300/q/90'
    when :preview
      url << '?imageView2/2/w/1000/h/1000/q/90'
    when :raw
      url << '?attname=#{post.filename}'
    else
      url
    end
  end

end
