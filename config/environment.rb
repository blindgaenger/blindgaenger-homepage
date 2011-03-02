require 'logger'
require 'active_record'

dbenv = ENV['RACK_ENV'] || 'development' || defined?(Sinatra) && Sinatra::Application.environment.to_s
dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = Logger::WARN
ActiveRecord::Base.establish_connection(dbconfig[dbenv])
ActiveRecord::Migrator.up('db/migrate')

$LOAD_PATH.unshift File.expand_path(File.join('..', 'models'), File.dirname(__FILE__))
require 'twitter'
require 'tweet'
