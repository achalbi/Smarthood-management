defmodule Smarthood.Communities.House do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Communities.House


  schema "houses" do
    field :constructed_on_date, :utc_datetime
    field :construction_status, :string
    field :house_number, :string
    field :house_type, :string
    field :kitchen, :string
    field :main_door_facing, :string
    field :members_count, :integer
    field :site_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%House{} = house, attrs) do
    house
    |> cast(attrs, [:house_number, :house_type, :main_door_facing, :members_count, :kitchen, :construction_status, :constructed_on_date, :site_id, :user_id])
    |> validate_required([:house_number, :house_type, :main_door_facing, :members_count, :kitchen, :construction_status, :constructed_on_date])
  end
end
