defmodule Smarthood.Plugs.KeyResultAreaAuthorizer do
	import Plug.Conn

	@actions [:index, :new, :edit, :delete]

  def init(default), do: default

  def call(%Plug.Conn{:private => %{:phoenix_action => action, :phoenix_controller => SmarthoodWeb.KeyResultAreaController}} = conn, _default) when action in @actions do
		work_status = Smarthood.StatusTrack.get_work_status!(conn.params["work_status_id"])
		if conn.assigns.current_user.id == work_status.user_id  do
			assign(conn, :authorized, true)
		else
			assign(conn, :authorized, false)
			Smarthood.Plugs.Authorizer.unauthorized_user(conn)
		end
	end

	def call(conn, _default), do: conn
end