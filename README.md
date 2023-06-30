# Introduction
This repo demonstrates the process necessary to get Ubuntu 20.04 for WSL configured for software and database development. It shows how to install databases, web servers, scripting engines, and associated modules needed to get a development system configured for use. Note, unlike a typical linux server, WSL does not allow services to auttomatically run at startup, so you'll need to issue the commands for each of your needed database servers, web servers, and scripting engines each time you login to WSL. Or you'll need to place them in a script that you can run in order to start them. Also, make sure ports for database servers, web servers, etc. are not occupied on Windows. This will potentially conflict with WSL.

Sample code is included, but no warranty is made about its correctness. Use sample code at your own risk.

# [Ubuntu 20.04 for WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
The following command summary can be used to get database servers, web servers, and scripting engines installed and running under Windows Subsytem for Linux (WSL) for Ubuntu 20.04.

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
  
 ## [PHP](https://www.php.net/docs.php)
 As of 20 May 2023, PHP 7.4 is the highest version available for Ubuntu 20.04 for WSL.
 
  1. Install PHP
     * `sudo apt update && sudo apt upgrade`
     * `sudo apt install php7.4-fpm -y`

  2. Installing modules --> sudo apt install php<version>-<package_name>
     * Exampe install with some modules: `sudo apt install php7.4-{mysql,zip,bcmath}`
     * Install driver for postgres: `sudo apt -y install php-pgsql`

  3. To uninstall PHP 
     * `sudo apt-get purge php7.4-fpm`
     * `sudo apt-get autoremove`
  
  ## [Python](https://www.python.org/doc/)
  As of 20 May 2023, Ubuntu 20.04 for WSL has an installed Python
  version that is greater than 3.7. This is incompatible with the 
  psycopg driver for Postgres. In order to access Postgres, you'll 
  need to install an alternative. The module pg8000 seems to work
  fine as a replacement. See the populate_tables.py script in this 
  repo for an example of how it works. For more info, see the pg8000 
  github page.
   
  ## [NGINX Webserver](https://nginx.org/en/docs/)
  Commands and configuration for running nginx on Ubuntu 20.04 WSL.
  
  * Start the PHP engine: `sudo service php7.4-fpm start`
  * Start the web server: `sudo service nginx start`
  * Restart the web server when config has changed: `sudo service nginx restart`
  * Stop the web server: `sudo service nginx stop`
  * Web server root: `/etc/nginx`

  ## Automating Server Startup
  You can automate the startup of services under WSL in a number of ways. One way to accomplish this task is to place the commands in a bash script and execute that script after you login. This way you only execute one command and start the services when you actually need them. So, create a file in your home directory called `'start-sercices.sh'` and issue the command `sudo chmod +x start-sercices.sh` to make the file executable. Then edit the file and enter the following: 
  ```
     #!/bin/sh
     sudo service php7.4-fpm
     sudo service nginx start
     sudo service postgresql start
     sudo service mysql start  
  ```
  When you login and need to make the services available, just issie the command `. start-sercices.sh`

  
