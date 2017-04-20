require 'rails_helper'

describe Post, type: :model do
  describe '#index' do
    get :index
    it { expect(response).to be_success }
  end


end