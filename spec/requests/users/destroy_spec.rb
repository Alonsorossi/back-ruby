require 'rails_helper'
require Rails.root.join('./spec/requests/users/invokes_policy.rb')

RSpec.describe User, type: :request do
  context 'Destroy' do
    let(:user) { create(:user, name: 'user') }
    let(:user_without_bills) { create(:user, name: 'user_without_bills') }
    let(:bill) { create(:bill, number: 1, user_id: user.id) }

    it 'Deleting a user removes it from db' do
      user.bills << bill

      delete_path = "#{users_path}/#{user.id}"

      sign_in user

      delete delete_path
      expect(response.status).to eq(204)
    end
  end
end
