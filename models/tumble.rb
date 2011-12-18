require 'open-uri'
require 'crack'

class Tumble < ActiveRecord::Base
  URL = "https://gimmebar.com/api/v0/public/assets/blindgaenger/firehose"
  BUNCH_SIZE = 9

  scope :history, :order => "posted_at DESC"

  class << self
    def fetch!
      url = "#{URL}?limit=#{BUNCH_SIZE}"

      json = open(url).read
      posts = Crack::JSON.parse(json)['records']
      posts.each do |post|
        begin
          model = self.find_by_post_id(post['id']) || self.new
          model.attributes = {
            :post_id => post['id'],
            :url => post['source'],
            :title => post['title'],
            :body => post['content'].to_yaml,
            :posted_at => Time.at(post['date'])
          }
          model.save
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