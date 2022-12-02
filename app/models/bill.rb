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
class Bill < ApplicationRecord
  enum status: %i[eraser sended validated] # posibles estados de la factura
  resourcify

  DNI_REGEX = /(\d{8})\D/.freeze # validamos el dni
  include AsJsonRepresentations
  include Filterable
  include Sorterable
  include Paginable

  after_save :send_email

  belongs_to :user
  has_one_attached :picture

  validates :concept, presence: true, length: { maximum: 100 }
  validates :expdate, presence: true
  validates :nifreceiver, presence: true, length: { maximum: 9 },
                          format: { with: DNI_REGEX }
  validates :niftransmitter, presence: true, length: { maximum: 9 },
                             format: { with: DNI_REGEX }
  validates :number, numericality: { only_integer: true },
                     uniqueness: true
  validates :totalcount, presence: true,
                         numericality: { only_float: true }
  validates :state, presence: true

  scope :filter_by_number, ->(number) { where(number: number) }
  scope :filter_by_concept, ->(concept) { where('concept like ?', "#{concept}%") }
  scope :filter_by_higher_than_expdate, ->(expdate) { where(expdate: expdate..) }
  scope :filter_by_lower_than_expdate, ->(expdate) { where(expdate: ..expdate) }
  scope :filter_by_id, ->(id) { where(id: id) }

  representation :public do
    {
      "number": number,
      "type": tipe,
      "exp_date": expdate,
      "nif_emisor": niftransmitter,
      "nif_receptor": nifreceiver,
      "concept": concept,
      "total": totalcount
    }
  end

  def updated_by_client?
    eraser?
  end

  def updated_by_admin?
    sended?
  end

  def send_email
    BillMailer.with(bill: self).bill_mail_to.deliver_later
  end
end
