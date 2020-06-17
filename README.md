# weatherApp
Weather application written fully in Julia

Capable of reading same day forecast and readings for Temperature, Pressure and Humidity.
This code simply presents simple functions that will interface with the BBC's RSS feeds.
An example of an implementation is also provided.
## Using the functions
Copy the "lib.jl" file into the same directory of your main code. Then run:
```julia
julia >> include("lib.jl")
```
The functions can then easily be called as follows:
```julia
julia >> city = "Glasgow"
julia >> getPressureReadingNow(city)
	"1080"
```
The following functions can be called:
```julia
getTempForecastToday(city)
getPressureForecastToday(city)
getHumidityForecastToday(city)
getTempReadingNow(city)
getHumidityReadingNow(city)
getPressureReadingNow(city)
getWindReadingNow(city)
getTimeReadingNow(city)
```
The units of the outputs that the functions return  are C, mbar, % and mph.
Note that the getTimeReadingNow will simply output the hour of the observation in GMT timezone.  

It is essential to make sure that the "lib.jl" file includes your city/location BBC code. If it's not there add it (lines 14 and 15) and feel free to update code here. The BBC code is the number at the end of the URL when you open the BBC forecast for your location from your browser.

## Using the "main.jl" example implementation

This utility will update a CSV file once a day by reading the RSS feed by BBC Weather. This is aimed at data collection.
To run in it's standard form insert the city name in the "setup.txt" file on the second line. 
Then make sure that the lib.jl file includes your city/location BBC code. If it's not there add it and feel free to update code here. The BBC code is the number at the end of the URL when you open the BBC forecast for your location from your browser.
Once you have completed the above steps run by navigating to the programs directory and doing:
```shell
user@linuxComputer ~ >>> julia timer.jl &
```
The Data collected will be written to: "NAME_OF_CITY.csv"
