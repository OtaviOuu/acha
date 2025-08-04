defmodule Achando.Workers.Scraper do
  use Oban.Worker

  alias Achando.Books
  alias Achando.Estante

  @impl Oban.Worker
  def perform(%Oban.Job{args: _args}) do
    Estante.get_new_books()
    |> Enum.each(&Books.create_book/1)
  end
end
