import sys, datetime
import pandas
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec

GENDER = {
    'Unknown':  0,
    'Male':     1,
    'Female':   2
}

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

def pieChart(gridLocation, sizes, labels, title):
    """
    Create a pie chart.

    Parameters
    ----------
    gridLocation : SubPlotSpec
        The location on the figure to place the pie chart.
    sizes : list of int
        The values to plot.
    labels : list of str
        The labels corresponding to the values in 'sizes'.
    title : str
        The title of for the pie chart.
    """
    ax = plt.subplot(gridLocation)
    ax.set_title(title)
    plt.pie(sizes, labels=labels, autopct='%1.1f%%')
    plt.axis('equal')

def plotGender(df, gridLocation):
    """
    Create a pie chart of the genders.

    Parameters
    ----------
    df : DataFrame
        A DataFrame containing the 'gender' column
    gridLocation : SubPlotSpec
        The location on the figure to place the pie chart.
    sizes : list of int
        The values to plot.
    labels : list of str
        The labels corresponding to the values in 'sizes'.
    title : str
        The title of for the pie chart.
    """
    sizes = np.bincount(df['gender'])
    labels = GENDER.keys()

    pieChart(gridLocation, sizes, labels, "Rides by Gender")


def plotType(df, gridLocation):
    """
    Create a pie chart of the user types.

    Parameters
    ----------
    df : DataFrame
        A DataFrame containing the 'usertype' column
    gridLocation : SubPlotSpec
        The location on the figure to place the pie chart.
    sizes : list of int
        The values to plot.
    labels : list of str
        The labels corresponding to the values in 'sizes'.
    title : str
        The title of for the pie chart.
    """
    labels = ['Customer', 'Subscriber']
    sizes = [(df['usertype'] == t).sum() for t in labels]

    pieChart(gridLocation, sizes, labels, "Rides by Rider Type")

if __name__ == '__main__':
    df = pandas.read_csv(sys.argv[1])
    averageTripDuration(df)

    grid = GridSpec(2, 2, wspace=1)
    plotGender(df, grid[0, 0])
    plotType(df, grid[0, 1])

    plt.show()