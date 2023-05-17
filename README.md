# SQL
Sandbox for SQL scripts.

These examples were created long ago in order to teach others some basics of SQL.
I make no warranty on any code in this repo. Use at your own risk.

Included are examples for creating stored procedures and functions along with some basic SQL commands.
These exampes were developed back in the days of MySQL 5.

# [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
The following command summary can be used to get database servers installed and running under Windows Subsytem for Linux.

  ## [Postgres Server](https://www.postgresql.org/):
  1. Install command: `sudo apt install postgresql postgresql-contrib`
  
  2. Other relevant commands:
     * Start Postgres server: `sudo service postgresql start`
     * Check DATABASE status: `sudo service postgresql status `
     * Get the version number: `psql --version`
     * Stop Postgres server: `sudo service postgresql stop`
        
  ## [MySQL](https://dev.mysql.com/):
  1. Install command: `apt install mysql-server`
  
  2. Other relevant commands:
     * Start MySQL server: `sudo service mysql start`
     * Get the version number: `mysql --versio`      
     * Stop MySQL server: `sudo service mysql stop`
