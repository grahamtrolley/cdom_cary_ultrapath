# CDOM Cary-100 & Ultrapath Measurement Merge Project

Repository to organize code & data for the paper: An Approach for Merging Colored Dissolved Organic Matter Absorption Measurements from Complementary Benchtop Spectrometers; Trolley et al. 2026.

This project combines CDOM absorption spectra of the same sample measured on two different benchtop spectrophotometers that have different but overlapping spectral ranges. The dataset here uses measurements from the long-pathlength WPI Ultrapath and the short-pathlength Agilent Cary-100 spectrophotometers, though the approach is generalizable for different instruments. The merged product has values over a wider wavelength range than the input spectra, and is designed to leverage the measurements from each instrument based on the spectral range to which each is most suited. For a more detailed explanation of the approach, please see the manuscript.

**Python version:** 3.13.5  
**R version:** 4.5.1


## Quick Start

1. Clone this repository
2. Choose your data access method (see below)
3. Run `ag_merge_code_trolley_et_al.ipynb`
4. Run the R script for S275:295 derivation

## Main Analysis

**Primary Jupyter notebook:** `ag_merge_code_trolley_et_al.ipynb`

- Downloads (From SeaBASS) or loads (from .pkl) CDOM data for paired Cary-Ultrapath measurements
- Implements merge approaches (value threshold and percent difference methods, as described in the manuscript)
- Generates all figures from the manuscript

**R script:** `cdom_slopes.r`

- Derives S275:295 using the `cdom` R package
- Exports results to CSV for use in the main notebook
- **Note:** The derived S275:295 values are only used for the dataset summary plot (Fig. 5)


## Data Access Options

The CDOM data are available through 2 methods:

### Method 1:

The first data access method uses the provided NASA SeaBASS links along with your systems earthdata credentials saved in your .netrc file to directly download all relevant CDOM files from SeaBASS automatically. This is the preferred method since you have the full files available to reference, but this approach is less beginner friendly as it requires you to have set up earthdata .netrc credentials.

#### Optional: NASA Earthdata Credentials:
For direct data download from SeaBASS, configure your `.netrc` file with Earthdata credentials. See [NASA Earthdata Login Setup](https://urs.earthdata.nasa.gov/documentation/for_users/data_access/create_net_rc_file).


### Method 2: 
The second data access method is to access the pre-configured paired cary-ultrapath measurements via the file in this repository: cary_ultrapath_paired_measurements.pkl. This file was created by the authors using the above approach, so we've made it available to make the dataset easier to jump right into for users who aren't interested in downloading 2000+ SeaBASS files. 

---
Contributors: Graham Trolley<sup>1,2</sup> , Kelsey Allen<sup>1,2</sup> , Antonio Mannino<sup>1</sup> \
Corresponding Author: Graham Trolley (graham.r.trolley@nasa.gov)\
<sup>1</sup> Ocean Ecology Laboratory (Code 616), NASA Goddard Space Flight Center, Greenbelt, MD, United States\
<sup>2</sup> Hydrosphere, Biosphere, and Geophysics (HBG) support services, Science Systems and Applications Inc, Lanham, MD, United States
