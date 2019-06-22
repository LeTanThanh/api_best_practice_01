shared_examples "car not found" do
  let(:response_body) do
    {
      success: false,
      message: "Car not found",
      errors: [
        {
          resource: "car",
          field: nil,
          code: 1025,
          message: "Car not found"
        }
      ]
    }
  end

  it "raise record_not_found error" do
    expect(response.status).to eq 404
    expect(response.body).to eq response_body.to_json
  end
end
