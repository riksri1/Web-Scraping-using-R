library(rvest)
library(stringr)

web_data <- read_html("https://uae.souq.com/ae-en/jbl-flip-4-waterproof-portable-bluetooth-speaker-grey-jblflip4gryam-22217877/i/")

review <- html_nodes(web_data, ".show_reviews_number")
review

reviews <- html_text(review)
reviews
reviews <- str_replace_all(reviews, "[[:punct:]]", " ")
reviews <- as.numeric(reviews)
reviews

for (i in 1:reviews)
{
  review <- html_nodes(web_data, "#reviews p ")
  review
  
  reviews <- html_text(review)
  reviews
  df<-data.frame(reviews, stringsAsFactors = FALSE)
  df
  
  write.table(df,file="rikteshs.txt",append=TRUE,row.names = FALSE)
}
