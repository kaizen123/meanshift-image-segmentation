# meanshift-image-segmentation
Image Segmentation using Mean Shift Algorithm

Steps Followed:
===============
* Downscale input image to 64x64 to ensure faster execution
* Initialize mean to a set of pixel and intensity values
* Calculate weight using the Gaussian kernel having a specified bandwidth h.
* Calculate new mean values using the above calculated weight
* Calculate the shift in the new mean from the old mean iteratively until convergence of the mean values.