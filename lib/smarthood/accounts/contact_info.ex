defmodule Smarthood.Accounts.ContactInfo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Accounts.ContactInfo


  schema "contact_infos" do
    field :address1, :string
    field :address2, :string
    field :email1, :string
    field :email2, :string
    field :phone1, :string
    field :phone2, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%ContactInfo{} = contact_info, attrs) do
    contact_info
    |> cast(attrs, [:email1, :email2, :phone1, :phone2, :address1, :address2, :user_id])
    |> validate_required([:email1, :phone1, :address1, :user_id])
  end
end
