defmodule Shortlab.Repo do
  use Ecto.Repo,
    otp_app: :shortlab,
    adapter: Ecto.Adapters.Postgres
end
