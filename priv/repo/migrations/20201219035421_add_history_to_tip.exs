defmodule SuretipsApi.Repo.Migrations.AddHistoryToTip do
  use Ecto.Migration

  def change do
    alter table(:tips) do
      add :history_id, references(:histories)
    end
  end
end
