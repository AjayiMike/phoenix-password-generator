defmodule PasswordGeneratorWeb.PageController do
  use PasswordGeneratorWeb, :controller

  def index(conn, _params, password_lengths) do
    conn
    |> assign(:password_lengths, password_lengths)
    |> assign(:password, "")
    |> render("index.html")
  end

  def generate(conn, %{"password" => password_params}, password_lengths) do
    {:okay, password} = PassGenerator.generate(password_params)

    conn
    |> assign(:password_lengths, password_lengths)
    |> assign(:password, password)
    |> render("index.html")
  end

  def action(conn, _) do
    password_lengths = [
      weak: Enum.map(6..15, & &1),
      strong: Enum.map(16..88, & &1),
      unbelivable: [100, 150]
    ]

    args = [conn, conn.params, password_lengths]
    apply(__MODULE__, action_name(conn), args)
  end
end
