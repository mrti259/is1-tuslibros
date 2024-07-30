run: build
	docker compose up -d

stop:
	docker compose down

logs:
	docker compose logs

build:
	docker compose build

install:
	cd backend && shards install

spec:
	cd backend && crystal spec

play: install
	cd backend && crystal play