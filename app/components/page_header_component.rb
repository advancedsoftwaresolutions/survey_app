# frozen_string_literal: true

class PageHeaderComponent < ViewComponent::Base
  def initialize(title:, link_text:, link_path:)
    @title = title
    @link_text = link_text
    @link_path = link_path
  end
end
