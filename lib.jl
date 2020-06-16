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
function getWeatherForecastToday(city)
	city = lowercase(city) #convert to lowercase
	code = findcode(city)
	url= string("https://weather-broker-cdn.api.bbci.co.uk/en/forecast/rss/3day/",code)
	response = HTTP.request("GET", url;)
	responseS = String(response.body)
	return responseS
end
function getWeatherReadingNow(city)
	city = lowercase(city) #convert to lowercase
	code = findcode(city)
	url= string("https://weather-broker-cdn.api.bbci.co.uk/en/observation/rss/",code)
	response = HTTP.request("GET", url;)
	responseS = String(response.body)
	return responseS
end

function getTempForecastToday(city)
	responseS = getWeatherForecastToday(city)
	rangeStart = findfirst("Wind Speed: ", responseS)
	indexStart = last(rangeStart)+1
	rangeEnd = findfirst("mph", responseS)
	indexEnd = first(rangeEnd)-1
	output = responseS[indexStart:indexEnd]
	return output
end
function getPressureForecastToday(city)
	responseS = getWeatherForecastToday(city)
	rangeStart = findfirst("Pressure: ", responseS)
	indexStart = last(rangeStart)+1
	rangeEnd = findfirst("mb", responseS)
	indexEnd = first(rangeEnd)-1
	output = responseS[indexStart:indexEnd]
	return output
end
function getHumidityForecastToday(city)
	responseS = getWeatherForecastToday(city)
	rangeStart = findfirst("Humidity: ", responseS)
	indexStart = last(rangeStart)+1
	rangeEnd = findfirst("%,", responseS)
	indexEnd = first(rangeEnd)-1
	output = responseS[indexStart:indexEnd]
	return output
end
function getTempReadingNow(city)
	responseS = getWeatherReadingNow(city)
	range = findfirst("°C", responseS) 
	indexEnd = first(range)-1
	indexStart = indexEnd-2
	if(responseS[indexStart]==' ') #if empty move indexes until blank spaces are not present forwards
		indexStart = indexEnd-1
		if(responseS[indexStart]==' ')
			indexStart = indexStart +1
		end
	end
	output = responseS[indexStart:indexEnd]
	return output
end
function getHumidityReadingNow(city)
	reponseS = getWeatherReadingNow(city)
	range = findfirst("%,", responseS)
	indexEnd = first(range)-1
	indexStart = indexEnd - 2
		if(responseS[indexStart]==' ') #if empty move indexes until blank spaces are not present forwards
		indexStart = indexEnd-1
		if(responseS[indexStart]==' ')
			indexStart = indexStart +1
		end
	end
	output = responseS[indexStart:indexEnd]
	return output
end
function getPressureReadingNow(city)
	responseS = getWeatherReadingNow(city)
	rangeStart = findfirst("Pressure: ", responseS)
	indexStart = last(rangeStart)+1
	rangeEnd = findfirst("mb", responseS)
	indexEnd = first(rangeEnd)-1
	output = responseS[indexStart:indexEnd]
	return output
end
function getWindReadingNow(city)
	responseS = getWeatherReadingNow(city)
	range = findfirst("mph", responseS)
	indexEnd = first(range)-1
	indexStart = indexEnd - 1
	if(responseS[indexStart]==' ') #if empty move indexes until blank spaces are not present forwards
		indexStart = indexEnd-1
		if(responseS[indexStart]==' ')
			indexStart = indexStart +1
		end
	end
	output = responseS[indexStart:indexEnd]
	return output
end
	
function getTimeReadingNow(city) #Time of Reading
	responseS = getWeatherReadingNow(city)
	range = findfirst("GMT", responseS)
	indexEnd = first(range)-2
	indexStart = indexEnd - 7
	output = responseS[indexStart:indexEnd]
	return output
end
	
#Insert more functions here