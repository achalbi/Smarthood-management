defmodule Smarthood.ToDos.ToDoUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.ToDos.ToDoUser
  alias Smarthood.ToDos.ToDo
  alias Smarthood.Accounts.User


  schema "to_do_users" do
    belongs_to :to_do, ToDo
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%ToDoUser{} = to_do_user, attrs) do
    to_do_user
    |> cast(attrs, [:to_do_id, :user_id])
    |> validate_required([])
  end
end
