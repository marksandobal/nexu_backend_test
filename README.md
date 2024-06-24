# Backedn Nexu Test Project

## Installation

The following features are required to run the project locally:

* Ruby version 3.3.0

* Rails version 7.1.3.4

* PostgreSQL version 14.1

## Configuration

* Database creation
 1. `bundle install`
 2. `rails db:create`
 3. `rails db:migrate`
 4. `rails db:seed`

* How to run the test suite
  * To Run all Test

     `bundle exec rspec`

  * To Run test with a specified file
    
    `bundle exec rspec spec/custom_folder/custom_file_spec.rb`

  * To Run test with a specified line
    
    `bundle exec rspec spec/custom_folder/custom_file_spec.rb:12`

* To Run Project

   `rails s` or `bundle exec rails server`

  To run Project with network ip
  
   `rails s -b 0.0.0.0`

  for example:
  
   `rails s -b 192.168.1.100`

* To Run Brakeman
  
   `bundle exec brakeman -z`

# instruction for use
The api is open without a token or session, but the following vendor must be included in the request headers, otherwise you will receive a non-existent route error.

`Accept: application/vnd.nexu-backend-api.v1+json`

If you consume the endpoint from postman, you have to add the vendor in the postman headers

# Note

The project was carried out with an architecture that can be readable without the need to comment on each method. The life cycle of a request works as follows.

- Request is sent to the router which is part of the rails application.
- The router sends the request to the controller.
- The controller sends the request to the Form object class.
- The repository sends the request to the model.
- The model sends the request to the database.

We try to apply the first SOLID principle: __Single Responsibility Principle__, In which each element that consolidates a process has the sole responsibility of doing what corresponds to it, who works together with the delegator design pattern.

You can find a guide on how to structure the architecture of your project in the following blog.
https://www.nopio.com/blog/how-to-organize-large-rails-applications/

## API Versioning

* For future versioning in the Api, logic is added in a class called ApiVersionConstraint.
You can find more details in the following blog http://railscasts.com/episodes/350-rest-api-versioning?view=asciicast

## What needs to be completed?

* To consolidate the security of the application. It is required to install a tokenization service with JWT or devise jwt

* Pagination should also be added for the lists of brands and models.

## Brakeman

![brakeman](brakeman.png)

* Note: The brakeman gem is added to validate possible security flaws in the development of the application.

If you want to know more, visit: https://brakemanscanner.org/

## Test Note:

There is an error in the filter statements with greater and lower params. One of the values ​​does not correspond to the filtering done by the parameters, since the value is much higher than the given range

```JSON
[
  {"id": 1264, "name": "NSX", "average_price": 3818225},
  {"id": 3, "name": "RDX", "average_price": 395753}
]

```

The object has the `average_price` field at $3,818,225 and it leaves the range of $300,000 and $400,000.
```JSON
{"id": 1264, "name": "NSX", "average_price": 3818225}
```
