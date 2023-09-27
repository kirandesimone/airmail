defmodule Airmail.Repo do
  use Ecto.Repo,
    otp_app: :airmail,
    adapter: Ecto.Adapters.Postgres
end
