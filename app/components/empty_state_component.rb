# frozen_string_literal: true

class EmptyStateComponent < ViewComponent::Base
  def initialize(icon:, title:, description:, button_text:, button_path:)
    @icon = icon
    @title = title
    @description = description
    @button_text = button_text
    @button_path = button_path
  end
end
