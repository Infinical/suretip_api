defmodule SuretipsApi.Repo do
  use Ecto.Repo,
    otp_app: :suretips_api,
    adapter: Ecto.Adapters.Postgres
end
