require 'open-uri'
require 'crack'

class Tumble < ActiveRecord::Base
  URL = "http://posterous.com/api/2/users/60745/sites/blindgaenger/posts/public"
  BUNCH_SIZE = 9

  scope :history, :order => "posted_at DESC"
  
  class << self
    def fetch!
      url = URL
      if latest_id = self.latest.try(:post_id)
        url += "?since_id=#{latest_id}"
      end
      
      json = open(url).read
      posts = Crack::JSON.parse(json)
      posts.each do |post|
        begin
          html = post['body_full']
          html.gsub!('\u003C', '<')
          html.gsub!('\u003E', '>')
          html.gsub!('width="500"', 'width="250"')
          html.gsub!('height="412"', 'height="206"')
          
          self.create(
            :post_id => post['id'],
            :url => post['full_url'],
            :title => post['title'],
            :body => html,
            :posted_at => Time.parse(post['display_date'])
          )
        rescue => ex
          warn "could not store tumble: #{ex.message}"
        end
      end
      
      self.history.all(:offset => BUNCH_SIZE*2).each(&:delete)
      
      posts
    end
    
    def bunch
      self.history.all(:limit => BUNCH_SIZE)
    end
    
    def latest
      self.history.first
    end
  end
  
  def text
  end
  
end