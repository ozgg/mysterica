# frozen_string_literal: true

module Components
  module Users
    # Handle creation and updates for user profiles
    class ProfileHandler < Components::BaseComponent
      def register(parameters)
        attributes = only_permitted_parameters(parameters).merge(site:)
        user = User.create(attributes)
        @errors = user.errors
        user
      end

      def self.permitted_parameters
        %i[email password password_confirmation slug]
      end

      private

      def only_permitted_parameters(parameters)
        self.class.permitted_parameters.index_with do |parameter|
          parameters[parameter]
        end
      end
    end
  end
end
