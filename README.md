# weatherApp
Weather application written fully in Julia
This utility will update a CSV file once a day based on the BBC Weather RSS feed. This is aimed at data collection.
To run in it's standard form insert the city name in the "setup.txt" file on the second line. 
Then make sure that the lib.jl file includes your city/location BBC code. If it's not there add it. The BBC code is the number at the end of the URL when you open the BBC forecast from your browser.
Once you have completed the above steps run by navigating to the programs directory and doing:
```shell
user@linuxComputer ~ >>> julia timer.jl &
```
The Data collected will be written to: "NAME_OF_CITY.csv"
Units are C, mph and mbar.