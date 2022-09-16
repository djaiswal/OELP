library(ncdf4)
myfile <- "/Users/deepakjaiswal/Desktop/tmp/rhum.2m.1994.nc"
climdatedata <- nc_open(filename = myfile)
print(climdatedata)
