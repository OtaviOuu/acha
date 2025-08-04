defmodule AchandoWeb.PageController do
  use AchandoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
