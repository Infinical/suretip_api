defmodule SuretipsApiWeb.TipControllerTest do
  use SuretipsApiWeb.ConnCase

  alias SuretipsApi.Bets
  alias SuretipsApi.Bets.Tip

  @create_attrs %{
    game: "some game",
    league: "some league",
    odds: "some odds",
    pick: "some pick",
    status: true
  }
  @update_attrs %{
    game: "some updated game",
    league: "some updated league",
    odds: "some updated odds",
    pick: "some updated pick",
    status: false
  }
  @invalid_attrs %{game: nil, league: nil, odds: nil, pick: nil, status: nil}

  def fixture(:tip) do
    {:ok, tip} = Bets.create_tip(@create_attrs)
    tip
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tips", %{conn: conn} do
      conn = get(conn, Routes.tip_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tip" do
    test "renders tip when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tip_path(conn, :create), tip: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.tip_path(conn, :show, id))

      assert %{
               "id" => id,
               "game" => "some game",
               "league" => "some league",
               "odds" => "some odds",
               "pick" => "some pick",
               "status" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tip_path(conn, :create), tip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tip" do
    setup [:create_tip]

    test "renders tip when data is valid", %{conn: conn, tip: %Tip{id: id} = tip} do
      conn = put(conn, Routes.tip_path(conn, :update, tip), tip: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.tip_path(conn, :show, id))

      assert %{
               "id" => id,
               "game" => "some updated game",
               "league" => "some updated league",
               "odds" => "some updated odds",
               "pick" => "some updated pick",
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tip: tip} do
      conn = put(conn, Routes.tip_path(conn, :update, tip), tip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tip" do
    setup [:create_tip]

    test "deletes chosen tip", %{conn: conn, tip: tip} do
      conn = delete(conn, Routes.tip_path(conn, :delete, tip))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.tip_path(conn, :show, tip))
      end
    end
  end

  defp create_tip(_) do
    tip = fixture(:tip)
    %{tip: tip}
  end
end
