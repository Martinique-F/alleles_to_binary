# alleles_to_binary
Convert allelic profiles from EnteroBase to binary to calculate differences in gene content


## Requirements

To run the functions probably, the following packages are required:

```
install.packages(tidyverse)
library(tidyverse)
```

To read in an allelic profile, where missing loci (no sequence at that loci) are labelled with '-' and undetermined loci (sequence at loci has bad quality and was not determined) are labelled with a negative number, use:

```
ap <- read.table("test_profiles.csv",
             sep = "\t", comment.char = "", header = T)
             
> head(ap)

    Name    ST CD196_RS15035 CDIF100001_01614 UAB_RS02000000220350 LocusCD630_211504 CD630_00070
1 dummy1  2275             -               -1                    2                 2           1
2 dummy2 14681             -                3                    2                 -           2
3 dummy3  2276             2                2                    2                 2           2
4 dummy4  2277             2                2                    2                 2          -1
5 dummy5  2278            -1                5                    2                 2           2
6 dummy6  2279             2                2                    4                 2           5
            
```

To change the profile into binary, '-' will be converted to '0' and negative values to 'NA' so that they can be pairwise excluded when calculating the distance between the profiles
```
ap_binary <- alleles_to_binary(ap)
head(ap_binary)

       CD196_RS15035 CDIF100001_01614 UAB_RS02000000220350 LocusCD630_211504 CD630_00070
dummy1             0               NA                    1                 1           1
dummy2             0                1                    1                 0           1
dummy3             1                1                    1                 1           1
dummy4             1                1                    1                 1          NA
dummy5            NA                1                    1                 1           1
dummy6             1                1                    1                 1           1
```

If you only want to have a look at the accessory loci, the function access_to_binary.R will automatically substitute the cgMLST Loci from the profiles. Therefore, you have to load the cgMLST_alleles.txt file:

```
cgMLST_info <- read.table("cgMLST_alleles.txt", header = T, quote="",sep = "\t")

access_binary <- access_to_binary(ap)
head(access_binary)

       CDIF100001_01614 LocusCD630_211504
dummy1               NA                 1
dummy2                1                 0
dummy3                1                 1
dummy4                1                 1
dummy5                1                 1
dummy6                1                 1
```

             