defmodule Physics.Quantities do
  @moduledoc """
  The Quantities context.
  """

  import Ecto.Query, warn: false
  alias Physics.Repo

  alias Physics.Quantities.Quantity

  @doc """
  Returns the list of quantities.

  ## Examples

      iex> list_quantities()
      [%Quantity{}, ...]

  """
  def list_quantities do
    Repo.all(Quantity)
  end

  @doc """
  Gets a single quantity.

  Raises `Ecto.NoResultsError` if the Quantity does not exist.

  ## Examples

      iex> get_quantity!(123)
      %Quantity{}

      iex> get_quantity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quantity!(id), do: Repo.get!(Quantity, id)

  @doc """
  Creates a quantity.

  ## Examples

      iex> create_quantity(%{field: value})
      {:ok, %Quantity{}}

      iex> create_quantity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quantity(attrs) do
    %Quantity{}
    |> Quantity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quantity.

  ## Examples

      iex> update_quantity(quantity, %{field: new_value})
      {:ok, %Quantity{}}

      iex> update_quantity(quantity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quantity(%Quantity{} = quantity, attrs) do
    quantity
    |> Quantity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quantity.

  ## Examples

      iex> delete_quantity(quantity)
      {:ok, %Quantity{}}

      iex> delete_quantity(quantity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quantity(%Quantity{} = quantity) do
    Repo.delete(quantity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quantity changes.

  ## Examples

      iex> change_quantity(quantity)
      %Ecto.Changeset{data: %Quantity{}}

  """
  def change_quantity(%Quantity{} = quantity, attrs \\ %{}) do
    Quantity.changeset(quantity, attrs)
  end
end
