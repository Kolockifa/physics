defmodule Physics.Repo.Migrations.CreateQuantities do
  use Ecto.Migration

  def change do
    create table(:quantities) do
      add :name, :string
      add :formula, :string
      add :descr, :string
      add :vector, :string
      add :unit, :string
      add :section, :string

      timestamps(type: :utc_datetime)
    end
  end
end
