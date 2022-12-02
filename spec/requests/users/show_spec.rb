require 'rails_helper'
require 'database_cleaner/active_record'
require Rails.root.join('./spec/requests/users/invokes_policy.rb')


RSpec.describe User, type: :request do
  context 'Confirmed client' do
    let(:user) { create(:user) }

    it 'blocks unauthenticated access and allows authenticated access' do
      user.save
      path = "#{users_path}/#{user.id}"
      get path
      expect(response.status).to eq(401)

      sign_in user
      get path
      expect(response.status).to eq(200)
    end
  end
end
