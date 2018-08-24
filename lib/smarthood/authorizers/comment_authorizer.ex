defmodule Smarthood.Plugs.CommentAuthorizer do
	import Plug.Conn

	@actions [:edit, :delete]

  def init(default), do: default

  def call(%Plug.Conn{:private => %{:phoenix_action => action, :phoenix_controller => SmarthoodWeb.CommentController}} = conn, _default) when action in @actions do
		comment = Smarthood.StatusTrack.get_comment!(conn.params["id"])
		if conn.assigns.current_user.id == comment.user_id  do
			assign(conn, :authorized, true)
		else
			assign(conn, :authorized, false)
			Smarthood.Plugs.Authorizer.unauthorized_user(conn)
		end
	end

	def call(conn, _default), do: conn
end