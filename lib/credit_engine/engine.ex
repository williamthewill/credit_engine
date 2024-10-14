defmodule CreditEngine.Engine do
  # @credit_script %{
  #   "begin" => %{
  #     node: "24",
  #     type: "flow_node",
  #     fun: :apidrivendados,
  #     condition: "Idade",
  #     output: ["25"]
  #   },
  #   "25" => %{
  #     node: "25",
  #     type: "flow_node",
  #     fun: :menorque,
  #     condition: 21,
  #     output: ["23", "26"]
  #   },
  #   "23" => %{
  #     node: "23",
  #     type: "stop_node",
  #     fun: :rejeitar,
  #     condition: nil,
  #     output: nil
  #   },
  #   "26" => %{
  #     node: "26",
  #     type: "flow_node",
  #     fun: :apidrivendados,
  #     condition: "Salario",
  #     output: ["27"]
  #   },
  #   "27" => %{
  #     node: "27",
  #     type: "flow_node",
  #     fun: :menorque,
  #     condition: 2000,
  #     output: ["28", "29"]
  #   },
  #   "28" => %{
  #     node: "28",
  #     type: "stop_node",
  #     fun: :rejeitar,
  #     condition: nil,
  #     output: nil
  #   },
  #   "29" => %{
  #     node: "26",
  #     type: "flow_node",
  #     fun: :apidrivendados,
  #     condition: "Salario",
  #     output: ["30"]
  #   },
  #   "30" => %{
  #     node: "30",
  #     type: "flow_node",
  #     fun: :maiorque,
  #     condition: 2000,
  #     output: ["31"]
  #   },
  #   "31" => %{
  #     node: "31",
  #     type: "stop_node",
  #     fun: :aceitar,
  #     condition: nil,
  #     output: nil
  #   }
  # }

  def run_node(%{type: "stop_node"} = node, current_result) do
    case CreditEngine.Engine.Actions.action(node.fun, current_result, node.condition) do
      {:continue, false} -> {:continue, false}
      {:finish, true} -> {:finish, true}
    end
  end

  def run_node(%{type: "flow_node"} = node, current_result) do
    IO.inspect([node.fun, current_result, node.condition])
    CreditEngine.Engine.Actions.action(node.fun, current_result, node.condition)
  end

  def start(credit_script, node, previus_result \\ nil) do
    case run_node(node, previus_result) do
      {:finish, result} ->
        {:finish, result}

      {:continue, current_result} ->
        case explode_nodes(credit_script, node.output, current_result) do
          {:continue, current_result, next_node} ->
            start(credit_script, next_node, current_result)

          {:finish, result} ->
            {:finish, result}
        end
    end
  end

  # def explode_nodes(credit_script, [out1, out2], false) do
  #   case run_node(credit_script[out2], current_result) |> IO.inspect(label: "explode_nodes") do
  #     {:continue, current_result} -> {:continue, current_result, credit_script[out2]}
  #     {:finish, result} -> {:finish, result}
  #   end
  # end

  def explode_nodes(credit_script, [out1, _out2], true) do
    case run_node(credit_script[out1], true) |> IO.inspect(label: "explode_nodes") do
      {:continue, current_result} ->
        [next_node] = credit_script[out1][:output]
        {:continue, current_result, credit_script[next_node]}

      {:finish, result} ->
        {:finish, result}
    end
  end

  def explode_nodes(credit_script, [_out1, out2], false) do
    case run_node(credit_script[out2], false) |> IO.inspect(label: "explode_nodes") do
      {:continue, current_result} ->
        [next_node] = credit_script[out2][:output]
        {:continue, current_result, credit_script[next_node]}

      {:finish, result} ->
        {:finish, result}
    end
  end

  def explode_nodes(credit_script, [out], current_result) do
    {:continue, current_result, credit_script[out]}
  end

  def explode_nodes(_credit_script, nil, current_result) do
    {:finish, current_result}
  end
end
