# Author: Sergio Cavalieri Canosa
# Description: FrontEnd display code for weatherApp project (julia)
# Date: 2020-06-12

using Plots, CSV, DataFrames

lines = readlines("setup.txt")
city = lines[2]
csvFilename = city*".csv"
df = CSV.read(csvFilename)
temp = plot(df.Date, df.Temperature)
hum = plot(df.Date, df.Humidity)
pre = plot(df.Date, df.Pressure)
plot(temp, hum, pre, layout = (3,1))