
#library(downloader)
library(plyr);
library(dplyr)
library(knitr)
library(tm)
library(stringi)
library(RWeka)
library(ggplot2)
library(slam)
library(SnowballC)
library(quanteda)
library(stringr)

options(mc.cores=1)


#path <- file.path("final" , "en_US")
#files<-list.files(path, recursive=TRUE)

## Read files

# Twitter
con <- file("final/en_US/en_US.twitter.txt", "r") 
Twitter<-readLines(con, skipNul = TRUE)
close(con)

# Blog
con <- file("final/en_US/en_US.blogs.txt", "r") 
Blogs<-readLines(con, skipNul = TRUE)
close(con)

# News
con <- file("final/en_US/en_US.news.txt", "r") 
News<-readLines(con, skipNul = TRUE)
close(con)


## Cleaning The Data

# Sample the data
set.seed(1234)
data_sample <- c(sample(Blogs, length(Blogs) * 0.02),
                 sample(News, length(News) * 0.02),
                 sample(Twitter, length(Twitter) * 0.02))

# Create corpus and clean the data
corpus <- VCorpus(VectorSource(data_sample))
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
corpus <- tm_map(corpus, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
corpus <- tm_map(corpus, toSpace, "@[^\\s]+")
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, PlainTextDocument)
unicorpus <- tm_map(corpus, removeWords, stopwords("en"))


## Exploratory Analysis

# Get word frequencies 
getFreq <- function(tdm) {
        freq <- sort(rowSums(as.matrix(tdm)), decreasing = TRUE)
        return(data.frame(word = names(freq), freq = freq))
}

# Prepare n-gram frequencies
getFreq <- function(tdm) {
        freq <- sort(rowSums(as.matrix(rollup(tdm, 2, FUN = sum)), na.rm = T), decreasing = TRUE)
        return(data.frame(word = names(freq), freq = freq))
}
bigram <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
trigram <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
quadgram <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))


# Get frequencies of most common n-grams in data sample
freq1 <- getFreq(removeSparseTerms(TermDocumentMatrix(unicorpus), 0.999))
saveRDS(freq1, file="freq1.RDS")
freq2 <- getFreq(TermDocumentMatrix(unicorpus, control = list(tokenize = bigram, bounds = list(global = c(5, Inf)))))
saveRDS(freq2, file="freq2.RDS")
freq3 <- getFreq(TermDocumentMatrix(corpus, control = list(tokenize = trigram, bounds = list(global = c(3, Inf)))))
save(freq3, file="freq3.RDS")
freq4 <- getFreq(TermDocumentMatrix(corpus, control = list(tokenize = quadgram, bounds = list(global = c(2, Inf)))))
saveRDS(freq4, file="freq4.RDS")

# convert files to frequence tables
# Bigrams
freq2 <- readRDS(freq2, file="freq2.RDS")
freq2 <- as.data.frame(freq2)
row.names(freq2) <- seq(nrow(freq2))
colnames(freq2) <- "token"
freq2$token <- as.character(freq2$token)
freq2$outcome <- word(freq2$token, -1)
freq2$variable <- word(string = freq2$token, start = 1, end = -2, sep = fixed(" "))
colnames(freq2) <- c("token","n","outcome","variable")
colorder <- c("outcome", "variable", "n")
freq2 <- freq2[,colorder]
saveRDS(freq2, file="freq2.rds")


# Trigrams
freq3 <- readRDS(freq3, file="freq3.RDS")
freq3 <- as.data.frame(freq3)
row.names(freq3) <- seq(nrow(freq3))
colnames(freq3) <- "token"
freq3$token <- as.character(freq3$token)
freq3$outcome <- word(freq3$token, -1)
freq3$variable <- word(string = freq3$token, start = 1, end = -2, sep = fixed(" "))
colnames(freq3) <- c("token","n","outcome","variable")
colorder <- c("outcome", "variable", "n")
freq3 <- freq3[,colorder]
saveRDS(freq3, file="freq3.rds")


# Fourgrams
freq4 <- readRDS(freq4, file="freq4.RDS")
freq4 <- as.data.frame(freq4)
row.names(freq4) <- seq(nrow(freq4))
colnames(freq4) <- "token"
freq4$token <- as.character(freq4$token)
freq4$outcome <- word(freq4$token, -1)
freq4$variable <- word(string = freq4$token, start = 1, end = -2, sep = fixed(" "))
colnames(freq4) <- c("token","n","outcome","variable")
colorder <- c("outcome", "variable", "n")
freq4 <- freq4[,colorder]
saveRDS(freq4, file="freq4.rds")




