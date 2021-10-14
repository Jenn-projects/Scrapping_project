require 'rspec'
require 'pry'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"))

def get_townhall_urls(departement_url)
  page = Nokogiri::HTML(open(departement_url))
  url = "http://annuaire-des-mairies.com/"
  townhalls_url_array = []
  townhall = page.css("a.lientxt")
    townhall.each do |t| 
    townhalls_url_array << [[t.text] + [url + t['href']]].to_h
    end
  return townhalls_url_array
end
#retourne ville et URL dans un array de hashes


def get_townhall_email(townhall_url) 
  page = Nokogiri::HTML(open(townhall_url))
  emails = []
  email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
    email.each do |e|
    emails << e.text
  end
  return emails
end

def perform
    townhalls_url_array = get_townhall_urls('http://annuaire-des-mairies.com/val-d-oise.html')
    emails = get_townhall_email(townhalls_url_array.to_s) 
    puts emails
#    puts townhalls_url_array
end

perform