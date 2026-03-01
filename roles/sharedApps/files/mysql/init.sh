# Сохрани SQL выше в файл init.sql и выполни:
docker exec -i shared-mysql-1 mysql -u root -p${ROOT_PASSWORD} < init.sql
