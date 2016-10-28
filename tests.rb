require_relative 'shopping_cart'
require 'test/unit'

# Test cases presented in challenge
class TestShoppingCart < Test::Unit::TestCase
  def setup
    products = [
      Product.new(id: 'A', unit_price: 2, vol_price: 7, vol_count: 4),
      Product.new(id: 'B', unit_price: 12),
      Product.new(id: 'C', unit_price: 1.25, vol_price: 6, vol_count: 6),
      Product.new(id: 'D', unit_price: 0.15)
    ]
    @terminal = Terminal.new
    @terminal.add_products(products)
  end

  def test_first_case_bulk
    @terminal.bulk_scan('ABCDABAA')
    assert_equal('32.40', @terminal.total)
  end

  def test_second_case_bulk
    @terminal.bulk_scan('CCCCCCC')
    assert_equal('7.25', @terminal.total)
  end

  def test_third_case_bulk
    @terminal.bulk_scan('ABCD')
    assert_equal('15.40', @terminal.total)
  end

  def test_first_case
    @terminal.scan('A')
    @terminal.scan('B')
    @terminal.scan('C')
    @terminal.scan('D')
    @terminal.scan('A')
    @terminal.scan('B')
    @terminal.scan('A')
    @terminal.scan('A')
    assert_equal('32.40', @terminal.total)
  end

  def test_second_case
    @terminal.scan('C')
    @terminal.scan('C')
    @terminal.scan('C')
    @terminal.scan('C')
    @terminal.scan('C')
    @terminal.scan('C')
    @terminal.scan('C')
    assert_equal('7.25', @terminal.total)
  end

  def test_third_case
    @terminal.scan('A')
    @terminal.scan('B')
    @terminal.scan('C')
    @terminal.scan('D')
    assert_equal('15.40', @terminal.total)
  end
end
