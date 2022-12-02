class BillPolicy < ApplicationPolicy

  def index?
    bill_owner?(user, bill) || admin?(user)
  end

  def show?
    bill_owner?(user, bill) || admin?(user)
  end

  def update?
    updated_by_client?(user, bill) || updated_by_admin?(user, bill)
  end

  def destroy?
    bill_owner?(user, bill) || admin? || admin?(user) || updated_by_client?(bill)
  end

  private

  def admin?(user)
    user.has_role? :client, Bill
  end

  def updated_by_client?(user, bill)
    bill_owner?(user, bill) && eraser?(bill)
  end

  def updated_by_admin?(user, bill)
    admin?(user) && sended?(bill)
  end

  def eraser?(bill)
    if bill.respond_to?('each')
      bill.each do |each_bill|
        return false unless each_bill.updated_by_client?
      end
    else
      return false unless bill.updated_by_client?
    end
    true
  end

  def sended?(bill)
    if bill.respond_to?('each')
      bill.each do |each_bill|
        return false unless each_bill.updated_by_admin?
      end
    else
      return false unless bill.updated_by_admin?
    end
    true
  end

  def bill_owner?(user, bill)
    if bill.respond_to?('each')
      bill.each do |each_bill|
        return false unless user[:id] == each_bill[:user_id]
      end
    else
      return false unless user[:id] == bill[:user_id]
    end
    true
  end

  def filtering_params
    params.permit({ filter: %i[number
                               concept
                               higher_than_bill_expdate
                               lower_than_bill_expdate
                               id] })
  end

  # Método para conseguir strong parameters para la ordenación
  def sort_params
    params.permit(:sort)
  end

  # Método para conseguir strong parameters para la paginación
  def paginate_params
    params.permit({ page: %i[number size] })
  end
end
