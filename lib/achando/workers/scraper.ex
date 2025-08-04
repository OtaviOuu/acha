defmodule Achando.Workers.Scraper do
  use Oban.Worker

  alias Achando.Books
  alias Achando.Estante

  @impl Oban.Worker
  def perform(%Oban.Job{args: _args}) do
    Estante.get_new_books()
    |> Enum.each(&Books.create_book/1)
  end

  def is_new_book?(book) do
    case Books.get_book_by_code(book.code) do
      nil -> true
      _ -> false
    end
  end
end
