require File.join(File.dirname(__FILE__), 'gilded_rose')

RSpec.describe GildedRose do
  context "#update_quality" do
    def sulfuras(options)
      item("Sulfuras, Hand of Ragnaros", options)
    end

    def aged_brie(options)
      item("Aged Brie", options)
    end

    def backstage_pass(options)
      item("Backstage passes to a TAFKAL80ETC concert", options)
    end

    def conjured(options)
      item("Conjured item", options)
    end

    def item(name, options)
      Item.new(name, options[:sell_in], options[:quality])
    end

    def update_quality(items)
      described_class.new(items).update_quality
    end

    context "regular item" do
      it "downgrades quality by 1 for a regular item" do
        item = item("regular item", sell_in: 5, quality: 5)
        update_quality([item])
        expect(item.quality).to eq 4
      end

      it "ages a regular item by 1 day" do
        item = item("regular item", sell_in: 5, quality: 5)
        update_quality([item])
        expect(item.sell_in).to eq 4
      end

      it "quality downgrades twice as fast (2) for an item past it's sell by date" do
        item = item("old item", sell_in: 0, quality: 5)
        update_quality([item])
        expect(item.quality).to eq 3
      end

      it "never makes the quality of an item negative" do
        item = item('low quality item', sell_in: 0, quality: 0)
        update_quality([item])
        expect(item.quality).to eq 0
      end
    end


    context "aged brie" do
      it "increases quality of Aged Brie" do
        item = aged_brie(sell_in: 5, quality: 10)
        update_quality([item])
        expect(item.quality).to eq 11
      end

      it "ages a aged brie by 1 day" do
        item = aged_brie(sell_in: 5, quality: 5)
        update_quality([item])
        expect(item.sell_in).to eq 4
      end

      it "never increases quality of Aged Brie more than 50" do
        item = aged_brie(sell_in: 5, quality: 50)
        update_quality([item])
        expect(item.quality).to eq 50
      end
    end

    context "backstage pass" do
      it "increases quality of backstage pass" do
        item = backstage_pass(sell_in: 25, quality: 10)
        update_quality([item])
        expect(item.quality).to eq 11
      end

      it "ages a backstage pass by 1 day" do
        item = backstage_pass(sell_in: 5, quality: 5)
        update_quality([item])
        expect(item.sell_in).to eq 4
      end

      it "does not increase quality of Backstage Pass more than 50" do
        item = backstage_pass(sell_in: 20, quality: 50)
        update_quality([item])
        expect(item.quality).to eq 50
      end

      it "increases quality of Backstage Pass by 2 when there are 10 days (or less)" do
        item = backstage_pass(sell_in: 10, quality: 10)
        update_quality([item])
        expect(item.quality).to eq 12
      end

      it "increases quality of Backstage Pass by 3 when there are 5 days (or less)" do
        item = backstage_pass(sell_in: 5, quality: 10)
        update_quality([item])
        expect(item.quality).to eq 13
      end

      it "drops quality to zero for a backstage pass after a concert" do
        item = backstage_pass(sell_in: 0, quality: 20)
        update_quality([item])
        expect(item.quality).to eq 0
      end
 
      it "never makes the quality of a backstage pass negative" do
        item = backstage_pass(sell_in: 0, quality: 0)
        update_quality([item])
        expect(item.quality).to eq 0
      end
    end

    context "sulfuras" do
      it "never changes quality when item is Sulfuras" do
        item = sulfuras(sell_in: 10, quality: 80)
        update_quality([item])
        expect(item.quality).to eq 80
      end

      it "never changes sell in days when item is Sulfuras" do
        item = sulfuras(sell_in: 10, quality: 80)
        update_quality([item])
        expect(item.sell_in).to eq 10
      end
    end

    context "conjured" do
      it "ages a conjured by 1 day" do
        item = conjured(sell_in: 5, quality: 5)
        update_quality([item])
        expect(item.sell_in).to eq 4
      end

      it "degrades twice as fast when the item is conjured" do
        item = conjured(sell_in: 10, quality: 25)
        update_quality([item])
        expect(item.quality).to eq 23
      end

      it "quality downgrades twice as fast (2) for a conjured item past it's sell by date" do
        item = conjured(sell_in: 0, quality: 5)
        update_quality([item])
        expect(item.quality).to eq 1
      end

      it "never makes the quality of a conjured item negative" do
        item = conjured(sell_in: 0, quality: 0)
        update_quality([item])
        expect(item.quality).to eq 0
      end

    end
  end
end
