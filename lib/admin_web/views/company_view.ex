defmodule AdminWeb.CompanyView do
  use AdminWeb, :view
  alias AdminWeb.CompanyView

  def render("index.json", %{companies: companies, total: total}) do
    %{data: render_many(companies, CompanyView, "company.json"), total: total}
  end

  def render("show.json", %{company: company}) do
    %{data: render_one(company, CompanyView, "company.json")}
  end

  def render("company.json", %{company: company}) do
    %{id: company.id,
      name: company.name,
      fantasy_name: company.fantasy_name,
      document_number: company.document_number}
  end
end
