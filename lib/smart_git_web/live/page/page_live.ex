defmodule SmartGitWeb.PageLive do
  @moduledoc false

  use SmartGitWeb, :live_view
  alias SmartGit.GithubApi
  alias SmartGitWeb.Shared.RepoDetail

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _, socket) do
    language = params["language"] || "elixir"
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    assigns = [
      language: language,
      page: page,
      per_page: per_page
    ]

    socket =
      socket
      |> assign(assigns)
      |> load_repos()

    {:noreply, socket}
  end

  def handle_event("select-language", %{"language" => language}, socket) do
    socket = push_redirect(socket, to: Routes.page_path(socket, :index, language: language))

    {:noreply, socket}
  end

  def handle_event("load-repos", _, socket) do
    socket =
      socket
      |> update(:page, fn page -> page + 1 end)
      |> load_repos()

    {:noreply, socket}
  end

  defp load_repos(socket) do
    language = socket.assigns.language
    page = socket.assigns.page
    per_page = socket.assigns.per_page

    language
    |> GithubApi.get_repos(page, per_page)
    |> get_response(socket)
  end

  defp get_response({:error, message}, socket) do
    socket
    |> put_flash(:error, message)
    |> assign(repos: [])
  end

  defp get_response({:ok, repos}, socket) do
    assign(socket, repos: repos)
  end
end
