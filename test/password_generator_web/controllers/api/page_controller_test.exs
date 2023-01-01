defmodule PasswordGeneratorWeb.Api.PageControllerTest do
  use PasswordGeneratorWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "genetates a password" do
    test "generates password with ony length passed", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "5"})
      assert(%{"password" => _pass} = json_response(conn, 200))
    end

    test "generates password with one option", %{conn: conn} do
      options = %{"length" => "10", "numbers" => "true"}
      conn = post(conn, Routes.page_path(conn, :api_generate), options)
      assert %{"password" => _pass} = json_response(conn, 200)
    end
  end

  describe "returns errors" do
    test "error when no options provided", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{})
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when length is not integer", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "not an interger"})
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when options are are not booleans", %{conn: conn} do
      options = %{"length" => "5", "numbers" => "wow"}
      conn = post(conn, Routes.page_path(conn, :api_generate), options)
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "error when options are are not valid", %{conn: conn} do
      options = %{"length" => "5", "abcd" => "true", "efgh" => "true"}
      conn = post(conn, Routes.page_path(conn, :api_generate), options)
      assert %{"error" => _error} = json_response(conn, 200)
    end
  end
end
