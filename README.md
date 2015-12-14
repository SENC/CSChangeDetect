# CSChangeDetect

Just helpful if you are very new to Remote sensig-Change detection using 2 satellite images

[1] Data Study process CROP SMALL portion and plot and compare
  Need to understand and know complete details about your input data structure and image data may require extra care.
  As a first step(Data Study Compare2Images.R) , just select a selective area in the image and check extent and CRS are same and
  maually look to see what are the chages between 2 .
  
  [2] 
RBand difference - separate Blue,Green,Red band information from Satellite images

Reference : http://landsat.usgs.gov/best_spectral_bands_to_use.php
Question: 
What are the best spectral bands to use for my study?

Answer:
This is a common question considered by all users of remotely sensed data. The level of detail (spatial resolution) is often the most interesting aspect of viewing a satellite image, but less appreciated is how changes in irradiative energy reflected by different surface materials are used to identify features of interest.
Landsat 8 Operational Land Imager (OLI) and Thermal Infrared Sensor (TIRS)

Band	  Wavelength	Useful for mapping

Band 1 – coastal aerosol	0.43 - 0.45	coastal and aerosol studies

Band 2 – blue	            0.45 - 0.51	Bathymetric mapping, distinguishing soil from vegetation and deciduous from coniferous vegetation

Band 3 -                  green	0.53 - 0.59	Emphasizes peak vegetation, which is useful for assessing plant vigor

Band 4 - red	0.64 - 0.67	Discriminates vegetation slopes

Band 5 - Near Infrared (NIR)	0.85-0.88	Emphasizes biomass content and shorelines

Band 6 - Short-wave Infrared (SWIR) 1	1.57 - 1.65	Discriminates moisture content of soil and vegetation; penetrates thin clouds

Band 7 - Short-wave Infrared (SWIR) 2	2.11 - 2.29	Improved moisture content of soil and vegetation and  thin cloud penetration

Band 8 - Panchromatic	0.50 - 0.68	15 meter resolution, sharper image definition

Band 9 – Cirrus	1.36 - 1.38	Improved detection of cirrus cloud contamination

Band 10 – TIRS 1	10.60 – 11.19	100 meter resolution, thermal mapping and estimated soil moisture

Band 11 – TIRS 2	11.5 - 12.51	100 meter resolution, Improved thermal mapping and estimated soil moisture

Landsat 4-5 Thematic Mapper (TM) and Landsat 7 Enhanced Thematic Mapper Plus (ETM+)
Band	Wavelength	Useful for mapping

Band 1 - blue	0.45 - 0.52	Bathymetric mapping, distinguishing soil from vegetation and deciduous from coniferous vegetation

Band 2 - green	0.52 - 0.60	Emphasizes peak vegetation, which is useful for assessing plant vigor

Band 3 - red	0.63 - 0.69	Discriminates vegetation slopes

Band 4 - Near Infrared	0.77 - 0.90	Emphasizes biomass content and shorelines

Band 5 - Short-wave Infrared	1.55 - 1.75	Discriminates moisture content of soil and vegetation; penetrates thin clouds

Band 6 - Thermal Infrared	10.40 - 12.50	Thermal mapping and estimated soil moisture

Band 7 - Short-wave Infrared	2.09 - 2.35	Hydrothermally altered rocks associated with mineral deposits

Band 8 - Panchromatic (Landsat 7 only)	0.52 - 0.90	15 meter resolution, sharper image definition

Landsat Multi Spectral Scanner (MSS)

Landsat MSS 1, 2,3  Spectral Bands	Landsat MSS 4,5 Spectral Bands	Wavelength	Useful for mapping
Band 4 - green	Band 1 - green	0.5 - 0.6	Sediment-laden water, delineates areas of shallow water

Band 5 - red	Band 2 - red	0.6 - 0.7	Cultural features

Band 6 - Near Infrared	Band 3 - Near Infrared	0.7 - 0.8	Vegetation boundary between land and water, and landforms

Band 7 - Near Infrared	Band 4 - Near Infrared	0.8 - 1.1	Penetrates atmospheric haze best, emphasizes vegetation, boundary between land and water, and landforms
