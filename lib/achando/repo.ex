defmodule Achando.Repo do
  use Ecto.Repo,
    otp_app: :achando,
    adapter: Ecto.Adapters.Postgres
end
