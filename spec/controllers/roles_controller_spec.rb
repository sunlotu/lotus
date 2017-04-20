require 'rails_helper'

describe Admin::RolesController, type: :controller do
  let(:user) { create :user }
  let(:role) { create :role }

  describe '#index' do
    it 'should work when login' do
      sign_in user
      get :index
      expect(response).to be_success
    end
  end

  describe '#create' do
    it 'should not allow when not login' do
      post :create, params: { id: role.id }
      expect(response).not_to be_success
    end

    it 'should work when login' do
      sign_in user
      post :create, params: { role: { code: 'new code', name: 'new name' }}
      expect(response).to redirect_to admin_roles_path
    end
  end
end