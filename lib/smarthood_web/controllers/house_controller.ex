defmodule SmarthoodWeb.HouseController do
  use SmarthoodWeb, :controller

  alias Smarthood.Communities
  alias Smarthood.Communities.House

  def index(conn, _params) do
    houses = Communities.list_houses()
    render(conn, "index.html", houses: houses)
  end

  def new(conn, %{"site_id" => id}) do
    changeset = Communities.change_house(%House{}, id, conn.assigns[:current_user].id )
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"house" => house_params}) do
    date = Timex.parse!(house_params["constructed_on_date"], "%Y-%m-%d", :strftime)
    house_params = Map.put(house_params, "constructed_on_date", date)
    case Communities.create_house(house_params) do
      {:ok, house} ->
        conn
        |> put_flash(:info, "House created successfully.")
        |> redirect(to: house_path(conn, :show, house))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    house = Communities.get_house!(id)
    render(conn, "show.html", house: house)
  end

  def edit(conn, %{"id" => id}) do
    house = Communities.get_house!(id)
    changeset = Communities.change_house(house)
    render(conn, "edit.html", house: house, changeset: changeset)
  end

  def update(conn, %{"id" => id, "house" => house_params}) do
    house = Communities.get_house!(id)

    case Communities.update_house(house, house_params) do
      {:ok, house} ->
        conn
        |> put_flash(:info, "House updated successfully.")
        |> redirect(to: house_path(conn, :show, house))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", house: house, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    house = Communities.get_house!(id)
    {:ok, _house} = Communities.delete_house(house)

    conn
    |> put_flash(:info, "House deleted successfully.")
    |> redirect(to: house_path(conn, :index))
  end
end
