library(ncdf4)
myfile <- "/Users/deepakjaiswal/Desktop/tmp/sfcWindAdjust_bced_1960_1999_ipsl-cm5a-lr_rcp4p5_2021-2030.nc"

climdatedata <- nc_open(filename = myfile)
