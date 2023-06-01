defmodule Shortlab.StoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shortlab.Stories` context.
  """

  @doc """
  Generate a story.
  """
  def story_fixture(attrs \\ %{}) do
    {:ok, story} =
      attrs
      |> Enum.into(%{
        label: "some label",
        name: "some name",
        number: "some number",
        project: "some project",
        release: "some release",
        type: "some type"
      })
      |> Shortlab.Stories.create_story()

    story
  end
end
