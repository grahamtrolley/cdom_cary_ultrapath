# CDOM Cary Ultrapath Merge Project:

Respository to organize code/data for Trolley et al. CDOM manuscript

## Data Access and Processing Script:

The main code here is in ag_merge_code_trolley_et_al.ipynb. This jupyter notebook downloads and/or loads in all the relevant cdom data, and processes it for the merge approaches discussed in the paper, and produces all the figures delivered in the paper

The only exception is that the derivation of S275:295 is conducted in the included r script, and the results are saved to csv and opened in the .ipynb file for plotting. This decision was made due to the superior documentation of the "cdom" package in r versus python equivalents. S275:295 is only used in the analysis for the one plot, so users may opt to skip that cell if they don't have the cabability to run R code.

### Data Access Nuance

The CDOM data are available through 2 methods

#### Method 1: (still working on implementation)

The first data access method uses the 2 provided .lis files, along with your systems earthdata credentials saved in your .netrc file to directly download all relevant cdom files from SeaBASS automatically. This is the preferred method, but in the case of seabass file revisions or improper/non-configured .netrc credentials, this method might have issues in the future. 

#### Method 2: 
The second data access method is to access the pre-configured paired cary-ultrapath measurements via the file in this repository: cary_ultrapath_paired_measurements.pkl. This file was created by the authors using the above approach, so we've made it available to make the dataset easier to jump right into for users/researchers who aren't interested in downloading all 2000+ seabass files. 
