#!/bin/bash
#script to compare the output files of the eWaterCycle project with river discharge data
#from the GRDC database. 
#
#This script heavily uses the CDO library, make sure you have it installed, with grib
# and netCDF support. 

GRDCLocation=../../localData/GRDC/GRDCdat_day/
#here the ensemble is stored, the entire ensemble!
eWaterOutput=../../localData/sampleOutput/ 
targetDay=2015-08-14T00:00:00
#targetday + end-forecast
endForcastDay=2015-08-22T00:00:00
outputFolder=../../localData/sampleOutput/

#will be cleaned at end of script
tmpFolder=../../localData/tmp 


#create tmpFolder
#mkdir ${tmpFolder}

#first, convert GRDC data to NetCDF. This only needs to be done once. See the seperate
#repo at https://github.com/RolfHut/GRDC2NetCDF
#python ../GRDC2NetCDF/GRDC2NetCDF.py ${GRDCLocation} daily ${tmpFolder}testDailyOld.nc 1990-01-01 2000-01-01

#THIS IS ONLY BECAUSE I DO NOT HAVE THE GRDC DATA YET AND MAKES NO HYDROLOGICAL SENSE
cdo shifttime,20year ${tmpFolder}/testDailyOld.nc ${tmpFolder}/testDaily.nc

#select one forecast-day. doing in this 2 steps, so this can be put into a loop later on.
cdo seldate,${targetDay},${endForcastDay} ${tmpFolder}/testDaily.nc ${tmpFolder}/GRDCSelection.nc

#interpolate output eWaterCycle (a grid) to GRDC station locations (points)
for ensembleMember in {01..20..1}
do
    cdo remapnn,${tmpFolder}/testDaily.nc ${eWaterOutput}/work${ensembleMember}/output/netcdf/discharge_dailyTot_output.nc ${tmpFolder}/eWaterCycleGRDCMap${ensembleMember}.nc
done

#calculate Brier scores
cdo ensbrs,0.95 ${tmpFolder}/GRDCSelection.nc ${tmpFolder}/eWaterCycleGRDCMap*.nc ${outputFolder}/validation

#remove tmp files, commented out for now, for debugging
#rm -r ${tmpFolder}
