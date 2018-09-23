defmodule Smarthood.Repo.Migrations.CreateHouses do
  use Ecto.Migration

  def change do
    create table(:houses) do
      add :house_number, :string
      add :house_type, :string
      add :main_door_facing, :string
      add :members_count, :integer
      add :kitchen, :string
      add :construction_status, :string
      add :constructed_on_date, :utc_datetime
      add :site_id, references(:sites, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:houses, [:site_id])
    create index(:houses, [:user_id])
    create index(:houses, [:constructed_on_date])
  end
end
