defmodule Smarthood.AccountsTest do
  use Smarthood.DataCase

  alias Smarthood.Accounts

  describe "users" do
    alias Smarthood.Accounts.User

    @valid_attrs %{firstname: "some firstname", lastname: "some lastname", username: "some username"}
    @update_attrs %{firstname: "some updated firstname", lastname: "some updated lastname", username: "some updated username"}
    @invalid_attrs %{firstname: nil, lastname: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "credentials" do
    alias Smarthood.Accounts.Credential

    @valid_attrs %{email: "some email", password_hash: "some password_hash"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash"}
    @invalid_attrs %{email: nil, password_hash: nil}

    def credential_fixture(attrs \\ %{}) do
      {:ok, credential} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_credential()

      credential
    end

    test "list_credentials/0 returns all credentials" do
      credential = credential_fixture()
      assert Accounts.list_credentials() == [credential]
    end

    test "get_credential!/1 returns the credential with given id" do
      credential = credential_fixture()
      assert Accounts.get_credential!(credential.id) == credential
    end

    test "create_credential/1 with valid data creates a credential" do
      assert {:ok, %Credential{} = credential} = Accounts.create_credential(@valid_attrs)
      assert credential.email == "some email"
      assert credential.password_hash == "some password_hash"
    end

    test "create_credential/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_credential(@invalid_attrs)
    end

    test "update_credential/2 with valid data updates the credential" do
      credential = credential_fixture()
      assert {:ok, credential} = Accounts.update_credential(credential, @update_attrs)
      assert %Credential{} = credential
      assert credential.email == "some updated email"
      assert credential.password_hash == "some updated password_hash"
    end

    test "update_credential/2 with invalid data returns error changeset" do
      credential = credential_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_credential(credential, @invalid_attrs)
      assert credential == Accounts.get_credential!(credential.id)
    end

    test "delete_credential/1 deletes the credential" do
      credential = credential_fixture()
      assert {:ok, %Credential{}} = Accounts.delete_credential(credential)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_credential!(credential.id) end
    end

    test "change_credential/1 returns a credential changeset" do
      credential = credential_fixture()
      assert %Ecto.Changeset{} = Accounts.change_credential(credential)
    end
  end

  describe "roles" do
    alias Smarthood.Accounts.Role

    @valid_attrs %{description: "some description", key: "some key", name: "some name"}
    @update_attrs %{description: "some updated description", key: "some updated key", name: "some updated name"}
    @invalid_attrs %{description: nil, key: nil, name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Accounts.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Accounts.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Accounts.create_role(@valid_attrs)
      assert role.description == "some description"
      assert role.key == "some key"
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, role} = Accounts.update_role(role, @update_attrs)
      assert %Role{} = role
      assert role.description == "some updated description"
      assert role.key == "some updated key"
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_role(role, @invalid_attrs)
      assert role == Accounts.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Accounts.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Accounts.change_role(role)
    end
  end

  describe "contact_infos" do
    alias Smarthood.Accounts.ContactInfo

    @valid_attrs %{address1: "some address1", address2: "some address2", email1: "some email1", email2: "some email2", phone1: "some phone1", phone2: "some phone2"}
    @update_attrs %{address1: "some updated address1", address2: "some updated address2", email1: "some updated email1", email2: "some updated email2", phone1: "some updated phone1", phone2: "some updated phone2"}
    @invalid_attrs %{address1: nil, address2: nil, email1: nil, email2: nil, phone1: nil, phone2: nil}

    def contact_info_fixture(attrs \\ %{}) do
      {:ok, contact_info} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_contact_info()

      contact_info
    end

    test "list_contact_infos/0 returns all contact_infos" do
      contact_info = contact_info_fixture()
      assert Accounts.list_contact_infos() == [contact_info]
    end

    test "get_contact_info!/1 returns the contact_info with given id" do
      contact_info = contact_info_fixture()
      assert Accounts.get_contact_info!(contact_info.id) == contact_info
    end

    test "create_contact_info/1 with valid data creates a contact_info" do
      assert {:ok, %ContactInfo{} = contact_info} = Accounts.create_contact_info(@valid_attrs)
      assert contact_info.address1 == "some address1"
      assert contact_info.address2 == "some address2"
      assert contact_info.email1 == "some email1"
      assert contact_info.email2 == "some email2"
      assert contact_info.phone1 == "some phone1"
      assert contact_info.phone2 == "some phone2"
    end

    test "create_contact_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_contact_info(@invalid_attrs)
    end

    test "update_contact_info/2 with valid data updates the contact_info" do
      contact_info = contact_info_fixture()
      assert {:ok, contact_info} = Accounts.update_contact_info(contact_info, @update_attrs)
      assert %ContactInfo{} = contact_info
      assert contact_info.address1 == "some updated address1"
      assert contact_info.address2 == "some updated address2"
      assert contact_info.email1 == "some updated email1"
      assert contact_info.email2 == "some updated email2"
      assert contact_info.phone1 == "some updated phone1"
      assert contact_info.phone2 == "some updated phone2"
    end

    test "update_contact_info/2 with invalid data returns error changeset" do
      contact_info = contact_info_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_contact_info(contact_info, @invalid_attrs)
      assert contact_info == Accounts.get_contact_info!(contact_info.id)
    end

    test "delete_contact_info/1 deletes the contact_info" do
      contact_info = contact_info_fixture()
      assert {:ok, %ContactInfo{}} = Accounts.delete_contact_info(contact_info)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_contact_info!(contact_info.id) end
    end

    test "change_contact_info/1 returns a contact_info changeset" do
      contact_info = contact_info_fixture()
      assert %Ecto.Changeset{} = Accounts.change_contact_info(contact_info)
    end
  end
end
