-- REF: https://github.com/mireq/luasnip-snippets/blob/main/lua/luasnip_snippets/c.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")
-- local t = ls.text_node
-- local rep = extras.rep
-- local l = extras.lambda
-- local c = ls.choice_node
--

local authorizedContextTest = [[
defmodule App.OrgsTest do
  use App.DataCase

  alias App.Orgs
  alias App.Accounts.{Scope, User}
  alias App.Orgs.{Org, Affiliations}
  alias App.Accounts

  import App.OrgFixtures
  import App.AccountFixtures, only: [user_scope_fixture: 0]

  @admin_scope Scope.for_user(%User{email: "admin@gmail.com"})
  @update_unauthorized {"is not authorized to change this resource", []}
  @delete_unauthorized {"is not authorized to delete this resource", []}

  describe "orgs" do
    alias App.Orgs.Org

    @invalid_attrs %{name: nil, description: nil, icon_file: nil}

    test "list_orgs/1 returns all scoped orgs" do
      scope1 = user_scope_fixture()
      org1 = org_fixture(scope1)

      scope2 = user_scope_fixture()
      org2 = org_fixture(scope2)

      anon_scope = Scope.for_user(nil)

      {:ok, scope1_res} = Orgs.list_orgs(scope1)
      {:ok, scope2_res} = Orgs.list_orgs(scope2)

      assert scope1_res == [org1, org2]
      assert scope2_res == [org1, org2]

      # Even anon users can list orgs
      {:ok, anon_res} = Orgs.list_orgs(anon_scope)
      assert anon_res == [org1, org2]
    end

    test "get_org!/2 returns the org with given id" do
      scope = user_scope_fixture()
      org = org_fixture(scope)

      {:ok, o} = Orgs.get_org!(scope, org.id)
      assert o == org

      result = Orgs.get_org!(scope, Ecto.UUID.generate())
      assert result == {:error, :not_found}
    end

    test "create_org/2 with valid data creates a org" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        icon_file: "some icon_file"
      }

      scope = user_scope_fixture()

      assert {:ok, %Org{} = org} = Orgs.create_org(scope, valid_attrs)
      assert org.name == "some name"
      assert org.description == "some description"
      assert org.icon_file == "some icon_file"
      assert org.created_by == scope.user.id
    end

    test "create_org/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Orgs.create_org(scope, @invalid_attrs)
    end

    test "update_org/3 with valid data updates the org" do
      scope = user_scope_fixture()
      org = org_fixture(scope)

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        icon_file: "some updated icon_file"
      }

      assert {:ok, %Org{} = org} =
               Orgs.update_org(scope, org, update_attrs)

      assert org.name == "some updated name"
      assert org.description == "some updated description"
      assert org.icon_file == "some updated icon_file"
    end

    test "update_org/3 with invalid scope raises" do
      scope1 = user_scope_fixture()
      org = org_fixture(scope1)

      scope2 = user_scope_fixture()

      {:error, %{errors: errors}} = Orgs.update_org(scope2, org, %{})
      assert errors[:current_user] == @update_unauthorized
    end

    test "update_org/3 with invalid data returns error changeset" do
      scope1 = user_scope_fixture()
      org = org_fixture(scope1)

      scope2 = user_scope_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Orgs.update_org(scope2, org, %{})

      {:ok, o} = Orgs.get_org!(scope1, org.id)
      assert o == org
    end

    test "delete_org/2 - Admin deletes the org" do
      scope = user_scope_fixture()
      org = org_fixture(scope)

      {:ok, o} = Orgs.delete_org(@admin_scope, org)
      assert o.id == org.id

      res = Orgs.get_org!(scope, org.id)
      assert res == {:error, :not_found}
    end

    test "delete_org/2 - Non-admin scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      org = org_fixture(scope)

      {:error, %{errors: errors}} = Orgs.delete_org(other_scope, org)
      assert errors[:current_user] == @delete_unauthorized
    end

    test "change_org/2 returns a org changeset" do
      scope = user_scope_fixture()
      org = org_fixture(scope)
      assert %Ecto.Changeset{} = Orgs.change_org(scope, org)
    end
  end

  describe "Orgs" do
    test "owned orgs" do
      scope = user_scope_fixture()
      org = org_fixture(scope)

      my_orgs = Accounts.my_owned_orgs(scope)
      assert length(my_orgs) == 1
      assert Enum.at(my_orgs, 0) == org
    end
  end

  describe "Affiliations" do
    test "adding an affiliate" do
      scope = user_scope_fixture()
      org = org_fixture(scope)

      res = Affiliations.get_org_affiliations(scope, org.id)
      assert res == []

      user2 = user_scope_fixture().user

      Affiliations.create_affiliation(scope, %{
        org_id: org.id,
        affiliate_id: user2.id
      })

      res = Affiliations.get_org_affiliations(scope, org.id)
      assert length(res) == 1

      first_member = res |> List.first()
      assert first_member.affiliate_id == user2.id
    end

    test "An org can have multiple affiliates" do
      owner1 = user_scope_fixture()
      org1 = org_fixture(owner1)

      res1 = Affiliations.get_org_affiliations(owner1, org1.id)
      assert res1 == []

      aff1 = user_scope_fixture().user
      aff2 = user_scope_fixture().user

      Affiliations.create_affiliation(owner1, %{
        org_id: org1.id,
        affiliate_id: aff1.id
      })

      Affiliations.create_affiliation(owner1, %{
        org_id: org1.id,
        affiliate_id: aff2.id
      })

      res1 = Affiliations.get_org_affiliations(owner1, org1.id)
      assert length(res1) == 2
    end

    test "A user can be affiliated to multiple orgs" do
      owner1 = user_scope_fixture()
      org1 = org_fixture(owner1)

      res1 = Affiliations.get_org_affiliations(owner1, org1.id)
      assert res1 == []

      aff1 = user_scope_fixture().user
      aff2 = user_scope_fixture().user

      Affiliations.create_affiliation(owner1, %{
        org_id: org1.id,
        affiliate_id: aff1.id
      })

      Affiliations.create_affiliation(owner1, %{
        org_id: org1.id,
        affiliate_id: aff2.id
      })

      res1 = Affiliations.get_org_affiliations(owner1, org1.id)
      assert length(res1) == 2
    end

    test "Users can access their affiliated orgs" do
      owner1 = user_scope_fixture()
      owner2 = user_scope_fixture()

      org1 = org_fixture(owner1)
      org2 = org_fixture(owner2)

      aff_scope = user_scope_fixture()
      aff1 = aff_scope.user

      res1 = Affiliations.my_affiliations(aff_scope)
      assert res1 == []

      Affiliations.create_affiliation(owner1, %{
        org_id: org1.id,
        affiliate_id: aff1.id
      })

      Affiliations.create_affiliation(owner2, %{
        org_id: org2.id,
        affiliate_id: aff1.id
      })

      res1 = Affiliations.my_affiliations(aff_scope)
      assert length(res1) == 2

      \[o1 | \[o2 | _\]\] = Accounts.my_affiliated_orgs(aff_scope)
      assert o1 == %{id: org1.id, name: org1.name}
      assert o2 == %{id: org2.id, name: org2.name}
    end
  end
end
]]

ls.add_snippets("elixir", {
	s("ctx:test"),
})
