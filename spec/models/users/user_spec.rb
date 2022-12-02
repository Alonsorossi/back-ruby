# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  auth_tokens            :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  dni                    :string
#  email                  :string
#  name                   :string
#  password_digest        :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'Relations' do
    it { is_expected.to have_many(:sales) }

    it 'Deletes sales corresponding to user' do
      user.save
      create(:sale, number: 1, user_id: user.id)

      user.destroy

      expect(user.sales).to be_empty
    end
  end

  context 'validation test' do
    it 'ensures name presence' do
      user.name = nil
      expect(user.save).to eq(false)
      expect(user.errors.details[:name]).to include(error: :blank)
    end

    it 'ensures email presence' do
      user.email = nil
      expect(user.save).to eq(false)
      expect(user.errors.details[:email]).to include(error: :blank)
    end

    it 'ensures dni presence' do
      user.dni = nil
      expect(user.save).to eq(false)
      expect(user.errors.details[:dni]).to include(error: :blank)
    end
  end
end


