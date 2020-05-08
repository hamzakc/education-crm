cd teacher_component/
echo 'Running tests for teacher component'
mix deps.get --only test && mix test

cd ../lesson_component/
echo 'Running tests for lesson component'
mix deps.get --only test
mix test
