import excel "C:\Users\nikhi\Downloads\Delhi_metro_launch_yr.xlsx", sheet("Sheet1") firstrow clear 
destring n, replace 
drop A

gen x = 2022 - yearoflaunch
 
expand x
drop x

bys Line n yearoflaunch: gen year = yearoflaunch + _n - 1 


gen x = 12 - monthoflaunch if year == yearoflaunch 
replace x = 12 if mi(x)
 
expand x
drop x 

bys Line n year monthoflaunch: gen month = monthoflaunch + _n - 1 if year == yearoflaunch 
bys Line n year monthoflaunch: replace month = _n if mi(month)

bys Line year month (n): replace n = _n

sort year month Line n
order year month Line n yearoflaunch monthoflaunch

export delimited using "C:\Users\nikhi\Downloads\expanded-year-wise-stations.csv", replace