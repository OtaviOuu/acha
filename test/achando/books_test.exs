defmodule Achando.BooksTest do
  use Achando.DataCase

  alias Achando.Books

  describe "books" do
    alias Achando.Books.Book

    import Achando.BooksFixtures

    @invalid_attrs %{description: nil, title: nil, image_url: nil, price: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Books.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Books.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{description: "some description", title: "some title", image_url: "some image_url", price: "120.5"}

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.description == "some description"
      assert book.title == "some title"
      assert book.image_url == "some image_url"
      assert book.price == Decimal.new("120.5")
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", image_url: "some updated image_url", price: "456.7"}

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.description == "some updated description"
      assert book.title == "some updated title"
      assert book.image_url == "some updated image_url"
      assert book.price == Decimal.new("456.7")
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, @invalid_attrs)
      assert book == Books.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end
end
