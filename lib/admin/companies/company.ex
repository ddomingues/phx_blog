defmodule Admin.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :document_number, :string
    field :fantasy_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :fantasy_name, :document_number])
    |> validate_required([:name, :fantasy_name, :document_number])
    |> unique_constraint(:document_number)
  end
end
