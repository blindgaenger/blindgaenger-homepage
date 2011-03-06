require 'octokit'

class Repo < ActiveRecord::Base
  BUNCH_SIZE = 5
  
  scope :history, :order => "pushed_at DESC"
  
  class << self
    def fetch!
      repos = Octokit.client.repositories('blindgaenger').reverse
      repos.map do |repo|
        model = self.find_by_name(repo.name) || self.new
        model.attributes = {
          :name => repo.name,
          :description => repo.description,
          :homepage => repo.homepage,
          :url => repo.url,
          :language => repo.language,
          :forks => repo.forks,
          :watchers => repo.watchers,
          :pushed_at => Time.parse(repo.pushed_at),
          :fork => repo.fork
        }
        model.save
      end
      repos
    end
    
    def bunch
      self.history.all(:limit => BUNCH_SIZE)
    end
  end
  
end