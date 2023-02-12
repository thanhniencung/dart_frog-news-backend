run:
	dart_frog dev 

build:
	dart_frog build 

start_db:
	docker run \
		--name basic-postgres \
		--rm -e POSTGRES_USER=postgres \
		-e POSTGRES_PASSWORD=code4func \
		-v /Users/ryan/workspace/docker/postgres/data:/var/lib/postgresql/data \
		-p 5432:5432 -it \
		-d postgres:14.1-alpine


pg_admin:
	docker run -p 80:80 \
        -e 'PGADMIN_DEFAULT_EMAIL=user@microlap.vn' \
        -e 'PGADMIN_DEFAULT_PASSWORD=111111' \
        -v /Users/ryan/workspace/docker/pg_admin/data:/var/lib/pgadmin \
        -d dpage/pgadmin4

clean_build:
	docker kill $(docker ps -q)
	docker rmi $(docker images -a -q)
	docker system prune -a
	docker-compose up -d
	docker-compose run db sh -c "psql -U postgres < /init_db.sql"