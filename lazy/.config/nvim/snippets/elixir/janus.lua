local authorizedContextTest = [[
defmodule App.${1:Orgs}Test do
  use App.DataCase

  alias App.$1
  alias App.Accounts.{Scope, User}
  alias App.$1.{${2:Org}, Affiliations}
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
      org1 = ${4:org}_fixture(scope1)

      scope2 = user_scope_fixture()
      org2 = $4_fixture(scope2)

      anon_scope = Scope.for_user(nil)

      {:ok, scope1_res} = $1.list_$3(scope1)
      {:ok, scope2_res} = $1.list_$3(scope2)

      assert scope1_res == [$4_1, $4_2]
      assert scope2_res == [$4_1, $4_2]

      # Even anon users can list $3
      {:ok, anon_res} = $1.list_$3(anon_scope)
      assert anon_res == [$4_1, $4_2]
    end

    test "get_org!/2 returns the org with given id" do
      scope = user_scope_fixture()
      org = $4_fixture(scope)

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

      {:error, %{errors: errors}} = $1.update_$4(scope2, org, %{})
      assert errors[:current_user] == @update_unauthorized
    end

    test "update_$4/3 with invalid data returns error changeset" do
      scope1 = user_scope_fixture()
      $4 = $4_fixture(scope1)

      scope2 = user_scope_fixture()

      assert {:error, %Ecto.Changeset{}} =
               $1.update_$4(scope2, org, %{})

      {:ok, o} = $1.get_$4!(scope1, org.id)
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

  describe "$1" do
    test "owned $3" do
      scope = user_scope_fixture()
      $4 = $4_fixture(scope)

      my_$3 = Accounts.my_owned_$3(scope)
      assert length(my_$3) == 1
      assert Enum.at(my_$3, 0) == $4
    end
  end

  describe "Affiliations" do
    test "adding an affiliate" do
      scope = user_scope_fixture()
      $4 = $4_fixture(scope)

      res = Affiliations.get_$4_affiliations(scope, $4.id)
      assert res == []

      user2 = user_scope_fixture().user

      Affiliations.create_affiliation(scope, %{
        $4_id: $4.id,
        affiliate_id: user2.id
      })

      res = Affiliations.get_$4_affiliations(scope, $4.id)
      assert length(res) == 1

      first_member = res |> List.first()
      assert first_member.affiliate_id == user2.id
    end

    test "An org can have multiple affiliates" do
      owner1 = user_scope_fixture()
      $4_1 = $4_fixture(owner1)

      res1 = Affiliations.get_$4_affiliations(owner1, $4_1.id)
      assert res1 == []

      aff1 = user_scope_fixture().user
      aff2 = user_scope_fixture().user

      Affiliations.create_affiliation(owner1, %{
        $4_id: $4_1.id,
        affiliate_id: aff1.id
      })

      Affiliations.create_affiliation(owner1, %{
        $4_id: $4_1.id,
        affiliate_id: aff2.id
      })

      res1 = Affiliations.get_$4_affiliations(owner1, $4_1.id)
      assert length(res1) == 2
    end

    test "A user can be affiliated to multiple $3" do
      owner1 = user_scope_fixture()
      $4_1 = $4_fixture(owner1)

      res1 = Affiliations.get_$4_affiliations(owner1, $4_1.id)
      assert res1 == []

      aff1 = user_scope_fixture().user
      aff2 = user_scope_fixture().user

      Affiliations.create_affiliation(owner1, %{
        $4_id: $4_1.id,
        affiliate_id: aff1.id
      })

      Affiliations.create_affiliation(owner1, %{
        $4_id: $4_1.id,
        affiliate_id: aff2.id
      })

      res1 = Affiliations.get_$4_affiliations(owner1, $4_1.id)
      assert length(res1) == 2
    end

    test "Users can access their affiliated $3" do
      owner1 = user_scope_fixture()
      owner2 = user_scope_fixture()

      $4_1 = $4_fixture(owner1)
      $4_2 = $4_fixture(owner2)

      aff_scope = user_scope_fixture()
      aff1 = aff_scope.user

      res1 = Affiliations.my_affiliations(aff_scope)
      assert res1 == []

      Affiliations.create_affiliation(owner1, %{
        $4_id: $4_1.id,
        affiliate_id: aff1.id
      })

      Affiliations.create_affiliation(owner2, %{
        $4_id: $4_2.id,
        affiliate_id: aff1.id
      })

      res1 = Affiliations.my_affiliations(aff_scope)
      assert length(res1) == 2

      \[o1 | \[o2 | _\]\] = Accounts.my_affiliated_$3(aff_scope)
      assert o1 == %{id: $4_1.id, name: $4_1.name}
      assert o2 == %{id: $4_2.id, name: $4_2.name}
    end
  end
end
]]

return {
  { prefix = "t", body = "Text", desc = "name" },
  { prefix = "ctx:janus:test", body = authorizedContextTest, desc = "Context Test with Janus Authorization" },
}
