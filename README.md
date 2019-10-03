# Data-Science-Capstone-Project
APP: NEXT WORD PREDICTION APP
Coursera - Data Science Specialization 
Date: 03.10.2019

Coursera Data Science Capstone Project:
The aim of the Coursera Data Science Specialization Capstone project from Johns Hopkins University (JHU)is to create a usable public data product that can show their skills to potential employers. 
Projects are drawn from real-world problems and are conducted with industry, government, and academic partners. 
In this part of course JHU is partnering with SwiftKey (https://swiftkey.com/) to apply data science in the area of natural language processing.

About the App:
An App has been created that is able to predict the next word given a sequence of words.
The prediction model has been built on texts from three sources, namely Blogs, News and Twitter.
The original english corpus comprised of over 580 MB of language information including over half a billion characters. 
A summary of the data and a first exploratory analysis are reported in  the "Capstone Milestone Report"

The next word prediction app usesg N-gram models based on "Stupid Backoff" algorithm (Brants et al 2007);
First the last 3 words are matched using 4-gram; If no matches are found,3-grams and 2-grams are used to predict the next word.

Using the App:
Just wirte some text in the input box (text is not case sensitive!), and the 3 next words with the highest probability will be displayed. If no match, "null" will be displayed

Please note that this App has only been developed for demonstration purposes. The App is fast, but the accuracy is limited, because the model has been trained only on 2% of the data. 
Moreover the tails of the n-grams have been cut to increase processing speed. This may lead to no matches for specific words.
