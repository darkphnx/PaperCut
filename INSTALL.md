# Installation

## Prerequisites

PaperCut requires the following pieces of software to be available on your
server:

* Ruby 2.4+
* Bundler 1.17+
* MariaDB 10+

## Application

Clone the application onto your server.
```
git clone https://github.com/darkphnx/PaperCut.git
```

Enter the newly created directory and install the dependencies.
```
cd PaperCut/
bundle install
```

Copy the example database configuration in the config directory. Afterwards
edit `config/database.yml` and enter the details of your database server.
```
cp config/database.yml.example config/database.yml
```

Load the database schema into your database.
```
bundle exec rake db:schema:load
```

## Running

You can use [Procodile](https://github.com/adamcooke/procodile/) if you wish
to run PaperCut as a daemon, or simply run `bundle exec rails server` to start
a server on port 3000.
