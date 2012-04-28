require 'spec_helper'

describe "offers/index" do
  before(:each) do
    assign(:offers, [
      stub_model(Offer),
      stub_model(Offer)
    ])
  end

  it "renders a list of offers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
