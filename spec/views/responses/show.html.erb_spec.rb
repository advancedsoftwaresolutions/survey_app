require 'rails_helper'

RSpec.describe "responses/show", type: :view do
  before(:each) do
    @response = assign(:response, Response.create!(
      answer: false,
      survey: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
