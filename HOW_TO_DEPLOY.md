# How to deploy

## 1 Create DB-Dump

``` shell
docker exec kutt-postgres-1 pg_dump -d kutt -U user --clean > kutt_postgres_backup.sql
```

## 2 Deploy

### 2.1 Build Image
``` shell
docker build . -t kutt-bytepoets
```

Verifiy whether it exists:
``` shell
docker images
```

### 2.2 Save/Export the image as a tar file
``` shell
docker save -o kutt-bytepoets.tar kutt-bytepoets
```

### 2.3 Copy the tar file to the server
``` shell
scp -i <identity file> kutt-bytepoets.tar ubuntu@byp.at:kutt/kutt-bytepoets.tar
```

### 2.4 Load the image from the tar file into docker
``` shell
docker load -i kutt-bytepoets.tar
```

Verifiy whether it exists:
``` shell
docker images
```

### 2.5 Optionally adjust the docker-compose file
If the name of the image has been changed it needs to be adjusted in the `docker-compose.yml`

### 2.6 Stop all running containers, remove old containers
``` shell
docker stop <container-id>
docker container rm <container-id>
```

### 2.7 Start
``` shell
docker-compose up -d
```

## 3 Restore DB-Dump
``` shell
docker exec -i kutt-postgres-1 psql -U user -d kutt < kutt_postgres_backup.sql
```