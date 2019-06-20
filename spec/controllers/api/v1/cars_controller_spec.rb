require "rails_helper"

RSpec.describe Api::V1::CarsController, type: :controller do
  let(:user) { create :user }
  let(:token) { create :token, user: user }
  let(:car) { create :car, user: user }
  let(:params) do
    {
      car: {
        name: "Car SunInc",
        color: "Red",
        code: "0123456789",
        description: "Car SunInc is awesome"
      }
    }
  end

  describe "POST #create" do
    context "unauthorized user" do
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
        post :create, params: params

        expect(response.status).to eq 401
        expect(response.body).to eq response_body.to_json
      end
    end

    context "authorized user" do
      before(:example) do
        request.headers["X-TOKEN"] = token.token
      end

      context "valid params" do
        let(:response_body) {
          {
            success: true,
            message: "Create car success",
            data: {
              id: 1,
              user_id: user.id,
              name: "Car SunInc",
              color: "Red",
              code: "0123456789",
              description: "Car SunInc is awesome"
            }
          }
        }

        it "create car success" do
          post :create, params: params
  
          expect(response.status).to eq 201
          expect(response.body).to eq response_body.to_json
        end
      end

      context "invalid params" do
        context "invalid name params" do
          context "name isn't presence" do
            let(:invalid_params) { params.deep_merge({car: {name: ""}}) }
            let(:response_body) do
              {
                success: false,
                message: "Create car fail",
                errors: [
                  {
                    resource: "car",
                    field: "name",
                    code: 1002,
                    message: "Name can't be blank"
                  }
                ]
              }
            end

            it "create car fail" do
              post :create, params: invalid_params
  
              expect(response.status).to eq 422
              expect(response.body).to eq response_body.to_json
            end
          end
  
          context "name isn't uniqueness" do
            let(:another_car) { create :car, user: user }
            let(:invalid_params) { params.deep_merge({car: {name: another_car.name}}) }
            let(:response_body) do
              {
                success: false,
                message: "Create car fail",
                errors: [
                  {
                    resource: "car",
                    field: "name",
                    code: 1021,
                    message: "Name has already been taken"
                  }
                ]
              }
            end

            it "create car fail" do
              post :create, params: invalid_params
  
              expect(response.status).to eq 422
              expect(response.body).to eq response_body.to_json
            end
          end
        end

        context "invalid color params" do
          context "color isn't presence" do
            let(:invalid_params) { params.deep_merge({car: {color: ""}}) }
            let(:response_body) do
              {
                success: false,
                message: "Create car fail",
                errors: [
                  {
                    resource: "car",
                    field: "color",
                    code: 1002,
                    message: "Color can't be blank"
                  }
                ]
              }
            end

            it "create car fail" do
              post :create, params: invalid_params
  
              expect(response.status).to eq 422
              expect(response.body).to eq response_body.to_json
            end
          end
        end

        context "invalid code params" do
          context "code isn't presence" do
            let(:invalid_params) { params.deep_merge({car: {code: ""}}) }
            let(:response_body) do
              {
                success: false,
                message: "Create car fail",
                errors: [
                  {
                    resource: "car",
                    field: "code",
                    code: 1002,
                    message: "Code can't be blank"
                  }
                ]
              }
            end

            it "create car fail" do
              post :create, params: invalid_params
  
              expect(response.status).to eq 422
              expect(response.body).to eq response_body.to_json
            end
          end

          context "code isn't uniqueness" do
            let(:another_car) { create :car, user: user }
            let(:invalid_params) { params.deep_merge({car: {code: another_car.code}}) }
            let(:response_body) do
              {
                success: false,
                message: "Create car fail",
                errors: [
                  {
                    resource: "car",
                    field: "code",
                    code: 1021,
                    message: "Code has already been taken"
                  }
                ]
              }
            end
            
            it "create car fail" do
              post :create, params: invalid_params
  
              expect(response.status).to eq 422
              expect(response.body).to eq response_body.to_json
            end
          end
        end

        context "invalid description params" do
          context "description isn't presence" do
            let(:invalid_params) { params.deep_merge({car: {description: ""}}) }
            let(:response_body) do
              {
                success: false,
                message: "Create car fail",
                errors: [
                  {
                    resource: "car",
                    field: "description",
                    code: 1002,
                    message: "Description can't be blank"
                  }
                ]
              }
            end

            it "create car fail" do
              post :create, params: invalid_params
  
              expect(response.status).to eq 422
              expect(response.body).to eq response_body.to_json
            end
          end
        end
      end
    end
  end

  describe "GET #index" do
    context "unauthorized user" do
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
        post :create, params: params

        expect(response.status).to eq 401
        expect(response.body).to eq response_body.to_json
      end
    end

    context "authorized user" do
      let!(:car_1) { create :car, user: user}
      let!(:car_2) { create :car, user: user}
      let(:response_body) do
        {
          success: true,
          message: "Get list cars success",
          data: ActiveModel::Serializer::CollectionSerializer.new([car_1, car_2])
        }
      end

      before(:example) do
        request.headers["X-TOKEN"] = token.token
      end

      it "return user's cars" do
        get :index

        expect(response.status).to eq 200
        expect(response.body).to eq response_body.to_json
      end
    end
  end

  describe "GET #show" do
    context "unauthorized user" do
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
        post :create, params: params

        expect(response.status).to eq 401
        expect(response.body).to eq response_body.to_json
      end
    end

    context "authorized user" do
      before(:example) do
        request.headers["X-TOKEN"] = token.token
      end

      context "car belong to user" do
        let(:response_body) do
          {
            success: true,
            message: "Get car detail success",
            data: CarSerializer.new(car)
          }
        end

        it "return user's car" do
          get :show, params: { id: car.id }

          expect(response.status).to eq 200
          expect(response.body).to eq response_body.to_json
        end
      end

      context "car not found" do
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
          get :show, params: {id: 0}

          expect(response.status).to eq 404
          expect(response.body).to eq response_body.to_json
        end
      end

      context "car belong to other user" do
        let(:other_user) { create :user }
        let(:other_car) { create :car, user: other_user }
        let(:response_body) do
          {
            success: false,
            message: "Please check again your permission"
          }
        end

        it "raise authorization error" do
          get :show, params: { id: other_car.id }

          expect(response.status).to eq 403
          expect(response.body).to eq response_body.to_json
        end
      end
    end
  end

  describe "PATCH #update" do
    context "unauthorized user" do
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
        post :create, params: params

        expect(response.status).to eq 401
        expect(response.body).to eq response_body.to_json
      end
    end

    context "authorized user" do
      before(:example) do
        request.headers["X-TOKEN"] = token.token
      end

      context "car belong to user" do
        context "valid params" do
          let(:response_body) {
            {
              success: true,
              message: "Update car success",
              data: {
                id: 1,
                user_id: user.id,
                name: "Car SunInc",
                color: "Red",
                code: "0123456789",
                description: "Car SunInc is awesome"
              }
            }
          }
  
          it "update car success" do
            patch :update, params: params.merge(id: car.id)
    
            expect(response.status).to eq 202
            expect(response.body).to eq response_body.to_json
          end
        end

        context "invalid params" do
          context "invalid name params" do
            context "name isn't presence" do
              let(:invalid_params) { params.deep_merge({car: {name: ""}}) }
              let(:response_body) do
                {
                  success: false,
                  message: "Update car fail",
                  errors: [
                    {
                      resource: "car",
                      field: "name",
                      code: 1002,
                      message: "Name can't be blank"
                    }
                  ]
                }
              end
  
              it "update car fail" do
                patch :update, params: invalid_params.merge(id: car.id)
    
                expect(response.status).to eq 422
                expect(response.body).to eq response_body.to_json
              end
            end

            context "name isn't uniqueness" do
              let(:another_car) { create :car, user: user }
              let(:invalid_params) { params.deep_merge({car: {name: another_car.name}}) }
              let(:response_body) do
                {
                  success: false,
                  message: "Update car fail",
                  errors: [
                    {
                      resource: "car",
                      field: "name",
                      code: 1021,
                      message: "Name has already been taken"
                    }
                  ]
                }
              end
  
              it "update car fail" do
                patch :update, params: invalid_params.merge(id: car.id)
    
                expect(response.status).to eq 422
                expect(response.body).to eq response_body.to_json
              end
            end
          end

          context "invalid color params" do
            context "color isn't presence" do
              let(:invalid_params) { params.deep_merge({car: {color: ""}}) }
              let(:response_body) do
                {
                  success: false,
                  message: "Update car fail",
                  errors: [
                    {
                      resource: "car",
                      field: "color",
                      code: 1002,
                      message: "Color can't be blank"
                    }
                  ]
                }
              end
  
              it "update car fail" do
                patch :update, params: invalid_params.merge(id: car.id)
    
                expect(response.status).to eq 422
                expect(response.body).to eq response_body.to_json
              end
            end
          end

          context "invalid code params" do
            context "code isn't presence" do
              let(:invalid_params) { params.deep_merge({car: {code: ""}}) }
              let(:response_body) do
                {
                  success: false,
                  message: "Update car fail",
                  errors: [
                    {
                      resource: "car",
                      field: "code",
                      code: 1002,
                      message: "Code can't be blank"
                    }
                  ]
                }
              end
  
              it "update car fail" do
                patch :update, params: invalid_params.merge(id: car.id)
    
                expect(response.status).to eq 422
                expect(response.body).to eq response_body.to_json
              end
            end
  
            context "code isn't uniqueness" do
              let(:another_car) { create :car, user: user }
              let(:invalid_params) { params.deep_merge({car: {code: another_car.code}}) }
              let(:response_body) do
                {
                  success: false,
                  message: "Update car fail",
                  errors: [
                    {
                      resource: "car",
                      field: "code",
                      code: 1021,
                      message: "Code has already been taken"
                    }
                  ]
                }
              end
              
              it "update car fail" do
                patch :update, params: invalid_params.merge(id: car.id)
    
                expect(response.status).to eq 422
                expect(response.body).to eq response_body.to_json
              end
            end

            context "invalid description params" do
              context "description isn't presence" do
                let(:invalid_params) { params.deep_merge({car: {description: ""}}) }
                let(:response_body) do
                  {
                    success: false,
                    message: "Update car fail",
                    errors: [
                      {
                        resource: "car",
                        field: "description",
                        code: 1002,
                        message: "Description can't be blank"
                      }
                    ]
                  }
                end
    
                it "update car fail" do
                  patch :update, params: invalid_params.merge(id: car.id)
      
                  expect(response.status).to eq 422
                  expect(response.body).to eq response_body.to_json
                end
              end
            end
          end

          context "invalid description params" do
            context "description isn't presence" do
              let(:invalid_params) { params.deep_merge({car: {description: ""}}) }
              let(:response_body) do
                {
                  success: false,
                  message: "Update car fail",
                  errors: [
                    {
                      resource: "car",
                      field: "description",
                      code: 1002,
                      message: "Description can't be blank"
                    }
                  ]
                }
              end
  
              it "update car fail" do
                patch :update, params: invalid_params.merge(id: car.id)
    
                expect(response.status).to eq 422
                expect(response.body).to eq response_body.to_json
              end
            end
          end
        end
      end

      context "car not found" do
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
          patch :update, params: params.merge(id: 0)

          expect(response.status).to eq 404
          expect(response.body).to eq response_body.to_json
        end
      end

      context "car belong to other user" do
        let(:other_user) { create :user }
        let(:other_car) { create :car, user: other_user }
        let(:response_body) do
          {
            success: false,
            message: "Please check again your permission"
          }
        end

        it "raise authorization error" do
          patch :update, params: params.merge(id: other_car.id)

          expect(response.status).to eq 403
          expect(response.body).to eq response_body.to_json
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "unauthorized user" do
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
        delete :destroy, params: { id: car.id }

        expect(response.status).to eq 401
        expect(response.body).to eq response_body.to_json
      end
    end

    context "authorized user" do
      before(:example) do
        request.headers["X-TOKEN"] = token.token
      end

      context "car belong to user" do
        let(:response_body) do
          {
            success: true,
            message: "Destroy car success"
          }
        end

        it "delete car success" do
          delete :destroy, params: { id: car.id }

          expect(response.status).to eq 202
          expect(response.body).to eq response_body.to_json
        end
      end

      context "car not found" do
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
          delete :destroy, params: { id: 0 }

          expect(response.status).to eq 404
          expect(response.body).to eq response_body.to_json
        end
      end

      context "car belong to other user" do
        let(:other_user) { create :user }
        let(:other_car) { create :car, user: other_user }
        let(:response_body) do
          {
            success: false,
            message: "Please check again your permission"
          }
        end

        it "raise authorization error" do
          delete :destroy, params: { id: other_car.id }

          expect(response.status).to eq 403
          expect(response.body).to eq response_body.to_json
        end
      end
    end
  end
end
