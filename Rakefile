namespace :generate do

  desc "generates scss files"  
  task :scss do
    system <<-SCRIPT
      rm tmp/*.css
      cp public/stylesheets/*.css tmp/
      sass views/css3.scss tmp/css3.css
      sass views/layout.scss tmp/layout.css
      sass views/style.scss tmp/style.css
    SCRIPT
  end
  
  desc "generates assets files"  
  task :assets => :scss do
    system "rm -r public/assets/"
    require 'jammit'
    Jammit.package!
  end

end

desc "deploys to heroku, after generating production assets"  
task :deploy => "generate:assets" do
  system "git push heroku master"
end