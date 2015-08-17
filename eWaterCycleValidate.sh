#!/bin/bash
#script to compare the output files of the eWaterCycle project with river discharge data
#from the GRDC database. 
#
#This script heavily uses the CDO library, make sure you have it installed, with grib
# and netCDF support. 


eWaterOutput= ../../localData/tmp/someOutputTest.nc
targetDay=YYYY-MM-DDThh:mm:ss
endForcastDay=YYYY-MM-DDThh:mm:ss #targetday + end-forecast

#first, convert GRDC data to NetCDF. This only needs to be done once. See the seperate
#repo at https://github.com/RolfHut/GRDC2NetCDF
python ../GRDC2NetCDF/GRDC2NetCDF.py ../../localData/GRDC/2stationsDaily/ daily ../../localData/tmp/testDaily.nc 1990-01-01 2000-01-01

#select one forecast-day. doing in this 2 steps, so this can be put into a loop later on.
cdo seldate,${targetDay},${endForcastDay} ../../localData/tmp/testDaily.nc ../../localData/tmp/tmp/GRDCSelection.nc

#interpolate output eWaterCycle (a grid) to GRDC station locations (points)
for ensembleMember in {01..20..1}
do
    cdo remapnn,../../localData/tmp/testDaily.nc ${eWaterOutput}/FOOBARENSEMBLESTRUCTUUR ../../localData/tmp/tmp/eWaterCycleGRDCMap.nc
done

#calculate Brier scores
ensbrs,0.95 ../../localData/tmp/tmp/GRDCSelection.nc ${eWaterOutput} ../../localData/tmp/result

exit


