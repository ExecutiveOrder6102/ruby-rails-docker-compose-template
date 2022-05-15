{
    "Servers": {
    "1": {
      "Name": "Postgres - Docker",
      "Group": "Servers",
      "Port": 5432,
      "Username": "$POSTGRES_USER",
      "Host": "$RAILS_DB_HOST",
      "SSLMode": "prefer",
      "MaintenanceDB": "postgres",
      "PassFile": "/var/lib/pgadmin/pgpass"
    }}
}