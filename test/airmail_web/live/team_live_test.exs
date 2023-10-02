defmodule AirmailWeb.TeamLiveTest do
  use AirmailWeb.ConnCase

  import Phoenix.LiveViewTest
  import Airmail.TeamsFixtures
  import Airmail.AccountsFixtures

  @create_attrs %{losses: 42, name: "some name", wins: 42}
  @update_attrs %{losses: 43, name: "some updated name", wins: 43}
  @invalid_attrs %{losses: nil, name: nil, wins: nil}

  defp create_team(_) do
    user = user_fixture()
    team = team_fixture(owner: user.id)
    %{team: team}
  end

  describe "Index" do
    setup [:create_team]

    test "lists all teams", %{conn: conn, team: team} do
      {:ok, _index_live, html} = live(conn, ~p"/teams")

      assert html =~ "Listing Teams"
      assert html =~ team.name
    end

    test "saves new team", %{conn: conn} do
      user = user_fixture()

      {:ok, index_live, _html} = conn |> log_in_user(user) |> live(~p"/teams")

      assert index_live |> element("a", "New Team") |> render_click() =~
               "New Team"

      assert_patch(index_live, ~p"/teams/new")

      assert index_live
             |> form("#team-form", team: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#team-form", team: %{@create_attrs | owner: user.id})
             |> render_submit()

      assert_patch(index_live, ~p"/teams")

      html = render(index_live)
      assert html =~ "Team created successfully"
      assert html =~ "some name"
    end

    test "updates team in listing", %{conn: conn, team: team} do
      {:ok, index_live, _html} = live(conn, ~p"/teams")

      assert index_live |> element("#teams-#{team.id} a", "Edit") |> render_click() =~
               "Edit Team"

      assert_patch(index_live, ~p"/teams/#{team}/edit")

      assert index_live
             |> form("#team-form", team: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#team-form", team: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/teams")

      html = render(index_live)
      assert html =~ "Team updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes team in listing", %{conn: conn, team: team} do
      {:ok, index_live, _html} = live(conn, ~p"/teams")

      assert index_live |> element("#teams-#{team.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#teams-#{team.id}")
    end
  end

  describe "Show" do
    setup [:create_team]

    test "displays team", %{conn: conn, team: team} do
      {:ok, _show_live, html} = live(conn, ~p"/teams/#{team}")

      assert html =~ "Show Team"
      assert html =~ team.name
    end

    test "updates team within modal", %{conn: conn, team: team} do
      user = user_fixture()

      {:ok, show_live, _html} = conn |> log_in_user(user) |> live(~p"/teams/#{team}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Team"

      assert_patch(show_live, ~p"/teams/#{team}/show/edit")

      assert show_live
             |> form("#team-form", team: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#team-form", team: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/teams/#{team}")

      html = render(show_live)
      assert html =~ "Team updated successfully"
      assert html =~ "some updated name"
    end
  end
end
