<img src="images/banner.png" width="1000">


# MakersBnB Project By Team Runhappy



This repo contains the codebase for the MakersBnB project in Ruby by team Runhappy, the team consists of Emma, Haydn, Manaswini, Molly and Owen.

This is our MakersBnB App which is hosted on local host, the user is given the ability 
to register, 
to login as a Guest to book a space and view bookings,
to login as a Host to list a space, view his/her listings, view bookings for their listings and approve or deny them.
to view only spaces available for a particular date, book a space and logout.

Please find access to our project below.

## Setup

```bash
# Install gems
bundle install

# Create tables
psql -h 127.0.0.1

then do a CREATE DATABASE makersbnb;
CREATE DATABASE makersbnb_test;

then do psql -h 127.0.0.1 makersbnb_test < spec/seeds.sql

# Run the tests
rspec

# Run the server (better to do this in a separate terminal).
rackup

then enter http://127.0.0.1:9292/spaces into your web browser
```

## User Stories

Below you can find the user stories:


Spec: Any signed-up user can list a new space
```bash
As a user, 
So that I can access MakersBNB
I must be able to register with a email, username  and password

As a user, 
So that I can list a new space
I must be able to login with email address, username and password as a host

As a user 
So that I can book a space
I must be able to login with username and password as a guest
``` 

Spec: Users can list multiple spaces. 
```
As a user,
So that I can rent multiple spaces,
I want to list multiple spaces at the same time.
```

Spec: Users should be able to name their space, provide a short description of the space, and a price per night.
```
As a user,
So that guests can read my space details,
I want to give my space a name, description and price.
```

Spec: Users should be able to offer the date where their space is available.
```
As a user,
So that guests can see when my space is available,
I want to list the dates when my space is available.
``` 

Spec: Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
```
As a guest,
So that I can rent a space for a night,
I want to send a booking request to the host.
 
As a host
So that I can approve a request,
I want to see who requests to hire my space.
``` 

Spec: Nights for which a space has already been booked should not be available for users to book that space.
```
As a host, 
So that my space is not double booked,
I expect only available dates to be shown for spaces. 
``` 
 
Spec: Until a user has confirmed a booking request, that space can still be booked for that night.
```
As a host,
So that I can manage my bookings,
I need my spaces to be available until I confirm booking requests.
```
