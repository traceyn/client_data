# Client Data

Client Data is a command line tool for searching within an existing set of clients.
It currently supports searching clients by name and identifying duplicate email addresses.

## Author
[Tracey Norrish](https://github.com/traceyn)

## Setup and usage instructions

### Prerequisites:
- Ruby (version 3.x)
- bundler gem

### Installation:

No installation is required for running the tool.

To run the tests, first use bundler to install rspec
```sh
bundle install
```

### Usage:

This tool provides two search options.

1. Search through all clients and return those with names partially matching a given search query
```sh
bin/client_data.rb search <name>
```

2. Find out if there are any clients with the same email in the dataset, and show those duplicates if any are found
```sh
bin/client_data.rb find_duplicates
```

### Running tests

Tests can be run using rspec:
```sh
rspec spec
```

## Assumptions and decisions made

### Search assumptions
- search is case insensitive
- partial matches will be returned
- no results will be returned for a whitespace search
- the escape character \ has been ignored

### Finding duplicates assumptions
- duplicates are only identified by email
- any duplicate email will be returned
- user input when finding duplicates will be ignored

## Known limitations and areas for future improvement
This tool has been built to work wiht a hardcoded set of JSON client data. Further changes would be required if this was to use a dynamic source of client data.

Changes might include:
- JSON schema validation
- a dedicated data store
- more complex search logic
- optimisations for faster searching of a larger dataset or more complex data structure

### Limitations
- this has been tested with ruby version 3.0 to 3.4. Other ruby versions may or may not be supported
- the clients list is hardcoded rather than created dynamically
- the code and tests have been built to perform two very specific commands. As such it would need refactoring if it needed to become more generic

### Future improvements
- specs could be improved by using fixture or factories for data setup
- more sophisticated search if required including fuzzy search, case sensitivity options, regex
- search could be expanded to allow the user to specify the key and value to search for rather than only name
- finding duplicates could be extended to allow the user to specify a key and value to search for duplicates on
- the output could make use of colour or highlighting to identify where a partial match has been found
- results could be output to a file rather than stdout
- this tool could be made into a gem with versioning






