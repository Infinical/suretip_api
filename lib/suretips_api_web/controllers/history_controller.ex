defmodule SuretipsApiWeb.HistoryController do
  use SuretipsApiWeb, :controller

  alias SuretipsApi.BetHistory
  alias SuretipsApi.BetHistory.History

  action_fallback SuretipsApiWeb.FallbackController

  def index(conn, _params) do
    histories = BetHistory.list_histories()
    render(conn, "index.json", histories: histories)
  end

  def create(conn, %{"history" => history_params}) do
    with {:ok, %History{} = history} <- BetHistory.create_history(history_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.history_path(conn, :show, history))
      |> render("show.json", history: history)
    end
  end

  def show(conn, %{"id" => id}) do
    history = BetHistory.get_history!(id)
    render(conn, "show.json", history: history)
  end

  def update(conn, %{"id" => id, "history" => history_params}) do
    history = BetHistory.get_history!(id)

    with {:ok, %History{} = history} <- BetHistory.update_history(history, history_params) do
      render(conn, "show.json", history: history)
    end
  end

  def delete(conn, %{"id" => id}) do
    history = BetHistory.get_history!(id)

    with {:ok, %History{}} <- BetHistory.delete_history(history) do
      send_resp(conn, :no_content, "")
    end
  end
end
