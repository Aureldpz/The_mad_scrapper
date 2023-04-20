require 'nokogiri'  
require 'open-uri'

def get_townhall_email
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/ableiges.html"))
  townhall_email = page.xpath('//tr[@class="txt-primary tr-last]"')

  mairie_email = {}
  mairie_email = email.xpath('tbody/tr[4]/td[2]').text

  return mairie_email

end
puts mairie_email


def get_townhall_urls

end