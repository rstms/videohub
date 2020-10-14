# nginx rtmp server makefile


default: run

build:
	docker-compose build videohub

run:
	docker-compose up
