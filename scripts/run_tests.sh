#!/bin/bash
set -ev

cd teacher_component/
echo 'Running tests for teacher component'
mix local.hex --force
mix deps.get --only test && mix test

cd ../lesson_component/
echo 'Running tests for lesson component'
mix local.hex --force
mix deps.get --only test
mix test

cd ../child_component/
echo 'Running tests for child component'
mix local.hex --force
mix deps.get --only test
mix test

cd ../subject_component/
echo 'Running tests for subject component'
mix local.hex --force
mix deps.get --only test
mix test

cd ../class_component/
echo 'Running tests for class component'
mix local.hex --force
mix deps.get --only test
mix test
