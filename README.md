# Autoput

For now it's only a proof of concept and works with rspec > 2.0 only.

## Installation

In case you are using Bundler you can simply add this to your Gemfile:

    gem "autoput", :group => "development"

Otherwise you can install the gem manually:

    gem install autoput

## Workflow

Use the autoput binary to run your specs and automatically commit with
the output of the spec message if the specs passed. This can be used to
do the red-green-refactor testing cycle. Here's how it works in detail:

* Start out with a failing spec
* Run autoput - the message for the failing spec gets saved
* Make the spec run
* Run autoput - on green bar it commits with the saved message
* Time for refactoring - autoput amends your commit until you have
  a failing spec and then starts all over

## TODO

* Make it RSpec 1.x compatible
* Make it Cucumber compatible