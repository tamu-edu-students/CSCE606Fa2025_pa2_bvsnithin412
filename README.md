# RottenPotatoes (CSCE 616 Programming Assignment)

> Course: CSCE 616 (Fall 2025)  
> Student: Venkata Sai Nithin Bazaru  
> Instructor: Prof. Ritchey  

This repository contains the RottenPotatoes Rails application used in CSCE 616 to practice Ruby on Rails (Rails 8) concepts: MVC architecture, RESTful routing, and basic CRUD operations.

## Live Demo

 **View the live application Deployed on Heroku:** [https://hidden-hamlet-49765-49d80390de70.herokuapp.com/movies](https://hidden-hamlet-49765-49d80390de70.herokuapp.com/movies)

## Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Ruby 3.4.5 |
| Framework | Rails 8.0.2.1 |
| Web Server | Puma |
| Database | SQLite3 |

## Prerequisites

* Ruby 3.4.5 (recommend asdf or rbenv)
* Bundler 
* SQLite3 client library
* Git

Verify:

```bash
ruby -v    # should report 3.4.5
bundle -v  # Bundler version
sqlite3 --version
```

## Setup & Running

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Setup database:**
   ```bash
   bin/rails db:prepare   # creates & migrates database
   bin/rails db:seed      # loads sample movies
   ```

3. **Start the server:**
   ```bash
   bin/rails server       # starts on http://localhost:3000
   ```

## Features

* **Movie Listing**: View all movies in a sortable table
* **Sort Functionality**: Click column headers to sort by Title, Rating, or Release Date
* **Add Movies**: Create new movies with title, rating, description, and release date
* **View Details**: Click on movie titles to see full details
* **Edit Movies**: Update existing movie information
* **Delete Movies**: Remove movies from the database

## Database Commands

```bash
bin/rails db:create     # create database
bin/rails db:migrate    # run migrations
bin/rails db:seed       # load sample data
bin/rails db:rollback   # undo last migration
```

```

## Project Structure

```
app/
├── controllers/        # Application logic
├── models/            # Data models
├── views/             # HTML templates
├── helpers/           # View helpers
└── assets/            # Stylesheets, JavaScript

config/
├── routes.rb          # URL routing
└── database.yml       # Database configuration

db/
├── migrate/           # Database migrations
└── seeds.rb           # Sample data
```

## Assignment Features Implemented

- ✅ Basic CRUD operations for movies
- ✅ Sortable columns (Title, Rating, Release Date) with session persistence
- ✅ Styled UI with centered forms and responsive design
- ✅ Date validation and proper error handling
- ✅ RESTful routing patterns


