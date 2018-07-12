library(rvest)

web_data <- read_html("https://uae.souq.com/ae-en/samsung-32-inch-3d-full-hd-led-tv-32f6400-5634017/i/")

review <- html_nodes(web_data, "#reviews p ")
review

reviews <- html_text(review)
reviews
df<-data.frame(reviews, stringsAsFactors = FALSE)
df

write.table(df,file="rikteshsouq.txt",append=TRUE,row.names = FALSE)

