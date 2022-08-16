#!/home/wwirth/.conda/envs/GISAIDR/bin/Rscript --vanilla

library("optparse")
 
option_list = list(
    make_option(c("-f", "--from"), type="character", default=NULL, 
              help="search from specific submission date", metavar="character"),
    make_option(c("-t", "--to"), type="character", default=NULL, 
              help="search to specific submission date", metavar="character"),
    make_option(c("-o", "--out"), type="character", default="mpox.csv", 
              help="Output file name [default= %default]", metavar="character")
); 
 
opt_parser <- OptionParser(option_list=option_list);
opt <- parse_args(opt_parser);

username <- Sys.getenv("GISAIDR_USERNAME")
password <- Sys.getenv("GISAIDR_PASSWORD")

credentials <- GISAIDR::login(username = username, password = password, database="EpiPox")

df <- GISAIDR::query(
    credentials = credentials,
    from_subm = opt$from,
    to_subm = opt$to,
    fast = TRUE
)

full_df <- GISAIDR::download(credentials = credentials, list_of_accession_ids = df$accession_id, get_sequence=TRUE)

export_fasta(full_df, 'mpox.fasta', date_format="%Y-%m-%d")