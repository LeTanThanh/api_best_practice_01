require "swagger_helper"

describe "Cars API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/cars/{id}" do
    delete "Delete car" do
      tags "Cars"
      consumes "application/json"
      produces "application/json"

      parameter name: "X-TOKEN", type: :string, in: :header, required: true, description: "X-TOKEN for API request", example: "123456789"
      parameter name: :id, in: :path, required: :true, description: "Car's id", example: 1

      response "202", "delete car success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Delete car success"},
            message: {type: :string, description: "Delete car success message"}
          }
        
        examples "Delete car success" => {
          success: true,
          message: "Delete car success"
        }

        run_test!
      end

      response "401", "Unauthorized" do
        schema "$ref": "#/definitions/errors/authentication/schema"

        examples "Unauthorized": {"$ref": "#/definitions/errors/authentication/example"}

        run_test!
      end

      response "403", "Forbidden" do
        schema "$ref": "#/definitions/errors/authorization/schema"

        examples "Forbidden": {"$ref": "#/definitions/errors/authorization/example"}

        run_test!
      end

      response "404", "Car not found" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Get car detail fail"},
            message: {type: :string, description: "Get car detail fail message"},
            errors: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  resource: {type: :string, description: "Error's resource"},
                  field: {type: :string, description: "Error's field"},
                  code: {type: :integer, description: "Error's code"},
                  message: {type: :string, description: "Error's message"}
                }
              }
            }
          }
        
          examples "Car not found" => {
            success: false,
            message: "Car not found",
            errors: [
              {
                resource: "car",
                field: "id",
                code: "1025",
                nessage: "Car not found"
              }
            ]
          }

          run_test!
      end
    end
  end
end
