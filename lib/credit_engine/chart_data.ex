defmodule CreditEngine.ChartData do
  def subscribe_to_extraterrestrial_updates(topic) do
    Phoenix.PubSub.subscribe(CreditEngine.PubSub, topic)
  end

  def broadcast_extraterrestrial_update(topic, chart_data) do
    Phoenix.PubSub.broadcast(
      CreditEngine.PubSub,
      topic,
      chart_data
    )
  end
end
