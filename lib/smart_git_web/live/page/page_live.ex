defmodule SmartGitWeb.PageLive do
  @moduledoc false

  use SmartGitWeb, :live_view
  alias SmartGit.GithubApi
  alias SmartGitWeb.Page.RepoDetail

  def mount(_params, _session, socket) do
    repos = GithubApi.get_repos()
    {:ok, socket |> assign(repos: repos)}
  end
end
