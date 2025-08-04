defmodule Achando.Estante do
  def get_new_books do
    url =
      "https://www.estantevirtual.com.br/ciencias-exatas?sort=new-releases&tipo-de-livro=usado"

    case Req.get(url) do
      {:ok, response} ->
        parse_books(response.body)

      {:error, reason} ->
        IO.puts("Failed to fetch books: #{reason}")
        []
    end
  end

  def parse_books(html) do
    {:ok, document} = Floki.parse_document(html)

    Floki.find(document, ".product-item.product-list__item")
    |> Enum.map(fn book ->
      code =
        book
        |> Floki.attribute("data-code")
        |> List.first()

      title =
        Floki.find(book, ".product-item__title")
        |> Floki.text()
        |> String.trim()

      _author =
        Floki.find(book, ".product-item__author")
        |> Floki.text()
        |> String.trim()

      image_url =
        "https://static.estantevirtual.com.br/book/00/" <>
          code <> "/" <> code <> "_detail1.jpg"

      %{
        title: title,
        image_url: image_url,
        description: "No description available",
        price: Enum.random(10..100) |> Decimal.new(),
        code: code
      }
    end)
  end
end
