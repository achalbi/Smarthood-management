defmodule Smarthood.Communities do
  @moduledoc """
  The Communities context.
  """
  require IEx

  import Ecto.Query, warn: false
  alias Smarthood.Repo

  alias Smarthood.Communities.Community
  alias Smarthood.Communities.CommunityUser
  alias Smarthood.Accounts.User

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
    attrs = %{"community_id" => community_id, "user_id" => user_id, "is_moderator" => is_moderator, "active" => true}
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

  alias Smarthood.Communities.Site

  @doc """
  Returns the list of sites.

  ## Examples

      iex> list_sites()
      [%Site{}, ...]

  """
  def list_sites do
    Repo.all(Site)
  end

  @doc """
  Gets a single site.

  Raises `Ecto.NoResultsError` if the Site does not exist.

  ## Examples

      iex> get_site!(123)
      %Site{}

      iex> get_site!(456)
      ** (Ecto.NoResultsError)

  """
  def get_site!(id), do: Repo.get!(Site, id)

  @doc """
  Creates a site.

  ## Examples

      iex> create_site(%{field: value})
      {:ok, %Site{}}

      iex> create_site(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_site(attrs \\ %{}) do
    %Site{}
    |> Site.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a site.

  ## Examples

      iex> update_site(site, %{field: new_value})
      {:ok, %Site{}}

      iex> update_site(site, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_site(%Site{} = site, attrs) do
    site
    |> Site.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Site.

  ## Examples

      iex> delete_site(site)
      {:ok, %Site{}}

      iex> delete_site(site)
      {:error, %Ecto.Changeset{}}

  """
  def delete_site(%Site{} = site) do
    Repo.delete(site)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking site changes.

  ## Examples

      iex> change_site(site)
      %Ecto.Changeset{source: %Site{}}

  """
  def change_site(%Site{} = site) do
    Site.changeset(site, %{})
  end


  def get_active_user_community(user_id) do
    result = CommunityUser
    |> Repo.get_by(active: true, user_id: user_id)
    |> Repo.preload(:community)
    unless is_nil(result) do
      result.community
    end
  end
end
