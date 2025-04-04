class GradientWaveComponent < ViewComponent::Base
  def initialize(
    top_gradient:,
    bottom_gradient:,
    dark_mode: false,
    blur: false,
    opacity: 1.0,
    animated: false,
    top_wave_path: nil,
    bottom_wave_path: nil,
    top_height: 200,
    bottom_height: 200,
    responsive_height: false
  )
    @top_gradient = top_gradient
    @bottom_gradient = bottom_gradient
    @dark_mode = dark_mode
    @blur = blur
    @opacity = opacity
    @animated = animated
    @responsive_height = responsive_height

    @top_wave_path = top_wave_path || 'M0,96 C480,0 960,160 1440,64 L1440,0 L0,0 Z'
    @bottom_wave_path = bottom_wave_path || 'M0,64 C480,160 960,0 1440,96 L1440,200 L0,200 Z'

    @top_height = top_height
    @bottom_height = bottom_height
  end
end
