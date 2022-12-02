# == Schema Information
#
# Table name: bills
#
#  id             :bigint           not null, primary key
#  concept        :string
#  expdate        :date
#  nifreceiver    :string
#  niftransmitter :string
#  number         :integer
#  state          :integer          default(0)
#  tipe           :boolean
#  totalcount     :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_bills_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Bill, type: :model do
  let(:user) { create(:user) }
  let(:bill) { create(:bill, number: 1, user_id: user.id) }
  context 'Validations' do
    it { is_expected.to validate_numericality_of(:number).only_integer }

    it { is_expected.to validate_presence_of(:expdate) }

    it { is_expected.to validate_presence_of(:nifreceiver) }

    it { is_expected.to validate_presence_of(:niftransmitter) }

    it { is_expected.to validate_presence_of(:totalcount) }

    it { is_expected.to belong_to(:user) }
  end

  context 'Relations' do
    it { is_expected.to belong_to :user }
  end
end
