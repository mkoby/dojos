require 'spec_helper'

describe Hand do
  subject do
    Hand.new(card_list)
  end

  describe "#new" do
    context "with 5 cards" do
      it "should not raise an error" do
        expect { hand = Hand.new("2C 3D 8S TD JS") }.to_not raise_error(Hand::InvalidHand)
      end
    end

    context "with less than 5 cards" do
      it "should raise InvalidHand Error" do
        expect { hand = Hand.new("5D 4D 9C KS") }.to raise_error(Hand::InvalidHand, "Valid hand has 5 cards")
      end
    end
  end

  describe "#card_count" do
    let(:card_list) { "2H 3D 5S 9C KD" }
    its(:card_count) { should == 5 }
  end
  
  describe "#value" do
    context "High Card" do
      let(:card_list) { "2H 3D 5S 9C KD" }
      its(:value) { should == HandType::HighCard }
      its("high_card.value") { should == 13 }
    end
    
    context "Pair" do
      let(:card_list) { "2H 3D 5S 9C 2S" }
      its(:value) { should == HandType::Pair }
    end
    
    context "Three of a Kind" do
      let(:card_list) { "2H 3D 5S 2S 2D" }
      its(:value) { should == HandType::ThreeOfAKind }
    end
    
    context "Full House" do
      let(:card_list) { "2H 2C 5S 5H 2D" }
      its(:value) { should == HandType::FullHouse }
    end
  
    context "Four of a Kind" do
      let(:card_list) { "3H 3D 3C 3S 6D"}
      its(:value) { should == HandType::FourOfAKind }
    end
    
    context "Straight" do
      let(:card_list) { "2H 3S 4H 5D 6C" }
      its(:value) { should == HandType::Straight }
    end
    
    context "Flush" do
      let(:card_list) { "2H 3H 4H 5H 7H" }
      its(:value) { should == HandType::Flush }
    end
    
    context "StraightFlush" do
      let(:card_list) { "2H 3H 4H 5H 6H" }
      its(:value) { should == HandType::StraightFlush }
    end
    
    context "Royal Flush" do
      let(:card_list) { "AS TS JS QS KS" }
      its(:value) { should == HandType::RoyalFlush }
    end
  end
end
