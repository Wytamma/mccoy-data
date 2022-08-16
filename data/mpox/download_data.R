username <- Sys.getenv("GISAIDR_USERNAME")
password <- Sys.getenv("GISAIDR_PASSWORD")

credentials <- GISAIDR::login(username = username, password = password, database="EpiPox")

df <- read.csv("mpox_ids.csv")

full_df <- GISAIDR::download(credentials = credentials, list_of_accession_ids = df$accession_id, get_sequence=TRUE)

GISAIDR::export_fasta(full_df, 'mpox.fasta', date_format="%Y-%m-%d")