require "swagger_helper"

describe "Cars API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/{id}" do
    delete "Delete car" do
      tags "Cars"
      consumes "application/json"
      produces "application/json"

      parameter name: :id, in: :path, required: :true, description: "Car's id"

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

      response "404", "Car not found" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Get car detail fail"},
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