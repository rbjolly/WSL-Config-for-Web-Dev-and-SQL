# SQL
The examples in this repo were created long ago in order to teach others some basics of SQL. **I make no warranty on any code in this repo. Use at your own risk.**

Included are examples for creating stored procedures and functions along with some basic SQL commands. These exampes were developed back in the days of MySQL 5.

# [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
The following command summary can be used to get database servers installed and running under Windows Subsytem for Linux. Also includes information for getting the web server nginx running.

  ## [Postgres Server](https://www.postgresql.org/):
  The default user for Postgres is `postgres``.
  
  1. Install command: `sudo apt install postgresql postgresql-contrib`
  
  2. Other relevant commands:
     * Start Postgres server: `sudo service postgresql start`
     * Check DATABASE status: `sudo service postgresql status `
     * Get the version number: `psql --version`
     * Stop Postgres server: `sudo service postgresql stop`
  
  3. The psql shell: `sudo -u postgres psql`
     * List ALL databases: `\l `
     * Change password: `\password userName`
     * Delete user: `DROP ROLE IF EXISTS userName`
     * List users: `\du+`
     * Create database: `createdb -h localhost -p 5432 -U postgres dbName`
     * Change to database: `\c dbName`
     * Show tables: `\dt`

  
  ## [MySQL](https://dev.mysql.com/):
  The default user for MySQL is `root`.
  
  1. Install command: `apt install mysql-server`
  
  2. Other relevant commands:
     * Start MySQL server: `sudo service mysql start`
     * Get the version number: `mysql --versio`      
     * Stop MySQL server: `sudo service mysql stop`
   
  3. Commandline Client:
     * Starting a session: `mysql -u userName -p -D dbName`

  ## [NGINX Webserver](https://nginx.org/en/docs/)
  Commands and configuration for running nginx on Ubuntu 20.04 WSL.
  
  * Start the webserver: `sudo service nginx restart`
  * Webserver root: `/etc/nginx`

