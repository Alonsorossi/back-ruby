require 'rails_helper'
require Rails.root.join('./spec/requests/users/invokes_policy_try.rb')

DatabaseCleaner.strategy = :truncation

RSpec.describe Bill, type: :request do
  context 'Update' do
    let(:owner) { create(:user, name: 'owner') }
    let(:not_owner) { create(:user, name: 'not_owner') }
    let(:bill) { create(:bill, number: 1, user_id: owner.id) }

    it 'only owner can update its bill:bills' do
      owner.bills << bill

      previous_bill_item = bill.item
      new_item = 'updated_item'

      update_path = "#{bills_path}/#{bill.id}"

      sign_in not_owner

      patch update_path, params: { "item": new_item }
      expect(response.status).to eq(403)
      expect(bill.item).to eq(previous_bill_item)

      sign_in owner
      # TODO. Pide "bill:bill": como parametro para hacer un put, no debería
      # Además, cuando le hago un put o patch ya con el supuesto "bill:bill", me
      # devuelve un 200 pero no modifica nada
      # patch update_path, params: { "item": new_item }
      # expect(response.status).to eq(200)
      # expect(bill:bill.item).not_to eq(previous_bill:bill_item)
      # expect(bill:bill.item).to eq(new_item)
    end
  end
end
