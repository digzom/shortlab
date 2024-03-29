defmodule ShortlabWeb.StoryLive.Index do
  require Logger
  use ShortlabWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, shortcut_token} = Application.fetch_env(:shortlab, :shortcut_token)
    {:ok, shortcut_url} = Application.fetch_env(:shortlab, :shortcut_url)

    # how to generalize this?
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.github.com"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Shortcut-Token", shortcut_token}]}
    ]

    client = Tesla.client(middleware)

    {:ok, %Tesla.Env{body: stories}} = Tesla.get(client, shortcut_url)

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

  @impl true
  def handle_event("save_params", params, socket) do
    params
    |> Map.filter(fn {_k, v} ->
      v == "true"
    end)
    |> Map.keys()

    {:noreply, socket |> push_navigate(to: ~p"/stories")}
  end

  def handle_event("create_mr", params, socket) do
    with {:ok, %Tesla.Env{body: %{"name" => branch_name}}} <- create_branch(),
         {:ok, %Tesla.Env{body: _mr_body}} <- create_mr(branch_name, params) do
      socket
      |> assign(:page_title, "fodase")
      |> assign(:story, nil)
      |> put_flash(:success, "deu certo man")
      |> push_patch(to: ~p"/stories")
    else
      e ->
        Logger.error("#{inspect(e)}")
    end

    {:noreply,
     socket
     |> assign(:page_title, "fodase")
     |> assign(:story, nil)
     |> put_flash(:success, "deu certo man")
     |> push_patch(to: ~p"/stories")}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stories")
    |> assign(:form, %{"mrs" => []})
    |> assign(:story, nil)
  end

  defp create_mr(branch_name, params) do
    {:ok, gitlab_access_key} = Application.get_env(:shortlab, :gitlab_access_key)
    {:ok, gitlab_url} = Application.get_env(:shortlab, :gitlab_url)

    middleware = [
      {Tesla.Middleware.BaseUrl, gitlab_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"PRIVATE-TOKEN", gitlab_access_key}]}
    ]

    story_list =
      params
      |> Enum.filter(fn {_k, v} -> v != "false" end)

    client = Tesla.client(middleware)

    Tesla.post(client, "https://gitlab.com/api/v4/projects/46562739/merge_requests", %{
      "allow_maintainer_to_push" => false,
      "description" => build_mr_description_table(story_list),
      "id" => 46_562_739,
      "remove_source_branch" => true,
      "source_branch" => branch_name,
      "target_branch" => "production",
      "title" => "Teste pela API numero #{Enum.random(0..100_000_000_000_000_000)}"
    })
  end

  defp build_mr_description_table(stories) do
    """
    | ID | Name |
    |----|------|
    """ <>
      Enum.map_join(stories, "\n", fn {id, title} -> "| #{id} | #{title} |" end)
  end

  defp create_branch do
    {:ok, gitlab_access_key} = Application.get_env(:shortlab, :gitlab_access_key)
    {:ok, gitlab_url} = Application.get_env(:shortlab, :gitlab_url)

    middleware = [
      {Tesla.Middleware.BaseUrl, gitlab_url},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"PRIVATE-TOKEN", gitlab_access_key}]}
    ]

    client = Tesla.client(middleware)

    timestamp =
      DateTime.utc_now()
      |> DateTime.to_string()
      |> String.replace("-", "")
      |> String.replace(" ", "")
      |> String.replace(":", "")
      |> String.replace(".", "")
      |> String.replace("Z", "")

    Tesla.post(client, "https://gitlab.com/api/v4/projects/46562739/repository/branches", %{
      "id" => 46_562_739,
      "branch" => "release-with-elixir-#{timestamp}",
      "ref" => "master"
    })
  end

  # Saving these two just to see how to use stream_insert
  # @impl true
  # def handle_info({ShortlabWeb.StoryLive.FormComponent, {:saved, story}}, socket) do
  #   {:noreply, stream_insert(socket, :stories, story)}
  # end
  #
  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   story = Stories.get_story!(id)
  #   {:ok, _} = Stories.delete_story(story)
  #
  #   {:noreply, stream_delete(socket, :stories, story)}
  # end
end
