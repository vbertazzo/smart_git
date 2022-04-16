defmodule SmartGit.GithubApi.GetReposTest do
  use SmartGit.DataCase
  import Tesla.Mock
  alias SmartGit.GithubApi.GetRepos

  setup do
    mock(fn
      %{method: :get, url: "https://api.github.com/search/repositories"} ->
        %Tesla.Env{status: 200, body: %{"items" => items()}}
    end)
  end

  describe "get_repos/3" do
    test "returns a list of repos" do
      result = GetRepos.get_repos("elixir", 1, 5)

      assert {:ok,
              [
                %{
                  avatar_url: "avatar_url",
                  description: "description",
                  forks: 2323,
                  full_name: "full_name",
                  git_id: "id",
                  language: "language",
                  name: "name",
                  open_issues: 2323,
                  url: "url",
                  watchers_count: 123_123
                }
              ]} == result
    end

    test "returns an error when api rate limit is exceeded" do
      mock(fn
        %{method: :get, url: "https://api.github.com/search/repositories"} ->
          %Tesla.Env{status: 403, body: %{}}
      end)

      result = GetRepos.get_repos("elixir", 1, 5)

      assert {:error, "GitHub API request rate limit exceeded. Try again in a few minutes."} ==
               result
    end
  end

  defp items do
    [
      %{
        "id" => "id",
        "owner" => %{"avatar_url" => "avatar_url"},
        "full_name" => "full_name",
        "watchers_count" => 123_123,
        "forks" => 2323,
        "description" => "description",
        "html_url" => "url",
        "name" => "name",
        "open_issues" => 2323,
        "language" => "language"
      }
    ]
  end
end
