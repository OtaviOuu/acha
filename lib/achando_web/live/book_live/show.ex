defmodule AchandoWeb.BookLive.Show do
  use AchandoWeb, :live_view

  alias Achando.Books

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Book {@book.id}
        <:subtitle>This is a book record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/books"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/books/#{@book}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit book
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@book.title}</:item>
        <:item title="Description">{@book.description}</:item>
        <:item title="Image url">{@book.image_url}</:item>
        <:item title="Price">{@book.price}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Book")
     |> assign(:book, Books.get_book!(id))}
  end
end
