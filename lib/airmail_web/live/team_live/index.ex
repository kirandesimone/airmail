defmodule AirmailWeb.TeamLive.Index do
  alias Airmail.Accounts
  use AirmailWeb, :live_view

  alias Airmail.Teams
  alias Airmail.Teams.Team

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :teams, Teams.list_teams())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Team")
    |> assign(:team, %Team{users: []})
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Team")
    |> assign(:team, Teams.get_team!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Teams")
    |> assign(:team, nil)
  end

  @impl true
  def handle_info({AirmailWeb.TeamLive.FormComponent, {:saved, team}}, socket) do
    {:noreply, stream_insert(socket, :teams, team)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    team = Teams.get_team!(id)

    if socket.assigns.current_user.id == team.owner do
      {:ok, _} = Teams.delete_team(team)
    else
      {:noreply, stream_delete(socket, :teams, team)}
    end
  end

  @impl true
  def handle_event("join", %{"team_id" => team_id, "user_id" => user_id}, socket) do
    user = Accounts.get_user!(user_id)
    team = Teams.get_team!(team_id)
    ids = Enum.map(team.users, fn u -> u.id end)

    if user.id in ids do
      {:noreply,
       socket
       |> put_flash(:error, "You're already on this team")
       |> push_navigate(to: ~p"/teams")}
    else
      {:ok, _team} = Teams.update_team(team, %{}, [user | team.users])

      {:noreply,
       socket
       |> put_flash(:info, "You're throwing with #{team.name}")
       |> push_navigate(to: ~p"/teams")}
    end
  end
end
