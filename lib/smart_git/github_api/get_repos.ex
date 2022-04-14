defmodule SmartGit.GithubApi.GetRepos do
  @moduledoc false

  use Tesla
  alias Tesla.Env

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON

  def get_repos(language, page, per_page) do
    "/search/repositories"
    |> get(
      query: [
        q: "language:#{language}",
        sort: "starts",
        order: "desc",
        page: page,
        per_page: per_page
      ]
    )
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 403}}) do
    {:error, "GitHub API request rate limit exceeded. Try again in a few minutes."}
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"items" => items}}}) do
    items = Enum.map(items, fn item -> parse_response_item(item) end)
    {:ok, items}
  end

  defp parse_response_item(item) do
    %{
      "id" => id,
      "owner" => %{"avatar_url" => avatar_url},
      "full_name" => full_name,
      "watchers_count" => watchers_count,
      "forks" => forks,
      "description" => description,
      "html_url" => url,
      "name" => name,
      "open_issues" => open_issues,
      "language" => language
    } = item

    %{
      git_id: id,
      avatar_url: avatar_url,
      full_name: full_name,
      watchers_count: watchers_count,
      forks: forks,
      url: url,
      description: description,
      name: name,
      open_issues: open_issues,
      language: language
    }
  end
end
