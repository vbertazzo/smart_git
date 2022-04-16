defmodule SmartGit.GitReposTest do
  use SmartGit.DataCase
  alias SmartGit.GitRepos
  alias SmartGit.GitRepos.GitRepo

  setup do
    payload = %{
      avatar_url: "https://avatars.githubusercontent.com/u/1481354?v=4",
      description: "Elixir is a dynamic, functional language",
      forks: 10,
      full_name: "elixir-lang/elixir",
      git_id: 250_404,
      name: "elixir",
      language: "elixir",
      open_issues: 24,
      url: "https://github.com/elixir-lang/elixir",
      watchers_count: 20_076
    }

    GitRepos.create(payload)

    :ok
  end

  describe "create/1" do
    test "creates a new git repo when all parameters are valid" do
      payload = %{
        avatar_url: "https://avatars.githubusercontent.com/u/1481354?v=4",
        description: "Elixir is a dynamic, functional language",
        forks: 10,
        full_name: "elixir-lang/elixir",
        git_id: 120,
        name: "elixir",
        language: "elixir",
        open_issues: 24,
        url: "https://github.com/elixir-lang/elixir",
        watchers_count: 20_076
      }

      {:ok, repo} = GitRepos.create(payload)

      assert %GitRepo{
               avatar_url: "https://avatars.githubusercontent.com/u/1481354?v=4",
               description: "Elixir is a dynamic, functional language",
               forks: 10,
               full_name: "elixir-lang/elixir",
               git_id: 120,
               name: "elixir",
               language: "elixir",
               open_issues: 24,
               url: "https://github.com/elixir-lang/elixir",
               watchers_count: 20_076
             } = repo
    end
  end

  describe "all/0" do
    test "returns all git repos" do
      result = GitRepos.all()

      assert [_ | _] = result
    end
  end

  describe "get_saved_repos/0" do
    test "returns a list of all saved repos git ids" do
      result = GitRepos.get_saved_repos()

      assert [250_404] = result
    end
  end

  describe "get_by_git_id/1" do
    test "returns a git repo" do
      id = 250_404

      result = GitRepos.get_by_git_id(id)

      assert {:ok, %GitRepo{git_id: ^id}} = result
    end

    test "returns an error when id is not found" do
      wrong_id = 404

      result = GitRepos.get_by_git_id(wrong_id)

      assert {:error, :not_found} = result
    end
  end
end
