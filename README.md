# Rails Engine
Rails Engine is a [Turing](https://turing.io/) turing back end solo project which exposes several ecommerce endpoints to the [front end](https://github.com/turingschool-examples/rails_driver).


- Clone this repository by using the command ``` git clone git@github.com:mronauli/rails_engine.git```    

- Find your way to the rails_engine directory ``` cd rails_engine ```

- Install the gems include in the Gemfile ``` bundle ```

- Setup the database and import data from csv files in db folder:   
 ```
 rails db:drop , rails db:{create,migrate,seed}, rake create_models
 ```   
- Fire up the server ``` rails s ```

- Clone front end repository by using the command ``` https://github.com/turingschool-examples/rails_driver.git```  

- Find your way to the rails_engine directory ``` cd rails_driver ```

- Install the gems include in the Gemfile ``` bundle ```

- Setup the database
 ```
rails db:{create,migrate}
 ```   
- run ``` bundle exec figaro install ```
- in your config/application.yml append ``` RAILS_ENGINE_DOMAIN: http://localhost:3000 ```

- Fire up a separate server for the front end ``` rails s -p 3001 ```

