defmodule CreditEngineWeb.ChartFlowLive do
  use CreditEngineWeb, :live_view

  # @api_driven_data %{
  #   "Idade" => 20,
  #   "Salario" => 2000,
  #   "Score" => 500,
  #   "Relacionamento_banco" => "ótimo"
  # }

  def mount(_params, _session, socket) do
    CreditEngine.ChartData.subscribe_to_extraterrestrial_updates("chart_data")
    CreditEngine.ChartData.subscribe_to_extraterrestrial_updates("api_driven")

    socket =
      socket
      |> assign(:title, "Datarisk Credit Engine")
      |> assign(:redraw, NaiveDateTime.local_now())

    {:ok, socket}
  end

  def handle_event("get_data_to_import", %{}, socket) do
    {:atomic, [{:chart_data, "1", "1", data_to_import}]} =
      :mnesia.transaction(fn -> :mnesia.read({:chart_data, "1"}) end)

    # data_to_import = %{
    #   drawflow: %{
    #     Other: %{
    #       data: %{
    #         "16": %{
    #           id: 16,
    #           name: "rejeitar",
    #           data: %{},
    #           class: "rejeitar",
    #           html:
    #             "\n        <div>\n          <div class=\"title-box\"><i class=\"fa-solid fa-square-xmark\"></i> Rejeitar</div>\n        </div>\n        ",
    #           typenode: false,
    #           inputs: %{
    #             input_1: %{
    #               connections: [
    #                 %{
    #                   node: "17",
    #                   input: "output_1"
    #                 }
    #               ]
    #             }
    #           },
    #           outputs: %{},
    #           pos_x: 868,
    #           pos_y: 419
    #         },
    #         "17": %{
    #           id: 17,
    #           name: "iguala",
    #           data: %{
    #             number: ""
    #           },
    #           class: "iguala",
    #           html:
    #             "\n          <div style=\"height:236px\">\n            <div class=\"title-box\"><i class=\"fab fa fa-less-than\"></i> Igual a</div>\n            <div class=\"box\">\n              <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n            </div>\n            <div class=\"losango\"></div>\n          </div>\n          ",
    #           typenode: false,
    #           inputs: %{
    #             input_1: %{
    #               connections: [
    #                 %{
    #                   node: "18",
    #                   input: "output_1"
    #                 }
    #               ]
    #             }
    #           },
    #           outputs: %{
    #             output_1: %{
    #               connections: [
    #                 %{
    #                   node: "16",
    #                   output: "input_1"
    #                 }
    #               ]
    #             }
    #           },
    #           pos_x: 548,
    #           pos_y: 326
    #         },
    #         "18": %{
    #           id: 18,
    #           name: "somar",
    #           data: %{
    #             number: ""
    #           },
    #           class: "somar",
    #           html:
    #             "\n        <div>\n          <div class=\"title-box\"><i class=\"fab fa fa-plus\"></i> Somar</div>\n          <div class=\"box\">\n            <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n          </div>\n        </div>\n        ",
    #           typenode: false,
    #           inputs: %{
    #             input_1: %{
    #               connections: []
    #             }
    #           },
    #           outputs: %{
    #             output_1: %{
    #               connections: [
    #                 %{
    #                   node: "17",
    #                   output: "input_1"
    #                 }
    #               ]
    #             }
    #           },
    #           pos_x: 241,
    #           pos_y: 377
    #         }
    #       }
    #     },
    #     Home: %{
    #       data: %{
    #         "14": %{
    #           id: 14,
    #           name: "maiorque",
    #           data: %{
    #             number: ""
    #           },
    #           class: "maiorque",
    #           html:
    #             "\n        <div style=\"height:236px\">\n          <div class=\"title-box\"><i class=\"fab fa fa-greater-than\"></i> Maior que</div>\n          <div class=\"box\">\n            <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n          </div>\n          <div class=\"losango\"></div>\n        </div>\n        ",
    #           typenode: false,
    #           inputs: %{
    #             input_1: %{
    #               connections: [
    #                 %{
    #                   node: "15",
    #                   input: "output_1"
    #                 }
    #               ]
    #             }
    #           },
    #           outputs: %{
    #             output_1: %{
    #               connections: []
    #             }
    #           },
    #           pos_x: 793,
    #           pos_y: 223
    #         },
    #         "15": %{
    #           id: 15,
    #           name: "multiplicarpor",
    #           data: %{
    #             number: ""
    #           },
    #           class: "multiplicarpor",
    #           html:
    #             "\n        <div>\n          <div class=\"title-box\"><i class=\"fa-solid fa-xmark\"></i> Multiplicar por</div>\n          <div class=\"box\">\n            <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n          </div>\n        </div>\n        ",
    #           typenode: false,
    #           inputs: %{
    #             input_1: %{
    #               connections: []
    #             }
    #           },
    #           outputs: %{
    #             output_1: %{
    #               connections: [
    #                 %{
    #                   node: "14",
    #                   output: "input_1"
    #                 }
    #               ]
    #             }
    #           },
    #           pos_x: 542,
    #           pos_y: 276
    #         }
    #       }
    #     }
    #   }
    # }

    {:reply, %{data_to_import: data_to_import}, socket}
  end

  def handle_event("save_data", %{"data_to_save" => data_to_save}, socket) do
    :mnesia.transaction(fn -> :mnesia.write({:chart_data, "1", "1", data_to_save}) end)

    Task.async(fn ->
      CreditEngine.ChartData.broadcast_extraterrestrial_update("chart_data", data_to_save)
    end)

    {:reply, %{was_saved: true}, socket}
  end

  def handle_event("data_driven", %{"args" => args}, socket) do
    w = ~w"#{args}"
    {encoded_resp, _} = System.cmd("curl", w)

    decoded_resp = Jason.decode!(encoded_resp)

    with :undefined <- :ets.whereis(:data_driven) do
      :ets.new(:data_driven, [:set, :named_table])
    end

    :ets.insert_new(:data_driven, {"user", decoded_resp})

    CreditEngine.ChartData.broadcast_extraterrestrial_update("api_driven", %{})

    {:reply, %{resp: decoded_resp}, socket}
  end

  def handle_event("publish", _el, socket) do
    {:atomic, [{:chart_data, "1", "1", data_to_import}]} =
      :mnesia.transaction(fn -> :mnesia.read({:chart_data, "1"}) end)

    credit_sript =
      data_to_import["drawflow"]["Home"]["data"]
      |> CreditEngine.PublishScript.run()

    CreditEngine.Engine.start(credit_sript, credit_sript["begin"])
    |> IO.inspect()

    {:noreply, socket}
  end

  def handle_event("api_driven", _, socket) do
    api_driven_data =
      case :ets.whereis(:data_driven) do
        :undefined ->
          %{}

        _ ->
          [{_, api_driven_data}] = :ets.lookup(:data_driven, "user")
          api_driven_data
      end

    data_targets =
      api_driven_data |> Enum.reduce([], fn {target, _}, acc -> acc ++ [target] end)

    Task.async(fn ->
      CreditEngine.ChartData.broadcast_extraterrestrial_update("api_driven", data_targets)
    end)

    IO.inspect(data_targets, label: "api_driven")

    {:reply, %{data: data_targets}, socket}
  end

  def handle_info(msg, socket) when msg == "chart_data" or msg == "api_driven" do
    IO.inspect("handle_info update chart_data")

    socket =
      socket
      |> assign(:redraw, NaiveDateTime.local_now())
      |> assign(:title, "Datarisk Credit Engine 2")

    {:noreply, socket}
  end

  def handle_info(msg, socket) do
    IO.inspect("handle_info nothing")
    IO.inspect(msg)

    {:noreply, socket}
  end
end
