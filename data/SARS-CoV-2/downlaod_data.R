library(GISAIDR)
library(tidyverse)

username = Sys.getenv("GISAIDR_USERNAME")
password = Sys.getenv("GISAIDR_PASSWORD")

credentials <- login(username = username, password = password)

meta_data <- read.csv("./metadata.csv")

full_df <-
  download(
    credentials = credentials,
    list_of_accession_ids = meta_data$GISAID_ID,
    get_sequence = T
  )
full_df$date <- as.Date(full_df$date)
full_df$date_submitted <- as.Date(full_df$date_submitted)

date_submitted_p <- full_df %>%
  ggplot(aes(x = date_submitted)) +
  geom_bar(aes(y = cumsum(..count..)),
           fill = "#69b3a2",
           color = "#e9ecef",
           alpha = 0.8) +
  labs(title = "Date Submitted")

date_collected_p <- full_df %>%
  ggplot(aes(x = date)) +
  geom_bar(aes(y = cumsum(..count..)),
           fill = "#69b3a2",
           color = "#e9ecef",
           alpha = 0.8) +
  labs(title = "Date Collected")

p <-
  gridExtra::grid.arrange(date_collected_p, date_submitted_p, ncol = 2)

ggsave('seamann_VIC.png', plot = p)

export_fasta(full_df, "SARS-CoV-2-VIC.fasta", delimiter = "|")

# sdf <- split(full_df, full_df$date_submitted)
# lapply(names(sdf),
#        function(x) {
#          export_fasta(sdf[[x]], paste0("submitted/", x, ".fasta"), delimiter = "|")
#        })
