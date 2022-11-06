
library(ncdf4)
setwd <- "C:\\Users\\DELL\\Downloads\\GCBB_datasets"

file0 = "C:\\Users\\DELL\\Downloads\\GCBB_datasets\\latlon.nc"
ncf = nc_open(file0)
XLAT = ncvar_get(ncf,"XLAT") 
XLONG = ncvar_get(ncf,"XLONG") 

file1<-"C:\\Users\\DELL\\Downloads\\GCBB_datasets\\CTL_S4\\cpost_ctl_s4_XLAI_monthly.nc"
nc1 = nc_open(file1)
file2<-"C:\\Users\\DELL\\Downloads\\GCBB_datasets\\BIO_S4\\cpost_bio_s4_XLAI_monthly.nc"
nc2 = nc_open(file2)
xlai1 = ncvar_get(nc1,"XLAI")
xlai2 =ncvar_get(nc2,"XLAI")
dim(xlai1)
X1=xlai1[,,1,2]
X2=xlai2[,,1,2]

library(akima)
my.matrix1 <- interp(XLONG,XLAT,X1,nx=dim(XLONG)[1],ny=dim(XLONG)[2])
my.matrix2 <- interp(XLONG,XLAT,X2,nx=dim(XLONG)[1],ny=dim(XLONG)[2])

d1<-as.data.frame(my.matrix1[["z"]]) #assigning 0 to all NA values for control
                                    #max value comes out to 5
d1[is.na(d1)] <- 0

d2<-as.data.frame(my.matrix2[["z"]]) #assigning 0 to all NA values for control

d2[is.na(d2)] <- 0


ref.matrix=my.matrix1[["z"]]-my.matrix1[["z"]] # same operation on the differnce of two matrix
                                              # max value comes out to be zero
d1_ref.matrix=as.data.frame(ref.matrix)
d1_ref.matrix[is.na(d1_ref.matrix)] <- 0
d1_ref.matrix
max(d1_ref.matrix)

for (r in 1:nrow(ref.matrix))   
