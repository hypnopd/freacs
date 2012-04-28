require 'spec_helper'

describe "invitations/index" do
  before(:each) do
    assign(:invitations, [
      stub_model(Invitation,
        :body => "MyText"
      ),
      stub_model(Invitation,
        :body => "MyText"
      )
    ])
  end

  it "renders a list of invitations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
