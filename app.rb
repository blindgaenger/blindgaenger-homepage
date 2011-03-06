# encoding: UTF-8

require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'sinatra/content_for2'
require File.expand_path(File.join('config', 'environment'), File.dirname(__FILE__))

configure do
  set :haml, :format => :html5 # default Haml format is :xhtml
  set :sass, :style => :compact # default Sass style is :nested, :expanded

  [:eot, :woff, :ttf, :otf ].each do |ext|
    mime_type ext, 'application/octet-stream'
  end
  mime_type :svg, 'image/svg+xml'
end

helpers do
  def separator
    haml '.separator ★★★★'
  end
end

get '/' do
  @tweets = Tweet.bunch
  @tumbles = Tumble.bunch
  @repos = Repo.bunch
  haml :index
end

get '/stylesheets/:file.css' do
  scss "stylesheets/#{params[:file]}".to_sym 
end
