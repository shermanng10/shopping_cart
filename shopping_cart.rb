# Product class used to store relevant data of store products
class Product
  attr_reader :product_code, :unit_price, :vol_price, :vol_count
  def initialize(params)
    @product_code = params[:id]
    @unit_price = params[:unit_price]
    @vol_price = params[:vol_price] || nil
    @vol_count = params[:vol_count] || nil
  end
end

# Main class used to scan and give totals for customer carts
class Terminal
  def initialize
    @products = {}
    @scanned_products = Hash.new 0
    @current_total = 0
  end

  def add_product(product)
    @products[product.product_code] = product
  end

  def add_products(products)
    products.each { |product| add_product(product) }
  end

  def calculate_bulk_discount(product)
    product.unit_price * product.vol_count - product.vol_price
  end

  def hit_bulk_vol?(product)
    num_products = @scanned_products[product.product_code]
    product.vol_count && (num_products % product.vol_count).zero?
  end

  def add_to_total(product_code)
    product = @products[product_code]
    @current_total += product.unit_price
    return unless hit_bulk_vol?(product)
    discount = calculate_bulk_discount(product)
    @current_total -= discount
    puts "Applying bulk discount $#{format('%.2f', discount)}"
  end

  def scan(product_code)
    @scanned_products[product_code] += 1
    add_to_total(product_code)
    puts "Current Total: $#{format('%.2f', @current_total)}"
  end

  def bulk_scan(product_codes)
    product_codes.split('').each { |product| scan(product) }
  end

  def total
    grand_total = format('%.2f', @current_total)
    puts "Grand Total: $#{grand_total}"
    grand_total
  end

  def new_session
    @scanned_products = Hash.new 0
    @current_total = 0
    puts 'Welcome New Customer!'
  end

  private :calculate_bulk_discount, :hit_bulk_vol?, :add_to_total
end
