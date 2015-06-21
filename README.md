# README

This is my first Rails app. Find your yoga class in Berlin. Determine your search by time, weekday and your favourite yoga art.

- Frontpage has JS filter
- Coursepage has ruby filter
- Admin login and function to manage content.

## Installation
- Clone repo and run `bundle install`
- Run `rake db:setup` to prepare DB and fill it with dara from seed.

Admin login:
name:		'admin'
pw: 		'qwe123!'

Initial:
- Relationships between classes
- Admin area and restricted admin function
- Added a terrific design
- Frontpage has now javascript based filter
  - Improved filter: separate search

TODO:
- Rspec tests

JS filter:
 - Add animation for height
 - Add result count
 - Ajax call loads part of secured session? (still there?)
 - Change ajax call for json

2015
Done:
  - Basic filter for Course page to filter by attributes.

2014
Done in Calendar Week 35:
- Deployed new version at Heroku (after resolving of problems )

Done in Calendar Week 34:

Admin:
- Valdiation: Require strenght password validation.
- New Admin: Information for proper validation password added.
Course:
- Validation: Times Validates now.
- layout new: Information for the proper validation time format added.

JS filter:
 - Script loads after refresh (turbolink issue)
 - Filter with time added

<tt>rake doc:app</tt>.
