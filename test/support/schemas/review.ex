defmodule Ostara.Schemas.Product.Review do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :author, :string
    field :rating, :integer
  end

  def changeset(data, params) do
    data
    |> cast(params, [:author, :rating])
    |> validate_required([:rating])
    |> validate_number(:rating, greater_than: 0, less_than_or_equal_to: 5)
  end
end
