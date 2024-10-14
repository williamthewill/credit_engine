defmodule CreditEngine.Repo do
  use Ecto.Repo,
    otp_app: :credit_engine,
    adapter: Ecto.Adapters.Postgres
end
