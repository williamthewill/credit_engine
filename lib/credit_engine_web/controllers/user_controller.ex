defmodule CreditEngineWeb.UserController do
  use CreditEngineWeb, :controller

  def get_data_example(conn, _params) do
    api_driven_data = %{
      "Idade" => 20,
      "Salario" => 2000,
      "Score" => 700,
      "Relacionamento_banco" => "ótimo"
    }

    conn |> put_status(200) |> json(api_driven_data) |> halt()
  end
end
