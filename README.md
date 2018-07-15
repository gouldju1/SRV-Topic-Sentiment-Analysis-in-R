### Topic and Sentiment Analyses of Top 5 Stevie Ray Vaughn Songs on Spotify

### Description

Exploring the capabilities of topic and sentiment analysis packages in R, I wanted to analyze the lyrics from the top 5 Stevie Ray Vaughn (SRV) songs, according to Spotify.

To perform these analyses, each song will be its own document, and I will be using sentence/phrase aggregation. Spotify notes that the following are SRV's top 5 songs:

1. Pride and Joy
2. Little Wing
3. Mary Had a Little Lamb
4. Texas Flood
5. Lenny

The first 4 of these songs have lyrics; however, "Lenny" does not. Therefore, I will use the #6 song, "Tin Pan Alley (AKA Roughest Place in Town)."

To compile the data, I use Excel and Notepad to copy and paste lyrics from the internet. In the Excel, for example, each phrase/sentence is an obersvation, identified by song title as the primary key of the table.

### Required Packages

The following packages are required to use the SRV topic and sentiment analysis code:

```
tm, wordcloud, sentimentr, topicmodels, SnowballC, RColorBrewer, sqldf, ggplot2
```

### Interpreting the Results

Please see the R Markdown file for code and analysis.

*The results of the analysis are located in the SRV_Analysis_RESULTS.pdf*