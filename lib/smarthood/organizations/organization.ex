defmodule Smarthood.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Organizations.{Organization, UserOrganization, Team, Domain}
  alias Smarthood.Accounts.User
  alias Smarthood.StatusTrack.WorkStatus
  alias Smarthood.StatusTrack.WorkStatusType
  alias Smarthood.Spreadsheets.Spreadsheet


  schema "organizations" do
    field :description, :string
    field :name, :string
    many_to_many :users, User, join_through: UserOrganization  
    has_many :teams, Team
    has_many :work_statuses, WorkStatus
    has_many :work_status_types, WorkStatusType
    has_many :domains, Domain
    has_one :spreadsheet, Spreadsheet

    timestamps()
  end

  @doc false
  def changeset(%Organization{} = organization, attrs) do
    organization
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
