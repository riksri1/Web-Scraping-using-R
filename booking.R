library(rvest)

web_data <- read_html("https://www.booking.com/hotel/in/la-casa.en-gb.html")

review <- html_nodes(web_data, ".hp-social_proof-item .hp-social_proof-quote_bubble")
review

reviews <- html_text(review)
reviews
df<-data.frame(reviews, stringsAsFactors = FALSE)
df

write.table(df,file="riktesh.txt",append=TRUE,row.names = FALSE)

