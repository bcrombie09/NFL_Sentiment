# DS 4002, Fall 2023. Extract and Clean Reddit Comments from Given
# Dataset of URLs

# Retrieve Libraries
library(dplyr)
library(RedditExtractoR)
library(stringr)

# Read in data frame from saved csv
# NEED TO BE EDITED TO RUN ON INDIVIDUAL MACHINES
df <- read.csv("C:/Users/Brkea/Downloads/Reddit_Links.csv", header = 1)

# Create list to be used with RedditExtractoR
url_list <- as.list(df$Links)

# Run ExtractoR func
results <- get_thread_content(url_list)

# Remove threads portion of return
comments <- results[2]$comments

# Create new column (subreddit) and retrieve from URL column
comments$subreddit <- gsub(".*r/", "", comments$url)
comments$subreddit <- gsub("/.*", "", comments$subreddit)

# Begin cleaning data (remove whitespace)
comments$comment <- str_trim(comments$comment, side = "both")

# Remove non UTF-8 characters for next two lines
comments$comment <- gsub("[^[:alnum:][:blank:]?&/\\-]", "", comments$comment)
comments$comment <- gsub("U00..", "", comments$comment)

# Get time for potential time analysis ? IE Late at night more negative ?
comments$time <- as.POSIXct(comments$timestamp, origin = "1970-01-01")
comments$time <- format(comments$time, "%H:%M:%S")

# Remove unwanted columns
# THIS CAN BE EDITED, WAS DONE BY MY OWN (Brendan's) DISCRETION
comments <- subset(comments, select = -c(author, comment_id, golds, downvotes, upvotes, url))
  
# Save resulting dataframe to machine
# AGAIN, NEEDS TO BE EDITED FOR EACH PERSON
write.csv(comments, "C:/Users/Brkea/Downloads/Reddit_Data.csv")

df2 <- comments %>% group_by(subreddit) %>% summarise(comment_count = n())

