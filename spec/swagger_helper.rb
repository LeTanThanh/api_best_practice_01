require "rails_helper"

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + "/swagger"

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    "v1/swagger.json" => {
      swagger: "2.0",
      info: {
        title: "API V1",
        version: "v1"
      },
      paths: {},
      schemes: ["http"],
      host: "localhost:3000",
      definitions: {
        errors: {
          authentication: {
            schema: {
              type: :object,
              properties: {
                success: {type: :boolean, description: "Unauthorized"},
                message: {type: :boolean, description: "Unauthorized message"}
              }
            },

            example: {
              success: false,
              message: "Please check again your email, password or your token token"
            }
          },

          authorization: {
            schema: {
              type: :object,
              properties: {
                success: {type: :boolean, description: "Forbidden"},
                message: {type: :boolean, description: "Forbidden message"}
              }
            },

            example: {
              success: false,
              message: "Please check again your permission"
            }
          }
        }
      }
    },
    "v2/swagger.json" => {
      swagger: "2.0",
      info: {
        title: "API V2",
        version: "v2"
      },
      paths: {}
    }
  }
end
