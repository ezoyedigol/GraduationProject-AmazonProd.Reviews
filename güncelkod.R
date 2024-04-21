library(rvest)
library(ggplot2)
library(tidytext)
library(tm)

# Amazon ürün sayfasının URL'si
url <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews"

# Sayfanın HTML içeriği
web_page <- read_html(url)

# Yorumların bulunduğu HTML etiketinin XPath'i 
review_xpath <- '//*[contains(concat( " ", @class, " " ), concat( " ", "review-text-content", " " ))]//span'

# Yorumları içeren HTML etiketleri
reviews <- web_page %>% html_nodes(xpath = review_xpath) %>% html_text()

Sys.setlocale("LC_ALL", "Turkish")

# İlk sayfa URL'si
url_page1 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews"
# İkinci sayfa URL'si
url_page2 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=2"
# Üçüncü sayfa URL'si
url_page3 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_3?ie=UTF8&reviewerType=all_reviews&pageNumber=3"
# Dördüncü sayfa URL'si
url_page4 <-  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_4?ie=UTF8&reviewerType=all_reviews&pageNumber=4"

# Beşinci sayfa URL'si
url_page5 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_5?ie=UTF8&reviewerType=all_reviews&pageNumber=5"
# Altıncı sayfa URL'si
url_page6 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_6?ie=UTF8&reviewerType=all_reviews&pageNumber=6"

#Yedinci sayfa URL'si
url_page7 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_7?ie=UTF8&reviewerType=all_reviews&pageNumber=7"

web_page1 <- read_html(url_page1)
web_page2 <- read_html(url_page2)
web_page3 <- read_html(url_page3)
web_page4 <- read_html(url_page4)
web_page5 <- read_html(url_page5)
web_page6 <- read_html(url_page6)
web_page7 <- read_html(url_page7)

# Yorumların XPath'i
review_xpath <- '//*[contains(concat( " ", @class, " " ), concat( " ", "review-text-content", " " ))]//span'

# İlk sayfa yorumları
reviews_page1 <- web_page1 %>% html_nodes(xpath = review_xpath) %>% html_text()

# İkinci sayfa yorumları
reviews_page2 <- web_page2 %>% html_nodes(xpath = review_xpath) %>% html_text()

# Üçüncü sayfa yorumları
reviews_page3 <- web_page3 %>% html_nodes(xpath = review_xpath) %>% html_text()

# Dördüncü sayfa yorumları
reviews_page4 <- web_page4 %>% html_nodes(xpath = review_xpath) %>% html_text()

# Beşinci sayfa yorumları
reviews_page5 <- web_page5 %>% html_nodes(xpath = review_xpath) %>% html_text()

#Altıncı sayfa yorumları 
reviews_page6 <- web_page6 %>% html_nodes(xpath = review_xpath) %>% html_text()

#Yedinci sayfa yorumları
reviews_page7 <- web_page7 %>% html_nodes(xpath = review_xpath) %>% html_text()

# İlk 10 yorum
first_10_reviews <- head(reviews_page1, 10)

# İkinci 10 yorum
second_10_reviews <- head(reviews_page2, 10)

# Üçüncü 10 yorum
third_10_reviews <- head(reviews_page3, 10)

# Dördüncü 10 yorum
fourth_10_reviews <- head(reviews_page4, 10)

# Beşinci 10 yorum
fifth_10_reviews <- head(reviews_page5, 10)

#Altıncı 10 yorum
sixth_10_reviews <- head(reviews_page6, 10)

#Yedinci 10 yorum
seventh_10_reviews <- head(reviews_page7, 10)

# Toplam 50 yorumu birleştir
total_reviews <- c(first_10_reviews, second_10_reviews, third_10_reviews, fourth_10_reviews, fifth_10_reviews, sixth_10_reviews, seventh_10_reviews)

# Toplam yorumları bir veri çerçevesine dönüştür
reviews_df <- data.frame(Reviews = total_reviews)

#Ratingsleri çekme
ratings <- web_page %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# İlk sayfa 
star_ratings_page1 <- web_page1 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# İkinci sayfa
star_ratings_page2 <- web_page2 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# Yıldız değerlendirmelerini alt alta yazdır
cat(star_ratings_page2, sep = "\n")

# Üçüncü sayfa 
star_ratings_page3 <- web_page3 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# Dördüncü sayfa 
star_ratings_page4 <- web_page4 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# Beşinci sayfa 
star_ratings_page5 <- web_page5 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

