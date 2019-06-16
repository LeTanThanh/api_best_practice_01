require "swagger_helper"

describe "Users API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/users/sign_up" do
    post "Sign up user" do
      tags "Users"
      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, required: :true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: {type: :string, description: "User's email", example: "some.one@sun-asterisk.com"},
              password: {type: :string, description: "User's password", example: "Aa@123456789"},
              password_confirmation: {type: :string, description: "User's password confirmation", example: "Aa@123456789"}
            }
          }
        }
      }

      response "201", "Sign up user success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Sign up user success"},
            message: {type: :string, boolean: "Sign up user success"},
            data: {
              type: :object,
              properties: {
                id: {type: :integer, description: "User's id"},
                email: {type: :string, description: "User's password"}
              }
            }
          }
        
        examples "Sign up user success" => {
          success: true,
          message: "Sign up user success",
          data: {
            id: 1,
            email: "some.one@sun-asterisk.com"
          }
        }

        run_test!
      end

      response "422", "Sign up user fail" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Sign up user fail"},
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
          errors: [
            {
              resource: "user",
              field: "email",
              code: 1021,
              message: "Email has already been take"
            }
          ]
        },
        "Password can't be blank" => {
          success: false,
          errors: [
            {
              resource: "user",
              field: "password",
              code: 1002,
              message: "Password can't be blank"
            }
          ]
        },
        "Password is too short (minimum is 6 characters)" => {
          success: false,
          errors: [
            {
              resource: "user",
              field: "password",
              code: 1023,
              message: "Password is too short (minimum is 6 characters)"
            }
          ]
        },
        "Password is too long (maximum is 128 characters)" => {
          success: false,
          errors: [
            {
              resource: "user",
              field: "password",
              code: 1022,
              message: "Password is too long (maximum is 128 characters)"
            }
          ]
        },
        "Password confirmation can't be blank" => {
          success: false,
          errors: [
            {
              resource: "user",
              field: "password_confirmation",
              code: 1002,
              message: "Password confirmation can't be blank"
            }
          ]
        },
        "Password confirmation doesn't match Password" => {
          success: false,
          errors: [
            {
              resource: "user",
              field: "password_confirmation",
              code: 1002,
              message: "Password confirmation doesn't match Password"
            }
          ]
        }

        run_test!
      end
    end
  end
end
