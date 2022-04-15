defmodule SmartGitWeb.Shared.RepoDetail do
  @moduledoc false

  use SmartGitWeb, :live_component
  alias SmartGit.GitRepos

  def update(%{saved_repos: nil} = assigns, socket) do
    socket =
      socket
      |> assign_default(assigns)
      |> assign(icon: "info.html")

    {:ok, socket}
  end

  def update(%{id: id, saved_repos: saved_repos} = assigns, socket) do
    socket =
      socket
      |> assign_default(assigns)
      |> select_icon(id, saved_repos)

    {:ok, socket}
  end

  def handle_event("add-repo", _, socket) do
    icon = socket.assigns.icon
    repo = socket.assigns.repo

    if icon == "add.html" do
      GitRepos.create(repo)

      message = (socket.assigns.message == nil && "Repo added!") || nil

      {:noreply, assign(socket, message: message, icon: "info.html")}
    else
      socket = push_redirect(socket, to: Routes.show_repo_path(socket, :index, repo.git_id))

      {:noreply, socket}
    end
  end

  defp assign_default(socket, %{repo: repo, id: id}) do
    assign(socket, repo: repo, id: id, message: nil)
  end

  defp select_icon(socket, id, saved_repos) do
    if String.to_integer(id) in saved_repos do
      assign(socket, icon: "info.html")
    else
      assign(socket, icon: "add.html")
    end
  end
end
