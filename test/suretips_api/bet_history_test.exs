defmodule SuretipsApi.BetHistoryTest do
  use SuretipsApi.DataCase

  alias SuretipsApi.BetHistory

  describe "histories" do
    alias SuretipsApi.BetHistory.History

    @valid_attrs %{past_date: ~D[2010-04-17]}
    @update_attrs %{past_date: ~D[2011-05-18]}
    @invalid_attrs %{past_date: nil}

    def history_fixture(attrs \\ %{}) do
      {:ok, history} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BetHistory.create_history()

      history
    end

    test "list_histories/0 returns all histories" do
      history = history_fixture()
      assert BetHistory.list_histories() == [history]
    end

    test "get_history!/1 returns the history with given id" do
      history = history_fixture()
      assert BetHistory.get_history!(history.id) == history
    end

    test "create_history/1 with valid data creates a history" do
      assert {:ok, %History{} = history} = BetHistory.create_history(@valid_attrs)
      assert history.past_date == ~D[2010-04-17]
    end

    test "create_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BetHistory.create_history(@invalid_attrs)
    end

    test "update_history/2 with valid data updates the history" do
      history = history_fixture()
      assert {:ok, %History{} = history} = BetHistory.update_history(history, @update_attrs)
      assert history.past_date == ~D[2011-05-18]
    end

    test "update_history/2 with invalid data returns error changeset" do
      history = history_fixture()
      assert {:error, %Ecto.Changeset{}} = BetHistory.update_history(history, @invalid_attrs)
      assert history == BetHistory.get_history!(history.id)
    end

    test "delete_history/1 deletes the history" do
      history = history_fixture()
      assert {:ok, %History{}} = BetHistory.delete_history(history)
      assert_raise Ecto.NoResultsError, fn -> BetHistory.get_history!(history.id) end
    end

    test "change_history/1 returns a history changeset" do
      history = history_fixture()
      assert %Ecto.Changeset{} = BetHistory.change_history(history)
    end
  end
end