#Altıncı Sayfa
star_ratings_page6 <- web_page6 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

#Yedinci Sayfa
star_ratings_page7 <- web_page7 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# Toplam 50 yıldız değerlendirmesi
total_star_ratings <- c(star_ratings_page1, star_ratings_page2, star_ratings_page3, star_ratings_page4, star_ratings_page5, star_ratings_page6, star_ratings_page7)

# Toplam yorumlar ve yıldız değerlendirmelerini bir veri çerçevesi
reviews_df <- data.frame(Reviews = total_reviews, Star_Ratings = total_star_ratings)



#PARALEL PAKET İLE VERİ KAZIMA
install.packages("parallel")
library(parallel)
library(httr)
library(rvest)

# Amazon ürün sayfasının URL'si
url <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews"
web_page <- read_html(url)

# İşlemcilerin sayısı
num_cores <- detectCores()

# Paralel işlem 
scrape_page <- function(url) {
  web_page <- read_html(url)
  reviews <- html_text(web_page %>% html_nodes(".review-text-content span"))
  star_ratings <- html_text2(web_page %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base"))
  return(data.frame(Reviews = reviews, Star_Ratings = star_ratings))
}

# Paralel işlem yapılacak sayfa URL'leri
urls <- c(
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=2",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_3?ie=UTF8&reviewerType=all_reviews&pageNumber=3",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_4?ie=UTF8&reviewerType=all_reviews&pageNumber=4",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_5?ie=UTF8&reviewerType=all_reviews&pageNumber=5",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_6?ie=UTF8&reviewerType=all_reviews&pageNumber=6",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_7?ie=UTF8&reviewerType=all_reviews&pageNumber=7"
)

# Paralel işlemle veri çekme
cluster <- makeCluster(num_cores)
clusterEvalQ(cluster, {
  library(rvest)
})
reviews_data <- parLapply(cluster, urls, scrape_page)
stopCluster(cluster)

# Toplam veriyi birleştir
reviews_df <- do.call(rbind, reviews_data)



#WORDCLOUD PAKETİ İLE KELİME BULUTU OLUŞTURMA
# Paketlerin yüklenmesi
library(wordcloud)  # Kelime bulutları oluşturmak için gerekli paket
library(wordcloud2) # Kelime bulutları oluşturmak için gerekli paket (wordcloud'ın geliştirilmiş sürümü)
library(tm)         # Metin madenciliği işlemleri için gerekli paket


# Metin belgesi koleksiyonunu oluşturma
corpus <- VCorpus(VectorSource(reviews_df$Reviews))

# Metin belgelerini ön işleme adımlarından geçirip temizleme
corpus <- tm_map(corpus, content_transformer(tolower))        # Metni küçük harfe dönüştürme
corpus <- tm_map(corpus, removeNumbers)                      # Sayıları kaldırma
corpus <- tm_map(corpus, removePunctuation)                  # Noktalama işaretlerini kaldırma
corpus <- tm_map(corpus, removeWords, stopwords("en"))        # İngilizce durak kelimelerini kaldırma
corpus <- tm_map(corpus, stripWhitespace)                    # Boşlukları kaldırma

# Metin belgelerini ön işleme adımlarından geçirme
corpus <- tm_map(corpus, removeWords, c("ürün")) # "ürün" kelimesini kaldırma
corpus <- tm_map(corpus, removeWords, c("gibi"))
corpus <- tm_map(corpus, removeWords, c("bir"))

# Metin belgelerini bir belge terim matrisine dönüştürme
dtm <- DocumentTermMatrix(corpus)

# BİRİNCİ YOL: Kelime frekanslarını hesaplayarak, sonrasında bir kelime bulutu oluşturma
word_freq <- colSums(as.matrix(dtm))
word_freq_df <- as.data.frame(sort(word_freq, decreasing = TRUE))
colnames(word_freq_df) <- 'freq'
word_freq_df$word <- rownames(word_freq_df)
word_freq_df <- word_freq_df[c("word", "freq")]

#İKİNCİ YOL: wordcloud2 paketi ile bir kelime bulutu oluşturma
wordcloud2(word_freq_df, size = .5)
custom_palette <- rep("#3498DB", length(unique(words)))
wordcloud2(word_freq_df, size = .5, color = custom_palette, fontFamily = "Arial")
