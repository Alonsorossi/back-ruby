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
require 'rspec-rails'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
