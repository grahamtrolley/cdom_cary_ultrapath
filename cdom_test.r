# Load the cdom library
library(cdom)
library(ggplot2)

# data("spectra")
# 
# fit <- cdom_fit_exponential(wl = spectra$wavelength,
#                         absorbance = spectra$spc3,
#                         wl0 = 275,
#                         startwl = 275,
#                         endwl = 295)
# 
# 
# ##          S          K         a0
# ## 0.02220677 1.85125099 6.02460455
# 
# 
# x_vals <- unlist(fit$data[,"x"])
# y_vals <- unlist(fit$data[,".fitted"])
# y2_vals <-  unlist(fit$data[,"y"])
# 
# # First plot establishes the plotting area
# plot(spectra$wavelength, spectra$spc3,
#      type = "p",
#      col = "blue",
#      xlab = "Wavelength (nm)",
#      ylab = "Absorbance",
#      main = "CDOM Data and Fit")
# 
# 
# points(x_vals, y2_vals, type = "p")
# 
# lines(x_vals, y_vals, type = "l", col='red', lwd=2)
# 
# print(fit$param$estimate[1])# prints S value

# Install and load reticulate and pandas if you haven't already
# install.packages("reticulate")
py_install("pandas")
library(reticulate)

# Load pandas in R
pd <- import("pandas")

# Read the pickle file
df <- pd$read_pickle("cary_ultrapath_paired_measurements.pkl")

# Convert to R data frame if needed
df_r <- py_to_r(df)

rowlen = dim(df_r)[1]

# Set up s_275_295 function, by taking relevant code from slope_ratio.R
# function in the CDOM R package, https://github.com/PMassicotte/cdom

s_275_295 <- function(x, y) {
  sf <- splinefun(x, y)
  wl_275_295 <- seq(from = 275, to = 295, length.out = 25)
  data_275_295 <- sf(wl_275_295)
  slope_275_295 <- coef(lm(log(data_275_295) ~ wl_275_295))[2]
  
  return(slope_275_295)
}



S_list <- list()
for (i in 1:rowlen) {
  print(i)
  #print(df_r$cruise[i])
  x = df_r$Cary_data[i][[1]]$wavelength
  y = unlist(df_r$Cary_data[i][[1]]$ag)
  fit <- cdom_fit_exponential(wl = x, absorbance = y, wl0 = 275,startwl = 275, endwl = 295)
  S=fit$params$estimate[1]
  #S_list <- append(S_list, S)
  
  print(S)
  print(s_275_295(x,y))
  S_list <- append(S_list, -s_275_295(x,y))
  
}
S_list = unlist(S_list)

s_275_295(x,y)




### code to make histogram ###
library(ggplot2)

# Convert to data frame
df <- data.frame(values = S_list)

# Calculate quartiles
q1 <- quantile(S_list, 0.25)
q2 <- median(S_list)
q3 <- quantile(S_list, 0.75)

# Get max count for positioning
max_count <- max(hist(S_list, plot = FALSE)$counts)

# Create histogram with staggered text
ggplot(df, aes(x = values)) +
  geom_histogram(bins = 20, fill = "lightblue", color = "black", alpha = 0.7) +
  geom_vline(aes(xintercept = q1), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = q2), color = "blue", size = 1.5) +
  geom_vline(aes(xintercept = q3), color = "red", linetype = "dashed", size = 1) +
  labs(title = "Histogram with Quartiles",
       x = "Values", 
       y = "Frequency") +
  annotate("text", x = q1, y = max_count * 0.9, label = paste("Q1:", round(q1, 5)), 
           color = "red", hjust = -0.1) +
  annotate("text", x = q2, y = max_count * 0.8, label = paste("Median:", round(q2, 5)), 
           color = "blue", hjust = -0.1) +
  annotate("text", x = q3, y = max_count * 0.7, label = paste("Q3:", round(q3, 5)), 
           color = "red", hjust = -0.1) +
  theme_minimal()

df <- data.frame(column_name = S_list)
# Write to CSV
write.csv(df, "cary_s275_295.csv", row.names = FALSE)
