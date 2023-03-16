defmodule Ostara.Schemas.Dimensions do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :length, :float
    field :width, :float
    field :height, :float
  end

  def changeset(data, params) do
    data
    |> cast(params, [:length, :width, :height])
    |> validate_required([:length, :width, :height])
  end
end
