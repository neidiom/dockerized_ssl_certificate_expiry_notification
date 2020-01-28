#!/usr/bin/env ruby
require 'ssl_expiry'
require 'slack-notifier'
require 'yaml'

vars = YAML.load_file('/srv/app/vars.yml')

results = SSLExpiry::SSLExpiry.check_certificates(vars['domains'])

puts results.inspect

results.each do |result|
  status = result[1]['status']
  error = result[1]['error']
  expires_in = result[1]['expires_in']
  expires_on = result[1]['expires_on']
  common_name = result[1]['common_name']
  issuer = result[1]['error']

  danger_expires_note = {
    fallback: "Exipres soon",
    text: "Expires on #{expires_on}",
    color: "danger"
  }

  case status
  when 200
    if expires_in < vars['ssl_expiry_days_check']
      notifier = Slack::Notifier.new vars['slack_webhook']
      notifier.post text: "#{result[0]} is expiring in #{expires_in} days.",
      icon_emoji: ":bangbang:",
      color: "danger",
      username: "SSL/TLS certificate expiry notification",
      attachments: [danger_expires_note]
    end
  when 400
    puts "Domain not found. The exact error message is #{error}"
  else
    "Uknown error."
  end
end
