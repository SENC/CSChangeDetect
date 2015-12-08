install.packages("rasterVis")

library(rasterVis) # Note: requires ggplot2
library(ggplot2)
library(raster)

r= raster (ncol=10,nrow=10,xmn=0,xmx=100,ymn=0,ymx=100)
projection(r) = "+proj=utm +zone=19 +datum=NAD83"
values(r)=seq(1:ncell(r))

gplot(pipelineImg2010) + geom_tile(aes(fill = value)) +
  scale_colour_brewer(palette="Blues") +
  coord_equal() + 
  geom_text(aes(label=sprintf("%02.0f", value)), colour='white',size=5)