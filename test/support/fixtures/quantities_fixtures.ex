defmodule Physics.QuantitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Physics.Quantities` context.
  """

  @doc """
  Generate a quantity.
  """
  def quantity_fixture(attrs \\ %{}) do
    {:ok, quantity} =
      attrs
      |> Enum.into(%{
        descr: "some descr",
        formula: "some formula",
        name: "some name",
        section: "some section",
        unit: "some unit",
        vector: "some vector"
      })
      |> Physics.Quantities.create_quantity()

    quantity
  end
end
