library(rvest)

url <- "https://www.amazon.in/Lenovo-320E-15ISK-320E-15-6-inch-i3-6006U/product-reviews/B07CRGDR8L/ref=cm_cr_dp_d_show_all_btm?ie=UTF8&reviewerType=all_reviews"

webpage <- read_html(url)
webpage

get_numbers <- function(webpage) {
  pages_raw <- url %>%
    html_session() %>%
    html_nodes("#cm_cr-pagination_bar") %>%
    html_text() 
  
  pages <- ifelse(is.null(pages_raw), 0, pages_raw)
  return(pages)
} 
numbers_raw <- unlist(lapply(url, get_numbers))
numbers_raw
pages <- sub(".*Previous(.*?)Next.*", "\\1", numbers_raw) 
pages <- ifelse(grepl(".*\\.\\.\\.", pages), gsub(".*\\.\\.\\.","", pages), gsub(".*(.)$", "\\1", pages))
pages[is.na(pages)] <- 1
pages
pages <- as.numeric(pages)
pages
offset=0

for ( i in 1:pages)
{
  web_data <- paste0("https://www.amazon.in/Lenovo-320E-15ISK-320E-15-6-inch-i3-6006U/product-reviews/B07CRGDR8L/ref=cm_cr_othr_d_paging_btm_1?ie=UTF8&reviewerType=all_reviews&pageNumber=",offset)
  web_data <- read_html(web_data)
  review <- html_nodes(web_data, ".review-text")
  reviews <- html_text(review)
  
  
  df<-data.frame(reviews, stringsAsFactors = FALSE)
  df
  #write.csv(df, "riktesh.csv",append=TRUE,row.names = FALSE)
  write.table(df,file="amazon.txt",append=TRUE,row.names = FALSE)
  offset <- offset + 1
}

