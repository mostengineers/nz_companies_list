require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'pry'

search_date = CGI.escape '01/03/2016'

search_url = 'https://www.business.govt.nz/companies/app/ui/pages/companies/search?q=&entityTypes=LTD&entityStatusGroups=REGISTERED&incorpFrom=' + search_date + '&incorpTo=' + search_date + '&addressTypes=ALL&addressKeyword=&start=0&limit=200&sf=&sd=&advancedPanel=true&mode=advanced#results'

company_details_url = 'https://www.business.govt.nz/companies/app/ui/pages/companies/' # + 5897810 to get details page

harvested_results = []

company_search_results = Nokogiri::HTML(open(search_url))

company_search_results.css('.dataList tr').each do |company_data|
  if company_data.css('.link')[0]
    popup_link = company_data.css('.link')[0][:href] 
    company_id = popup_link.scan(/'([^']*)'/)[0][0]
    company_details = [
      company_details_url + company_id,
      company_data.css('.entityName').text,
      #company_data.css('.entityInfo').text,
      company_data.css('.incorporationDate label').text
    ] 
    harvested_results <<  company_details.join(',')
  end
end

puts harvested_results
