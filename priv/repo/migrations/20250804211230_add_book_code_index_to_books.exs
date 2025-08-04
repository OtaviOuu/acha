defmodule Achando.Repo.Migrations.AddBookCodeIndexToBooks do
  use Ecto.Migration

  def change do
    create unique_index(:books, [:code])
  end
end
