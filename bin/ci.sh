#!/bin/bash
set -e

TYPE=$1

if [ "$TYPE" = "lint" ] || [ "$TYPE" = "" ]; then
  bundle exec rubocop
fi

if [ "$TYPE" = "test" ] || [ "$TYPE" = "" ]; then
  ruby -Ilib:test ./test/sepa_parser_test.rb
fi