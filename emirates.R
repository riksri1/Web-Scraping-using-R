library(rvest)

web_data <- read_html("http://www.airlinequality.com/airline-reviews/emirates/")

review <- html_nodes(web_data, ".text_content")
review

reviews <- html_text(review)
reviews
df<-data.frame(reviews, stringsAsFactors = FALSE)
df

write.table(df,file="emirates.txt",append=TRUE,row.names = FALSE)

offset=2

for (i in 2:157)
{
  web_data <- paste0("http://www.airlinequality.com/airline-reviews/emirates/page/",offset,"/")
  web_data <- read_html(web_data)
  review <- html_nodes(web_data, ".text_content")
  reviews <- html_text(review)
  
  
  df<-data.frame(reviews, stringsAsFactors = FALSE)
  df
  #write.csv(df, "riktesh.csv",append=TRUE,row.names = FALSE)
  write.table(df,file="emirates.txt",append=TRUE,row.names = FALSE)
  offset <- offset + 1
}
#http://www.airlinequality.com/airline-reviews/emirates/page/157/