#####  Download file from web  ###################
### Create data folder if necessary ---------
if(!dir.exists("DATA")) dir.create("DATA")

### Download file from article data ---------
## https://peerj.com/articles/16666/
url0 <- "https://dfzljdn9uc3pi.cloudfront.net/2024/16666/1/Data.xlsx"
data0 <- "DATA/0_tomato-raw.xlsx"
download.file(url0, data0)

### Clean -----------------------------------
rm(url0, data0)

