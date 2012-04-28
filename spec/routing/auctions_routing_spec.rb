require "spec_helper"

describe AuctionsController do
  describe "routing" do

    it "routes to #index" do
      get("/auctions").should route_to("auctions#index")
    end

    it "routes to #new" do
      get("/auctions/new").should route_to("auctions#new")
    end

    it "routes to #show" do
      get("/auctions/1").should route_to("auctions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/auctions/1/edit").should route_to("auctions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/auctions").should route_to("auctions#create")
    end

    it "routes to #update" do
      put("/auctions/1").should route_to("auctions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/auctions/1").should route_to("auctions#destroy", :id => "1")
    end

  end
end
