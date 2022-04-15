defmodule SmartGit.GitRepos.GitRepo do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :avatar_url,
    :description,
    :forks,
    :git_id,
    :language,
    :name,
    :open_issues,
    :url,
    :watchers_count
  ]
  @required @fields

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "git_repos" do
    field :avatar_url, :string
    field :description, :string
    field :forks, :integer
    field :git_id, :integer
    field :language, :string
    field :name, :string
    field :open_issues, :integer
    field :url, :string
    field :watchers_count, :integer

    timestamps()
  end

  @doc false
  def changeset(git_repo, attrs) do
    git_repo
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> unique_constraint(:git_id)
  end
end
