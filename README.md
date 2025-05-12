# Introduction
This repo demonstrates the process necessary to get Ubuntu 24.04 for WSL configured for software and database development. It shows how to install databases, web servers, scripting engines, and associated modules needed to get a development system configured for use. Note, unlike a typical linux server, WSL does not allow services to automatically run at startup, so you'll need to issue the commands for each of your needed database servers, web servers, and scripting engines each time you login to WSL. Or you'll need to place them in a script that you can run in order to start them. Also, make sure ports for database servers, web servers, etc. are not occupied on Windows. This will potentially conflict with WSL.

Sample code is included, but no warranty is made about its correctness. Use sample code at your own risk.

# [Ubuntu 24.04 for WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
The following command summary can be used to get database servers, web servers, and scripting engines installed and running under Windows Subsytem for Linux (WSL) for Ubuntu 24.04.

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
     * Get the version number: `mysql --version`      
     * Stop MySQL server: `sudo service mysql stop`
   
  3. Commandline Client:
     * Starting a session: `mysql -u userName -p -D dbName`
  
 ## [PHP](https://www.php.net/docs.php)
 PHP (Hypertext Preprocessor) is a popular server-side scripting 
 language that enables the development of dynamic web applications. 
 PHP-FPM (FastCGI Process Manager) provides additional features and 
 improved performance over traditional CGI-based methods to enable 
 PHP connections with other applications such as web servers to 
 process dynamic web application requests. Note for Ubuntu 24.04 
 the supporteed version is 8.3.
 
  1. Install PHP
     * `sudo apt update && sudo apt upgrade`
     * `sudo apt install php-fpm -y`
  
  2. View installed modules:  `php -m`
  
  3. View current version: `php-fpm8.3 -v`
  
  4. List all files in PHP directory: `ls /etc/php/8.3/`
    
  6. Installing modules --> sudo apt install php<version>-<package_name>
     * Exampe install with some modules: `sudo apt install php8.3-{mysql,zip,bcmath}`
     * Install driver for postgres: `sudo apt -y install php-pgsql`
  
  8. Switch to the PHP-FPM pool configurations directory `/etc/php/8.3/fpm/pool.d/`: `cd /etc/php/8.3/fpm/pool.d/`
  
  9. Open the default PHP-FPM pool configuration `/etc/php/8.3/fpm/pool.d/www.conf`: `$ sudo nano www.conf`
  
  10. Find the [www] option to verify your PHP-FPM pool name.
  
  11. Find the user and group options and verify they run as the user: www-data.
  
  12. Find the listen directive and verify the socket path to access the PHP-FPM service on your server: `listen = /run/php/php8.3-fpm.sock`
  
  13. Restart PHP engine if changes were made: `sudo systemctl restart php8.3-fpm`
  
  14. If you ever need to uninstall PHP: 
     * `sudo apt-get purge php-fpm`
     * `sudo apt-get autoremove`
    
  ## [Python](https://www.python.org/doc/)
  Note the following may not apply to Ubuntu 24.04 so you are warned.
  
  As of 20 May 2023, Ubuntu 20.04 for WSL has an installed Python
  version that is greater than 3.7. This is incompatible with the 
  psycopg driver for Postgres. In order to access Postgres, you'll 
  need to install an alternative. The module pg8000 seems to work
  fine as a replacement. See the populate_tables.py script in this 
  repo for an example of how it works. For more info, see the pg8000 
  github page.
   
  ## [NGINX Webserver](https://nginx.org/en/docs/)
  Commands and configuration for running nginx on Ubuntu 24.04 WSL.

  1. Install the Nginx web server application to test access to the PHP-FPM service: `sudo apt install nginx -y`
  2. Back up the default Nginx virtual host configuration: `sudo mv /etc/nginx/sites-available/default  /etc/nginx/sites-available/default.BAK`
  3. Create a new default Nginx configuration file: `sudo nano /etc/nginx/sites-available/default`
  4. Add the following configurations to the file: 'server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root  /var/www/html/;
    index index.html index.php index.nginx-debian.html;

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_pass unix:/run/php/php-fpm.sock;
        fastcgi_index index.php;
        include fastcgi.conf;
    }
}'

  5. Save and close the file.
  6. Test the Nginx configuration for errors: `sudo nginx -t`
  7. Restart NginX: `sudo systemctl restart nginx`
  8. Summary of basic NginX vommands:
     * Start the PHP engine: `sudo service php8.3-fpm start`
     * Start the web server: `sudo service nginx start`
     * Restart the web server when config has changed: `sudo service nginx restart`
     * Stop the web server: `sudo service nginx stop`
  

  ## Automating Server Startup
  You can automate the startup of services under WSL in a number of ways. One way to accomplish this task is to place the commands in a bash script and execute that script after you login. This way you only execute one command and start the services when you actually need them. So, create a file in your home directory called `'start-sercices.sh'` and issue the command `sudo chmod +x start-sercices.sh` to make the file executable. Then edit the file and enter the following: 
  ```
     #!/bin/sh
     sudo service php8.3-fpm
     sudo service nginx start
     sudo service postgresql start
     sudo service mysql start  
  ```
  When you login and need to make the services available, just issie the command `. start-sercices.sh`

  
