shared_examples "unauthorized user" do
  let(:response_body) do
    {
      success: false,
      message: "Please check again your email, password or your token token"
    }
  end

  before(:example) do
    request.headers["X-TOKEN"] = ""
  end

  it "raise authentication error" do
    # post :create, params: params

    expect(response.status).to eq 401
    expect(response.body).to eq response_body.to_json
  end
end
