defmodule Physics.Repo.Migrations.AddSymbol do
  use Ecto.Migration

  def change do
    alter table(:quantities) do
      add :symbol, :string
    end
  end
end
