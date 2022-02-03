defmodule MyApp.Accounts.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Inspect, except: []}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "organizations" do
    field :name, :string
    has_many :users, MyApp.Accounts.User
    timestamps()
  end

  def default_changeset(organization, attrs \\ %{}) do
    organization
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
