defmodule Airmail.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Airmail.Teams` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        losses: 42,
        name: "some name",
        wins: 42
      })
      |> Airmail.Teams.create_team()

    team
  end
end
