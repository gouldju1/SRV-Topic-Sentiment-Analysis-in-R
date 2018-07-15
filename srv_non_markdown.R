## Required Packages
#install.packages("tm")
#install.packages("topicmodels")
#install.packages("sentimentr")
#install.packages("wordcloud")
#install.packages("sqldf")
#install.packages("SnowballC")
#install.packages("RColorBrewer")
#install.packages("ggplot2")
library(tm)
library(topicmodels)
library(sentimentr)
library(wordcloud)
library(sqldf)
library(SnowballC)
library(RColorBrewer)
library(ggplot2)

## Topic Modeling

#Loading the individual song txt files into corpus
setwd("C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R")
filenames = list.files(getwd(),pattern="*.txt")
files = lapply(filenames,readLines)
documents = Corpus(VectorSource(files))

#Creating the document-term matrix
#Remove punctuation
documents = tm_map(documents, removePunctuation)
#Text to lower case
documents = tm_map(documents,content_transformer(tolower))
#Eliminate digits
documents = tm_map(documents, removeNumbers)
#Remove stopwords from standard stopword list 
documents = tm_map(documents, removeWords, stopwords("english"))
#Create document-term matrix
dtm = DocumentTermMatrix(documents)
rownames(dtm) = filenames
dtm

#Run LDA to find topics in text (since I am using top 5 songs, I will use 5 topics)
burnin = 1000
iter = 2000
thin = 500
nstart = 5
seed = list(365783, 210, 233998, 256730148, 3)
best = TRUE
k = 5
ldaOut = LDA(dtm, k, method = "Gibbs", control = list(nstart = nstart, seed = seed, best = best, burnin = burnin, iter = iter, thin = thin))

# Reviewing the Topics from the LDA

#Review the top 4 terms for each of the 5 topics from LDA
terms(ldaOut,4)

# Assigning Topics to Documents

topics(ldaOut)

## Sentiment Analysis

#Loading the csv containing all lyrics, aggregated at sentence-level, by song title
lyrics = read.csv("C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R\\lyrics.csv", header = T, sep = ",")
lyrics$title = as.character(lyrics$title)
lyrics$text = as.character(lyrics$text)
lyrics$rowNum = 1:nrow(lyrics)

#Running the sentiment analysis
textSen = data.frame(sentiment(lyrics$text))

#JOINing the sentiment scores ON the lyrics data.frame
lyrics = sqldf("SELECT lyrics.*, textSen.word_count AS word_count, textSen.sentiment AS sentiment FROM lyrics, textSen WHERE lyrics.rowNum = textSen.element_id")
lyrics$rowNum = NULL

#Average sentiment score aggregated by song
avgScore = sqldf("SELECT title, avg(sentiment) AS avgSentiment, sum(word_count) AS total_words FROM lyrics GROUP BY title")
avgScore
lyrics
write.csv(lyrics, "C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R\\lyricsSENTIMENT.csv")

## Relationship between word_count and sentiment

lyrics$title = as.factor(lyrics$title)
myColors = brewer.pal(5,"Set1")
names(myColors) = levels(lyrics$title)
colScale <- scale_colour_manual(name = "title",values = myColors)
j = ggplot(lyrics, aes(word_count, sentiment, colour = title))
wordCountSen = j + geom_point() + labs(x = "Word Count", y = "Sentiment Score", title = "Sentiment Score by Sentence Word Count") + scale_x_continuous(breaks = seq(1,15,1))
wordCountSen

# Word Clouds

## Pride and Joy

#Import the lyrics
filenames = list("C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R\\prideAndJoy.txt")
files = lapply(filenames,readLines)
documents = Corpus(VectorSource(files))

#Preprocessing/preparing the data
#Convert the text to lower case
documents = tm_map(documents, content_transformer(tolower))
#Remove numbers
documents = tm_map(documents, removeNumbers)
#Remove english common stopwords
documents = tm_map(documents, removeWords, stopwords("english"))
#Remove punctuation
documents <- tm_map(documents, removePunctuation)

#Document term matrix creation
dtm = TermDocumentMatrix(documents)
m = as.matrix(dtm)
v = sort(rowSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)

#Build the word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8, "Dark2"))

## Little Wing

#Import the lyrics
filenames = list("C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R\\littleWing.txt")
files = lapply(filenames,readLines)
documents = Corpus(VectorSource(files))

#Preprocessing/preparing the data
#Convert the text to lower case
documents = tm_map(documents, content_transformer(tolower))
#Remove numbers
documents = tm_map(documents, removeNumbers)
#Remove english common stopwords
documents = tm_map(documents, removeWords, stopwords("english"))
#Remove punctuation
documents <- tm_map(documents, removePunctuation)

#Document term matrix creation
dtm = TermDocumentMatrix(documents)
m = as.matrix(dtm)
v = sort(rowSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)

#Build the word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8, "Dark2"))

## Mary Had a Little Lamb

#Import the lyrics
filenames = list("C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R\\maryHadALittleLamb.txt")
files = lapply(filenames,readLines)
documents = Corpus(VectorSource(files))

#Preprocessing/preparing the data
#Convert the text to lower case
documents = tm_map(documents, content_transformer(tolower))
#Remove numbers
documents = tm_map(documents, removeNumbers)
#Remove english common stopwords
documents = tm_map(documents, removeWords, stopwords("english"))
#Remove punctuation
documents <- tm_map(documents, removePunctuation)

#Document term matrix creation
dtm = TermDocumentMatrix(documents)
m = as.matrix(dtm)
v = sort(rowSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)

#Build the word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8, "Dark2"))

## Texas Flood

#Import the lyrics
filenames = list("C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R\\texasFlood.txt")
files = lapply(filenames,readLines)
documents = Corpus(VectorSource(files))

#Preprocessing/preparing the data
#Convert the text to lower case
documents = tm_map(documents, content_transformer(tolower))
#Remove numbers
documents = tm_map(documents, removeNumbers)
#Remove english common stopwords
documents = tm_map(documents, removeWords, stopwords("english"))
#Remove punctuation
documents <- tm_map(documents, removePunctuation)

#Document term matrix creation
dtm = TermDocumentMatrix(documents)
m = as.matrix(dtm)
v = sort(rowSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)

#Build the word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8, "Dark2"))

## Tin Pan Alley (AKA Roughest Place in Town)

#Import the lyrics
filenames = list("C:\\Users\\gould\\Documents\\Developer\\SRV-Topic-Sentiment-Analysis-in-R\\tinPanAlley.txt")
files = lapply(filenames,readLines)
documents = Corpus(VectorSource(files))

#Preprocessing/preparing the data
#Convert the text to lower case
documents = tm_map(documents, content_transformer(tolower))
#Remove numbers
documents = tm_map(documents, removeNumbers)
#Remove english common stopwords
documents = tm_map(documents, removeWords, stopwords("english"))
#Remove punctuation
documents <- tm_map(documents, removePunctuation)

#Document term matrix creation
dtm = TermDocumentMatrix(documents)
m = as.matrix(dtm)
v = sort(rowSums(m), decreasing = TRUE)
d = data.frame(word = names(v), freq = v)

#Build the word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, colors = brewer.pal(8, "Dark2"))