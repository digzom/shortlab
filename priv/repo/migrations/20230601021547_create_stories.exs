defmodule Shortlab.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :name, :string
      add :label, :string
      add :release, :string
      add :number, :string
      add :type, :string
      add :project, :string

      timestamps()
    end
  end
end
