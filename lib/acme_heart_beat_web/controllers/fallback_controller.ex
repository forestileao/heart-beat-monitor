defmodule AcmeHeartBeatWeb.FallbackController do
  use AcmeHeartBeatWeb, :controller
  import Plug.Conn.Status, only: [code: 1]

  def call(conn, {:error, result, status}) do
    conn
    |> put_status(status)
    |> put_view(AcmeHeartBeatWeb.ErrorJSON)
    |> render("#{code(status)}.json", result: result)
  end

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(AcmeHeartBeatWeb.ErrorJSON)
    |> render("400.json", result: result)
  end
end
