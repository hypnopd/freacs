require 'spec_helper'

describe "invitations/show" do
  before(:each) do
    @invitation = assign(:invitation, stub_model(Invitation,
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
