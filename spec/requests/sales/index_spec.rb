require 'rails_helper'
require 'application_controller'
require Rails.root.join('./spec/requests/users/invokes_policy.rb')

RSpec.describe Bill, type: :request do
  context 'Access and filters' do
    # it 'requests list of all users' do
    #   expect(RailsJwtAuth).to receive(:policy_scope!).with(params)
    #   expect(response).to be_successful
    #   expect(response.body).to include('a')
    # end

    # it 'scopes result' do
    #   expect(RailsJwtAuth.policy_scope!(params)).to eq(scoped_result)
    # end

    let(:first_user) { create(:user, name: 'first_user') }
    let(:second_user) { create(:user, name: 'second_user') }
    let(:first_bill) { create(:bill, number: 1, user_id: first_user.id) }
    let(:second_bill) { create(:bill, number: 2, user_id: second_user.id) }

    it 'blocks unauthenticated access and allows authenticated access' do
      first_user.sales << first_sale
      second_user.sales << second_sale

      get sales_path
      expect(response.status).to eq(401)

      sign_in first_user
      second_user.save
      get sales_path
      expect(response.status).to eq(403)
    end

    # it 'filters by name and/or email' do
    #   sign_in user
    #   unsigned_in_user.save
    #   path = "#{users_path}?filter[name]=#{user.name}"
    #   get path
    #   expect(response.status).to eq(200)
    #   expect(response.body).to include(user.name)
    #   expect(response.body).to include(user.email)
    #   expect(response.body).not_to include(unsigned_in_user.name)
    #   expect(response.body).not_to include(unsigned_in_user.email)

    #   path = "#{users_path}?filter[name]=#{user.name}&filter[email]#{user.email}"
    #   get path
    #   expect(response.status).to eq(200)
    #   expect(response.body).to include(user.name)
    #   expect(response.body).to include(user.email)
    #   expect(response.body).not_to include(unsigned_in_user.name)
    #   expect(response.body).not_to include(unsigned_in_user.email)
    # end

    # it 'sorts by name' do
    #   sign_in user
    #   unsigned_in_user.save
    #   path = "#{users_path}?sort=name"
    #   get path
    #   expect(response.status).to eq(200)
    #   expect(response.body).to include(user.name)
    #   expect(response.body).to include(user.email)
    #   expect(response.body).to include(unsigned_in_user.name)
    #   expect(response.body).to include(unsigned_in_user.email)
    #   tmp_hash = JSON.parse(response.body)
    #   expect(tmp_hash.first['name'].casecmp(tmp_hash.second['name'])).to eq(-1)

    #   path = "#{users_path}?sort=-name"
    #   get path
    #   expect(response.status).to eq(200)
    #   expect(response.body).to include(user.name)
    #   expect(response.body).to include(user.email)
    #   expect(response.body).to include(unsigned_in_user.name)
    #   expect(response.body).to include(unsigned_in_user.email)
    #   tmp_hash = JSON.parse(response.body)
    #   expect(tmp_hash.first['name'].casecmp(tmp_hash.second['name'])).to eq(1)
    # end

    # it 'sorts by email' do
    #   sign_in user
    #   unsigned_in_user.save
    #   path = "#{users_path}?sort=email"
    #   get path
    #   expect(response.status).to eq(200)
    #   expect(response.body).to include(user.name)
    #   expect(response.body).to include(user.email)
    #   expect(response.body).to include(unsigned_in_user.name)
    #   expect(response.body).to include(unsigned_in_user.email)
    #   tmp_hash = JSON.parse(response.body)
    #   expect(tmp_hash.first['email'].casecmp(tmp_hash.second['email'])).to eq(-1)

    #   path = "#{users_path}?sort=-email"
    #   get path
    #   expect(response.status).to eq(200)
    #   expect(response.body).to include(user.name)
    #   expect(response.body).to include(user.email)
    #   expect(response.body).to include(unsigned_in_user.name)
    #   expect(response.body).to include(unsigned_in_user.email)
    #   tmp_hash = JSON.parse(response.body)
    #   expect(tmp_hash.first['email'].casecmp(tmp_hash.second['email'])).to eq(1)
    # end
  end
end
