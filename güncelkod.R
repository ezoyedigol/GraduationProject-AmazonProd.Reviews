library(rvest)
library(ggplot2)
library(tidytext)
library(tm)

# Amazon ??r??n sayfas??n??n URL'si
url <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews"

# Sayfan??n HTML i??eri??i
web_page <- read_html(url)

# Yorumlar??n bulundu??u HTML etiketinin XPath'i 
review_xpath <- '//*[contains(concat( " ", @class, " " ), concat( " ", "review-text-content", " " ))]//span'

# Yorumlar?? i??eren HTML etiketleri
reviews <- web_page %>% html_nodes(xpath = review_xpath) %>% html_text()

Sys.setlocale("LC_ALL", "Turkish")


# ??lk sayfa URL'si
url_page1 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews"
# ??kinci sayfa URL'si
url_page2 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=2"
# ??????nc?? sayfa URL'si
url_page3 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_3?ie=UTF8&reviewerType=all_reviews&pageNumber=3"
# D??rd??nc?? sayfa URL'si
url_page4 <-  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_4?ie=UTF8&reviewerType=all_reviews&pageNumber=4"

# Be??inci sayfa URL'si
url_page5 <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_5?ie=UTF8&reviewerType=all_reviews&pageNumber=5"
# Alt??nc?? sayfa URL'si
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

# Yorumlar??n XPath'i
review_xpath <- '//*[contains(concat( " ", @class, " " ), concat( " ", "review-text-content", " " ))]//span'

# ??lk sayfa yorumlar??
reviews_page1 <- web_page1 %>% html_nodes(xpath = review_xpath) %>% html_text()

# ??kinci sayfa yorumlar??
reviews_page2 <- web_page2 %>% html_nodes(xpath = review_xpath) %>% html_text()

# ??????nc?? sayfa yorumlar??
reviews_page3 <- web_page3 %>% html_nodes(xpath = review_xpath) %>% html_text()

# D??rd??nc?? sayfa yorumlar??
reviews_page4 <- web_page4 %>% html_nodes(xpath = review_xpath) %>% html_text()

# Be??inci sayfa yorumlar??
reviews_page5 <- web_page5 %>% html_nodes(xpath = review_xpath) %>% html_text()

#Alt??nc?? sayfa yorumlar?? 
reviews_page6 <- web_page6 %>% html_nodes(xpath = review_xpath) %>% html_text()

#Yedinci sayfa yorumlar??
reviews_page7 <- web_page7 %>% html_nodes(xpath = review_xpath) %>% html_text()

# ??lk 10 yorum
first_10_reviews <- head(reviews_page1, 10)

# ??kinci 10 yorum
second_10_reviews <- head(reviews_page2, 10)

# ??????nc?? 10 yorum
third_10_reviews <- head(reviews_page3, 10)

# D??rd??nc?? 10 yorum
fourth_10_reviews <- head(reviews_page4, 10)

# Be??inci 10 yorum
fifth_10_reviews <- head(reviews_page5, 10)

#Alt??nc?? 10 yorum
sixth_10_reviews <- head(reviews_page6, 10)

#Yedinci 10 yorum
seventh_10_reviews <- head(reviews_page7, 10)

# Toplam 50 yorumu birle??tir
total_reviews <- c(first_10_reviews, second_10_reviews, third_10_reviews, fourth_10_reviews, fifth_10_reviews, sixth_10_reviews, seventh_10_reviews)

# Toplam yorumlar?? bir veri ??er??evesine d??n????t??r
reviews_df <- data.frame(Reviews = total_reviews)

#Ratingsleri ??ekme
ratings <- web_page %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# ??lk sayfa 
star_ratings_page1 <- web_page1 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# ??kinci sayfa
star_ratings_page2 <- web_page2 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# Y??ld??z de??erlendirmelerini alt alta yazd??r
cat(star_ratings_page2, sep = "\n")

# ??????nc?? sayfa 
star_ratings_page3 <- web_page3 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# D??rd??nc?? sayfa 
star_ratings_page4 <- web_page4 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# Be??inci sayfa 
star_ratings_page5 <- web_page5 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

#Alt??nc?? Sayfa
star_ratings_page6 <- web_page6 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

#Yedinci Sayfa
star_ratings_page7 <- web_page7 %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base") %>% html_text2()

# Toplam 50 y??ld??z de??erlendirmesi
total_star_ratings <- c(star_ratings_page1, star_ratings_page2, star_ratings_page3, star_ratings_page4, star_ratings_page5, star_ratings_page6, star_ratings_page7)

