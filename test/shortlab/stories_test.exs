defmodule Shortlab.StoriesTest do
  use Shortlab.DataCase

  alias Shortlab.Stories

  describe "stories" do
    alias Shortlab.Stories.Story

    import Shortlab.StoriesFixtures

    @invalid_attrs %{label: nil, name: nil, number: nil, project: nil, release: nil, type: nil}

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert Stories.list_stories() == [story]
    end

    test "get_story!/1 returns the story with given id" do
      story = story_fixture()
      assert Stories.get_story!(story.id) == story
    end

    test "create_story/1 with valid data creates a story" do
      valid_attrs = %{label: "some label", name: "some name", number: "some number", project: "some project", release: "some release", type: "some type"}

      assert {:ok, %Story{} = story} = Stories.create_story(valid_attrs)
      assert story.label == "some label"
      assert story.name == "some name"
      assert story.number == "some number"
      assert story.project == "some project"
      assert story.release == "some release"
      assert story.type == "some type"
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stories.create_story(@invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = story_fixture()
      update_attrs = %{label: "some updated label", name: "some updated name", number: "some updated number", project: "some updated project", release: "some updated release", type: "some updated type"}

      assert {:ok, %Story{} = story} = Stories.update_story(story, update_attrs)
      assert story.label == "some updated label"
      assert story.name == "some updated name"
      assert story.number == "some updated number"
      assert story.project == "some updated project"
      assert story.release == "some updated release"
      assert story.type == "some updated type"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = Stories.update_story(story, @invalid_attrs)
      assert story == Stories.get_story!(story.id)
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = Stories.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Stories.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = Stories.change_story(story)
    end
  end
end
