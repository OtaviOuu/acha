defmodule AchandoWeb.HomeLive.Index do
  use Phoenix.LiveView

  alias AchandoWeb.Layouts
  alias Achando.Books.Book
  alias Achando.Books

  on_mount {AchandoWeb.UserAuth, :mount_current_scope}

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Books.subscribe_books()
    end

    books = Books.list_books_ordered_by_time()

    socket =
      socket
      |> stream(:books, books, limit: 10, reset: true, at: 0)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div
        class="flex flex-row justify-center gap-6 flex-wrap p-4"
        phx-update="stream"
        id="books-grid"
      >
        <.books_grid :for={{dom_id, book} <- @streams.books} book={book} id={dom_id} />
      </div>
    </Layouts.app>
    """
  end

  attr :book, Book, required: true, doc: "the book to display"

  attr :id, :string, required: true

  def books_grid(assigns) do
    ~H"""
    <div class="card bg-base-100 w-64 shadow-sm hover:shadow-md transition-shadow" id={@id}>
      <figure class="px-4 pt-4">
        <img src={@book.image_url} alt="Livro" class="rounded-xl w-full h-80 object-cover" />
      </figure>
      <div class="card-body p-4">
        <h2 class="card-title text-lg font-semibold line-clamp-2">{@book.title}</h2>
        <p class="text-sm text-base-content/70 mb-2">{@book.description}</p>
        <p class="text-sm text-base-content/70 mb-2">R$ {@book.price}</p>
      </div>
    </div>
    """
  end

  def handle_info({:found_new_book, book}, socket) do
    socket =
      socket
      |> stream_insert(:books, book, at: 0, limit: 10)

    {:noreply, socket}
  end
end
