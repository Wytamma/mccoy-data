import argparse
from itertools import groupby
from datetime import datetime, timedelta
from pathlib import Path

from Bio import SeqIO

periods = {
    "day": "%Y-%m-%d",
    "week": "%Y-%W",
    "month": "%Y-%m",
}

def get_date_period(_id: str, period='day', format="%Y-%m-%d", delimiter="|", loc=-1):
    date_string = _id.split(delimiter)[loc]
    if format == 'decimal':
        dec_year = float(_id.split('|')[-1])
        year = int(dec_year)
        rem = dec_year - year
        base = datetime(year, 1, 1)
        date: datetime = base + timedelta(seconds=(base.replace(year=base.year + 1) - base).total_seconds() * rem)
    else:
        date = datetime.strptime(date_string, format)
    return date.strftime(periods[period])


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Group Fasta by time period.')
    parser.add_argument('FASTA', type=Path)
    parser.add_argument('--period', default='day', choices=['day', 'week', 'month'])
    parser.add_argument('--date-format', default='%Y-%m-%d')
    parser.add_argument('--delimiter', default='|')
    parser.add_argument('--location', default=-1, type=int)
    parser.add_argument('--cumulative', default=False, action='store_true')

    args = parser.parse_args()
    records = list(SeqIO.parse(args.FASTA, "fasta"))

    data = {}
    for k, g in groupby(records, lambda rec:get_date_period(
            rec.id, 
            period=args.period, 
            format=args.date_format, 
            delimiter=args.delimiter, 
            loc=args.location
        )):
        if not data.get(k, None):
            data[k] = list(g)
        else:
            data[k] = data[k] + list(g)

    dates = sorted(list(data.keys()))

    if args.cumulative:
        for i, k in enumerate(dates):
            l = []
            for date in dates[:i+1]:
                l += data[date]
        SeqIO.write(l, f"{date}.fasta", "fasta")
    else:
        for date in dates:
            SeqIO.write(data[date], f"{date}.fasta", "fasta")
    
