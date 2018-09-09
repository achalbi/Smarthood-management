defmodule Smarthood.Communities do
  @moduledoc """
  The Communities context.
  """

  import Ecto.Query, warn: false
  alias Smarthood.Repo

  alias Smarthood.Communities.Community
  alias Smarthood.Communities.CommunityUser

  @doc """
  Returns the list of communities.

  ## Examples

      iex> list_communities()
      [%Community{}, ...]

  """
  def list_communities do
    Repo.all(Community)
  end

  @doc """
  Gets a single community.

  Raises `Ecto.NoResultsError` if the Community does not exist.

  ## Examples

      iex> get_community!(123)
      %Community{}

      iex> get_community!(456)
      ** (Ecto.NoResultsError)

  """
  def get_community!(id), do: Repo.get!(Community, id)

  @doc """
  Creates a community.

  ## Examples

      iex> create_community(%{field: value})
      {:ok, %Community{}}

      iex> create_community(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_community(attrs \\ %{}) do
    %Community{}
    |> Community.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a community.

  ## Examples

      iex> update_community(community, %{field: new_value})
      {:ok, %Community{}}

      iex> update_community(community, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_community(%Community{} = community, attrs) do
    community
    |> Community.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Community.

  ## Examples

      iex> delete_community(community)
      {:ok, %Community{}}

      iex> delete_community(community)
      {:error, %Ecto.Changeset{}}

  """
  def delete_community(%Community{} = community) do
    Repo.delete(community)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking community changes.

  ## Examples

      iex> change_community(community)
      %Ecto.Changeset{source: %Community{}}

  """
  def change_community(%Community{} = community) do
    Community.changeset(community, %{})
  end


  def add_users_to_community(community_id, user_id, is_moderator) do
    attrs = %{"community_id" => community_id, "user_id" => user_id, "is_moderator" => is_moderator}
    %CommunityUser{}
    |> CommunityUser.changeset(attrs)
    |> Repo.insert() 
  end

  def remove_users_from_community(community_id, user_id) do
    if is_community_user?(community_id,user_id) do
        CommunityUser
        |> Repo.get_by(community_id: community_id, user_id: user_id)
        |> Repo.delete() 
    else
      {:error, "user doesn't exist"}  
    end
  end

  def is_community_user?(community_id,user_id) do
    CommunityUser
    |> Repo.get_by(community_id: community_id, user_id: user_id)
  end

  def is_community_moderator?(community_id,user_id) do
    cu = is_community_user?(community_id,user_id)
    if cu, do: cu.is_moderator, else: nil
  end

  def set_as_community_moderator(community_id,user_id) do
    attrs = %{is_moderator: true}
    is_community_user?(community_id,user_id)
    |> CommunityUser.changeset(attrs)
    |> Repo.update() 
  end
end
