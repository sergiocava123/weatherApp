# Author: Sergio Cavalieri Canosa
# Description: Main code for weatherApp project (julia)
# Date: 2020-06-09
using HTTP

function findcode(city)
	if (city=="glasgow") 
		code = 2648579
	elseif(city == "edinburgh")
		code = 2650225
	elseif(city == "garda")
		code = 3176320
	end
	
	return code
end

println("For what city?")
city = readline() #read input
city = lowercase(city) #convert to lowercase
code = findcode(city)
url= string("https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/",code)
response = HTTP.request("GET", url;)
responseS = String(response.body)
rangeStart = findfirst("Today", responseS)
if (rangeStart==nothing)
	rangeStart = findfirst("Tonight", responseS)
end 
indexStart = first(rangeStart)
rangeEnd = findfirst("Maximum Temperature", responseS)
indexEnd = last(rangeEnd)+8
output = responseS[indexStart:indexEnd]