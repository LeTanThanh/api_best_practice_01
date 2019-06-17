describe "Users API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/users/sign_out" do
    delete "Sign out usser" do
      tags "Users"
      consumes "application/json"
      produces "application/json"

      parameter name: "X-TOKEN", type: :string, in: :header, required: :true, description: "X-TOKEN for API request", example: "123456789"

      response "200", "Sign out user success" do
        schema type: :object,
          properties: {
            success: {type: :boolean, description: "Sign out user success"},
            message: {type: :string, description: "Sign out user success mesage"}
          }
        
        examples "Sign out user" => {
          success: true,
          mesage: "Sign out user success"
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
    end
  end
end
