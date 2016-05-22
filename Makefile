dev:
	hugo server --port 3000

clean:
	@echo cleaning public
	@rm -rf public/
	@mkdir -p public/

build: clean
	hugo
