require 'rspec'
require 'pry'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))

#extraire elements par le xpath et les mettre chacun dans un array
def symbols
  doc = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  crypto_symbols = []
  symbols = doc.xpath('//*[@class="text-left col-symbol"]')
    symbols.each do |symbol|
    crypto_symbols << symbol.text #les ajoute un par un dans l'array
    end
  return crypto_symbols
end

def prices
  doc = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  crypto_prices = []
  prices = doc.xpath('//*[@class="price"]')
    prices.each do |price|
    crypto_prices << price.text.delete('$ ,') #on enleve le dollar
    end
  return crypto_prices
end

def crypto_scrapper
  array = []
  hash = Hash[symbols.zip(prices)].map {|k,v| {name: k, price: v}}.join
  return array = [hash]
end

def perform
  puts "Voici les cours actuels de la cryptomonnaie :"
  puts crypto_scrapper
end

perform