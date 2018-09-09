defmodule Smarthood.Repo.Migrations.CreateCommunityUsers do
  use Ecto.Migration

  def change do
    create table(:community_users) do
      add :community_id, references(:communities, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
      add :is_moderator, :boolean, default: false, null: false

      timestamps()
    end

    create index(:community_users, [:community_id])
    create index(:community_users, [:user_id])
    create index(:community_users, [:community_id, :user_id])
  end
end
