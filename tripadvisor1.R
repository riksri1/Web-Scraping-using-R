library(rvest)
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


url <- "https://www.tripadvisor.com/Attraction_Review-g42881-d109972-Reviews-Mall_of_America-Bloomington_Minnesota.html"

webpage <- read_html(url)

#Using CSS selectors to scrap the rankings section
review_data_html <- html_nodes(webpage,'.partial_entry')

#Converting the ranking data to text
review_data <- html_text(review_data_html)

#Let's have a look at the rankings
head(review_data)

for ( i in 1:437){
  url<-paste("https://www.tripadvisor.com/Attraction_Review-g42881-d109972-Reviews-or",(i*10), "-Mall_of_America-Bloomington_Minnesota.html",sep="")
  webpage <- read_html(url)
  review_data_html <- html_nodes(webpage,'.partial_entry')
  review_data_int <- html_text(review_data_html)
  review_data<-append(review_data, review_data_int, after = length(review_data))
  
}

review_data

