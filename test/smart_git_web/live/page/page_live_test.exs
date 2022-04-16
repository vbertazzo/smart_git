defmodule SmartGitWeb.PageLiveTest do
  use SmartGitWeb.ConnCase
  import Mock
  import Phoenix.LiveViewTest
  alias SmartGit.{GithubApi, GitRepos}

  test "load page elements", %{conn: conn} do
    items = items()

    with_mock GithubApi, get_repos: fn _language, _page, _per_page -> {:ok, items} end do
      items
      |> hd()
      |> GitRepos.create()

      {:ok, view, _html} = live(conn, Routes.page_path(conn, :index))

      assert has_element?(view, "[data-role=btn-language-select][data-id=elixir]", "Elixir")

      assert has_element?(
               view,
               "[data-role=btn-language-select][data-id=javascript]",
               "Javascript"
             )

      assert has_element?(view, "[data-role=btn-language-select][data-id=java]", "Java")
      assert has_element?(view, "[data-role=btn-language-select][data-id=python]", "Python")
      assert has_element?(view, "[data-role=btn-language-select][data-id=go]", "Go")
      assert has_element?(view, "##{items |> hd() |> then(& &1.git_id)}")
    end
  end

  test "select pages", %{conn: conn} do
    items = items()

    with_mock GithubApi, get_repos: fn _language, _page, _per_page -> {:ok, items} end do
      {:ok, view, _html} = live(conn, Routes.page_path(conn, :index))

      view
      |> element("[data-role=btn-language-select][data-id=go]", "Go")
      |> render_click()
      |> follow_redirect(conn, "/?language=go")
    end
  end

  test "error message", %{conn: conn} do
    with_mock GithubApi, get_repos: fn _language, _page, _per_page -> {:error, "test message"} end do
      {:ok, view, _html} = live(conn, Routes.page_path(conn, :index))

      assert has_element?(view, "[role=alert]", "test message")
    end
  end

  test "load repos hook", %{conn: conn} do
    with_mock GithubApi, get_repos: fn _language, _page, _per_page -> {:ok, items()} end do
      {:ok, view, _html} = live(conn, Routes.page_path(conn, :index))

      assert view
             |> element("#allrepos")
             |> render()
             |> Floki.parse_fragment!()
             |> Floki.find("[data-test=list-item]")
             |> Enum.count() == 10

      view
      |> element("#load-repos")
      |> render_hook("load-repos", %{})

      assert view
             |> element("#allrepos")
             |> render()
             |> Floki.parse_fragment!()
             |> Floki.find("[data-test=list-item]")
             |> Enum.count() == 15
    end
  end

  defp items do
    Enum.map(
      1..5,
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
    )
  end
end
