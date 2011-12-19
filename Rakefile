task :environment do
  require File.expand_path(File.join('config', 'environment'), File.dirname(__FILE__))
end

desc "run all asset processings"
task :assets => %w(assets:images assets:package)

namespace :assets do
  desc "crushes all PNGs in public/images"
  task :images do
    require 'find'

    sum = []

    images_dir = File.expand_path('public/images')
    Find.find(images_dir) do |file|
      next unless file.match('\.png$')

      # crush
      crushed_file = "#{file}.crushed"
      command = <<-CMD
        pngcrush -reduce -brute -no_cc -q "#{file}" "#{crushed_file}"
      CMD
      system command.strip

      # check
      next unless File.exists?(crushed_file)
      crushed_size = File.size(file) - File.size(crushed_file)
      unless crushed_size > 0
        system "rm \"#{crushed_file}\""
        next
      end

      system "mv \"#{crushed_file}\" \"#{file}\""
      sum << crushed_size
      puts "CRUSHED #{crushed_size}: #{file}"
    end

    puts "TOTAL: #{sum.inject(0){|s,i|s+i}} bytes of #{sum.size} files"
  end

  desc "generates scss files"
  task :scss do
    system <<-SCRIPT
      rm tmp/*.css
      cp public/stylesheets/*.css tmp/
      bundle exec sass views/stylesheets/css3.scss tmp/css3.css
      bundle exec sass views/stylesheets/layout.scss tmp/layout.css
      bundle exec sass views/stylesheets/style.scss tmp/style.css
    SCRIPT
  end

  desc "packages asset files with jammit"
  task :package => :scss do
    system "rm -r public/assets/"
    require 'jammit'
    Jammit.package!(:force => true)
  end
end

namespace :db do
  desc "migrate the database"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate(
      'db/migrate',
      ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    )
  end

  desc "reset the database"
  task :reset => :environment do
    system "heroku pg:reset SHARED_DATABASE"
  end
end

desc "fetch all"
task :cron => %w(cron:twitter cron:tumbles cron:github) do
  puts "fetched all at #{Time.now.to_s}"
end

namespace :cron do
  desc "fetch new tweets"
  task :twitter => :environment do
    tweets = Tweet.fetch!
    puts "fetched #{tweets.size} tweets"
  end

  desc "fetch new tumbles"
  task :tumbles => :environment do
    tumbles = Tumble.fetch!
    puts "fetched #{tumbles.size} tumbles"
  end

  desc "fetch github repos"
  task :github => :environment do
    repos = Repo.fetch!
    puts "fetched #{repos.size} repos"
  end
end

desc "setup the heroku instance"
task :setup do
  system "heroku create --stack cedar"

  system "heroku addons:add custom_domains"
  #system "heroku domains:remove blindgaenger.net --app old-blindgaenger-homepage"
  system "heroku domains:add blindgaenger.net"

  system "heroku addons:add cron:daily"

  Rake::Task["deploy"].invoke
end

desc "deploys to heroku, after generating production assets"
task :deploy do
  system "git push heroku master"
  system "heroku run rake db:migrate"
  system "heroku run rake cron"
end
