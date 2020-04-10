defmodule Teacher do
	defdelegate login(email, password), to: Teacher.Auth
end
