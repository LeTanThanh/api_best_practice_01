shared_examples "car not belongs to user" do
  let(:other_user) { create :user }
  let(:other_car) { create :car, user: other_user }
  let(:response_body) do
    {
      success: false,
      message: "Please check again your permission"
    }
  end

  it "raise authorization error" do
    expect(response.status).to eq 403
    expect(response.body).to eq response_body.to_json
  end
end
