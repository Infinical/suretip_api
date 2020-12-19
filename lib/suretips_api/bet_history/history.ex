defmodule SuretipsApi.BetHistory.History do
  use Ecto.Schema
  import Ecto.Changeset

  schema "histories" do
    field :past_date, :date
    has_many :tips, SuretipsApi.Bets.Tip

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:past_date])
    |> validate_required([:past_date])
  end
end
