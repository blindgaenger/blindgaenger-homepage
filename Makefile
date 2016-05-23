dev:
	hugo server --port 3000

clean:
	@echo cleaning public
	@rm -rf public/
	@mkdir -p public/

build: clean
	hugo

deploy:
	git push origin master
	git push origin `git subtree split --prefix=public master`:gh-pages --force

.PHONY: dev clean build deploy
