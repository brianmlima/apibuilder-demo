# ApiBuilder Demo

This project has 2 purposes.
* To provide apibuilder services for developing Generators and Validators
 without using the public apibuilder.io application.
* To serve as a base platform for demonstrations of apibuilder.io and 
 api first methodology.

This is accomplished by exposing a docker image that can be started on 
OSX/Linux which contains the API and APP services with some minimal 
configuration such as

* A default organization configurable at runtime.
* An API token
* Example configuration files like .apibuilder/config
* Instructions on how to get apibuilder-cli configured  

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

#### Running Services

* OSX or Linux
* Docker running with command line utilities.
* Bash

#### Developing

* [apibuilder-cli](https://github.com/apicollective/apibuilder-cli) for 
code generation. On OSX you can install using 
```
brew install apibuilder-cli
```
* [docker-squash](https://github.com/apicollective/apibuilder-cli) for 
code generation. On OSX you can install using 
```
brew install apibuilder-cli


### Installing

* Clone this project in to your projects directory. For this example we will use 
**/opt/api-first/projects**

* Build the base and application images using 
```
/opt/api-first/projects/apibuilder-demo/bin/build.sh
```

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

This project is meant for dev and demonstration. It will not persist data 
over a container restart. 

## Built With

* Docker - Container Management
* Docker-Squash - Container Size Management
* Bash - Lifecycle Management

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Brian Lima** - *Initial work* - [BML](https://github.com/brianmlima)

See also the list of [contributors](https://github.com/your/apibuilder-demo/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to flow.io, this stuff is gold.

