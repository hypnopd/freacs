require 'spec_helper'

describe "conditions/index" do
  before(:each) do
    assign(:conditions, [
      stub_model(Condition,
        :name => "Name",
        :type => "Type",
        :percentage => 1
      ),
      stub_model(Condition,
        :name => "Name",
        :type => "Type",
        :percentage => 1
      )
    ])
  end

  it "renders a list of conditions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
