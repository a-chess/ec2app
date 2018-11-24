app_path = '/home/hyuga/ec2app'

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 1)
timeout 15
preload_app true
working_directory "#{app_path}/current"

listen  "#{app_path}/shared/tmp/unicorn.sock"
pid     "#{app_path}/shared/tmp/pids/unicorn.pid"

stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])

# 遅くなるのでコメントアウトしてるけど、本番運用ならGemfileはsharedに入れるべきでない。
# before_exec do |server|
#   ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
# end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
 
  sleep 1
end 

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

