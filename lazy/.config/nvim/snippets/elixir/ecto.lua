local schemaFields = [[
    field :created_by, :binary_id
    field :updated_by, :binary_id

    field :archived, :boolean, default: false
    field :archived_by, :binary_id
    field :archived_at, :utc_datetime

    # change_set 
    # institution
    #|> cast(attrs, [:name, :description, :icon_file])
    #|> validate_required([:name])
    #|> put_change(:created_by, user_scope.user.id)
    #|> put_change(:updated_by, user_scope.user.id)
]]

local migFields = [[
    add :created_by, references(:users, type: :uuid), null: true
    add :updated_by, references(:users, type: :uuid), null: true

    add :archived, :boolean, default: false
    add :archived_by, references(:users, type: :uuid, on_delete: :nothing)
    add :archived_at, :utc_datetime
  ]]

local migUUID = [[
    create table(:${1:refs}, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
    end
]]

local schemaTmpl = [[
defmodule ${1:App}.${2:Model} do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "${3:table_name}" do
    # field :name, :string


    # belongs_to :owner, $1.Accounts.User

    timestamps(type: :utc_datetime)
  end


  @doc false
  def changeset(model, attrs) do
    # model 
    # |> cast(attrs, [:name])
    # |> validate_required([:name])
  end

end
]]

return {
  {
    prefix = "schema:uuid",
    body = "@primary_key {:id, :binary_id, autogenerate: true}",
    description = "Ecto Schema use UUID",
  },
  { prefix = "schema:definition", body = schemaTmpl, description = "Full Ecto Schema definition" },
  { prefix = "schema:fields", body = schemaFields, description = "Ecto Schema additional fields" },
  { prefix = "migration:fields", body = migFields, description = "Ecto Migration additional fields" },
  { prefix = "migration:uuid", body = migUUID, description = "Ecto Migration use UUID" },
  { prefix = "ecto:first", body = " $1 = ${2:Model} |> first() |> Repo.one()", description = "description" },
  { prefix = "ecto:last", body = " $1 = ${2:Model} |> last() |> Repo.one()", description = "description" },
}
