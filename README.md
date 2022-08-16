# Datasets for testing McCoy

This repo contains data and scripts for testing realtime the realtime phylodynamics package McCoy. 

## process data into groups 

McCoy works with data collected overtime. To convert the datasets into time period grouped fasta files use the `group.py` script. 

```
python group.py data/Ebola/Full-EbolaTest-2015-42.fasta --period month
```

Use the `--date-format`, `--delimiter`, and `--location` to process other date formats. 

```
python group.py data/Influenza/InfluenzaAH3N2_HAgene_2009_California.fasta --date-format "%Y/%m/%d" --delimiter "_" --location -1 
```

Use `--date-format decimal` to parse decimal dates.

```
python group.py data/SARS-CoV-2/SARS-CoV-2-VIC.fasta --date-format decimal
```

Use `--cumulative` to create a cumulative dataset. 

```
python group.py data/Ebola/Full-EbolaTest-2015-42.fasta --period month --cumulative
```


### --help

```
usage: group.py [-h] [--period {day,week,month}] [--date-format DATE_FORMAT] [--delimiter DELIMITER] [--location LOCATION] [--cumulative] FASTA

Group Fasta by time period.

positional arguments:
  FASTA

optional arguments:
  -h, --help            show this help message and exit
  --period {day,week,month}
  --date-format DATE_FORMAT
  --delimiter DELIMITER
  --location LOCATION
  --cumulative
```