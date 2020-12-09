defmodule SuretipsApi.BetsTest do
  use SuretipsApi.DataCase

  alias SuretipsApi.Bets

  describe "tips" do
    alias SuretipsApi.Bets.Tip

    @valid_attrs %{game: "some game", league: "some league", odds: "some odds", pick: "some pick", status: true}
    @update_attrs %{game: "some updated game", league: "some updated league", odds: "some updated odds", pick: "some updated pick", status: false}
    @invalid_attrs %{game: nil, league: nil, odds: nil, pick: nil, status: nil}

    def tip_fixture(attrs \\ %{}) do
      {:ok, tip} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bets.create_tip()

      tip
    end

    test "list_tips/0 returns all tips" do
      tip = tip_fixture()
      assert Bets.list_tips() == [tip]
    end

    test "get_tip!/1 returns the tip with given id" do
      tip = tip_fixture()
      assert Bets.get_tip!(tip.id) == tip
    end

    test "create_tip/1 with valid data creates a tip" do
      assert {:ok, %Tip{} = tip} = Bets.create_tip(@valid_attrs)
      assert tip.game == "some game"
      assert tip.league == "some league"
      assert tip.odds == "some odds"
      assert tip.pick == "some pick"
      assert tip.status == true
    end

    test "create_tip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bets.create_tip(@invalid_attrs)
    end

    test "update_tip/2 with valid data updates the tip" do
      tip = tip_fixture()
      assert {:ok, %Tip{} = tip} = Bets.update_tip(tip, @update_attrs)
      assert tip.game == "some updated game"
      assert tip.league == "some updated league"
      assert tip.odds == "some updated odds"
      assert tip.pick == "some updated pick"
      assert tip.status == false
    end

    test "update_tip/2 with invalid data returns error changeset" do
      tip = tip_fixture()
      assert {:error, %Ecto.Changeset{}} = Bets.update_tip(tip, @invalid_attrs)
      assert tip == Bets.get_tip!(tip.id)
    end

    test "delete_tip/1 deletes the tip" do
      tip = tip_fixture()
      assert {:ok, %Tip{}} = Bets.delete_tip(tip)
      assert_raise Ecto.NoResultsError, fn -> Bets.get_tip!(tip.id) end
    end

    test "change_tip/1 returns a tip changeset" do
      tip = tip_fixture()
      assert %Ecto.Changeset{} = Bets.change_tip(tip)
    end
  end
end
