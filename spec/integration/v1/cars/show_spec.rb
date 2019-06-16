require "swagger_helper"

describe "Cars API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/cars/{id}" do
    get "Car detail" do
      tags "Cars"
      consumes "application/json"
      produces "application/json"

      parameter name: :id, type: :integer, in: :path, required: :true, description: "Car's id"

      response "200", "Get car detail success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Get car detail success"},
            message: {type: :string, description: "Get car detail succes message"},
            data: {
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
        
          examples "Get car details success" => {
            success: true,
            message: "Get car detail success",
            data: {
              id: "1",
              name: "Car-VinFast",
              color: "Red",
              code: "123456789",
              description: "Car Vinfast"
            }
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
