defmodule Smarthood.Communities.CommunityUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Communities.CommunityUser


  schema "community_users" do
    field :community_id, :id
    field :user_id, :id
    field :is_moderator, :boolean

    timestamps()
  end

  @doc false
  def changeset(%CommunityUser{} = community_user, attrs) do
    community_user
    |> cast(attrs, [:community_id, :user_id, :is_moderator])
    |> validate_required([:community_id, :user_id, :is_moderator])
  end
end
