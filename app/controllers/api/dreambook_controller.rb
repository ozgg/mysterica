# frozen_string_literal: true

module Api
  # Public dreambook pages
  class DreambookController < ApplicationController
    # get /api/dreambook
    def index
      @letters = Components::DreambookComponent::LETTERS.chars
    end

    # get /api/dreambook/:letter
    def letter
      @collection = DreamPattern.letter(params[:letter]).ordered_by_name
    end

    # get /api/dreambook/:letter/:name
    def show
      @entity = DreamPattern[params[:name]]

      render 'api/shared/not_found', status: :not_found if @entity.blank?
    end
  end
end
