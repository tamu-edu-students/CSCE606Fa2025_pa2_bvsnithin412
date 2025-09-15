<!--
	Update the placeholders marked TODO: before submitting.
	Keep the Honor Code section if this is an individual assignment.
-->

# RottenPotatoes (CSCE 616 Programming Assignment)

> Course: CSCE 616 (Fall 2025)  
> Student: Venkata Sai Nithin Bazaru 
> Instructor: Prof. Ritchey  

This repository contains the starter / working code for the RottenPotatoes Rails application used in CSCE 616 to practice modern Ruby on Rails (Rails 8) concepts: MVC architecture, RESTful routing, asset pipeline with Import Maps & Propshaft, containerization, basic security tooling, and deployment workflow using Kamal.

## 1. Objectives

By completing this assignment you should be able to:

1. Set up and run a Rails 8 application (Ruby 3.4) locally and in Docker.
2. Add models, migrations, controllers, and views following Rails conventions.
3. Implement basic CRUD routes and RESTful patterns.
4. Utilize asset delivery with Import Maps (no Node build step) & Propshaft.
5. Run static analysis (Rubocop) and security scanning (Brakeman).
6. Understand production image build flow (multi-stage Docker + Thruster + Kamal deploy).
7. (Optional) Add progressive web app (PWA) manifest/service worker.

## 2. Tech Stack

| Layer | Technology |
|-------|------------|
| Language | Ruby 3.4.5 |
| Framework | Rails 8.0.2.1 |
| Web Server | Puma (wrapped by Thruster in container) |
| Assets | Propshaft + Importmap |
| DB (dev/test) | SQLite3 |
| Deployment | Kamal (container-based) |
| Static Analysis | Rubocop (Omakase) |
| Security Scan | Brakeman |

## 3. Repository Layout (Key Paths)

```
app/              # MVC code (controllers, models, views, assets)
bin/              # Rails & utility executables
config/           # Environment, routes, initializers
db/               # Seeds & schema/migrations (add your migrations here)
public/           # Static error pages, icons, robots.txt
Dockerfile        # Production-oriented build (multi-stage)
Gemfile           # Project dependencies
config/deploy.yml # Kamal deploy configuration (edit for real deployment)
```

## 4. Prerequisites

Install locally:

* Ruby 3.4.5 (recommend asdf or rbenv)
* Bundler (bundled with Ruby >= 2.6) – run `gem install bundler` if needed
* SQLite3 client library
* Git
* (Optional) Docker 24+ if using container workflow

Verify:

```bash
ruby -v    # should report 3.4.5
bundle -v  # Bundler version
sqlite3 --version
docker --version  # if using Docker
```

## 5. Initial Local Setup

```bash
bundle install
bin/rails db:prepare   # creates & migrates (development + test)
bin/rails server       # starts on http://localhost:3000
```

If you add new gems, re-run `bundle install`.

### Database Commands

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed      # (edit db/seeds.rb first)
bin/rails db:rollback  # undo last migration
```

## 6. Running in Docker (Production Image Locally)

The included `Dockerfile` is optimized for production (multi-stage, precompiled assets, non-root user). For quick local run:

```bash
docker build -t rottenpotatoes .
cp config/master.key /tmp/master.key   # ensure you have master.key
docker run -p 8080:80 -e RAILS_MASTER_KEY="$(cat config/master.key)" --name rottenpotatoes_app rottenpotatoes
```

App becomes available at: http://localhost:8080

To rebuild after changes:

```bash
docker rm -f rottenpotatoes_app || true
docker build -t rottenpotatoes . && docker run -p 8080:80 -e RAILS_MASTER_KEY="$(cat config/master.key)" --name rottenpotatoes_app rottenpotatoes
```

## 7. Development Tips

* Use `bin/dev` (if you add a Procfile.dev) for multi-process (e.g., JS bundlers) – currently not required due to Import Maps.
* Keep controllers skinny; push logic into models or PORO service objects as app grows.
* Add indexes in migrations for foreign keys & frequently queried columns.

## 8. Adding a Model (Example Walkthrough)

Example: Movie with title, rating, release_date.

```bash
bin/rails generate model Movie title:string rating:string release_date:date
bin/rails db:migrate
```

Add seed data in `db/seeds.rb` then:

```bash
bin/rails db:seed
```

Generate a controller & routes (RESTful):

```bash
bin/rails generate controller Movies index show new create edit update destroy
```

Edit `config/routes.rb`:

```ruby
resources :movies
root 'movies#index'
```

Then implement views in `app/views/movies/`.

## 9. Testing (Add If Required)

This skeleton does not ship with RSpec or Minitest system tests enabled. To enable RSpec (example):

```bash
bundle add rspec-rails --group "development,test"
bin/rails generate rspec:install
```

Then create specs under `spec/` and run:

```bash
bundle exec rspec
```

If the assignment requires Minitest instead, enable `rails/test_unit` in `config/application.rb` and re-run generators.

## 10. Code Quality & Security

Run Rubocop (style):

```bash
bundle exec rubocop
```

Run Brakeman (security):

```bash
bundle exec brakeman
```

Address warnings before submission when practical.

## 11. Deployment With Kamal (Overview)

Kamal uses your Docker image + SSH to remote hosts. Basic flow (conceptual):

1. Configure `config/deploy.yml` (set image name, host(s), registry, env).
2. Ensure registry login (e.g., GHCR or Docker Hub).
3. Build & push: `bundle exec kamal deploy` (Kamal automates build + rollout).

For the assignment you may only need to explain expected deployment steps rather than actually deploying (unless specified).

## 12. PWA Support (Optional)

Files in `app/views/pwa/` show how to serve a manifest & service worker. Uncomment related routes in `config/routes.rb` if you implement them:

```ruby
get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
```

Add in `app/views/layouts/application.html.erb` head section:

```erb
<link rel="manifest" href="<%= pwa_manifest_path %>">
```

## 13. Common Issues

| Symptom | Fix |
|---------|-----|
| Missing master.key error in Docker | Provide `RAILS_MASTER_KEY` env var or mount credentials. |
| `sqlite3` native extension fails | Ensure `libsqlite3` dev libs installed (on Debian: `apt-get install libsqlite3-dev`). |
| Assets not updating | Clear `tmp/cache` or restart server. |
| Route not found | Run `bin/rails routes | grep movies` to debug. |

## 14. Submission Checklist

Before submitting to Gradescope / LMS:

- [ ] README updated (removed TODO tags where appropriate)
- [ ] All migrations committed
- [ ] Seeds load successfully (if required)
- [ ] App boots locally (`bin/rails server`)
- [ ] Lint passes (or documented exceptions)
- [ ] Security scan run
- [ ] Git history clean (no large binaries, no secrets)


Happy coding! 🍿

