require "swagger_helper"

describe "Cars API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/cars/{id}" do
    patch "Update car" do
      tags "Cars"
      consumes "application/json"
      produces "application/jsonc"

      parameter name: :id, type: :integer, in: :path, required: :true, description: "Car's id"
      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          car: {
            type: :object,
            properties: {
              name: {type: :string, description: "Car's name", example: "Car-VinFast"},
              color: {type: :string, description: "Car's color", example: "Red"},
              code: {type: :string, description: "Car's code", example: "123456789"},
              description: {type: :string, description: "Car's description", example: "Car VinFast"}
            }
          }
        }
      }

      response "204", "Update car success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Update car success"},
            message: {type: :string, description: "Update car success message"},
            data: {
              type: :object,
              properties: {
                id: {type: :integer, description: "Car's id"},
                name: {type: :string, description: "Car's name"},
                color: {type: :string, description: "Car's color"},
                code: {type: :string, description: "Car's code"},
                description: {type: :string, description: "Car's description", example: "Car VinFast"}
              }
            }
          }

        examples "Update car success" => {
          success: true,
          message: "Update car success",
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

      response "422", "Update car fail" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Update car fail"},
            errors: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  resource: {type: :string, description: "Error's resource"},
                  field: {type: :string, description: "Error's field"},
                  code: {type: :integer, description: "Error's code"},
                  message: {type: :message, description: "Error's message"}
                }
              }
            }
          }

        examples "Name can't be blank" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "name",
              code: 1002,
              message: "Name can't be blank"
            }
          ]
        },
        "Name has already been taken" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "name",
              code: 1021,
              message: "Name has already been taken"
            }
          ]
        },
        "Color can't be blank" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "color",
              code: 1002,
              message: "Color can't be blank"
            }
          ]
        },
        "Color has already been taken" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "color",
              code: 1021,
              message: "Color has already been taken"
            }
          ]
        },
        "Code can't be blank" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "code",
              code: 1002,
              message: "Code can't be blank"
            }
          ]
        },
        "Code has already been taken" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "code",
              code: 1021,
              message: "Code has already been taken"
            }
          ]
        },
        "Description can't be blank" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "description",
              code: 1002,
              message: "Description can't be blank"
            }
          ]
        },
        "Description has already been taken" => {
          success: false,
          errors: [
            {
              resource: "car",
              field: "description",
              code: 1021,
              message: "Description has already been taken"
            }
          ]
        }

        run_test!
      end
    end
  end 
end
