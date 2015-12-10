### Data preparation
require(readr)
require(dplyr)
require(tidyr)
require(ggplot2)
original_data = read_delim("http://www.maths.usyd.edu.au/u/gartht/Brauer2008_DataSet1.tds", delim = "\t")
cleaned_data = original_data %>%
  separate(NAME, 
           c("name", "BP", "MF", "systematic_name", "number"), 
           sep = "\\|\\|") %>%
  mutate_each(funs(trimws), name:systematic_name) %>%
  select(-number, -GID, -YORF, -GWEIGHT)  %>%
  gather(sample, expression, G0.05:U0.3) %>%
  separate(sample, c("nutrient", "rate"), sep = 1, convert = TRUE)