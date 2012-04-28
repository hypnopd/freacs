require 'spec_helper'

describe "auctions/edit" do
  before(:each) do
    @auction = assign(:auction, stub_model(Auction,
      :name => "MyString"
    ))
  end

  it "renders the edit auction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auctions_path(@auction), :method => "post" do
      assert_select "input#auction_name", :name => "auction[name]"
    end
  end
end
