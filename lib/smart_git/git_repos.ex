defmodule SmartGit.GitRepos do
  @moduledoc false
  import Ecto.Query
  alias SmartGit.GitRepos.GitRepo
  alias SmartGit.Repo

  def create(repo) do
    %GitRepo{}
    |> GitRepo.changeset(repo)
    |> Repo.insert()
  end

  def all, do: Repo.all(GitRepo)

  def get_saved_repos do
    GitRepo
    |> select([g], g.git_id)
    |> Repo.all()
  end
end
