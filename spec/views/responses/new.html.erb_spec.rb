require 'rails_helper'

RSpec.describe "responses/new", type: :view do
  before(:each) do
    assign(:response, Response.new(
      answer: false,
      survey: nil
    ))
  end

  it "renders new response form" do
    render

    assert_select "form[action=?][method=?]", responses_path, "post" do

      assert_select "input[name=?]", "response[answer]"

      assert_select "input[name=?]", "response[survey_id]"
    end
  end
end
