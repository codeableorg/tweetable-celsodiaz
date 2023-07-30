class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user.admin? || user == record.user
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || user == record.user
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      @user.admin? ? @scope.all : @scope.where(user_id: @user.id)
    end

    private

    attr_reader :user, :scope
  end
end
