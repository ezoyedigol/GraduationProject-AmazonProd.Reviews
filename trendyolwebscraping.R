install.packages("rvest")
library(rvest)
library(stringi)
library(stringr)
library(tidyverse)

link = "https://www.trendyol.com/sr?tag=kategori_encoksatanlar"  
trendyol = read_html(link)
#urun isimleri
product_name = trendyol %>% html_nodes(".prdct-desc-cntnr-name") %>% html_text() 

#urun fiyatlar??
product_prices = trendyol %>% html_nodes(".prc-box-dscntd") %>% html_text()
# Virg??lleri noktaya d??n????t??r
product_prices <- gsub(",", ".", product_prices)
# TL ibaresini kald??r
product_prices <- gsub(" TL", "", product_prices)
# numerik olarak ??evir
product_prices <- as.numeric(product_prices)

#urun markalar??
product_brands = trendyol %>% html_nodes(".prdct-desc-cntnr-ttl") %>% html_text() 

#urun resimleri
product_images <- trendyol %>% 
  html_nodes("img") %>%  
  html_attr("src") 

#yorumlar?? ??ekme
url <- "https://www.trendyol.com/smool/ingiliz-karbonati-1000-gr-icilebilir-katkisiz-dogal-food-grade-p-750018562/yorumlar?boutiqueId=61&merchantId=710576"
web_page <- read_html(url)

comments <- web_page %>%
  html_nodes(".comment .comment-text p") %>%
  html_text()
