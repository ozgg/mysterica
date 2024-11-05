# frozen_string_literal: true

module Components
  # Base component
  class BaseComponent
    attr_reader :errors, :site, :user

    def initialize(user: nil, site: nil)
      @errors = {}
      @site = site
      @user = user
    end
  end
end
