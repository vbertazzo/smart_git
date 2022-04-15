defmodule SmartGit.GitRepos do
  @moduledoc false
  alias SmartGit.GitRepos.GitRepo
  alias SmartGit.Repo

  def create(repo) do
    %GitRepo{}
    |> GitRepo.changeset(repo)
    |> Repo.insert()
  end

  def all, do: Repo.all(GitRepo)
end
