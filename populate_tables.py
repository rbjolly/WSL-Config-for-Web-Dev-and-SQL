# When DBeaver generated this file, it requires that python have the 
# followingh modules installed in order to query Postgres:
#   psycopg2==2.8.5
#   python-decouple==3.3

# But to run under Ubuntu 20.04 on WSL, which has a version of 
# Python (3.7+ as of 2023-05-18) which is not compatible with the 
# above listed modules, you'll need to install an alternative. I chose pg8000.
# So, this example file, which is based on a backup file created using DBeaver
# shows the pg8000 code required to connect and query a local Postgres server.
# For more info, see the pg8000 github page.
import pg8000.native

def insert_entries(table_name):
    fname = f'data/{table_name}.csv'
    
    with open(f'{fname}', 'r') as file:
        lines = [ i.strip().split(',') for i in file.readlines() ]

        # Format the values by type and insert them into the values list
        for line in lines:
            values = ""

            # Add quotes only if a string
            for i in line:
                try:
                    int(i)
                    values += f", {i}"
                except ValueError:
                    # Format correctly if date
                    if '/' in i:
                        date = i.replace('/', '')
                        values += f", '{date[4:]}/{date[2:4]}/{date[:2]}'"
                    else:
                        values += f", '{i}'"

            # Execute the query when all values areaadded
            con.run(f"INSERT INTO {table_name} VALUES({values[2:]})")
            con.run("COMMIT")


# Populate database connection options with your credentials.
dbname   = ""
user     = ""
password = ""

# Connect the database
con = pg8000.native.Connection(user, database=dbname, password=password)
con.run("START TRANSACTION")

# Insert entries for each table
table_names = ['author', 'client', 'book', 'borrower']
for i in table_names:
    print(f'\nTable : {i}')
    insert_entries(i)
    
print ("Done\n")
