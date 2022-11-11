library(ncdf4)
library(akima)
library(this.path) #This package is used to get the directory of the executing script so that we can use relative paths
current_directory <- this.path::this.dir()


setwd <- "C:\\Users\\DELL\\Downloads\\GCBB_datasets"

file0 = paste0(current_directory,"/ignored_by_git/latlon.nc", sep="")
ncf = nc_open(file0)
XLAT = ncvar_get(ncf,"XLAT") 
XLONG = ncvar_get(ncf,"XLONG") 

file1<- paste0(current_directory,"/ignored_by_git/CTL_S4/cpost_ctl_s4_XLAI_monthly.nc",sep="")
nc1 = nc_open(file1)
file2<- paste0(current_directory,"/ignored_by_git/BIO_S4/cpost_bio_s4_XLAI_monthly.nc",sep="")
nc2 = nc_open(file2)
xlai1_CTL = ncvar_get(nc1,"XLAI")
xlai2_BIO =ncvar_get(nc2,"XLAI")
nc_close(ncf)
nc_close(nc1)
nc_close(nc2)
'
Difference in the LAI will be largest in the middle of summer when land use (replacing natural
vegetation by miscanthus) change results in very high LAI for miscanthus. Therefore let us 
use month of July (month index = 7) for comparison
'

ctl_lai_july=xlai1_CTL[,,7,30]
bio_lai_july=xlai2_BIO[,,7,30]


ctl_lai_july_matrix <- interp(XLONG,XLAT,ctl_lai_july,nx=dim(XLONG)[1],ny=dim(XLONG)[2])
bio_lai_july_matrix <- interp(XLONG,XLAT,bio_lai_july,nx=dim(XLONG)[1],ny=dim(XLONG)[2])

#Creating a new list (difference)
diff_lai <- bio_lai_july_matrix
diff_lai$z = bio_lai_july_matrix$z - ctl_lai_july_matrix$z
filled.contour(ctl_lai_july_matrix)
filled.contour(bio_lai_july_matrix)
filled.contour(diff_lai)
