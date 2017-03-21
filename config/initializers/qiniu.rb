begin
  Qiniu.establish_connection! Rails.application.config_for(:qiniu).deep_symbolize_keys
rescue => e
  puts e.message
end