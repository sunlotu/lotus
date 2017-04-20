#!/usr/bin/env puma
require 'dotenv'

app_dir     = File.expand_path("../..",__FILE__)
env_file    = "#{app_dir}/.env"

Dotenv.load(env_file) if File.exist?(env_file)

# Specifies the `environment` that Puma will run in.
work_env    = ENV.fetch('RACK_ENV', 'development')
environment work_env

# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
port          ENV.fetch("PUMA_PORT") { 3000 }.to_i
# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
# WEB_CONCURRENCY
workers       ENV.fetch("PUMA_WORKERS") { 2 }
min_threads = ENV.fetch("PUMA_MIN_THREADS") { 1 }.to_i
max_threads = ENV.fetch("PUMA_MAX_THREADS") { 5 }.to_i
threads min_threads, max_threads

daemonize false

pidfile "#{app_dir}/tmp/pids/puma.pid"
state_path "#{app_dir}/tmp/pids/puma.state"
bind "unix://#{app_dir}/tmp/sockets/puma.sock"
activate_control_app "unix://#{app_dir}/tmp/sockets/pumactl.sock"
if work_env.to_sym == :production
  stdout_redirect "#{app_dir}/log/puma_access.log", "#{app_dir}/log/puma_error.log"
end

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
preload_app!

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection_pool.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  end
end
# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
on_worker_boot do
  if defined?(ActiveRecord::Base)
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
    end
  end
end

# Allow puma to be restarted by `rails restart` command.
# plugin :tmp_restart
