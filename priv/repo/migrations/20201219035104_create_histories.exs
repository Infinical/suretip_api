defmodule SuretipsApi.Repo.Migrations.CreateHistories do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :past_date, :date

      timestamps()
    end

  end
end
