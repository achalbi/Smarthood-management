defmodule Smarthood.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:sites) do
      add :site_number, :string
      add :measurement, :string
      add :total_area, :string
      add :direction_facing, :string
      add :corner, :boolean, default: false, null: false
      add :cross, :string
      add :phase, :string
      add :info, :text
      add :community_id, references(:communities, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:sites, [:community_id])
    create index(:sites, [:user_id])
    create index(:sites, [:community_id, :user_id])
    create index(:sites, [:site_number])
    create index(:sites, [:measurement])
    create index(:sites, [:direction_facing])
    create index(:sites, [:corner])
    create index(:sites, [:cross])
    create index(:sites, [:phase])
    create index(:sites, [:total_area])
  end
end
