defmodule OstaraTest do
  use ExUnit.Case
  alias Ostara.Schemas.Product

  # Test schema based on https://json-schema.org/learn/getting-started-step-by-step.html
  describe "transmute/1" do
    test "produces the correct schema" do
      assert Ostara.transmute(Product) == %{
               "$schema" => "https://json-schema.org/draft/2020-12/schema",
               "title" => "Product",
               "type" => "object",
               "description" => "A product from Acme's catalog",
               "properties" => %{
                 "productId" => %{
                   "type" => "integer"
                 },
                 "productName" => %{
                   "type" => "string"
                 },
                 "price" => %{
                   "type" => "number",
                   "exclusiveMinimum" => 0
                 },
                 "tags" => %{
                   "type" => "array",
                   "items" => %{
                     "type" => "string"
                   },
                   "minItems" => 1
                 },
                 "dimensions" => %{
                   "title" => "Dimensions",
                   "type" => "object",
                   "properties" => %{
                     "length" => %{
                       "type" => "number"
                     },
                     "width" => %{
                       "type" => "number"
                     },
                     "height" => %{
                       "type" => "number"
                     }
                   },
                   "required" => ["length", "width", "height"]
                 }
               },
               "required" => ["dimensions", "productId", "productName", "price"]
             }
    end

    test "generates JSON data" do
      assert Ostara.transmute(Product, format: :json) =~ ~s("title": "Product")
    end
  end
end
