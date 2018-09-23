defmodule SmarthoodWeb.HouseControllerTest do
  use SmarthoodWeb.ConnCase

  alias Smarthood.Communities

  @create_attrs %{constructed_on_date: "2010-04-17 14:00:00.000000Z", construction_status: "some construction_status", house_number: "some house_number", house_type: "some house_type", kitchen: "some kitchen", main_door_facing: "some main_door_facing", members_count: 42}
  @update_attrs %{constructed_on_date: "2011-05-18 15:01:01.000000Z", construction_status: "some updated construction_status", house_number: "some updated house_number", house_type: "some updated house_type", kitchen: "some updated kitchen", main_door_facing: "some updated main_door_facing", members_count: 43}
  @invalid_attrs %{constructed_on_date: nil, construction_status: nil, house_number: nil, house_type: nil, kitchen: nil, main_door_facing: nil, members_count: nil}

  def fixture(:house) do
    {:ok, house} = Communities.create_house(@create_attrs)
    house
  end

  describe "index" do
    test "lists all houses", %{conn: conn} do
      conn = get conn, house_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Houses"
    end
  end

  describe "new house" do
    test "renders form", %{conn: conn} do
      conn = get conn, house_path(conn, :new)
      assert html_response(conn, 200) =~ "New House"
    end
  end

  describe "create house" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, house_path(conn, :create), house: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == house_path(conn, :show, id)

      conn = get conn, house_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show House"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, house_path(conn, :create), house: @invalid_attrs
      assert html_response(conn, 200) =~ "New House"
    end
  end

  describe "edit house" do
    setup [:create_house]

    test "renders form for editing chosen house", %{conn: conn, house: house} do
      conn = get conn, house_path(conn, :edit, house)
      assert html_response(conn, 200) =~ "Edit House"
    end
  end

  describe "update house" do
    setup [:create_house]

    test "redirects when data is valid", %{conn: conn, house: house} do
      conn = put conn, house_path(conn, :update, house), house: @update_attrs
      assert redirected_to(conn) == house_path(conn, :show, house)

      conn = get conn, house_path(conn, :show, house)
      assert html_response(conn, 200) =~ "some updated construction_status"
    end

    test "renders errors when data is invalid", %{conn: conn, house: house} do
      conn = put conn, house_path(conn, :update, house), house: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit House"
    end
  end

  describe "delete house" do
    setup [:create_house]

    test "deletes chosen house", %{conn: conn, house: house} do
      conn = delete conn, house_path(conn, :delete, house)
      assert redirected_to(conn) == house_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, house_path(conn, :show, house)
      end
    end
  end

  defp create_house(_) do
    house = fixture(:house)
    {:ok, house: house}
  end
end
