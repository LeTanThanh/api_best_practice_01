require "swagger_helper"

describe "Users API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/users/sign_in" do
    post "Sign in user" do
      tags "Users"
      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: {type: :string, description: "User's email", example: "some.one@sun-asterisl.com"},
              password: {type: :string, description: "User's password", example: "Aa@123456789"}
            }
          }
        }
      }

      response "201", "Sign in user success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Sign in user success"},
            message: {type: :boolean, description: "Sign in user success message"},
            data: {
              type: :object,
              id: {type: :integer, description: "User's id"},
              email: {type: :string, description: "User's email"},
              token: {type: :string, description: "User's token"}
            }
          }

        examples "Sign in user success" => {
          success: true,
          message: "Sign in success",
          data: {
            id: 1,
            email: "some.one@sun-asterisk.com",
            token: "xxx-xxx-xxx"
          }
        }

        run_test!
      end

      response "401", "Unauthorized" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Sign in user fail"},
            message: {type: :boolean, description: "Sign in user fail message"}
          }

        examples "Sign in user fail" => {
          success: false,
          message: "Please check email and password"
        }

        run_test!
      end
    end
  end
end