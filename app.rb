require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'sinatra/content_for2'

configure do
  set :haml, :format => :html5 # default Haml format is :xhtml
  set :sass, :style => :compact # default Sass style is :nested, :expanded
  
  [:eot, :woff, :ttf, :otf ].each do |ext|
    mime_type ext, 'application/octet-stream'
  end
  mime_type :svg, 'image/svg+xml'
end

get '/' do
  haml :index
end

get '/stylesheets/:file.css' do
  scss params[:file].to_sym 
end
