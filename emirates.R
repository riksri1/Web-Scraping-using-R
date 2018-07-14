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

#tripadvisor
web_data <- read_html("https://www.tripadvisor.in/Airline_Review-d8729069-Reviews-Emirates")

npages<-web_data%>% 
  html_nodes(" .pageNum ") %>% 
  html_attr(name="data-page-number") %>%
  tail(.,1) %>%
  as.numeric()
npages

review <- html_nodes(web_data, "#REVIEWS .entry .partial_entry")
reviews <- html_text(review)


df<-data.frame(reviews, stringsAsFactors = FALSE)
df
write.table(df,file="emirates.txt",append=TRUE,row.names = FALSE)

offset=0


for (i in 1:npages)
{
  web_data <- paste0("https://www.tripadvisor.in/Airline_Review-d8729069-Reviews-or",offset,"0-Emirates#REVIEWS")
  web_data <- read_html(web_data)
  review <- html_nodes(web_data, "#REVIEWS .entry .partial_entry")
  reviews <- html_text(review)
  
  
  df<-data.frame(reviews, stringsAsFactors = FALSE)
  df
  #write.csv(df, "riktesh.csv",append=TRUE,row.names = FALSE)
  write.table(df,file="emirates.txt",append=TRUE,row.names = FALSE)
  offset <- offset + 1
}

