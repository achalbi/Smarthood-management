defmodule Smarthood.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smarthood.Accounts.{User, Credential, Role, UserRole, ContactInfo}
  alias Smarthood.Organizations.{Team, UserTeam, Organization, UserOrganization}
  alias Smarthood.Galleries.Photo
  alias Smarthood.StatusTrack.WorkStatus
  alias Smarthood.Communities.{Community, CommunityUser}

  schema "users" do
    field :firstname, :string
    field :lastname, :string
    field :username, :string
    field :avatar, :string
    belongs_to :photo, Photo, on_replace: :nilify 
    has_one :credential, Credential
    has_one :contact_info, ContactInfo
    many_to_many :roles, Role, join_through: UserRole
    many_to_many :organizations, Organization, join_through: UserOrganization  
    many_to_many :communities, Community, join_through: CommunityUser  
    many_to_many :teams, Team, join_through: UserTeam 
    has_many :work_statuses, WorkStatus

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username, :avatar])
    |> cast_assoc(:contact_info)
    |> validate_required([])
  #  |> unique_constraint(:username)
  end
end
