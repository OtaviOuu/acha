defmodule Achando.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Achando.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        price: "120.5",
        title: "some title"
      })
      |> Achando.Books.create_book()

    book
  end
end
