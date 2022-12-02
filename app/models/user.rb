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
class User < ApplicationRecord
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze # validacion de email
  DNI_REGEX = /(\d{8})\D/.freeze # validamos el dni
  rolify before_add: :before_add_method
  include AsJsonRepresentations # incluimos asJson
  include Filterable # filtros de busqueda y ordenacion
  include Sorterable
  include Paginable
  include RailsJwtAuth::Authenticatable # gemas de autenticacion
  include RailsJwtAuth::Confirmable
  include RailsJwtAuth::Recoverable # gema de reinicio de contraseña

  after_create :assign_client_role # asignamos el rol por defecto
  after_save :send_user_email # mandamos el correo tras ser guardado el user
  has_many :bills, dependent: :destroy # dependencias de la clase user
  validates :name, presence: true, length: { maximum: 50 } # validamos que el nombre no sea blank y longitud
  validates :email, presence: true, length: { maximum: 255 }, # se valida el correo
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :dni, presence: true, length: { maximum: 9 }, # se valida el dni
                  format: { with: DNI_REGEX }

  scope :filter_by_name, ->(name) { where("name like ?", "#{name}%") } # query de los filtros
  scope :filter_by_email, ->(email) { where(email: email) }
  scope :filter_by_dni, ->(dni) { where(dni: dni) }

  representation :public do
    {
      "id": id,
      "name": name,
      "email": email,
      "dni": dni
    }
  end

  def self.filtrate(filtering_params)
    filter_by(filtering_params)
  end

  def self.sort(sort_params)
    sort_by(sort_params)
  end

  def self.pagination_query(pagination_params)
    paginate_by(pagination_params)
  end

  def before_add_method(role)
    # do something before it gets added
  end

  def assign_client_role
    self.add_role(:client) if self.roles.blank?
  end

  def assig_admin_role
    self.add_role(:admin) if self.roles.blank?
  end

  def send_user_email
    UserMailer.with(user: self).welcome_email.deliver_now
  end
end
