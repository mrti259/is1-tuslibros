run: build
	docker compose up -d

stop:
	docker compose down

logs:
	docker compose logs

build:
	docker compose build

test:
	crystal spec backend