# Toplam yorumlar?? ve y??ld??z de??erlendirmelerini bir veri ??er??evesi
reviews_df <- data.frame(Reviews = total_reviews, Star_Ratings = total_star_ratings)



#PARALEL PAKET ??LE VER?? KAZIMA
install.packages("parallel")
library(parallel)
library(httr)
library(rvest)

# Amazon ??r??n sayfas??n??n URL'si
url <- "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews"
web_page <- read_html(url)

# ????lemcilerin say??s??
num_cores <- detectCores()

# Paralel i??lem 
scrape_page <- function(url) {
  web_page <- read_html(url)
  reviews <- html_text(web_page %>% html_nodes(".review-text-content span"))
  star_ratings <- html_text2(web_page %>% html_nodes("a.a-color-base, a:link.a-color-base, a:visited.a-color-base"))
  return(data.frame(Reviews = reviews, Star_Ratings = star_ratings))
}

# Paralel i??lem yap??lacak sayfa URL'leri
urls <- c(
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_arp_d_paging_btm_next_2?ie=UTF8&reviewerType=all_reviews&pageNumber=2",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_3?ie=UTF8&reviewerType=all_reviews&pageNumber=3",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_4?ie=UTF8&reviewerType=all_reviews&pageNumber=4",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_5?ie=UTF8&reviewerType=all_reviews&pageNumber=5",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_6?ie=UTF8&reviewerType=all_reviews&pageNumber=6",
  "https://www.amazon.com.tr/Stanley-Klasik-Vakumlu-Termos-1-9/product-reviews/B07PBN67YJ/ref=cm_cr_getr_d_paging_btm_next_7?ie=UTF8&reviewerType=all_reviews&pageNumber=7"
)

# Paralel i??lemle veri ??ekme
cluster <- makeCluster(num_cores)
clusterEvalQ(cluster, {
  library(rvest)
})
reviews_data <- parLapply(cluster, urls, scrape_page)
stopCluster(cluster)

# Toplam veriyi birle??tir
reviews_df <- do.call(rbind, reviews_data)



#WORDCLOUD PAKET?? ??LE KEL??ME BULUTU OLU??TURMA
# Paketlerin y??klenmesi
library(wordcloud)  # Kelime bulutlar?? olu??turmak i??in gerekli paket
library(wordcloud2) # Kelime bulutlar?? olu??turmak i??in gerekli paket (wordcloud'??n geli??tirilmi?? s??r??m??)
library(tm)         # Metin madencili??i i??lemleri i??in gerekli paket


# Metin belgesi koleksiyonunu olu??turma
corpus <- VCorpus(VectorSource(reviews_df$Reviews))

# Metin belgelerini ??n i??leme ad??mlar??ndan ge??irip temizleme
corpus <- tm_map(corpus, content_transformer(tolower))        # Metni k??????k harfe d??n????t??rme
corpus <- tm_map(corpus, removeNumbers)                      # Say??lar?? kald??rma
corpus <- tm_map(corpus, removePunctuation)                  # Noktalama i??aretlerini kald??rma
corpus <- tm_map(corpus, removeWords, stopwords("en"))        # ??ngilizce durak kelimelerini kald??rma
corpus <- tm_map(corpus, stripWhitespace)                    # Bo??luklar?? kald??rma

# Metin belgesini ??n i??leme ad??mlar??ndan ge??irme
corpus <- tm_map(corpus, removeWords, c("??r??n")) # "??r??n" kelimesini kald??rma
corpus <- tm_map(corpus, removeWords, c("gibi"))
corpus <- tm_map(corpus, removeWords, c("bir"))

# Metin belgelerini bir belge terim matrisine d??n????t??rme
dtm <- DocumentTermMatrix(corpus)

# B??R??NC?? YOL: Kelime frekanslar??n?? hesaplayarak, sonras??nda bir kelime bulutu olu??turma
word_freq <- colSums(as.matrix(dtm))
word_freq_df <- as.data.frame(sort(word_freq, decreasing = TRUE))
colnames(word_freq_df) <- 'freq'
word_freq_df$word <- rownames(word_freq_df)
word_freq_df <- word_freq_df[c("word", "freq")]

#??K??NC?? YOL: wordcloud2 paketi ile bir kelime bulutu olu??turma
wordcloud2(word_freq_df, size = .5)
custom_palette <- rep("#3498DB", length(unique(words)))
wordcloud2(word_freq_df, size = .5, color = custom_palette, fontFamily = "Arial")