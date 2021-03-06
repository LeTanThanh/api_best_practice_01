require "swagger_helper"

describe "Cars API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/cars" do
    get "List cars" do
      tags "Cars"
      produces "application/json"

      parameter name: "X-TOKEN", type: :string, in: :header, required: true, description: "X-TOKEN for API request", example: "123456789"

      response "200", "List cars success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Get list cars success"},
            message: {type: :string, description: "Get list cars success message"},
            data: {type: :array,
              items: {
                type: :object,
                properties: {
                  id: {type: :integer, description: "Car's id"},
                  name: {type: :string, description: "Car's name"},
                  color: {type: :string, description: "Car's color"},
                  code: {type: :string, description: "Car's code"},
                  description: {type: :string, description: "Car's description"}
                }
              }
            }
          }

        examples "List cars success" => {
          success: true,
          message: "Get list cars success",
          data: [
            {
              id: 1,
              name: "Car-repellat",
              color: "cornflowerblue",
              code: "8157646007824",
              description: "Qui laboriosam repellat corrupti ea."
            },
            {
              id: 2,
              name: "Car-autInc",
              color: "gray",
              code: "9163234980164",
              description: "Et et ut minus quam voluptatem earum repellat pariatur."
            }
          ]
        }

        run_test!
      end

      response "401", "Unauthorized" do
        schema "$ref": "#/definitions/errors/authentication/schema"

        examples "Unauthorized": {"$ref": "#/definitions/errors/authentication/example"}

        run_test!
      end
    end
  end
end
