require 'nokogiri'
require 'open-uri'
require 'pry'

search_url = 'https://www.business.govt.nz/companies/app/ui/pages/companies/search?q=&entityTypes=LTD&entityStatusGroups=REGISTERED&incorpFrom=01%2F03%2F2016&incorpTo=01%2F03%2F2016&addressTypes=ALL&addressKeyword=&start=0&limit=200&sf=&sd=&advancedPanel=true&mode=advanced#results'

doc = Nokogiri::HTML(open(search_url))

doc.css('.dataList tr').each do |company_data|
  if company_data.css('.link')[0]
    puts company_data.css('.link')[0][:href] 
    puts company_data.css('.entityName')
    puts company_data.css('.entityInfo')
    puts company_data.css('.incorporationDate label')
  end
end

