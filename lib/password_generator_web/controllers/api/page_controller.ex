defmodule PasswordGeneratorWeb.Api.PageController do
  use PasswordGeneratorWeb, :controller

  def api_generate(conn, params) do
    case PassGenerator.generate(params) do
      {:okay, pass} -> json(conn, %{password: pass})
      {:error, error} -> json(conn, %{error: error})
    end
  end
end
