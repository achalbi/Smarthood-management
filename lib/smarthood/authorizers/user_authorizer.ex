defmodule Smarthood.Plugs.UserAuthorizer do

	import Plug.Conn

	alias Smarthood.Organizations

  def init(default), do: default

  # def call(%Plug.Conn{:private => %{:phoenix_action => :edit, :phoenix_controller => SmarthoodWeb.UserController}} = conn, _default) do
	# 	organization = hd(conn.assigns.current_user.organizations)
	# 	if Organizations.is_org_moderator?(conn.assigns.current_user.id, organization.id) || (String.to_integer(conn.params["id"]) == conn.assigns.current_user.id)  do
	# 		assign(conn, :authorized, true)
	# 	else
	# 		assign(conn, :authorized, false)
	# 		Smarthood.Plugs.Authorizer.unauthorized_user(conn)
	# 	end
  # end
  
  # def call(%Plug.Conn{:private => %{:phoenix_action => :delete, :phoenix_controller => SmarthoodWeb.UserController}} = conn, _default) do
	# 	organization = hd(conn.assigns.current_user.organizations)
	# 	if Organizations.is_org_moderator?(conn.assigns.current_user.id, organization.id) do
	# 		assign(conn, :authorized, true)
	# 	else
	# 		assign(conn, :authorized, false)
	# 		Smarthood.Plugs.Authorizer.unauthorized_user(conn)
	# 	end
	# end

	def call(conn, _default), do: conn
end