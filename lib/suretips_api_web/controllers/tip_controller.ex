defmodule SuretipsApiWeb.TipController do
  use SuretipsApiWeb, :controller

  alias SuretipsApi.Bets
  alias SuretipsApi.Bets.Tip

  action_fallback SuretipsApiWeb.FallbackController

  def index(conn, _params) do
    tips = Bets.list_tips()
    render(conn, "index.json", tips: tips)
  end

  def create(conn, %{"tip" => tip_params}) do
    with {:ok, %Tip{} = tip} <- Bets.create_tip(tip_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tip_path(conn, :show, tip))
      |> render("show.json", tip: tip)
    end
  end

  def show(conn, %{"id" => id}) do
    tip = Bets.get_tip!(id)
    render(conn, "show.json", tip: tip)
  end

  def update(conn, %{"id" => id, "tip" => tip_params}) do
    tip = Bets.get_tip!(id)

    with {:ok, %Tip{} = tip} <- Bets.update_tip(tip, tip_params) do
      render(conn, "show.json", tip: tip)
    end
  end

  def delete(conn, %{"id" => id}) do
    tip = Bets.get_tip!(id)

    with {:ok, %Tip{}} <- Bets.delete_tip(tip) do
      send_resp(conn, :no_content, "")
    end
  end

  def show_today(conn, _params) do
    date = Date.utc_today
    IO.puts(date)
    tips = Bets.get_tips_by_date(date)
   
    render(conn, "index.json", tips: tips)
  end

end
