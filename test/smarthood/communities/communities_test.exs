defmodule Smarthood.CommunitiesTest do
  use Smarthood.DataCase

  alias Smarthood.Communities

  describe "communities" do
    alias Smarthood.Communities.Community

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def community_fixture(attrs \\ %{}) do
      {:ok, community} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Communities.create_community()

      community
    end

    test "list_communities/0 returns all communities" do
      community = community_fixture()
      assert Communities.list_communities() == [community]
    end

    test "get_community!/1 returns the community with given id" do
      community = community_fixture()
      assert Communities.get_community!(community.id) == community
    end

    test "create_community/1 with valid data creates a community" do
      assert {:ok, %Community{} = community} = Communities.create_community(@valid_attrs)
      assert community.description == "some description"
      assert community.name == "some name"
    end

    test "create_community/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communities.create_community(@invalid_attrs)
    end

    test "update_community/2 with valid data updates the community" do
      community = community_fixture()
      assert {:ok, community} = Communities.update_community(community, @update_attrs)
      assert %Community{} = community
      assert community.description == "some updated description"
      assert community.name == "some updated name"
    end

    test "update_community/2 with invalid data returns error changeset" do
      community = community_fixture()
      assert {:error, %Ecto.Changeset{}} = Communities.update_community(community, @invalid_attrs)
      assert community == Communities.get_community!(community.id)
    end

    test "delete_community/1 deletes the community" do
      community = community_fixture()
      assert {:ok, %Community{}} = Communities.delete_community(community)
      assert_raise Ecto.NoResultsError, fn -> Communities.get_community!(community.id) end
    end

    test "change_community/1 returns a community changeset" do
      community = community_fixture()
      assert %Ecto.Changeset{} = Communities.change_community(community)
    end
  end

  describe "sites" do
    alias Smarthood.Communities.Site

    @valid_attrs %{corner: true, cross: "some cross", direction_facing: "some direction_facing", info: "some info", measurement: "some measurement", phase: "some phase", site_number: "some site_number"}
    @update_attrs %{corner: false, cross: "some updated cross", direction_facing: "some updated direction_facing", info: "some updated info", measurement: "some updated measurement", phase: "some updated phase", site_number: "some updated site_number"}
    @invalid_attrs %{corner: nil, cross: nil, direction_facing: nil, info: nil, measurement: nil, phase: nil, site_number: nil}

    def site_fixture(attrs \\ %{}) do
      {:ok, site} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Communities.create_site()

      site
    end

    test "list_sites/0 returns all sites" do
      site = site_fixture()
      assert Communities.list_sites() == [site]
    end

    test "get_site!/1 returns the site with given id" do
      site = site_fixture()
      assert Communities.get_site!(site.id) == site
    end

    test "create_site/1 with valid data creates a site" do
      assert {:ok, %Site{} = site} = Communities.create_site(@valid_attrs)
      assert site.corner == true
      assert site.cross == "some cross"
      assert site.direction_facing == "some direction_facing"
      assert site.info == "some info"
      assert site.measurement == "some measurement"
      assert site.phase == "some phase"
      assert site.site_number == "some site_number"
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communities.create_site(@invalid_attrs)
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()
      assert {:ok, site} = Communities.update_site(site, @update_attrs)
      assert %Site{} = site
      assert site.corner == false
      assert site.cross == "some updated cross"
      assert site.direction_facing == "some updated direction_facing"
      assert site.info == "some updated info"
      assert site.measurement == "some updated measurement"
      assert site.phase == "some updated phase"
      assert site.site_number == "some updated site_number"
    end

    test "update_site/2 with invalid data returns error changeset" do
      site = site_fixture()
      assert {:error, %Ecto.Changeset{}} = Communities.update_site(site, @invalid_attrs)
      assert site == Communities.get_site!(site.id)
    end

    test "delete_site/1 deletes the site" do
      site = site_fixture()
      assert {:ok, %Site{}} = Communities.delete_site(site)
      assert_raise Ecto.NoResultsError, fn -> Communities.get_site!(site.id) end
    end

    test "change_site/1 returns a site changeset" do
      site = site_fixture()
      assert %Ecto.Changeset{} = Communities.change_site(site)
    end
  end

  describe "houses" do
    alias Smarthood.Communities.House

    @valid_attrs %{constructed_on_date: "2010-04-17 14:00:00.000000Z", construction_status: "some construction_status", house_number: "some house_number", house_type: "some house_type", kitchen: "some kitchen", main_door_facing: "some main_door_facing", members_count: 42}
    @update_attrs %{constructed_on_date: "2011-05-18 15:01:01.000000Z", construction_status: "some updated construction_status", house_number: "some updated house_number", house_type: "some updated house_type", kitchen: "some updated kitchen", main_door_facing: "some updated main_door_facing", members_count: 43}
    @invalid_attrs %{constructed_on_date: nil, construction_status: nil, house_number: nil, house_type: nil, kitchen: nil, main_door_facing: nil, members_count: nil}

    def house_fixture(attrs \\ %{}) do
      {:ok, house} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Communities.create_house()

      house
    end

    test "list_houses/0 returns all houses" do
      house = house_fixture()
      assert Communities.list_houses() == [house]
    end

    test "get_house!/1 returns the house with given id" do
      house = house_fixture()
      assert Communities.get_house!(house.id) == house
    end

    test "create_house/1 with valid data creates a house" do
      assert {:ok, %House{} = house} = Communities.create_house(@valid_attrs)
      assert house.constructed_on_date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert house.construction_status == "some construction_status"
      assert house.house_number == "some house_number"
      assert house.house_type == "some house_type"
      assert house.kitchen == "some kitchen"
      assert house.main_door_facing == "some main_door_facing"
      assert house.members_count == 42
    end

    test "create_house/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communities.create_house(@invalid_attrs)
    end

    test "update_house/2 with valid data updates the house" do
      house = house_fixture()
      assert {:ok, house} = Communities.update_house(house, @update_attrs)
      assert %House{} = house
      assert house.constructed_on_date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert house.construction_status == "some updated construction_status"
      assert house.house_number == "some updated house_number"
      assert house.house_type == "some updated house_type"
      assert house.kitchen == "some updated kitchen"
      assert house.main_door_facing == "some updated main_door_facing"
      assert house.members_count == 43
    end

    test "update_house/2 with invalid data returns error changeset" do
      house = house_fixture()
      assert {:error, %Ecto.Changeset{}} = Communities.update_house(house, @invalid_attrs)
      assert house == Communities.get_house!(house.id)
    end

    test "delete_house/1 deletes the house" do
      house = house_fixture()
      assert {:ok, %House{}} = Communities.delete_house(house)
      assert_raise Ecto.NoResultsError, fn -> Communities.get_house!(house.id) end
    end

    test "change_house/1 returns a house changeset" do
      house = house_fixture()
      assert %Ecto.Changeset{} = Communities.change_house(house)
    end
  end
end
