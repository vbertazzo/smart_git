defmodule SmartGit.GithubApi.GetRepos do
  @moduledoc false

  def call do
    Enum.map(1..10, fn _ -> mock_repo() end)
  end

  def mock_repo do
    %{
      git_id: :rand.uniform(10_000),
      avatar_url: "https://avatars.githubusercontent.com/u/98585563?s=200&v=4",
      full_name: "Elixir language",
      watchers_count: 500,
      forks: 500,
      description: "Lorem ipsum",
      name: "Elixir",
      open_issues: 10,
      language: "Elixir"
    }
  end
end
