defmodule SuretipsApiWeb.TipView do
  use SuretipsApiWeb, :view
  alias SuretipsApiWeb.TipView

  def render("index.json", %{tips: tips}) do
    %{data: render_many(tips, TipView, "tip.json")}
  end

  def render("show.json", %{tip: tip}) do
    %{data: render_one(tip, TipView, "tip.json")}
  end

  def render("tip.json", %{tip: tip}) do
    %{id: tip.id,
      game: tip.game,
      odds: tip.odds,
      league: tip.league,
      pick: tip.pick,
      status: tip.status}
  end
end
