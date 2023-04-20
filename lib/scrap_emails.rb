=begin
require 'nokogiri'
require 'open-uri'
require 'rubygems'

def emails_scraper(city_data)
    emails_list = []
    names_list = []
    for i in 0..(city_data.length - 1)
        page = Nokogiri::HTML(URI.open("#{city_data[i]}"))
      emails_list[i] = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').map(&:text)
      names_list[i] = page.xpath('//section/div/div/div/h1').map(&:text)
    end
    names_list = names_list.map{|name|name.to_s[2..-1].split(' ')[0]}
    final_list = Hash[names_list.zip(emails_list)]
    puts final_list
    return final_list
end

def city_scraper
    page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html%22))
   city_data = page.xpath('//a[contains(@href, "95")]/@href').map(&:text)
   city_data = city_data.each{|index|index[0] = ""}.map{|link|"https://www.annuaire-des-mairies.com/" + link}
    return emails_scraper(city_data)
end

city_scraper 
=end

require 'nokogiri'
require 'open-uri'
require 'rubygems'

def emails_scraper(city_data)
  emails_list = []
  names_list = []
  city_data.each do |city|
    page = Nokogiri::HTML(URI.open(city))
    emails_list << page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    names_list << page.xpath('//section/div/div/div/h1').text.split(' ')[0]
  end
  final_list = Hash[names_list.zip(emails_list)]
  puts final_list
  return final_list
end

def city_scraper
  page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  city_data = page.xpath('//a[contains(@href, "95")]/@href').map{|link| "https://www.annuaire-des-mairies.com/#{link.text}"}
  return emails_scraper(city_data)
end

city_scraper