require 'rails-helper'
require Rails.root.join('./spec/requests/users/invokes_policy.rb')
RSpec.describe User, type: :request do
  context 'Confirmed client' do
    let(:user) { create(:user) }
    let(:unsigned_in_user) { create(:user) }

    it 'requests list of all users' do
      expect(response.status).to eq(401)

      sign_in user
      unsigned_in_user.save

      get users_path
      expect(response.status).to eq(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
      expect(response.body).to include(unsigned_in_user.name)
      expect(response.body).to include(unsigned_in_user.email)
    end

    it 'filters by name and/or email' do
      sign_in user
      unsigned_in_user.save
      path = "#{users_path}?filter[name]=#{user.name}"
      get path
      expect(response.status).to eq(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
      expect(response.body).not_to include(unsigned_in_user.name)
      expect(response.body).not_to include(unsigned_in_user.email)

      path = "#{users_path}?filter[name]=#{user.name}&filter[email]#{user.email}"
      get path
      expect(response.status).to eq(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
      expect(response.body).not_to include(unsigned_in_user.name)
      expect(response.body).not_to include(unsigned_in_user.email)
    end

    it 'sorts by name' do
      sign_in user
      unsigned_in_user.save
      path = "#{users_path}?sort=name"
      get path
      expect(response.status).to eq(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
      expect(response.body).to include(unsigned_in_user.name)
      expect(response.body).to include(unsigned_in_user.email)
      tmp_hash = JSON.parse(response.body)
      expect(tmp_hash.first['name'].casecmp(tmp_hash.second['name'])).to eq(-1)

      path = "#{users_path}?sort=-name"
      get path
      expect(response.status).to eq(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
      expect(response.body).to include(unsigned_in_user.name)
      expect(response.body).to include(unsigned_in_user.email)
      tmp_hash = JSON.parse(response.body)
      expect(tmp_hash.first['name'].casecmp(tmp_hash.second['name'])).to eq(1)
    end

    it 'sorts by email' do
      sign_in user
      unsigned_in_user.save
      path = "#{users_path}?sort=email"
      get path
      expect(response.status).to eq(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
      expect(response.body).to include(unsigned_in_user.name)
      expect(response.body).to include(unsigned_in_user.email)
      tmp_hash = JSON.parse(response.body)
      expect(tmp_hash.first['email'].casecmp(tmp_hash.second['email'])).to eq(-1)

      path = "#{users_path}?sort=-email"
      get path
      expect(response.status).to eq(200)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
      expect(response.body).to include(unsigned_in_user.name)
      expect(response.body).to include(unsigned_in_user.email)
      tmp_hash = JSON.parse(response.body)
      expect(tmp_hash.first['email'].casecmp(tmp_hash.second['email'])).to eq(1)
    end
  end
end
