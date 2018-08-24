defmodule SmarthoodWeb.PageView do
  use SmarthoodWeb, :view
  
  alias Smarthood.Accounts.User

  def current_user_fullname(conn) do
    %User{firstname: firstname, lastname: lastname} = current_user(conn)
    firstname <> " " <> lastname
  end
end
