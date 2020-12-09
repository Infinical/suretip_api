defmodule SuretipsApi.Bets.Tip do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tips" do
    field :game, :string
    field :league, :string
    field :odds, :string
    field :pick, :string
    field :status, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(tip, attrs) do
    tip
    |> cast(attrs, [:game, :odds, :league, :pick, :status])
    |> validate_required([:game, :odds, :league, :pick, :status])
  end
end
