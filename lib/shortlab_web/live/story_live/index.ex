defmodule ShortlabWeb.StoryLive.Index do
  use ShortlabWeb, :live_view

  alias Shortlab.Stories
  alias Shortlab.Stories.Story

  @impl true
  def mount(_params, _session, socket) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.github.com"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Shortcut-Token", "647bc707-c963-47ea-94c2-83c2897a301a"}]}
    ]

    client = Tesla.client(middleware)

    {:ok, %Tesla.Env{body: stories}} =
      Tesla.get(client, "https://api.app.shortcut.com/api/v3/labels/4/stories")

    stories =
      Enum.map(stories, fn story ->
        Map.merge(story, %{id: Enum.random(0..300)})
      end)

    {:ok, stream(socket, :stories, stories)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Story")
    |> assign(:story, Stories.get_story!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Story")
    |> assign(:story, %Story{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stories")
    |> assign(:story, nil)
  end

  @impl true
  def handle_info({ShortlabWeb.StoryLive.FormComponent, {:saved, story}}, socket) do
    {:noreply, stream_insert(socket, :stories, story)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    story = Stories.get_story!(id)
    {:ok, _} = Stories.delete_story(story)

    {:noreply, stream_delete(socket, :stories, story)}
  end
end
