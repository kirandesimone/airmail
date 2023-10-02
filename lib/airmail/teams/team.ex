defmodule Airmail.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :losses, :integer, default: 0
    field :name, :string
    field :wins, :integer, default: 0
    field :owner, :integer

    many_to_many :users, Airmail.Accounts.User, join_through: "users_teams", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(team, attrs, users \\ []) do
    team
    |> cast(attrs, [:name, :wins, :losses, :owner])
    |> put_assoc(:users, users)
    |> validate_required([:name, :owner])
    |> unique_constraint(:name)
  end
end
