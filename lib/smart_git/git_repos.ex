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
    |> select([r], r.git_id)
    |> Repo.all()
  end

  def get_by_git_id(id) do
    case Repo.get_by(GitRepo, git_id: id) do
      nil -> {:error, :not_found}
      repo -> {:ok, repo}
    end
  end
end
