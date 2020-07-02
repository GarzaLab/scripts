# Scripts

Here are useful scripts for several needs.

# Rodent DBM

This folder contains scripts for rat and mouse DBM.

## Vertex Coordinate Atlas

This is a function I created for R statistics. This function uses the GLM information from the vertexLm and vertexFDR from RMINC, to create Tables ready for publication. The tables have the following columns: 1) Labels, 2) MNI coordinates, 3) vertex, 4) T-value. 

At the moment it uses the AAL atlas, but it can be modified to use with any atlas.

The function uses the AAL labels as factors to cluster the MNI coordinates and t-values, from which then it chooses the MAX t-value and prints the related row with all the information. 

The function needs the following information:

1) vertexLm object, from the GLM analysis for each hemisphere.
2) The column of interest in the GLM analysis. It can be a number or the string (i.e. "tvalue-age").
3) The t-value threshold for each hemisphere.
4) The AAL atlas for each hemisphere.
5) The AAL labels file.
6) The MNI coordinates for each vertex file.

The Atlases, labels and MNI coordinates I used are included in the folder. You will have to load them into R first.

The function only creates the table, you will need to explicitly create the table (i.e. `table <- function(mystuff)`).

Then to export it: 

`write.csv(mytable, file = "mytable.csv")`






