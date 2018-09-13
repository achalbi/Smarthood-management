defmodule Smarthood.Auth.CurrentUser do
  import Plug.Conn
  import Guardian.Plug

  alias Smarthood.Repo

  def init(opts), do: opts
  
  def call(conn, _opts) do
    current_user = current_resource(conn) |> Repo.preload([:credential, :photo, :communities, organizations: :work_status_types])
    assign(conn, :current_user, current_user)
  end
end