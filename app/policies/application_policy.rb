class ApplicationPolicy
  attr_reader :user, :bill, :context

  def initialize(user, bill, context)
    @user = user
    @bill = bill
    @context = context
  end
end
