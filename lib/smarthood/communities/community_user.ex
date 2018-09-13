defmodule Smarthood.Communities.CommunityUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Communities.{CommunityUser, Community}
  alias Smarthood.Accounts.User


  schema "community_users" do
    belongs_to :community, Community
    belongs_to :user, User
    field :is_moderator, :boolean
    field :active, :boolean

    timestamps()
  end

  @doc false
  def changeset(%CommunityUser{} = community_user, attrs) do
    community_user
    |> cast(attrs, [:community_id, :user_id, :is_moderator, :active])
    |> validate_required([:community_id, :user_id])
  end
end
