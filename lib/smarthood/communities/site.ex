defmodule Smarthood.Communities.Site do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Communities.Site


  schema "sites" do
    field :corner, :boolean, default: false
    field :cross, :string
    field :direction_facing, :string
    field :info, :string
    field :total_area, :string
    field :measurement, :string
    field :phase, :string
    field :site_number, :string
    field :community_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Site{} = site, attrs) do
    site
    |> cast(attrs, [:site_number, :measurement, :direction_facing, :corner, :cross, :phase, :info, :total_area])
    |> validate_required([:site_number, :total_area, :cross, :phase])
  end
end
