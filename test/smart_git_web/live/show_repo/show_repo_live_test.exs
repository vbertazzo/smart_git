defmodule SartGitWeb.ShowRepoLiveTest do
  use SmartGitWeb.ConnCase
  import Phoenix.LiveViewTest
  alias SmartGit.GitRepos

  test "load show repo", %{conn: conn} do
    repo = create_repo()
    {:ok, view, _html} = live(conn, Routes.show_repo_path(conn, :index, repo.git_id))

    assert has_element?(view, "##{repo.id}")
  end

  defp create_repo do
    generate_payload =
      &%{
        git_id: :rand.uniform(10_000),
        avatar_url: "avatar_url-#{&1}",
        full_name: "full_namel-#{&1}",
        watchers_count: 123_123,
        forks: 1232,
        url: "urll-#{&1}",
        description: "descriptionl-#{&1}",
        name: "namel-#{&1}",
        open_issues: 23_232,
        language: "languagel-#{&1}"
      }

    {:ok, repo} = GitRepos.create(generate_payload.(1))
    repo
  end
end
