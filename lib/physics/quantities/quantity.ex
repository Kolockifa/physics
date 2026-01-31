defmodule Physics.Quantities.Quantity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quantities" do
    field :name, :string
    field :formula, :string
    field :descr, :string
    field :vector, :string
    field :unit, :string
    field :section, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(quantity, attrs) do
    quantity
    |> cast(attrs, [:name, :formula, :descr, :vector, :unit, :section])
    |> validate_required([:name, :formula, :descr, :vector, :unit, :section])
  end
end
