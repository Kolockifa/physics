defmodule PhysicsWeb.QuantityLive.Show do
  use PhysicsWeb, :live_view

  alias Physics.Quantities

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Quantity {@quantity.id}
        <:subtitle>This is a quantity record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/quantities"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/quantities/#{@quantity}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit quantity
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@quantity.name}</:item>
        <:item title="Formula">{@quantity.formula}</:item>
        <:item title="Descr">{@quantity.descr}</:item>
        <:item title="Vector">{@quantity.vector}</:item>
        <:item title="Unit">{@quantity.unit}</:item>
        <:item title="Section">{@quantity.section}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Quantity")
     |> assign(:quantity, Quantities.get_quantity!(id))}
  end
end
