require 'pp'
require 'logger'
require 'active_record'
require 'uri'

# http://devcenter.heroku.com/articles/rack
db = URI.parse(ENV['DATABASE_URL'] || 'postgres://bjuenger:@localhost/homepage_blindgaenger_net')
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = Logger::WARN
ActiveRecord::Base.establish_connection(
  :adapter      => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host         => db.host,
  :username     => db.user,
  :password     => db.password,
  :database     => db.path[1..-1],
  :encoding     => 'utf8',
  :min_messages => 'notice'
)

$LOAD_PATH.unshift File.expand_path(File.join('..', 'models'), File.dirname(__FILE__))
require 'tweet'
require 'repo'
require 'tumble'