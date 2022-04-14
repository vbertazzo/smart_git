defmodule SmartGit.GithubApi do
  @moduledoc false

  alias SmartGit.GithubApi.GetRepos

  defdelegate get_repos(language, page, per_page), to: GetRepos
end
