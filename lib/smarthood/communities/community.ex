defmodule Smarthood.Communities.Community do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Communities.Community


  schema "communities" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Community{} = community, attrs) do
    community
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
