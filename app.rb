require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'sinatra/content_for2'
require 'twitter'

configure do
  set :haml, :format => :html5 # default Haml format is :xhtml
  set :sass, :style => :compact # default Sass style is :nested, :expanded
  
  [:eot, :woff, :ttf, :otf ].each do |ext|
    mime_type ext, 'application/octet-stream'
  end
  mime_type :svg, 'image/svg+xml'
end

get '/' do
  load_tweets
  haml :index
end

get '/stylesheets/:file.css' do
  scss params[:file].to_sym 
end

helpers do
  Tweet = Struct.new(:id, :time, :text, :user, :icon)
  def load_tweets
    @tweets = Twitter.user_timeline('blindgaenger', :count => 10, :include_rts => true, :include_entities => true).map do |t|
      tweet = Tweet.new(t.id, Time.parse(t.created_at))
      status = t.retweeted_status ? t.retweeted_status : t
      tweet.text = replace_entities(status.text, status.entities)
      tweet.user = status.user.screen_name
      tweet.icon = status.user.profile_image_url
      tweet
    end
  end
  
  def replace_entities(text, entities)
    text #TODO
  end
  
end