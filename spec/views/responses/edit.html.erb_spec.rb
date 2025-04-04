require 'rails_helper'

RSpec.describe "responses/edit", type: :view do
  before(:each) do
    @response = assign(:response, Response.create!(
      answer: false,
      survey: nil
    ))
  end

  it "renders the edit response form" do
    render

    assert_select "form[action=?][method=?]", response_path(@response), "post" do

      assert_select "input[name=?]", "response[answer]"

      assert_select "input[name=?]", "response[survey_id]"
    end
  end
end
