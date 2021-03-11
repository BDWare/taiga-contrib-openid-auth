ifndef CIRCLE_BRANCH
override CIRCLE_BRANCH = latest
endif

all: clean test build

build: build-front build-back

build-front:
	cd front && npm install && npm run build
	docker build docker/front --no-cache -t bdware/taiga-front-openid:$(CIRCLE_BRANCH)
	docker build docker/front --no-cache -t bdware/taiga-front-openid:latest

build-back:
	docker build docker/back --no-cache -t bdware/taiga-back-openid:$(CIRCLE_BRANCH)
	docker build docker/back --no-cache -t bdware/taiga-back-openid:latest
	
publish:
	docker push bdware/taiga-back-openid:$(CIRCLE_BRANCH)
	docker push bdware/taiga-back-openid:latest
	docker push bdware/taiga-front-openid:$(CIRCLE_BRANCH)
	docker push bdware/taiga-front-openid:latest
