version:
	@echo Laravelの勉強用環境です

up:
	@docker-compose up -d

stop:
	@docker-compose stop

exec:
	@docker-compose exec

build:
	@docker-compose up -d --build
	@make create-project
	@make composer-install
	@make setting-env

create-project:
	@if [ ! -e ./app ]; then \
		make exec laravel-study composer create-project laravel/laravel .; \
	fi;

composer-install:
	@make exec laravel-study composer install
	
setting-env:
	@make exec laravel-study mv .env.example .env
	@make exec laravel-study sed '12s/127.0.0.1/mysql-study/g' .env
	@make exec laravel-study sed '14s/laravel/database/g' .env
	@make exec laravel-study sed '16s/DB_PASSWORD=/DB_PASSWORD=root/g' .env
	@make exec laravel-study php artisan key:generate
	@make exec laravel-study php artisan config:cache
	