require 'rails_helper'

describe PostsController, type: :controller do
  render_views
  let(:post) { create :post }
  let(:user) { create :user }

  describe '#index' do
    it 'should work when login' do
      sign_in user
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe '#create' do
    it 'should success' do
      sign_in user
      post :create
      expect(response).not_to be_success
    end
  end

  describe '#destroy' do
    it 'should work' do
      sign_in user
      post=create :post, title: 'new title', filename: 'new filename'
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to posts_url
    end
  end
end