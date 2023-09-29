defmodule Airmail.Repo.Migrations.AddUsersTeamsTable do
  use Ecto.Migration

  def change do
    create table(:users_teams, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :team_id, references(:teams, on_delete: :delete_all)
    end

    create index(:users_teams, [:user_id, :team_id])

    alter table(:teams) do
      add :limit, :integer, default: 0, check: "limit < 6"
      add :owner, :integer, null: false
    end

    create unique_index(:teams, [:name])
  end
end
