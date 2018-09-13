defmodule Smarthood.Repo.Migrations.AddActiveIdToCommunityUsers do
  use Ecto.Migration

  def change do
    alter table(:community_users) do
      add :active, :boolean, default: false, null: false
    end
    create index(:community_users, [:community_id, :user_id, :active])
  end
end
