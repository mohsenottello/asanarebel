#### containers

1- app

  It contains RoR application

2- postgres
  I am using db for two tables

  2-1  `Location`

    results of 3rd party request saved in this table, we can use this table for showing addresses instead of using 3rd party

    we can disable it by updating secret file `(search_locations[:save_db] && search_locations[:use_db])`

    And I save all useless information in data, maybe we can use it in future.

  2-2  `Token`

    For authenticating, I am using this table. So we can have a lot of customes with diffrent token hash for sending request to our application.

3- sidekiq

  For backgroundjob, I am using sidekiq. I will save results of 3rd party request by using sidkeiq because I dont want to increate response time.

4- Redis

  results of 3rd party request save in cache too. I am using Redis for this and also for handling sidekiq I need it.

#### How recieve to result

  For fetching all addresses

  1- cache(If exist)

  2- db(If it is active and exist)

  3- using third party

    If we face with any problem for fetching data, I will try to send another request.
    you can choose how many retries we need to be sure about our result by using secret file.
    If all requests are mot successful, we show our customers 3rd party error with same status code.
    But it is possible to show some specific error with specific message for 3rd party request problem.

  4- unfortunetly, In this task, it is not clear if we have a lot of results from 3rd party, So I show all of them in one array.
     It is very simple if we just want to show only one result.

## Development environment setup
To run and use this app as I did, you need to have docker and docker-compose on your machine:
* Docker version 19.03.8
* docker-compose version 1.24.1

#### 1 create containers

`docker-compose build`

#### 2 Run server
This command runs web server:

`docker-compose up`

#### 3 Run rails console
`docker-compose run app rails c`

#### 4 Run rspec test
`docker-compose run -e RAILS_ENV=test app rake db:setup`
`docker-compose run -e RAILS_ENV=test app bundle exec rspec`

#### 5 using API

for using API we can use this address

`localhost:3000/api/search_address`

but we should also provide:

`HEADER: AuthenticationToken`

and

`params: address_details`
