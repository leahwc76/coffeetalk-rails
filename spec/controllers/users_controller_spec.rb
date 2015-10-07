require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	let(:valid_attributes) {
		@valid_attributes = {
			fname: "Leah",
			lname: "Chang",
			phone: 1234567890,
			email: "leah@nycda.com",
			username: "leahchang",
			password: "1234",
			fav_cafe: "blue bottle",
			fav_coffee: "latte"
		}
	}

	let(:invalid_attributes) {
		@invalid_attributes = {
			email: nil
		}
	}

	let(:valid_session) {
			{user_id: 1}
	}


	describe "GET#index" do #get to the index page
		it "assigns all users as @user" do
			user = User.create! valid_attributes
			get :index
			expect(assigns(:users)).to eq [user]
		end
	end

	describe "GET#show" do #get to the show page
		it "assigns current user as @user" do
			user = User.create! valid_attributes
			get :show, {id: user.to_param}, valid_session
			expect(assigns(:user)).to eq(user)
		end
	end

	describe "GET#new" do #get to the new page
		it "assigns the new user as @user" do
			get :new, {}, valid_session
			expect(assigns(:user)).to be_a_new(User)
		end
	end

	describe "GET#edit" do #get to the edit page
		it "assigns the requested user as @user" do
			user = User.create! valid_attributes
			get :edit, {id: user.to_param}, valid_session
			expect(assigns(:user)).to eq(user)
		end
	end

	describe "POST#create" do #post create action with context of 'valid' and 'invalid' attributes
		context "with valid params" do
			it "creates new user" do
				expect{ 
					post :create, {user: valid_attributes}, valid_session
				}.to change(User, :count).by(1) 
				#the action of post create adds user by count of 1
			end

			it "assigns newly created user to @user" do
				post :create, {user: valid_attributes}, valid_session
				expect(assigns(:user)).to be_a(User) 
				#predicate matcher, make a new user in User class
				expect(assigns(:user)).to be_persisted 
				#predicate matcher, asks whether it was saved or not, true if saved
			end

			it "redirects to newly created and assigned @user" do
				post :create, {user: valid_attributes}, valid_session
				expect(response).to redirect_to(user_path(User.last))
				#newly created user should be User.last
				#redirect to User.last url page
			end

		end

		context "invalid params" do
			it "assigns newly created but unsaved user as @user" do
				post :create, {user: invalid_attributes}, valid_session
				expect(assigns(:user)).to be_a_new(User)
			end

			it "redirects to 'new' template" do
				post :create, {user: invalid_attributes}, valid_session
				expect(response).to render_template("new")
			end
		end
	end

	describe "PUT#update" do
		let(:valid_attributes) {
			@valid_attributes = {
				email: "leahchang@gmail.com",
				password: "awesome1234"
			}
		}

		context "with valid params" do
			it "updates the requested @user" do
				user = User.create! valid_attributes
				put :update, {id: user.to_param, user: valid_attributes}, valid_session
				user.reload #reload after updating
				expect(user.email).to eq("leahchang@gmail.com")
				expect(user.password).to eq("awesome1234")
			end

			it "assigns newly updated user as @user" do
				user = User.create! valid_attributes
				put :update, {id: user.to_param, user: valid_attributes}, valid_session
				expect(assigns(:user)).to eq(user)
			end

			it "redirects to newly updated and assigned @user" do
				user = User.create! valid_attributes
				put :update, {id: user.to_param, user: valid_attributes}, valid_session
				expect(response).to redirect_to(user_path(user))
			end

		end

		context "with invalid params" do
			it "assigns newly updated but unsaved user as @user" do
				user = User.create! valid_attributes
				put :update, {id: user.to_param, user: invalid_attributes}, valid_session
				expect(assigns(:user)).to eq(user)
			end

			it "redirects to 'edit' template" do
				user = User.create! valid_attributes
				put :update, {id: user.to_param, user: invalid_attributes}, valid_session
				expect(response).to render_template("edit")
			end
		end

	end

	describe "DELETE#destroy" do
		it "deletes requested @user" do
			user = User.create! valid_attributes
			expect{
				delete :destroy, {id: user.to_param}, valid_session
			}.to change(User, :count).by(-1)
			#the action of delete destroy subtracts user by count of 1
		end

		it "redirects to users index" do

		end
	end

	describe "POST#follow" do

	end

	describe "POST#unfollow" do

	end

	describe "GET#profile" do

	end

end