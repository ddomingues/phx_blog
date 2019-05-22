defmodule AdminWeb.CompanyController do
  use AdminWeb, :controller

  alias Admin.Companies
  alias Admin.Companies.Company

  action_fallback AdminWeb.FallbackController

  def index(conn, %{"per_page" => per_page, "page" => page}) do
    {per_page_i, _} = per_page |> Integer.parse
    {page_i, _} = page |> Integer.parse
    companies = Companies.list_companies(per_page_i, page_i)
    total_companies = Companies.total_companies
    # total_companies = 425038
    render(conn, "index.json", companies: companies, total: total_companies )
  end

  def create(conn, %{"company" => company_params}) do
    with {:ok, %Company{} = company} <- Companies.create_company(company_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.company_path(conn, :show, company))
      |> render("show.json", company: company)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Companies.get_company!(id)
    render(conn, "show.json", company: company)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Companies.get_company!(id)

    with {:ok, %Company{} = company} <- Companies.update_company(company, company_params) do
      render(conn, "show.json", company: company)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Companies.get_company!(id)

    with {:ok, %Company{}} <- Companies.delete_company(company) do
      send_resp(conn, :no_content, "")
    end
  end
end
