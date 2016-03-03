database:
	#pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
	postgres -D /usr/local/var/postgres

server:
	bundle exec ruby app.rb

envars:
	export TWITTER_CONSUMER_KEY=`envars twitter_consumer_key`
	export TWITTER_CONSUMER_SECRET=`envars twitter_consumer_secret`
	export TWITTER_ACCESS_TOKEN=`envars twitter_access_token`
	export TWITTER_ACCESS_SECRET=`envars twitter_access_secret`

deploy:
	heroku config:set TWITTER_CONSUMER_KEY=`envars -e production -S twitter_consumer_key`
	heroku config:set TWITTER_CONSUMER_SECRET=`envars -e production -S twitter_consumer_secret`
	heroku config:set TWITTER_ACCESS_TOKEN=`envars -e production -S twitter_access_token`
	heroku config:set TWITTER_ACCESS_SECRET=`envars -e production -S twitter_access_secret`
	RACK_ENV=production bundle exec rake deploy