defmodule Smarthood.Communities.Community do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Communities.{Community, CommunityUser}
  alias Smarthood.Accounts.User


  schema "communities" do
    field :description, :string
    field :name, :string
    many_to_many :users, User, join_through: CommunityUser  

    timestamps()
  end

  @doc false
  def changeset(%Community{} = community, attrs) do
    community
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
