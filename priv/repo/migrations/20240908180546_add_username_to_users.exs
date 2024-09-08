defmodule Tooter.Repo.Migrations.AddUsernameToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, null: true, collate: :nocase
    end

    create unique_index(:users, [:username])
  end
end
