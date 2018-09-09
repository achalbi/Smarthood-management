defmodule SmarthoodWeb.CommunityController do
  use SmarthoodWeb, :controller

  alias Smarthood.Communities
  alias Smarthood.Communities.Community

  def index(conn, _params) do
    communities = Communities.list_communities()
    render(conn, "index.html", communities: communities)
  end

  def new(conn, _params) do
    changeset = Communities.change_community(%Community{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"community" => community_params}) do
    case Communities.create_community(community_params) do
      {:ok, community} ->
        conn
        |> put_flash(:info, "Community created successfully.")
        |> redirect(to: community_path(conn, :show, community))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    community = Communities.get_community!(id)
    render(conn, "show.html", community: community)
  end

  def edit(conn, %{"id" => id}) do
    community = Communities.get_community!(id)
    changeset = Communities.change_community(community)
    render(conn, "edit.html", community: community, changeset: changeset)
  end

  def update(conn, %{"id" => id, "community" => community_params}) do
    community = Communities.get_community!(id)

    case Communities.update_community(community, community_params) do
      {:ok, community} ->
        conn
        |> put_flash(:info, "Community updated successfully.")
        |> redirect(to: community_path(conn, :show, community))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", community: community, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    community = Communities.get_community!(id)
    {:ok, _community} = Communities.delete_community(community)

    conn
    |> put_flash(:info, "Community deleted successfully.")
    |> redirect(to: community_path(conn, :index))
  end
end
