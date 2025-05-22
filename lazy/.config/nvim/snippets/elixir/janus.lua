local policy = [[
defmodule App.${1:Orgs} do
  @moduledoc """
  The $1 context.
  """

  import Ecto.Query, warn: false

  alias App.$1.${2:Org}
  alias App.Accounts.Scope
  import App.Accounts.Policy

  @doc """
  Subscribes to scoped notifications about any ${3:org} changes.

  The broadcasted messages match the pattern:

    * {:created, %$2{}}
    * {:updated, %$2{}}
    * {:deleted, %$2{}}

  """
  def subscribe_$3s(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(App.PubSub, "user:#{key}:$3s")
  end

  defp broadcast(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(App.PubSub, "user:#{key}:$3s", message)
  end

  @doc """
  Returns the list of $3s.

  ## Examples

      iex> list_$3s(scope)
      [%$2{}, ...]

  """
  def list_$3s(scope) when is_nil(scope) do
    authorized_fetch_all($2, authorize: {:list, scope})
  end

  def list_$3s(%Scope{} = scope) do
    authorized_fetch_all($2, authorize: {:list, scope})
  end

  @doc """
  Gets a single $3.

  Raises `Ecto.NoResultsError` if the $2 does not exist.

  ## Examples

      iex> get_$3!(123)
      %$2{}

      iex> get_$3!(456)
      ** (Ecto.NoResultsError)

  """
  def get_$3!(%Scope{} = scope, id) do
    authorized_fetch_by($2, [id: id], authorize: {:read, scope})
  end

  @doc """
  Creates a $3.

  ## Examples

      iex> create_$3(%{field: value})
      {:ok, %$2{}}

      iex> create_$3(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_$3(%Scope{} = scope, attrs) do
    with {:ok, $3 = %$2{}} <-
           change_$3(scope, %$2{}, attrs)
           |> authorized_insert(authorize: {:create, scope}) do
      broadcast(scope, {:created, $3})
      {:ok, $3}
    end
  end

  @doc """
  Updates a $3.

  ## Examples

      iex> update_$3($3, %{field: new_value})
      {:ok, %$2{}}

      iex> update_$3($3, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_$3(%Scope{} = scope, %$2{} = $3, attrs) do
    with {:ok, $3 = %$2{}} <-
           change_$3(scope, $3, attrs)
           |> authorized_update(authorize: {:update, scope}) do
      broadcast(scope, {:updated, $3})
      {:ok, $3}
    end
  end

  @doc """
  Deletes a $3.

  ## Examples

      iex> delete_$3($3)
      {:ok, %$2{}}

      iex> delete_$3($3)
      {:error, %Ecto.Changeset{}}

  """
  def delete_$3(%Scope{} = scope, %$2{} = $3) do
    with {:ok, $3 = %$2{}} <-
           authorized_delete($3, authorize: {:archive, scope}) do
      broadcast(scope, {:deleted, $3})
      {:ok, $3}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking $3 changes.

  ## Examples

      iex> change_$3($3)
      %Ecto.Changeset{data: %$2{}}

  """
  def change_$3(%Scope{} = scope, %$2{} = $3, attrs \\\\ %{}) do
    $2.changeset($3, attrs, scope)
  end
end

]]

local policyTest = [[
defmodule App.${1:Orgs}Test do
  use App.DataCase

  alias App.$1
  alias App.Accounts.{Scope, User}
  alias App.Accounts

  import App.$2Fixtures
  import App.AccountFixtures, only: [user_scope_fixture: 0]

  @admin_scope Scope.for_user(%User{email: "admin@gmail.com"})
  @update_unauthorized {"is not authorized to change this resource", []}
  @delete_unauthorized {"is not authorized to delete this resource", []}

  describe "$3" do
    alias App.$1.$2

    @invalid_attrs %{name: nil, description: nil, icon_file: nil}

    test "list_${3:orgs}/1 returns all scoped $3" do
      scope1 = user_scope_fixture()
      ${4:org}_1 = $4_fixture(scope1)

      scope2 = user_scope_fixture()
      $4_2 = $4_fixture(scope2)

      anon_scope = Scope.for_user(nil)

      {:ok, scope1_res} = $1.list_$3(scope1)
      {:ok, scope2_res} = $1.list_$3(scope2)

      assert scope1_res == [$4_1, $4_2]
      assert scope2_res == [$4_1, $4_2]

      # Even anon users can list $3
      {:ok, anon_res} = $1.list_$3(anon_scope)
      assert anon_res == [$4_1, $4_2]
    end

    test "get_$4!/2 returns the $4 with given id" do
      scope = user_scope_fixture()
      $4 = $4_fixture(scope)

      {:ok, o} = $1.get_$4!(scope, $4.id)
      assert o == $4

      result = $1.get_$4!(scope, Ecto.UUID.generate())
      assert result == {:error, :not_found}
    end

    test "create_$4/2 with valid data creates an $4" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        icon_file: "some icon_file"
      }

      scope = user_scope_fixture()

      assert {:ok, %$2{} = $4} = $1.create_$4(scope, valid_attrs)
      assert $4.name == "some name"
      assert $4.description == "some description"
      assert $4.icon_file == "some icon_file"
      assert $4.created_by == scope.user.id
    end

    test "create_$4/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = $1.create_$4(scope, @invalid_attrs)
    end

    test "update_$4/3 with valid data updates the $4" do
      scope = user_scope_fixture()
      $4 = $4_fixture(scope)

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        icon_file: "some updated icon_file"
      }

      assert {:ok, %$2{} = o1} =
               $1.update_$4(scope, $4, update_attrs)

      assert o1.name == "some updated name"
      assert o1.description == "some updated description"
      assert o1.icon_file == "some updated icon_file"
    end

    test "update_$4/3 with invalid scope raises" do
      scope1 = user_scope_fixture()
      $4 = $4_fixture(scope1)

      scope2 = user_scope_fixture()

      {:error, %{errors: errors}} = $1.update_$4(scope2, $4, %{})
      assert errors[:current_user] == @update_unauthorized
    end

    test "update_$4/3 with invalid data returns error changeset" do
      scope1 = user_scope_fixture()
      $4 = $4_fixture(scope1)

      scope2 = user_scope_fixture()

      assert {:error, %Ecto.Changeset{}} =
               $1.update_$4(scope2, $4, %{})

      {:ok, o} = $1.get_$4!(scope1, $4.id)
      assert o == $4
    end

    test "delete_$4/2 - Admin deletes the $4" do
      scope = user_scope_fixture()
      $4 = $4_fixture(scope)

      {:ok, o} = $1.delete_$4(@admin_scope, $4)
      assert o.id == $4.id

      res = $1.get_$4!(scope, $4.id)
      assert res == {:error, :not_found}
    end

    test "delete_$4/2 - Non-admin scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      $4 = $4_fixture(scope)

      {:error, %{errors: errors}} = $1.delete_$4(other_scope, $4)
      assert errors[:current_user] == @delete_unauthorized
    end

    test "change_$4/2 returns a $4 changeset" do
      scope = user_scope_fixture()
      $4 = $4_fixture(scope)
      assert %Ecto.Changeset{} = $1.change_$4(scope, $4)
    end
  end
end
]]

return {
  { prefix = "policy:test", body = policyTest, desc = "Context Test with Janus Authorization" },
  { prefix = "policy:definition", body = policy, desc = "Context with Janus Authorization" },
}
