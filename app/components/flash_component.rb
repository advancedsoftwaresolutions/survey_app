# app/components/flash_component.rb
class FlashComponent < ViewComponent::Base
  def initialize(flash:)
    @flash = flash
  end

  def bootstrap_class(type)
    {
      notice: "success",
      alert: "danger",
      info: "info",
      warning: "warning"
    }[type.to_sym] || type
  end
end
