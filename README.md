# CDOM Cary Ultrapath Merge Project:

Repository to organize code & data for Trolley et al. 2026 CDOM manuscript  
**Python version:** 3.13.5  
**R version:** 4.5.1


## Quick Start

1. Clone this repository
2. Choose your data access method (see below)
3. Run `ag_merge_code_trolley_et_al.ipynb`
4. Run the R script for S275:295 derivation

## Main Analysis

**Primary notebook:** `ag_merge_code_trolley_et_al.ipynb`

This Jupyter notebook:
- Downloads/loads CDOM data from paired Cary-Ultrapath measurements
- Implements merge approaches (value threshold and percent difference methods, as described in the manuscript)
- Generates all figures from the manuscript

**R script:** `cdom_slopes.r`

- Derives S275:295 using the `cdom` R package
- Exports results to CSV for use in the main notebook
- **Note:** The derived S275:295 values are only used for the dataset summary plot (Fig. 5)


## Data Access Options

The CDOM data are available through 2 methods

### Method 1:

The first data access method uses the provided NASA SeaBASS links along with your systems earthdata credentials saved in your .netrc file to directly download all relevant cdom files from SeaBASS automatically. This is the preferred method since you have the full files available to reference, but this approach is less beginner friendly as it requires you to have set up earthdata .netrc credentials

#### Optional: NASA Earthdata Credentials
For direct data download from SeaBASS, configure your `.netrc` file with Earthdata credentials. See [NASA Earthdata Login Setup](https://urs.earthdata.nasa.gov/documentation/for_users/data_access/create_net_rc_file).


### Method 2: 
The second data access method is to access the pre-configured paired cary-ultrapath measurements via the file in this repository: cary_ultrapath_paired_measurements.pkl. This file was created by the authors using the above approach, so we've made it available to make the dataset easier to jump right into for users/researchers who aren't interested in downloading all 2000+ seabass files. 
