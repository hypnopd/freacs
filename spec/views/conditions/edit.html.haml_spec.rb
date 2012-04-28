require 'spec_helper'

describe "conditions/edit" do
  before(:each) do
    @condition = assign(:condition, stub_model(Condition,
      :name => "MyString",
      :type => "",
      :percentage => 1
    ))
  end

  it "renders the edit condition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => conditions_path(@condition), :method => "post" do
      assert_select "input#condition_name", :name => "condition[name]"
      assert_select "input#condition_type", :name => "condition[type]"
      assert_select "input#condition_percentage", :name => "condition[percentage]"
    end
  end
end
