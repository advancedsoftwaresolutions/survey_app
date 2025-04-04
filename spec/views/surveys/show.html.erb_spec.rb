require 'rails_helper'

RSpec.describe "surveys/show", type: :view do
  before(:each) do
    @survey = assign(:survey, Survey.create!(
      question: "Question",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Question/)
    expect(rendered).to match(//)
  end
end
