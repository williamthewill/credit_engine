defmodule CreditEngine.PublishScript do
  # @chart_flow %{
  #   "drawflow" => %{
  #     "Home" => %{
  #       "data" => %{
  #         "23" => %{
  #           "class" => "rejeitar",
  #           "data" => %{},
  #           "html" =>
  #             "\n        <div>\n          <div class=\"title-box\"><i class=\"fa-solid fa-square-xmark\"></i> Rejeitar</div>\n        </div>\n        ",
  #           "id" => 23,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_1", "node" => "25"}]
  #             }
  #           },
  #           "name" => "rejeitar",
  #           "outputs" => %{},
  #           "pos_x" => 704,
  #           "pos_y" => 96,
  #           "typenode" => false
  #         },
  #         "24" => %{
  #           "class" => "apidrivendados",
  #           "data" => %{"option" => "Idade"},
  #           "html" =>
  #             "<div><div class=\"title-box\">API Driven</div><select id=\"proList\" df-option=\"\"><option class=\"item\" value=\"Idade\">Idade</option><option class=\"item\" value=\"Salario\">Salario</option><option class=\"item\" value=\"Score\">Score</option><option class=\"item\" value=\"Relacionamento_banco\">Relacionamento_banco</option></select></div>",
  #           "id" => 24,
  #           "inputs" => %{"input_1" => %{"connections" => []}},
  #           "name" => "apidrivendados",
  #           "outputs" => %{
  #             "output_1" => %{
  #               "connections" => [%{"node" => "25", "output" => "input_1"}]
  #             }
  #           },
  #           "pos_x" => 54,
  #           "pos_y" => 89,
  #           "typenode" => false
  #         },
  #         "25" => %{
  #           "class" => "menorque",
  #           "data" => %{"number" => "21"},
  #           "html" =>
  #             "\n          <div style=\"height:236px\">\n            <div class=\"title-box\"><i class=\"fab fa fa-less-than\"></i> Menor que</div>\n            <div class=\"box\">\n              <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n            </div>\n            <div class=\"losango\"></div>\n          </div>\n          ",
  #           "id" => 25,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_1", "node" => "24"}]
  #             }
  #           },
  #           "name" => "menorque",
  #           "outputs" => %{
  #             "output_1" => %{
  #               "connections" => [%{"node" => "23", "output" => "input_1"}]
  #             },
  #             "output_2" => %{
  #               "connections" => [%{"node" => "26", "output" => "input_1"}]
  #             }
  #           },
  #           "pos_x" => 344,
  #           "pos_y" => 15,
  #           "typenode" => false
  #         },
  #         "26" => %{
  #           "class" => "apidrivendados",
  #           "data" => %{"option" => "Salario"},
  #           "html" =>
  #             "<div><div class=\"title-box\">API Driven</div><select id=\"proList\" df-option=\"\"><option class=\"item\" value=\"Idade\">Idade</option><option class=\"item\" value=\"Salario\">Salario</option><option class=\"item\" value=\"Score\">Score</option><option class=\"item\" value=\"Relacionamento_banco\">Relacionamento_banco</option></select></div>",
  #           "id" => 26,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_2", "node" => "25"}]
  #             }
  #           },
  #           "name" => "apidrivendados",
  #           "outputs" => %{
  #             "output_1" => %{
  #               "connections" => [%{"node" => "27", "output" => "input_1"}]
  #             }
  #           },
  #           "pos_x" => 698,
  #           "pos_y" => 208,
  #           "typenode" => false
  #         },
  #         "27" => %{
  #           "class" => "menorque",
  #           "data" => %{"number" => "2000"},
  #           "html" =>
  #             "\n          <div style=\"height:236px\">\n            <div class=\"title-box\"><i class=\"fab fa fa-less-than\"></i> Menor que</div>\n            <div class=\"box\">\n              <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n            </div>\n            <div class=\"losango\"></div>\n          </div>\n          ",
  #           "id" => 27,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_1", "node" => "26"}]
  #             }
  #           },
  #           "name" => "menorque",
  #           "outputs" => %{
  #             "output_1" => %{
  #               "connections" => [%{"node" => "28", "output" => "input_1"}]
  #             },
  #             "output_2" => %{
  #               "connections" => [%{"node" => "29", "output" => "input_1"}]
  #             }
  #           },
  #           "pos_x" => 970,
  #           "pos_y" => 233,
  #           "typenode" => false
  #         },
  #         "28" => %{
  #           "class" => "rejeitar",
  #           "data" => %{},
  #           "html" =>
  #             "\n        <div>\n          <div class=\"title-box\"><i class=\"fa-solid fa-square-xmark\"></i> Rejeitar</div>\n        </div>\n        ",
  #           "id" => 28,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_1", "node" => "27"}]
  #             }
  #           },
  #           "name" => "rejeitar",
  #           "outputs" => %{},
  #           "pos_x" => 1363,
  #           "pos_y" => 317,
  #           "typenode" => false
  #         },
  #         "29" => %{
  #           "class" => "apidrivendados",
  #           "data" => %{"option" => "Salario"},
  #           "html" =>
  #             "<div><div class=\"title-box\">API Driven</div><select id=\"proList\" df-option=\"\"><option class=\"item\" value=\"Idade\">Idade</option><option class=\"item\" value=\"Salario\">Salario</option><option class=\"item\" value=\"Score\">Score</option><option class=\"item\" value=\"Relacionamento_banco\">Relacionamento_banco</option></select></div>",
  #           "id" => 29,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_2", "node" => "27"}]
  #             }
  #           },
  #           "name" => "apidrivendados",
  #           "outputs" => %{
  #             "output_1" => %{
  #               "connections" => [%{"node" => "30", "output" => "input_1"}]
  #             }
  #           },
  #           "pos_x" => 1360,
  #           "pos_y" => 454,
  #           "typenode" => false
  #         },
  #         "30" => %{
  #           "class" => "maiorque",
  #           "data" => %{"number" => "2000"},
  #           "html" =>
  #             "\n        <div style=\"height:236px\">\n          <div class=\"title-box\"><i class=\"fab fa fa-greater-than\"></i> Maior que</div>\n          <div class=\"box\">\n            <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n          </div>\n          <div class=\"losango\"></div>\n        </div>\n        ",
  #           "id" => 30,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_1", "node" => "29"}]
  #             }
  #           },
  #           "name" => "maiorque",
  #           "outputs" => %{
  #             "output_1" => %{
  #               "connections" => [%{"node" => "31", "output" => "input_1"}]
  #             }
  #           },
  #           "pos_x" => 1707,
  #           "pos_y" => 571,
  #           "typenode" => false
  #         },
  #         "31" => %{
  #           "class" => "aceitar",
  #           "data" => %{},
  #           "html" =>
  #             "\n        <div>\n          <div class=\"title-box\"><i class=\"fa-solid fa-divide\"></i> Aceitar</div>\n        </div>\n        ",
  #           "id" => 31,
  #           "inputs" => %{
  #             "input_1" => %{
  #               "connections" => [%{"input" => "output_1", "node" => "30"}]
  #             }
  #           },
  #           "name" => "aceitar",
  #           "outputs" => %{},
  #           "pos_x" => 2074,
  #           "pos_y" => 680,
  #           "typenode" => false
  #         }
  #       }
  #     },
  #     "Other" => %{"data" => %{}}
  #   }
  # }
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
