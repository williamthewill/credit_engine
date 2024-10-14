defmodule CreditEngine.Engine.Actions do
  require Integer

  def action(:menorque, value1, value2) when value1 < value2 do
    IO.inspect([value1, value2], label: "menorque")
    {:continue, true}
  end

  def action(:menorque, value1, value2) do
    IO.inspect([value1, value2], label: "menorque")
    {:continue, false}
  end

  def action(:maiorque, value1, value2) when value1 > value2 do
    IO.inspect([value1, value2], label: "maiorque")
    {:continue, true}
  end

  def action(:maiorque, value1, value2) do
    IO.inspect([value1, value2], label: "maiorque")
    {:continue, false}
  end

  def action(:rejeitar, true, _condition) do
    IO.inspect([true], label: "rejeitar")
    {:finish, true}
  end

  def action(:rejeitar, false, _condition) do
    IO.inspect([false], label: "rejeitar")
    {:continue, false}
  end

  def action(:aceitar, true, _condition) do
    IO.inspect([true], label: "aceitar")
    {:finish, true}
  end

  def action(:aceitar, false, _condition) do
    IO.inspect([false], label: "aceitar")
    {:continue, false}
  end

  def action(:iguala, value1, value2) when value1 == value2,
    do: {:continue, true} |> IO.inspect(label: "iguala")

  def action(:iguala, _value1, _value2), do: {:continue, false} |> IO.inspect(label: "iguala")

  def action(:multiplicarpor, value1, value2),
    do: {:continue, value1 * value2} |> IO.inspect(label: "multiplicarpor")

  def action(:dividirpor, value1, value2),
    do: {:continue, value1 / value2} |> IO.inspect(label: "dividirpor")

  def action(:senao, value, _condition), do: {:continue, !value} |> IO.inspect(label: "senao")

  def action(:apidrivendados, _previus_result, target) do
    [{_, api_driven_data}] = :ets.lookup(:data_driven, "user")

    # get for data api
    {:continue, api_driven_data[target]}
    |> IO.inspect(label: "apidrivendados[#{target}]")
  end
end
