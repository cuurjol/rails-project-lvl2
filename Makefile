install:
	bundle install
	yarn install

db-drop:
	bundle exec rails db:drop

db-migrate:
	bundle exec rails db:migrate

db-reset:
	bundle exec rails db:drop db:create db:migrate

console:
	bundle exec rails console

linters:
	bundle exec rubocop
	bundle exec slim-lint app/views

test:
	bundle exec rails test

heroku-deploy:
	git push heroku main

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail

.PHONY: test