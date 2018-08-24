defmodule Smarthood.Plugs.TeamAuthorizer do
	import Plug.Conn

	alias Smarthood.Organizations

	@actions [:edit, :delete]

  def init(default), do: default

  def call(%Plug.Conn{:private => %{:phoenix_action => action, :phoenix_controller => SmarthoodWeb.TeamController}} = conn, _default) when action in @actions do
		organization = hd(conn.assigns.current_user.organizations)
		team = Organizations.get_team!(conn.params["id"])
		if Organizations.is_org_moderator?(conn.assigns.current_user.id, organization.id) || Organizations.is_team_moderator?(team,conn.assigns.current_user) do
			assign(conn, :authorized, true)
		else
			assign(conn, :authorized, false)
			Smarthood.Plugs.Authorizer.unauthorized_user(conn)
		end
	end

	def call(conn, _default), do: conn
end