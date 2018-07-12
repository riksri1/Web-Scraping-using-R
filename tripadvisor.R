library(rvest)

web_data <- read_html("https://www.tripadvisor.com/Hotel_Review-g295424-d302462-Reviews-Jumeirah_Beach_Hotel-Dubai_Emirate_of_Dubai.html")

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
write.table(df,file="riktesh.txt",append=TRUE,row.names = FALSE)

offset=0


for (i in 1:npages)
{
  web_data <- paste0("https://www.tripadvisor.com/Hotel_Review-g295424-d302462-Reviews-or",offset,"-Jumeirah_Beach_Hotel-Dubai_Emirate_of_Dubai.html")
  web_data <- read_html(web_data)
  review <- html_nodes(web_data, "#REVIEWS .entry .partial_entry")
  reviews <- html_text(review)
  
  
  df<-data.frame(reviews, stringsAsFactors = FALSE)
  df
  write.csv(df, "riktesh.csv",append=TRUE,row.names = FALSE)
  #write.table(df,file="riktesh.txt",append=TRUE,row.names = FALSE)
  offset <- offset + 5
}
