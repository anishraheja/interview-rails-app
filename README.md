# README

# Interview Rails App

This is a Ruby on Rails application using SQLite3 as the development and test database. This guide will help you get set up and running quickly.

## 🚀 Requirements

- Ruby 3.1.0 (Check with `ruby -v`)
- Rails 7.2.2 (Check with `rails -v`)
- SQLite3
- Bundler (`gem install bundler` if not already installed)

## 📦 Setup Instructions

### 1. Clone the Repository

```bash
git clone git@github.com:anishraheja/interview-rails-app.git
cd interview-rails-app

### 2. Intall gems
bundle install

### 3. Set Up the Database
rails db:create
rails db:migrate
