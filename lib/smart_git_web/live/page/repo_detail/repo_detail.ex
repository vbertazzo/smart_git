defmodule SmartGitWeb.Page.RepoDetail do
  @moduledoc false

  use SmartGitWeb, :live_component

  def update(assigns, socket) do
    {:ok, socket |> assign(assigns) |> assign(message: nil)}
  end

  def handle_event("add-repo", _, socket) do
    message =
      case is_nil(socket.assigns.message) do
        true -> "Repo added!"
        false -> nil
      end

    {:noreply, assign(socket, message: message)}
  end
end
