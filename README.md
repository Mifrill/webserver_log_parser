## Skeleton

Entry point is `parser.rb` script with top level shebang
It loads all required classes and calls Application with provided arguments
The structure based on logic flow:
```
-> App
    (the base logic of application with global exceptions handler)
    -> wrap Cli
     (logic to handle run commands)
        -> wrap Source
         (File or any other external sources to fetch content with checks)
            -> wrap Store
             (setup storage (DB) and insert data with validation logic)
                -> wrap Aggregator
                 (business logic of data processing)
                    -> wrap Presenter
                    (output of processed results by console or any other ways)
```
## TODO:
- gracefully prevent fail of insert all rows by error in one row
- import source from content "as in" into raw_content table -> insert rows from raw_content table
- gem 'addressable' for model validation IP/route
- encapsulate solution in a Gem

## Run

    ./parser.rb webserver.log

## Tests

    COVERAGE=true bundle exec rspec

## Lints

    bundle exec rubocop

______________
### Test description

```
The test is as follows: ruby_app

Write a ruby script that:
a. Receives a log as argument (webserver.log is provided)
e.g.: ./parser.rb webserver.log
b. Returns the following:
> list of webpages with most page views ordered from most pages views to less page views
e.g.:
/home 90 visits 
/index 80 visits
 etc... 
> list of webpages with most unique page views also ordered
e.g.:
/about/2 8 unique views
/index 5 unique views
 etc...
```
