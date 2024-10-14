defmodule CreditEngine.Stores.ChartData do
  @moduledoc """
  Provides the structure of ExampleStore records for a minimal example of Mnesiac.
  """
  use Mnesiac.Store
  import Record, only: [defrecord: 3]

  @doc """
  Record definition for ExampleStore example record.
  """
  defrecord(
    :chart_data,
    __MODULE__,
    id: nil,
    topic_id: nil,
    content: nil
  )

  @typedoc """
  ExampleStore example record field type definitions.
  """
  @type chart_data ::
          record(
            :chart_data,
            id: String.t(),
            topic_id: String.t(),
            content: map()
          )

  @impl true
  def store_options,
    do: [
      record_name: :chart_data,
      attributes: chart_data() |> chart_data() |> Keyword.keys(),
      index: [:topic_id],
      disc_copies: [node()]
    ]

  @impl true
  def copy_store do
    for type <- [:ram_copies, :disc_copies, :disc_only_copies] do
      value = Keyword.get(store_options(), type, [])

      if Enum.member?(value, node()) do
        :mnesia.add_table_copy(
          Keyword.get(store_options(), :record_name, __MODULE__),
          node(),
          type
        )
      end
    end
  end

  @impl true
  def resolve_conflict(node) do
    Logger.warning("RESOLVE CONFLICT #{inspect(node())} vs #{inspect(node)}")

    copy_store()
  end
end
