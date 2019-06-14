require "swagger_helper"

describe "Cars API", swagger_doc: "v1/swagger.json" do
  path "/api/v1/cars" do
    get "List cars" do
      tags "Cars"
      produces "application/json"

      response "200", "List cars success" do
        schema type: :aray,
          items: {
            type: :object,
            properties: {
              id: {type: :integer, description: "Car's id"},
              name: {type: :string, description: "Car's name"},
              color: {type: :string, description: "Car's color"},
              code: {type: :string, description: "Car's code"},
              description: {type: :string, description: "Car's description"},
              created_at: {type: :string, description: "Car's created_at"},
              updated_at: {type: :string, description: "Car's updated_at"}
            }
          }

        examples "List cars success" => [
          {
            id: 1,
            name: "Car-repellat",
            color: "cornflowerblue",
            code: "8157646007824",
            description: "Qui laboriosam repellat corrupti ea.",
            created_at: "2019-06-13T15:41:19.020Z",
            updated_at: "2019-06-13T15:41:19.020Z"
          },
          {
            id: 2,
            name: "Car-autInc",
            color: "gray",
            code: "9163234980164",
            description: "Et et ut minus quam voluptatem earum repellat pariatur.",
            created_at: "2019-06-13T15:41:19.025Z",
            updated_at: "2019-06-13T15:41:19.025Z"
          }
        ]

        run_test!
      end
    end
  end
end
