defmodule Shortlab.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :label, :string
    field :name, :string
    field :number, :string
    field :project, :string
    field :release, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:name, :label, :release, :number, :type, :project])
    |> validate_required([:name, :label, :release, :number, :type, :project])
  end
end
