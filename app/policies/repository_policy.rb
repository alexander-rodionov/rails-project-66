# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def initialize(user, controller_action)
    super
    @user = user
    @controller_action = controller_action
  end

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
