.PHONY: up down

up:
	docker run -d --name mongodb-hw4 -p 27017:27017 -v $(PWD)/data:/data/import --rm mongo:7.0 || docker start mongodb-hw4
	sleep 5
	docker exec mongodb-hw4 mongosh sample_mflix --eval "db.dropDatabase()" --quiet
	docker exec mongodb-hw4 mongoimport --db sample_mflix --collection theaters --file /data/import/theaters.json
	docker exec mongodb-hw4 mongoimport --db sample_mflix --collection comments --file /data/import/comments.json
	docker exec mongodb-hw4 mongoimport --db sample_mflix --collection movies --file /data/import/movies.json
	docker exec mongodb-hw4 mongoimport --db sample_mflix --collection sessions --file /data/import/sessions.json
	docker exec mongodb-hw4 mongoimport --db sample_mflix --collection users --file /data/import/users.json

down:
	docker stop mongodb-hw4
	docker rm mongodb-hw4