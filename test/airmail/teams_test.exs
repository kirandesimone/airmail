defmodule Airmail.TeamsTest do
  use Airmail.DataCase

  alias Airmail.Teams

  describe "teams" do
    alias Airmail.Teams.Team

    import Airmail.TeamsFixtures

    @invalid_attrs %{losses: nil, name: nil, wins: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Teams.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Teams.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{losses: 42, name: "some name", wins: 42}

      assert {:ok, %Team{} = team} = Teams.create_team(valid_attrs)
      assert team.losses == 42
      assert team.name == "some name"
      assert team.wins == 42
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teams.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{losses: 43, name: "some updated name", wins: 43}

      assert {:ok, %Team{} = team} = Teams.update_team(team, update_attrs)
      assert team.losses == 43
      assert team.name == "some updated name"
      assert team.wins == 43
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Teams.update_team(team, @invalid_attrs)
      assert team == Teams.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Teams.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Teams.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Teams.change_team(team)
    end
  end
end
