require 'spec_helper'

describe "invitations/edit" do
  before(:each) do
    @invitation = assign(:invitation, stub_model(Invitation,
      :body => "MyText"
    ))
  end

  it "renders the edit invitation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invitations_path(@invitation), :method => "post" do
      assert_select "textarea#invitation_body", :name => "invitation[body]"
    end
  end
end
