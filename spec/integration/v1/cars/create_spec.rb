require "swagger_helper"

describe "Cars API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/cars" do
    post "Create car" do
      tags "Cars"
      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, required: :true, description: "Create car's params", schema: {
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

      response "201", "Create car success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Create car success"},
            message: {type: :string, description: "Create car success message"},
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

        examples "Create car success" => {
          success: true,
          message: "Create car success",
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

      response "401", "Unauthorized" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Unauthorized"},
            message: {type: :boolean, description: "Unauthorized message"}
          }

        examples "Unauthorized" => {
          success: false,
          message: "Please check again your email, password or your token token"
        }

        run_test!
      end

      response "422", "Create car fail" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Create car fail"},
            message: {type: :string, description: "Create car fail message"},
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
          message: "Create car fail",
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
          message: "Create car fail",
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
          message: "Create car fail",
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
          message: "Create car fail",
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
          message: "Create car fail",
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
          message: "Create car fail",
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
          message: "Create car fail",
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
          message: "Create car fail",
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
