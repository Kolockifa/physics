defmodule PhysicsWeb.QuantityLive.Form do
  use PhysicsWeb, :live_view

  alias Physics.Quantities
  alias Physics.Quantities.Quantity

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage quantity records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="quantity-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:formula]} type="text" label="Formula" />
        <.input field={@form[:descr]} type="text" label="Descr" />
        <.input field={@form[:vector]} type="text" label="Vector" />
        <.input field={@form[:unit]} type="text" label="Unit" />
        <.input field={@form[:section]} type="text" label="Section" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Quantity</.button>
          <.button navigate={return_path(@return_to, @quantity)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    quantity = Quantities.get_quantity!(id)

    socket
    |> assign(:page_title, "Edit Quantity")
    |> assign(:quantity, quantity)
    |> assign(:form, to_form(Quantities.change_quantity(quantity)))
  end

  defp apply_action(socket, :new, _params) do
    quantity = %Quantity{}

    socket
    |> assign(:page_title, "New Quantity")
    |> assign(:quantity, quantity)
    |> assign(:form, to_form(Quantities.change_quantity(quantity)))
  end

  @impl true
  def handle_event("validate", %{"quantity" => quantity_params}, socket) do
    changeset = Quantities.change_quantity(socket.assigns.quantity, quantity_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"quantity" => quantity_params}, socket) do
    save_quantity(socket, socket.assigns.live_action, quantity_params)
  end

  defp save_quantity(socket, :edit, quantity_params) do
    case Quantities.update_quantity(socket.assigns.quantity, quantity_params) do
      {:ok, quantity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quantity updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, quantity))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_quantity(socket, :new, quantity_params) do
    case Quantities.create_quantity(quantity_params) do
      {:ok, quantity} ->
        {:noreply,
         socket
         |> put_flash(:info, "Quantity created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, quantity))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _quantity), do: ~p"/quantities"
  defp return_path("show", quantity), do: ~p"/quantities/#{quantity}"
end
