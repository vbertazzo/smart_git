defmodule SmartGitWeb.RepoLiveTest do
  use SmartGitWeb.ConnCase
  import Phoenix.LiveViewTest
  alias SmartGit.GitRepos

  test "load repo elements", %{conn: conn} do
    items = insert_items()

    {:ok, view, _html} = live(conn, Routes.repo_path(conn, :index))

    Enum.each(items, fn item ->
      assert has_element?(view, "#repo-#{item.git_id}")
    end)
  end

  defp insert_items do
    generate_payload =
      &%{
        git_id: :rand.uniform(10_000),
        avatar_url: "avatar_url-#{&1}",
        full_name: "full_name-#{&1}",
        watchers_count: 123_123,
        forks: 1232,
        url: "url-#{&1}",
        description: "description-#{&1}",
        name: "name-#{&1}",
        open_issues: 23_232,
        language: "language-#{&1}"
      }

    Enum.map(1..5, fn n ->
      {:ok, item} = GitRepos.create(generate_payload.(n))
      item
    end)
  end
end
