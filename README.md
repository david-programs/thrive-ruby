# thrive-ruby

### Installation
This program use standard libraries that are default in most ruby distributions. You can ensure dependencieis are installed by running the following command:

```
bundle install
```

### Running the program


1. Put the `companies.json` and `users.json` file in the `/input` folder and run:

```
bundle exec ruby challenge.rb
```

Or if you don't have bundler:

```
ruby challenge.rb
```

You can also customize where the inputs will be with the `-u` and `-c` flags. For example:
```
bundle exec challenge.rb -u users_example.json -c companies_example.json
```
Use `bundle exec ruby challenge.rb --help for more details.


3. The output will default to `/output/output.txt` unless specified with `-o` flag. For example:
```
bundle exec challenge.rb -o other_output_example.txt
```

### Tests
Some basic unit tests are available with
```
bundle exec rake test
```
