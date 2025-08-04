defmodule Achando.Repo.Migrations.AddBookCodeToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :code, :string, null: false
    end
  end
end
