defmodule Ostara.Schemas.Product do
  @moduledoc """
  A product from Acme's catalog
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :product_id, :integer
    field :product_name, :string
    field :price, :float
    field :tags, {:array, :string}

    embeds_one :dimensions, Ostara.Schemas.Dimensions
    embeds_many :reviews, __MODULE__.Review
  end

  def changeset(data, params) do
    data
    |> cast(params, [:product_id, :product_name, :price, :tags])
    |> cast_embed(:dimensions, required: true)
    |> cast_embed(:reviews)
    |> validate_required([:product_id, :product_name, :price])
    |> validate_number(:price, greater_than: 0)
    |> validate_length(:tags, min: 1)
  end
end
