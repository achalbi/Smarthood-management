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
end
