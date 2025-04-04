# app/components/radial_chart_component.rb
class RadialChartComponent < ViewComponent::Base
  def initialize(percentage:, label:, color:, delay: '0s')
    @percentage = percentage.to_f
    @label = label
    @color = color
    @delay = delay
  end
end
