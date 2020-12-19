defmodule SuretipsApi.Repo.Migrations.ModifyPastDateHistories do
  use Ecto.Migration

  def change do
    alter table(:histories) do
      modify :past_date , :utc_datetime, default: fragment("current_date")
    end
  end
end
