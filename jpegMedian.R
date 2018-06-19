library(jpeg)

img.dir <- getwd() # change to img-dir

img.names.list <- list.files(path = img.dir, pattern = '.jpg')
img.matrices <- lapply(paste(img.dir, img.names.list, sep = ""), readJPEG)

img.matrices <- array(unlist(img.matrices), dim = c(dim(img.matrices[[1]]), length(img.matrices)))
img.matrices.dims <- dim(img.matrices)

newImage.median <- array(1, dim = img.matrices.dims[1:3])
for (i in 1:img.matrices.dims[1]) {
  for (j in 1:img.matrices.dims[2]) {
    for (k in 1:3) {
      
      vals <- rep(0, img.matrices.dims[4])
      
      for (l in 1:img.matrices.dims[4]) {
        vals[l] <- img.matrices[i,j,k,l]
      }
      
      newImage.median[i,j,k] <- median(vals)
      
    }
  }
}

writeJPEG(newImage.median, target = 'newImage_median.png')
