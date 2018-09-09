defmodule Smarthood.Repo.Migrations.CreateCommunities do
  use Ecto.Migration

  def change do
    create table(:communities) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
