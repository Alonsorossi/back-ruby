require 'rails_helper'
require Rails.root.join('./spec/requests/users/invokes_policy.rb')

DatabaseCleaner.strategy = :truncation

RSpec.describe Bill, type: :request do
  context 'Destroy' do
    let(:owner) { create(:user, name: 'owner') }
    let(:not_owner) { create(:user, name: 'not_owner') }
    let(:bill) { create(:bill, number: 1, user_id: owner.id) }

    it 'only owner can destroy its bills' do
      owner.bills << bill

      delete_path = "#{bills_path}/#{bill.id}"

      sign_in not_owner

      delete delete_path
      expect(response.status).to eq(403)

      sign_in owner
      delete delete_path
      expect(response.status).to eq(204)
    end
  end
end
