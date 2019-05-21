defmodule Admin.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :fantasy_name, :string
      add :document_number, :string

      timestamps()
    end

    create unique_index(:companies, [:document_number])
  end
end
