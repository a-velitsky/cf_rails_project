require 'rails_helper'

describe ProductsController, type: :controller do
	let(:user) { FactoryGirl.create(:user)}
	let(:admin) {FactoryGirl.create(:admin_user)}
	let(:product) { FactoryGirl.create(:product) }
	before do
		admin.confirm
		user.confirm
	end
	describe "GET product" do

		context "#index" do
			
			it "reads the product index page" do
				get :index
				expect(response).to have_http_status(200)
				expect(response).to render_template :index
			end

			it "displays all products on product index page" do
				get :index
				expect(assigns(:products)).to eq Product.all
			end

			it "filters products names" do
				get :index, params: { q: "test product"}
				expect(response).to have_http_status(200)
				expect(response).to render_template :index
			end
		end

		context "#show/[id]" do

			it "reads the correct product show page" do
				get :show, params:{id: product.id}
        expect(response).to have_http_status(200)
        expect(assigns(:product)).to eq product
			end
		end
	end
	describe "POST product" do

		context "using guest user" do
			it "does not create a new product" do
				post :new
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to match(/You are not authorized to access this page./)
			end
		end

		context "using admin user" do
			before do
				sign_in admin
			end
			
			it "creates a new product" do
				post :new
				expect(response).to have_http_status(200)
				expect(response).to render_template :new
				expect(assigns(:product)).to be_a_new(Product)
				expect{
					post :create, params: {id: product.id, product: FactoryGirl.attributes_for(:product)}
						}.to change(Product, :count).by(2)
        expect(response).to redirect_to(product_path(Product.last))

			end
		end
		
		context "using non-admin user" do	
			before do
				sign_in user
			end
			
			it "does not create a new product" do
				post :new
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
			end
		end
	end

	describe "PATCH product" do

		context "using guest user" do
			
			it "does not update" do
				patch :edit, params: { id: product.id, name: "new name", description: "new description", image_url: "this.jpg", colour: "orange", price: "99.99" }
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to match(/You are not authorized to access this page./)
			end
		end

		context "using non-admin user" do
			before do
				sign_in user
			end

			it "does not update" do
				patch :edit, params: { id: product.id, name: "new name", description: "new description", image_url: "this.jpg", colour: "orange", price: "99.99" }
				expect(response).to have_http_status(302)
				expect(response).to redirect_to(root_path)
				expect(flash[:alert]).to match(/You are not authorized to access this page./)
			end
		end

		context "using admin user" do
			before do
				sign_in admin
			end
			
			context "updates product" do
				
				it "using :edit" do
					patch :edit, params: { id: product.id, product: FactoryGirl.attributes_for(:updated_product) }
        	expect(response).to have_http_status(200)
        	expect(response).to render_template :edit
					#patch :update, params: {id: @product.id, name: "new name", description: "new description", image_url: "this.jpg", colour: "orange", price: "99.99" }
				end
				
				it "using :update" do
					patch :update, params: {id: product, product: FactoryGirl.attributes_for(:updated_product, name: "re-updated name") }
					expect(flash[:notice]).to match(/Product was successfully updated./)
					expect(assigns(:product)).to eq(product)
				end
			end

			context "doesn't update" do

				it "using :update with invalid params" do
					expect { patch :update, params: {id: product, name: "red" } }.to raise_error ActionController::ParameterMissing
				end
			end
		end
	end 

	describe "DELETE product" do
		
		context "using guest user" do
			
			it "does not delete a product" do
				expect{delete :destroy, params:{id: product.id}}.to change(Product, :count).by(1)
				#expect(flash[:notice]).to match(/Product was successfully destroyed./)
				expect(flash[:alert]).to match(/You are not authorized to access this page./)
			end
		end

		context "using non-admin user" do
			before do
				sign_in user
			end

			it "does not delete a product" do
				expect{delete :destroy, params:{id: product.id}}.to change(Product, :count).by(1)
			end
		end

		context "using admin user" do
			before do
				sign_in admin
			end

			it "deletes a product" do
				expect{delete :destroy, params:{id: product.id}}.to change(Product, :count).by(0)
				expect { product.reload }.to raise_error ActiveRecord::RecordNotFound
				expect(flash[:notice]).to match(/Product was successfully destroyed./)
			end
		end
	end
end