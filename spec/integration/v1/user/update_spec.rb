describe "Users API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/users/{id}" do
    patch "Update user" do
      tags "Users"
      consumes "application/json"
      produces "application/json"

      parameter name: "X-TOKEN", type: :string, in: :header, required: true, description: "X-TOKEN for API request", example: "123456789"
      parameter name: :id, type: :integer, in: :path, required: :true, description: "User's id", example: 1
      parameter name: :body, in: :body, required: :true, description: "User's update body", schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: {type: :string, description: "User's email", example: "some.one@sun-asterisk.com"}
            }
          }
        }
      }

      response "202", "Update user success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Update user success"},
            message: {type: :boolean, description: "Update user success message"},
            data: {
              type: :object,
              properties: {
                id: {type: :integer, description: "User's id"},
                email: {type: :string, description: "User's email"}
              }
            }
          }

        examples "202" "Update user success" => {
          success: true,
          message: "Update user success",
          data: {
            id: "1",
            email: "some.one@sun-asterisk.com"
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

      response "403", "Forbidden" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Forbidden"},
            message: {type: :boolean, description: "Forbidden message"}
          }

        examples "Forbidden" => {
          success: false,
          message: "Please check again your permission"
        }

        run_test!
      end

      response "404", "User not found" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "User not found"},
            message: {type: :boolean, description: "User not found message"},
            erors: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  resource: {type: :string, description: "Error's resource"},
                  field: {type: :string, description: "Error's field"},
                  code: {type: :string, description: "Error's code"},
                  message: {type: :string, description: "Error's message"}
                }
              }
            }
          }

        examples "User not found" => {
          success: false,
          message: "user not found",
          errors: [
            {
              "resource": "user",
              "field": "id",
              "code": 1025,
              "message": "User not found"
            }
          ]
        }

        run_test!
      end

      response "422", "Update user fail" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Sign up user fail"},
            message: {type: :string, description: "Sign up user fail message"},
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
        
        examples "Email can't be blank" => {
          success: false,
          message: "Sign up user fail",
          errors: [
            {
              resource: "user",
              field: "email",
              code: 1002,
              message: "Email can't be blank"
            }
          ]
        },
        "Email is invalid" => {
          success: false,
          message: "Sign up user fail",
          errors: [
            {
              resource: "user",
              field: "email",
              code: 1011,
              message: "Email is invalid"
            }
          ]
        },
        "Email has already been take" => {
          success: false,
          message: "Sign up user fail",
          errors: [
            {
              resource: "user",
              field: "email",
              code: 1021,
              message: "Email has already been take"
            }
          ]
        }

        run_test!
      end
    end
  end  
end
