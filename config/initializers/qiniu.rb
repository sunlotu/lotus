begin
  $qiniu_config = YAML.load_file("#{Rails.root}/config/qiniu.yml").with_indifferent_access
  Qiniu.establish_connection! $qiniu_config[:default].deep_symbolize_keys
rescue => e
  puts e.message
end