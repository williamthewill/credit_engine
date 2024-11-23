defmodule CreditEngine.PublishScript do
  def run(chart_flow_data) do
    chart_flow_data
    |> Enum.reduce(%{}, fn {target, node}, acc ->
      Map.merge(
        acc,
        %{
          "#{extract_node_name(node)}" => %{
            node: target,
            type: extract_node_type(node),
            fun: String.to_atom(node["class"]),
            condition: extract_condition(node["data"]),
            output: extract_output(node["outputs"])
          }
        }
      )
    end)
  end

  def extract_node_name(%{"inputs" => %{"input_1" => %{"connections" => []}}}), do: "begin"
  def extract_node_name(node), do: node["id"]

  def extract_condition(%{"option" => att}), do: att
  def extract_condition(%{"number" => number}), do: String.to_integer(number)

  def extract_condition(%{"text" => value}) do
    case Float.parse(value) do
      :error -> value
      {number, _} -> number
    end
  end

  def extract_condition(%{}), do: nil

  def extract_output(%{
        "output_1" => %{"connections" => [%{"node" => node_id1}]},
        "output_2" => %{"connections" => [%{"node" => node_id2}]}
      }),
      do: [node_id1, node_id2]

  def extract_output(%{"output_1" => %{"connections" => [%{"node" => node_id}]}}), do: [node_id]
  def extract_output(%{}), do: nil

  def extract_node_type(%{"outputs" => %{"output_1" => %{"connections" => [%{"node" => _node}]}}}),
    do: "flow_node"

  def extract_node_type(%{"outputs" => %{}}), do: "stop_node"
end
