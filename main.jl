# Author: Sergio Cavalieri Canosa
# Description: Main code for weatherApp project (julia)
# Date: 2020-06-09
using DataFrames, CSV, Dates
include("lib.jl")

println("please ensure the correct city name is present in the setup.txt file")
lines = readlines("setup.txt")
city = lines[2]
println("city from setup file is: ", city)    
csvFilename = city*".csv"
files = readdir()
for i in 1:length(files)
	exit = 1 #exit will ensure that if csvFilename is found 
	if (files[i]==csvFilename)
		println("CSV found")
		global df = CSV.read(csvFilename)
		exit = 1
	elseif(exit!=1) #if no file found create new CSV file
		pritln("[WARNING]: CSV not found... Creating")
		global df = DataFrame(Date = [], Temperature = [], Humidity = [], Pressure = [];)
		CSV.write(csvFilename, df)
	end
end
if (length(df.Date)>0) #Check if dataframe has any data 
	DateofLastEntry = df.Date[end]
else #If Dataframe has no data act as if yesterday's date were present
	todayDay = Dates.today()
	yDay = Dates.day(todayDay)-1
	yMonth = Dates.month(todayDay)
	yYear = Dates.year(todayDay)
	DateofLastEntry = Date(yYear, yMonth, yDay)
end
if (DateofLastEntry!=string(Dates.today())) #Check that an entry hasn't already been written today. NOTE: Date must be stringed
	println("updating df")
	df2 = DataFrame(Date = Dates.today(), Temperature = getTemp(city), Humidity = getHumidity(city),Pressure = getPressure(city))
	df3=vcat(df,df2) #Concatenate the Dataframe from CSV with new data
	println("writing to CSV")
	CSV.write(csvFilename, df3)#Write the new df to the CSV file
end 