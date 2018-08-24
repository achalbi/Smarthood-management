defmodule Smarthood.Galleries.Photo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Galleries.Photo
  alias Smarthood.Accounts.User


  schema "photos" do
    field :public_id, :string
    field :secure_url, :string
    has_one :user, User
    timestamps()
  end

  @doc false
  def changeset(%Photo{} = photo, attrs) do
    photo
    |> cast(attrs, [:public_id, :secure_url])
    |> validate_required([:public_id])
  end
end
