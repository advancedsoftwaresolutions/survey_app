require 'rails_helper'

RSpec.describe "surveys/edit", type: :view do
  before(:each) do
    @survey = assign(:survey, Survey.create!(
      question: "MyString",
      user: nil
    ))
  end

  it "renders the edit survey form" do
    render

    assert_select "form[action=?][method=?]", survey_path(@survey), "post" do

      assert_select "input[name=?]", "survey[question]"

      assert_select "input[name=?]", "survey[user_id]"
    end
  end
end
