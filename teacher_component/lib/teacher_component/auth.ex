defmodule TeacherComponent.Auth do
  alias TeacherComponent.{Teacher}

  def load(email, password) do
    authenticate(email, password)
  end

  # TODO Generate seed data / Hook into mock server
  defp authenticate(email, _password) do
    {:ok,
     %Teacher{
       email: email,
       first_name: 'Iqbal',
       last_name: 'Khan',
       tel: '09302883',
       position: 'Head of Boys Maths Department'
     }}
  end
end
