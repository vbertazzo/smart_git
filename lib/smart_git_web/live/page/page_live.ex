defmodule SmartGitWeb.PageLive do
  @moduledoc false

  use SmartGitWeb, :live_view
  alias SmartGitWeb.Page.RepoDetail

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
