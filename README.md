# MyCalendar

Track and access your Google Calendar events with this application.

## Features
* On successful sign in through Google account, all his calendars and events are imported to the App.
* User can sync the subsequent events and calendars which get created/updated are synced to the app.

## Technical details

* Uses Ruby on Rails, ruby version - ruby 2.6.2, rails version - Rails 5.2
* Uses PostreSQL database
* Uses OAuth2 for authentication and access control
* User Google Calendar APIs to import data from Google Calendar
* Currently a signed in user has options to the following : 
  - List his calendars
  - List events of particular calendar with basic info
  - List all events with basic info
  - Sync calendars and events with Google Calendar
* Data sync
  - Initial data sync is on successful sign in of user
  - Gives a *sync now* button to user for subsequent syncing of data
  - Subsequent syncing is implemented using a sidekiq worker
* Uses Rspec for Testing

## Steps to run locally 

1. Install & setup PostgreSQL locally
2. Setup Google Calendar API & OAuth consent screen and get client_id & client_secret.
3. Create application.yml file to store environment variables(google_client_id, google_client_secret).
4. Run bundle install
5. Run rails db:migrate
6. Start sidekiq server
7. Start rails server - rails s
