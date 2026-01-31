defmodule PhysicsWeb.QuantityLive.Index do
  use PhysicsWeb, :live_view

  alias Physics.Quantities

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Справочник физичесих величин
      </.header>

      <.table
        id="quantities"
        rows={@streams.quantities}
        row_click={fn {_id, quantity} -> JS.navigate(~p"/quantities/#{quantity}") end}
      >
        <:col :let={{_id, quantity}} label="Название">{quantity.name}</:col>
        <:col :let={{_id, quantity}} label="Formula">{quantity.formula}</:col>
        <:col :let={{_id, quantity}} label="Descr">{quantity.descr}</:col>
        <:col :let={{_id, quantity}} label="Vector">{quantity.vector}</:col>
        <:col :let={{_id, quantity}} label="Unit">{quantity.unit}</:col>
        <:col :let={{_id, quantity}} label="Section">{quantity.section}</:col>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Quantities")
     |> stream(:quantities, list_quantities())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    quantity = Quantities.get_quantity!(id)
    {:ok, _} = Quantities.delete_quantity(quantity)

    {:noreply, stream_delete(socket, :quantities, quantity)}
  end

  defp list_quantities() do
    Quantities.list_quantities()
  end
end
