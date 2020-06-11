# Author: Sergio Cavalieri Canosa
# Description: Acts as GET function libary for weatherApp project (julia)
# Date: 2020-06-09
using HTTP

function findcode(city)
#In order to succesfully monitor a target city the code must be present here
	if (city=="glasgow") 
		code = 2648579
	elseif(city == "edinburgh")
		code = 2650225
	elseif(city == "garda")
		code = 3176320
	elseif(city == "YOUR_CITY_NAME_HERE")
		code = 3176320
	end
	
	return code
end
function getWeather(city)
	city = lowercase(city) #convert to lowercase
	code = findcode(city)
	url= string("https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/",code)
	response = HTTP.request("GET", url;)
	responseS = String(response.body)
	return responseS
end

function getTemp(city)
	responseS = getWeather(city)
	rangeStart = findfirst("Wind Speed: ", responseS)
	indexStart = last(rangeStart)+1
	rangeEnd = findfirst("mph", responseS)
	indexEnd = first(rangeEnd)-1
	output = responseS[indexStart:indexEnd]
	return output
end
function getPressure(city)
	responseS = getWeather(city)
	rangeStart = findfirst("Pressure: ", responseS)
	indexStart = last(rangeStart)+1
	rangeEnd = findfirst("mb", responseS)
	indexEnd = first(rangeEnd)-1
	output = responseS[indexStart:indexEnd]
	return output
end
function getHumidity(city)
	responseS = getWeather(city)
	rangeStart = findfirst("Humidity: ", responseS)
	indexStart = last(rangeStart)+1
	rangeEnd = findfirst("%,", responseS)
	indexEnd = first(rangeEnd)-1
	output = responseS[indexStart:indexEnd]
	return output
end
#Insert more functions here