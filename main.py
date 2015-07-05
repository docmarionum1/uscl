import sys, datetime
import pandas
import numpy as np

def prettyFormatSeconds(seconds):
    """
    Return a number of seconds formatted as HH:MM:SS

    Parameters
    ----------
    seconds : number

    Returns
    -------
    str
        The formatted string
    """
    return str(datetime.timedelta(seconds=round(seconds)))


def averageTripDuration(df):
    """
    Print the average trip duration.

    Parameters
    ----------
    df : DataFrame
        A DataFrame containing the 'tripduration' column

    """
    print "Average trip duration is %s" % prettyFormatSeconds(np.mean(df['tripduration']))

if __name__ == '__main__':
    df = pandas.read_csv(sys.argv[1])
    averageTripDuration(df)