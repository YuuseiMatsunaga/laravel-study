version:
	@echo Laravelの勉強用環境です

up:
	@docker-compose up -d

stop:
	@docker-compose stop

build:
	@docker-compose up -d --build
	@make create-project
	@make composer-install
	@make setting-env

create-project:
	@if [ ! -e ./app ]; then \
		docker-compose exec laravel-study composer create-project laravel/laravel .; \
	fi;

composer-install:
	@docker-compose exec laravel-study composer install
	
setting-env:
	@docker-compose exec laravel-study mv .env.example .env
	@docker-compose exec laravel-study sed '12s/127.0.0.1/mysql-study/g' .env
	@docker-compose exec laravel-study sed '14s/laravel/database/g' .env
	@docker-compose exec laravel-study sed '16s/DB_PASSWORD=/DB_PASSWORD=root/g' .env
	@docker-compose exec laravel-study php artisan key:generate
	@docker-compose exec laravel-study php artisan config:cache
	