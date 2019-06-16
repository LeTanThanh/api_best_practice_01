class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  attribute :token, if: :show_token?

  def token
    @instance_options[:token].token
  end

  def show_token?
    @instance_options[:token]
  end
end
