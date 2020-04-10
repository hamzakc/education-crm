defmodule Teacher.Auth do

	alias Teacher.{Teacher}

	def login(email, password) do
		authenticate(email, password)
	end

	# Move to Authenticate component
	defp authenticate(email, _password) do
		{ :ok,
			%Teacher{
				email: email,
				first_name: 'Iqbal',
				last_name: 'Khan',
				tel: '09302883',
				position: 'Head of Boys Islamic Studies'
			}
		}
	end
end
