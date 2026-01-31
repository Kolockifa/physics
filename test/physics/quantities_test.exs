defmodule Physics.QuantitiesTest do
  use Physics.DataCase

  alias Physics.Quantities

  describe "quantities" do
    alias Physics.Quantities.Quantity

    import Physics.QuantitiesFixtures

    @invalid_attrs %{name: nil, unit: nil, formula: nil, descr: nil, vector: nil, section: nil}

    test "list_quantities/0 returns all quantities" do
      quantity = quantity_fixture()
      assert Quantities.list_quantities() == [quantity]
    end

    test "get_quantity!/1 returns the quantity with given id" do
      quantity = quantity_fixture()
      assert Quantities.get_quantity!(quantity.id) == quantity
    end

    test "create_quantity/1 with valid data creates a quantity" do
      valid_attrs = %{name: "some name", unit: "some unit", formula: "some formula", descr: "some descr", vector: "some vector", section: "some section"}

      assert {:ok, %Quantity{} = quantity} = Quantities.create_quantity(valid_attrs)
      assert quantity.name == "some name"
      assert quantity.unit == "some unit"
      assert quantity.formula == "some formula"
      assert quantity.descr == "some descr"
      assert quantity.vector == "some vector"
      assert quantity.section == "some section"
    end

    test "create_quantity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quantities.create_quantity(@invalid_attrs)
    end

    test "update_quantity/2 with valid data updates the quantity" do
      quantity = quantity_fixture()
      update_attrs = %{name: "some updated name", unit: "some updated unit", formula: "some updated formula", descr: "some updated descr", vector: "some updated vector", section: "some updated section"}

      assert {:ok, %Quantity{} = quantity} = Quantities.update_quantity(quantity, update_attrs)
      assert quantity.name == "some updated name"
      assert quantity.unit == "some updated unit"
      assert quantity.formula == "some updated formula"
      assert quantity.descr == "some updated descr"
      assert quantity.vector == "some updated vector"
      assert quantity.section == "some updated section"
    end

    test "update_quantity/2 with invalid data returns error changeset" do
      quantity = quantity_fixture()
      assert {:error, %Ecto.Changeset{}} = Quantities.update_quantity(quantity, @invalid_attrs)
      assert quantity == Quantities.get_quantity!(quantity.id)
    end

    test "delete_quantity/1 deletes the quantity" do
      quantity = quantity_fixture()
      assert {:ok, %Quantity{}} = Quantities.delete_quantity(quantity)
      assert_raise Ecto.NoResultsError, fn -> Quantities.get_quantity!(quantity.id) end
    end

    test "change_quantity/1 returns a quantity changeset" do
      quantity = quantity_fixture()
      assert %Ecto.Changeset{} = Quantities.change_quantity(quantity)
    end
  end
end
