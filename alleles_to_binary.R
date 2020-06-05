alleles_to_binary <- function(file, ...){
  file %>% remove_rownames %>% column_to_rownames(var="Name") -> file_rnmd
  file_rnmd <- subset(file_rnmd, select = -c(1))
  #change all columns to numeric - '-' will be changed to NA
  file_rnmd <- as.data.frame(lapply(file_rnmd, function(x) as.numeric(as.character(x))))
   rownames(file_rnmd) <- file$Name
   #replace all NA with 0 - absence
   file_rnmd[is.na(file_rnmd)] <- 0
   #change all numbers smaller 0 to NA - negative numbers imply fragmented pieces
   #but there is sequence - these should be pairwise excluded from analysis
   file_rnmd[file_rnmd <0] <- NA
  #convert into binary data : 0=not present, 1=present
   file_rnmd[file_rnmd !=0] <- 1
  
    return(data.frame(file_rnmd))
}
