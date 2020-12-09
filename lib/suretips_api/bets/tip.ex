defmodule SuretipsApi.Bets.Tip do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tips" do
    field :game, :string
    field :league, :string
    field :odds, :string
    field :pick, :string
    field :status, :boolean, default: false
    field :today, :date, default: Date.utc_today

    timestamps()
  end

  @doc false
  def changeset(tip, attrs) do
    tip
    |> cast(attrs, [:game, :odds, :league, :pick, :status,:today])
    |> validate_required([:game, :odds, :league, :pick, :status,:today])
  end
end
