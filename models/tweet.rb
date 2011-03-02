class Tweet < ActiveRecord::Base
  BUNCH_SIZE = 10
  
  scope :history, :order => "tweet_id DESC"
  
  class << self
    def fetch!
      options = {
        :count => BUNCH_SIZE,
        :include_rts => true
      }
      if latest_id = self.latest.try(:tweet_id)
        options[:since_id] = latest_id
      end
      
      tweets = Twitter.user_timeline('blindgaenger', options)
      tweets.each do |tweet|
        status = tweet.retweeted_status ? tweet.retweeted_status : tweet
        Tweet.create(
          :tweet_id => tweet.id,
          :screen_name => status.user.screen_name,
          :profile_image_url => status.user.profile_image_url,
          :text => status.text,
          :tweeted_at => Time.parse(tweet.created_at)
        )
      end
      
      Tweet.history.all(:offset => BUNCH_SIZE*2).each(&:delete)
      
      tweets
    end
    
    def bunch
      self.history.all(:limit => BUNCH_SIZE)
    end
    
    def latest
      self.history.first
    end
  end

  before_save :replace_entities
  
  alias_attribute :avatar_url, :profile_image_url
  
  def profile_url
    "http://www.twitter.com/#{screen_name}"
  end
  
  def tweet_url
    "http://twitter.com/#{screen_name}/status/#{tweet_id}"
  end
  
  private
  
  def replace_entities
    temp = self.text.dup

    temp = temp.gsub(/\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/) do |link|
      schema = $2.match(/w/) ? "http://" : ""
      text = (link.length > 25) ? link[0..24] + "..." : link
      '<a class="link" href="' + schema+link + '" target="_blank">' + text + '</a>'
    end

    temp.gsub!(/\B#([a-zA-Z0-9_]{1,20})([\s,]|$)/,
      '<a class="hash" href="http://twitter.com/search?q=%23\1" target="_blank">#\1</a>\2')

    temp.gsub!(/\B@([a-zA-Z0-9_]{1,20})([\s,]|$)/,
      '@<a class="mention" href="http://twitter.com/\1" target="_blank">\1</a>\2')
    
    self.html = temp
  end
end
