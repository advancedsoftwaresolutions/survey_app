# app/components/alert_icon_component.rb
class AlertIconComponent < ViewComponent::Base
  def initialize(type:)
    @type = type
  end
end
