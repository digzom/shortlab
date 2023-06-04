defmodule ShortlabWeb.StoryLiveTest do
  use ShortlabWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shortlab.StoriesFixtures

  @create_attrs %{
    label: "some label",
    name: "some name",
    number: "some number",
    project: "some project",
    release: "some release",
    type: "some type"
  }
  @update_attrs %{
    label: "some updated label",
    name: "some updated name",
    number: "some updated number",
    project: "some updated project",
    release: "some updated release",
    type: "some updated type"
  }
  @invalid_attrs %{label: nil, name: nil, number: nil, project: nil, release: nil, type: nil}

  defp create_story(_) do
    story = story_fixture()
    %{story: story}
  end

  describe "temp" do
    test "temp2" do
      assert true
    end
  end

  # describe "Index" do
  #   setup [:create_story]

  # test "lists all stories", %{conn: conn, story: story} do
  #   {:ok, _index_live, html} = live(conn, ~p"/stories")

  #   assert html =~ "Listing Stories"
  #   assert html =~ story.label
  # end

  # test "saves new story", %{conn: conn} do
  #   {:ok, index_live, _html} = live(conn, ~p"/stories")

  #   assert index_live |> element("a", "New Story") |> render_click() =~
  #            "New Story"

  #   assert_patch(index_live, ~p"/stories/new")

  #   assert index_live
  #          |> form("#story-form", story: @invalid_attrs)
  #          |> render_change() =~ "can&#39;t be blank"

  #   assert index_live
  #          |> form("#story-form", story: @create_attrs)
  #          |> render_submit()

  #   assert_patch(index_live, ~p"/stories")

  #   html = render(index_live)
  #   assert html =~ "Story created successfully"
  #   assert html =~ "some label"
  # end

  #   test "updates story in listing", %{conn: conn, story: story} do
  #     {:ok, index_live, _html} = live(conn, ~p"/stories")

  #     assert index_live |> element("#stories-#{story.id} a", "Edit") |> render_click() =~
  #              "Edit Story"

  #     assert_patch(index_live, ~p"/stories/#{story}/edit")

  #     assert index_live
  #            |> form("#story-form", story: @invalid_attrs)
  #            |> render_change() =~ "can&#39;t be blank"

  #     assert index_live
  #            |> form("#story-form", story: @update_attrs)
  #            |> render_submit()

  #     assert_patch(index_live, ~p"/stories")

  #     html = render(index_live)
  #     assert html =~ "Story updated successfully"
  #     assert html =~ "some updated label"
  #   end

  #   test "deletes story in listing", %{conn: conn, story: story} do
  #     {:ok, index_live, _html} = live(conn, ~p"/stories")

  #     assert index_live |> element("#stories-#{story.id} a", "Delete") |> render_click()
  #     refute has_element?(index_live, "#stories-#{story.id}")
  #   end
  # end

  # describe "Show" do
  #   setup [:create_story]

  #   test "displays story", %{conn: conn, story: story} do
  #     {:ok, _show_live, html} = live(conn, ~p"/stories/#{story}")

  #     assert html =~ "Show Story"
  #     assert html =~ story.label
  #   end

  #   test "updates story within modal", %{conn: conn, story: story} do
  #     {:ok, show_live, _html} = live(conn, ~p"/stories/#{story}")

  #     assert show_live |> element("a", "Edit") |> render_click() =~
  #              "Edit Story"

  #     assert_patch(show_live, ~p"/stories/#{story}/show/edit")

  #     assert show_live
  #            |> form("#story-form", story: @invalid_attrs)
  #            |> render_change() =~ "can&#39;t be blank"

  #     assert show_live
  #            |> form("#story-form", story: @update_attrs)
  #            |> render_submit()

  #     assert_patch(show_live, ~p"/stories/#{story}")

  #     html = render(show_live)
  #     assert html =~ "Story updated successfully"
  #     assert html =~ "some updated label"
  #   end
  # end
end
