defmodule SmarthoodWeb.LayoutView do
  use SmarthoodWeb, :view

  def title do
    "Smarthood"
  end

  def current_user_fullname(conn) do
    %Smarthood.Accounts.User{firstname: firstname, lastname: lastname} = Smarthood.Accounts.current_user(conn)
    firstname <> " " <> lastname
  end
end
