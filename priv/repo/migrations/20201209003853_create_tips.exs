defmodule SuretipsApi.Repo.Migrations.CreateTips do
  use Ecto.Migration

  def change do
    create table(:tips) do
      add :game, :string
      add :odds, :string
      add :league, :string
      add :pick, :string
      add :status, :boolean, default: false, null: false

      timestamps()
    end

  end
end
