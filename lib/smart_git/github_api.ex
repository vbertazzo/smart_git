defmodule SmartGit.GithubApi do
  @moduledoc false

  alias SmartGit.GithubApi.GetRepos

  defdelegate get_repos(), to: GetRepos
end
