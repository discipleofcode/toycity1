require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
  # Print the name of the toy
  # Print the retail price of the toy
  # Calculate and print the total number of purchases
  # Calculate and print the total amount of sales
  # Calculate and print the average price the toy sold for
  # Calculate and print the average discount (% or $) based off the average sales price

  products_hash["items"].each do |toy|
  
    name = toy["title"]
	price = toy["full-price"].to_f
	totalPurchases = toy["purchases"].length
	
	totalSales = 0
	toy["purchases"].each do |purchase|
		totalSales += purchase["price"]
	end
	
	avgPrice = totalSales / totalPurchases
	avgDiscount = price - avgPrice
	avgDiscountPercentage = (avgDiscount / price) * 100
	
	### Displaying now
	
	puts ""
	puts name
	puts "********************"
	puts "Price: $" + price.to_s
	puts "Total purchases: " + totalPurchases.to_s
	puts "Total sales: $" + totalSales.to_s
	puts "Average price: $" + avgPrice.to_s
	puts "Average discount: $" + sprintf('%.2f', avgDiscount)
	puts "Average discount (percentage): " + sprintf('%.2f%', avgDiscountPercentage)
	puts "********************"

  end

puts " _                         _     "
puts "| |                       | |    "
puts "| |__  _ __ __ _ _ __   __| |___ "
puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
puts "| |_) | | | (_| | | | | (_| \\__ \\"
puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
puts ""

# For each brand in the data set:
  # Print the name of the brand
  # Count and print the number of the brand's toys we stock
  # Calculate and print the average price of the brand's toys
  # Calculate and print the total revenue of all the brand's toy sales combined'
  
  ### Is there a cleaner way of getting list of brands without duplicates?
  
  brands_hash = {}
  products_hash["items"].each do |toy|
    brands_hash[toy["brand"]] = 1
  end
  
  brands_hash.each do |name, brand|
	
	products = products_hash["items"].select{|toy| toy["brand"] == name}
	
	brandsToysStock = 0
	brandsPriceSum = 0
	brandsTotalSales = 0
	products.each do |product|
	  brandsToysStock += product["stock"]
	  brandsPriceSum += product["full-price"].to_f
	  
	  totalProductSales = 0
	  product["purchases"].each do |purchase|
		totalProductSales += purchase["price"]
	  end
	  brandsTotalSales += totalProductSales
	end
	brandsAvgProductPrice = brandsPriceSum / products.length
	
	### Displaying now
	
	puts ""
	puts name
	puts "********************"
	puts "Number of Products: " + brandsToysStock.to_s
	puts "Average Product Price: $" + sprintf('%.2f', brandsAvgProductPrice)
	puts "Total Sales: $" + sprintf('%.2f', brandsTotalSales)
	
  end