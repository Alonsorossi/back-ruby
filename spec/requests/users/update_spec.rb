require 'rails_helper'
require 'database_cleaner/active_record'
# idk about this, I only required it to see if i could use RailsJwtAuth::NotAuthorized
require 'application_controller'
require Rails.root.join('./spec/requests/users/invokes_policy_try.rb')

DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :request do
  context 'Confirmed client' do
    let(:user) { create(:user, name: 'first_user') }
    let(:unsigned_in_user) { create(:user, name: 'second_user') }

    # it 'blocks unauthenticated access and allows authenticated access' do
    #   # Me gustaría poner esto, con el error correspondiente, pero sale un error
    #   # expect { get users_path }.to raise_error(RailsJwtAuth::NotAuthorized)
    #   get users_path
    #   expect(response.status).to eq(401)

    #   sign_in user
    #   unsigned_in_user.save

    #   get users_path
    #   expect(response.status).to eq(200)
    #   # Must include any saved user's name and email
    #   expect(response.body).to include(user.name)
    #   expect(response.body).to include(user.email)
    #   expect(response.body).to include(unsigned_in_user.name)
    #   expect(response.body).to include(unsigned_in_user.email)
    # end
  end
end
