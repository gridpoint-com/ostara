defmodule OstaraTest do
  use ExUnit.Case
  alias Ostara.Schemas.Product

  # Test schema based on https://json-schema.org/learn/getting-started-step-by-step.html
  describe "transmute/1" do
    test "produces the correct schema" do
      assert Ostara.transmute(Product) == %{
               "$schema" => "https://json-schema.org/draft/2020-12/schema",
               "$id" => "product",
               "title" => "Product",
               "type" => "object",
               "description" => "A product from Acme's catalog",
               "properties" => %{
                 "product_id" => %{
                   "type" => "integer"
                 },
                 "product_name" => %{
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
                 },
                 "reviews" => %{
                   "type" => "array",
                   "items" => %{
                     "title" => "Review",
                     "type" => "object",
                     "properties" => %{
                       "author" => %{
                         "type" => "string"
                       },
                       "rating" => %{
                         "type" => "integer",
                         "exclusiveMinimum" => 0,
                         "maximum" => 5
                       }
                     },
                     "required" => ["rating"]
                   }
                 }
               },
               "required" => ["dimensions", "product_id", "product_name", "price"]
             }
    end

    # test "generates JSON data" do
    #   assert Ostara.transmute(Product, format: :json) =~ ~s("title": "Product")
    # end
  end
end
