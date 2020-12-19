defmodule SuretipsApiWeb.HistoryView do
  use SuretipsApiWeb, :view
  alias SuretipsApiWeb.HistoryView

  def render("index.json", %{histories: histories}) do
    %{data: render_many(histories, HistoryView, "history.json")}
  end

  def render("show.json", %{history: history}) do
    %{data: render_one(history, HistoryView, "history.json")}
  end

  def render("history.json", %{history: history}) do
    %{id: history.id,
      past_date: history.past_date}
  end
end
