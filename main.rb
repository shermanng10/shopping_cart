require_relative 'shopping_cart'

terminal = Terminal.new

products = [
  Product.new(id: 'A', unit_price: 2, vol_price: 7, vol_count: 4),
  Product.new(id: 'B', unit_price: 12),
  Product.new(id: 'C', unit_price: 1.25, vol_price: 6, vol_count: 6),
  Product.new(id: 'D', unit_price: 0.15)
]

terminal.add_products(products)

terminal.scan('A')
terminal.scan('B')
terminal.scan('C')
terminal.scan('D')
terminal.scan('A')
terminal.scan('B')
terminal.scan('A')
terminal.scan('A')
puts terminal.total
terminal.new_session

terminal.scan('C')
terminal.scan('C')
terminal.scan('C')
terminal.scan('C')
terminal.scan('C')
terminal.scan('C')
terminal.scan('C')
puts terminal.total
terminal.new_session

terminal.bulk_scan('ABCD')
puts terminal.total
