#List Of Packages Used
library(RColorBrewer) 
library(tm)
library(twitteR)
library(ROAuth)
library(plyr)
library(stringr)
library(base64enc)
library(SnowballC)
library(ggplot2)

library(maps)


consumerKey <- "waBr4IahpZM5n51AqP1Mmw3Fl"
consumerSecret <- "fumvQLQNbtYgNZqZTT3orYrn86NV9FpnCIFIbUiroKgsoMjkgO"
accessToken <- "123191143-kL4e0MFc7hhcDpSibhHUNgpqNWZ9pKfEW8RhkCuy"
accessTokenSecret <- "HoZG076gm30SzIX9l5uda8cnhGUwih1Miv2ovWX9lZoEX"


setup_twitter_oauth(consumerKey,consumerSecret,accessToken,accessTokenSecret)

#search TWitter
users<- searchTwitteR("#sharjah", resultType="recent",n=3000, lang="en")
#Converting into Dataframe 
tweet.df = do.call("rbind",lapply(users,as.data.frame))

#Viewing the data


#Reading sentiment analysis data from Txt document
pos.words = scan('positive-words.txt', what='character', comment.char=';')
neg.words = scan('negative-words.txt', what='character', comment.char=';')

#Appending some more words to actual words
pos.words = c(pos.words, 'new','nice' ,'good', 'horizon')
neg.words = c(neg.words, 'wtf', 'behind','feels', 'ugly', 'back','worse' , 'shitty', 'bad', 'no','freaking','sucks','horrible')

#converting Into dataFrame
test <-ldply(users,function(t)t$toDataFrame())

#sentiment score
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    sentence = tolower(sentence)
    word.list = str_split(sentence, '\\s+')
    words = unlist(word.list)
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    score <- sum(pos.matches) - sum(neg.matches)
    return(score)
  }, pos.words, neg.words, .progress=.progress )
  
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}


#calcuating result
result <- score.sentiment(test$text,pos.words,neg.words)

write.csv(result, file = "MyData.csv",row.names=FALSE)



#summarlizing data
summary(result$score)

#Histogram
hist(result$score,col="yellow", main="Score of tweets",ylab=" Count of tweets")

#Count No of Tweets
count(result$score)

#ploting the tweets on qplot
qplot(result$score,xlab = "Score of tweets")

#score Sentiment function 
#Used to remove all unwanted data 


