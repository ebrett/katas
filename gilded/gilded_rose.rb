class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |original_item|
      item = wrap(original_item)
      item.update
    end
  end

  def wrap(item)
    case item.name
    when "Aged Brie"
      AgedBrieUpdater.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassUpdater.new(item)
    when "Sulfuras, Hand of Ragnaros"
      SulfurasUpdater.new(item)
    when "Conjured item"
      ConjuredUpdater.new(item)
    else
      Updater.new(item)
    end
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class Updater
  MAX_QUALITY = 50
  MIN_QUALITY = 0
  DEFAULT_QUALITY_DELTA = 1

  def initialize(item)
    @item = item
    @delta = DEFAULT_QUALITY_DELTA
  end
  attr_accessor :item, :delta

  def update
    update_quality!
    tick!
    update_aged
  end

  def update_quality!
    decrease_quality
  end

  def tick!
    item.sell_in = item.sell_in - 1
  end

  def update_aged
    decrease_quality if passed_sell_by_day?
  end

  private

  def approaching_sell_by_day?
    item.sell_in < 11
  end

  def close_to_sell_by_day?
    item.sell_in < 6
  end

  def passed_sell_by_day?
    item.sell_in < 0
  end

  def minimal_quality
    item.quality = MIN_QUALITY
  end

  def decrease_quality
    item.quality = [item.quality - delta, MIN_QUALITY].max
  end

  def increase_quality
    item.quality = [item.quality + delta, MAX_QUALITY].min
  end

end

class ConjuredUpdater < Updater
  def initialize(item)
    super
    @delta = DEFAULT_QUALITY_DELTA * 2
  end
end

class AgedBrieUpdater < Updater
  def update
    increase_quality
    tick!
  end
end

class SulfurasUpdater < Updater
  def update; end
end

class BackstagePassUpdater < Updater
  def update_quality!
    increase_quality
    increase_quality if approaching_sell_by_day?
    increase_quality if close_to_sell_by_day?
  end

  def update_aged
    minimal_quality if passed_sell_by_day?
  end
end

