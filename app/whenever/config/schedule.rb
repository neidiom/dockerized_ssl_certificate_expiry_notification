every :day do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  env :PATH, '/usr/local/bundle/bin:/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  env :GEM_HOME,'/usr/local/bundle'
  command "ruby /srv/app/ssl_check.rb"
#  command "ruby /srv/app/ssl_check.rb", :output => '/srv/app/cron.log'
end
