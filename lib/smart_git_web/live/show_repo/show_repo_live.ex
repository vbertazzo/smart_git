defmodule SmartGitWeb.ShowRepoLive do
  @moduledoc false

  use SmartGitWeb, :live_view
  alias SmartGit.GitRepos

  def mount(%{"id" => git_id}, _, socket) do
    {:ok, repo} = GitRepos.get_by_git_id(git_id)

    {:ok, assign(socket, repo: repo)}
  end
end
