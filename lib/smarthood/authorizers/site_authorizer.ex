defmodule Smarthood.Plugs.SiteAuthorizer do
	import Plug.Conn

	alias Smarthood.Communities

	@actions [:edit, :delete]

  def init(default), do: default

  def call(%Plug.Conn{:private => %{:phoenix_action => action, :phoenix_controller => SmarthoodWeb.SiteController}} = conn, _default) when action in @actions do
		current_user = conn.assigns.current_user
		community = current_user.community
    site = Smarthood.Communities.get_site!(conn.params["id"])
		if Communities.is_community_moderator?(community.id, current_user.id)|| (site.user_id == current_user.id)  do
			assign(conn, :authorized, true)
		else
			assign(conn, :authorized, false)
			Smarthood.Plugs.Authorizer.unauthorized_user(conn)
		end
	end

	def call(conn, _default), do: conn
end