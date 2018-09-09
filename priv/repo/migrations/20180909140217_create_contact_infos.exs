defmodule Smarthood.Repo.Migrations.CreateContactInfos do
  use Ecto.Migration

  def change do
    create table(:contact_infos) do
      add :email1, :string
      add :email2, :string
      add :phone1, :string
      add :phone2, :string
      add :address1, :text
      add :address2, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:contact_infos, [:user_id])
  end
end
