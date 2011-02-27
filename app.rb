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
  @tweets = []
  load_tweets
  haml :index
end

get '/stylesheets/:file.css' do
  scss params[:file].to_sym 
end

helpers do
  Tweet = Struct.new(:id, :time, :user, :icon, :text, :html)
  def load_tweets
    @tweets = Twitter.user_timeline('blindgaenger', :count => 10, :include_rts => true).map do |t|
      tweet = Tweet.new(t.id, Time.parse(t.created_at))
      status = t.retweeted_status ? t.retweeted_status : t
      tweet.user = status.user.screen_name
      tweet.icon = status.user.profile_image_url
      tweet.text = status.text
      tweet.html = replace_entities(status.text, status.entities)
      tweet
    end
  end
  
  def replace_entities(text, entities)
    html = text.dup

    html = html.gsub(/\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/) do |link|
      schema = $2.match(/w/) ? "http://" : ""
      text = (link.length > 25) ? link[0..24] + "..." : link
      '<a class="link" href="' + schema+link + '" target="_blank">' + text + '</a>'
    end
    
    html.gsub!(/\B#([a-zA-Z0-9_]{1,20})([\s,]|$)/,
      '<a class="hash" href="http://twitter.com/search?q=%23\1" target="_blank">#\1</a>\2')
    html
    
    html.gsub!(/\B@([a-zA-Z0-9_]{1,20})([\s,]|$)/,
      '@<a class="mention" href="http://twitter.com/\1" target="_blank">\1</a>\2')
    html
  end
  
end