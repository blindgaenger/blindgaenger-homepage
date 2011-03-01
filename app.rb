# encoding: UTF-8

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'models')

require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'sinatra/content_for2'
require 'logger'
require 'active_record'
require 'twitter'
require 'tweet'

configure do
  set :haml, :format => :html5 # default Haml format is :xhtml
  set :sass, :style => :compact # default Sass style is :nested, :expanded

  [:eot, :woff, :ttf, :otf ].each do |ext|
    mime_type ext, 'application/octet-stream'
  end
  mime_type :svg, 'image/svg+xml'

  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger.level = Logger::WARN
  config = {
    :adapter => 'sqlite3',
    :database => "db/#{Sinatra::Application.environment.to_s}.sqlite3"
  }
  ActiveRecord::Base.establish_connection(config)
  ActiveRecord::Migrator.up('db/migrate')
end

configure :development do
  Tweet.fetch_tweets if Tweet.count == 0
end

helpers do
  def separator
    haml '.separator ★★★★'
  end
end

get '/' do
  @tweets = Tweet.all
  haml :index
end

get '/stylesheets/:file.css' do
  scss params[:file].to_sym 
end
