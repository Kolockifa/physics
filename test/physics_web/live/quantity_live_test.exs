defmodule PhysicsWeb.QuantityLiveTest do
  use PhysicsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Physics.QuantitiesFixtures

  @create_attrs %{name: "some name", unit: "some unit", formula: "some formula", descr: "some descr", vector: "some vector", section: "some section"}
  @update_attrs %{name: "some updated name", unit: "some updated unit", formula: "some updated formula", descr: "some updated descr", vector: "some updated vector", section: "some updated section"}
  @invalid_attrs %{name: nil, unit: nil, formula: nil, descr: nil, vector: nil, section: nil}
  defp create_quantity(_) do
    quantity = quantity_fixture()

    %{quantity: quantity}
  end

  describe "Index" do
    setup [:create_quantity]

    test "lists all quantities", %{conn: conn, quantity: quantity} do
      {:ok, _index_live, html} = live(conn, ~p"/quantities")

      assert html =~ "Listing Quantities"
      assert html =~ quantity.name
    end

    test "saves new quantity", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/quantities")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Quantity")
               |> render_click()
               |> follow_redirect(conn, ~p"/quantities/new")

      assert render(form_live) =~ "New Quantity"

      assert form_live
             |> form("#quantity-form", quantity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#quantity-form", quantity: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/quantities")

      html = render(index_live)
      assert html =~ "Quantity created successfully"
      assert html =~ "some name"
    end

    test "updates quantity in listing", %{conn: conn, quantity: quantity} do
      {:ok, index_live, _html} = live(conn, ~p"/quantities")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#quantities-#{quantity.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/quantities/#{quantity}/edit")

      assert render(form_live) =~ "Edit Quantity"

      assert form_live
             |> form("#quantity-form", quantity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#quantity-form", quantity: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/quantities")

      html = render(index_live)
      assert html =~ "Quantity updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes quantity in listing", %{conn: conn, quantity: quantity} do
      {:ok, index_live, _html} = live(conn, ~p"/quantities")

      assert index_live |> element("#quantities-#{quantity.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#quantities-#{quantity.id}")
    end
  end

  describe "Show" do
    setup [:create_quantity]

    test "displays quantity", %{conn: conn, quantity: quantity} do
      {:ok, _show_live, html} = live(conn, ~p"/quantities/#{quantity}")

      assert html =~ "Show Quantity"
      assert html =~ quantity.name
    end

    test "updates quantity and returns to show", %{conn: conn, quantity: quantity} do
      {:ok, show_live, _html} = live(conn, ~p"/quantities/#{quantity}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/quantities/#{quantity}/edit?return_to=show")

      assert render(form_live) =~ "Edit Quantity"

      assert form_live
             |> form("#quantity-form", quantity: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#quantity-form", quantity: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/quantities/#{quantity}")

      html = render(show_live)
      assert html =~ "Quantity updated successfully"
      assert html =~ "some updated name"
    end
  end
end
