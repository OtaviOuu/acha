defmodule Achando.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :description, :string
      add :image_url, :string
      add :price, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
