#!/bin/bash
docker stop i66
docker rm i66
docker rmi r66
docker build -t r66 .
docker run --env-file .env -p 3000:80 --name i66 r66


