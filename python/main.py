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

TIME_FORMAT = '%Y-%m-%d %H:%M:%S'

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
    """
    labels = ['Customer', 'Subscriber']
    sizes = [(df['usertype'] == t).sum() for t in labels]

    pieChart(gridLocation, sizes, labels, "Rides by Rider Type")

def plotPercentageLine(df, ax, total, genderLabel, genderCode):
    """
    Plot a line graph on the gender/time plot.

    Parameters
    ----------
    df : DataFrame
        A DataFrame containing the columns 'gender', 'starttime' and 'tripduration'.
    ax : Axes
        The axes of the subplot where the line will be plotted.
    total : int[]
        An array of total number of rides per hour bin.
    genderLabel : str
        The Label for the gender.
    genderCode : int
        The numeric code representing the gender.

    Returns
    -------
    Plot
        The created plot.
    """
    bins = range(25)
    hist = np.histogram(df[df.gender == genderCode].apply(averageRideHour, axis=1), bins=bins)[0]
    return ax.plot(range(24), 100.*hist/total, label=genderLabel+"%")[0]


def plotTime(df, gridLocation):
    """
    Create a pie chart of the user types.

    Parameters
    ----------
    df : DataFrame
        A DataFrame containing the columns 'gender', 'starttime' and 'tripduration'.
    gridLocation : SubPlotSpec
        The location on the figure to place the chart.
    """
    #Get the total number of rides per hour
    bins = range(25)
    total = np.histogram(df.apply(averageRideHour, axis=1), bins=bins)[0]

    ax = plt.subplot(gridLocation)
    ax.set_title("Rider Gender Percentage by Time")

    #Plot the relative percentages for each gender
    lines = []
    for label, code in GENDER.iteritems():
        lines.append(plotPercentageLine(df, ax, total, label, code))

    plt.xticks(range(24))
    plt.xlim(0,23)
    plt.xlabel('Hour')
    plt.ylabel('Gender Percentage')

    #Make a second axis to plot the raw totals
    ax2 = ax.twinx()
    lines.append(ax2.plot(range(24), total, 'k--', label='Ride#')[0])
    plt.ylabel('Number of Rides')
    plt.legend(lines, [l.get_label() for l in lines], fontsize='small', loc='center left')


def averageRideHour(row):
    """
    Return the middle hour of a ride.  For example, if a ride started at
    7:30 and lasted for 1:10, return 8.

    Parameters
    ----------
    row : dict_like
        A ride entry containing 'starttime' and 'tripduration'

    Returns
    -------
    int
        The hour
    """
    start = datetime.datetime.strptime(row['starttime'], TIME_FORMAT)
    duration2 = datetime.timedelta(seconds=row['tripduration']/2)
    return (start+duration2).hour

def main():
    # Read CSV into DataFrame
    try:
        df = pandas.read_csv(sys.argv[1])
    except IndexError:
        print "Pass the CSV file as an argument to the program.  For example:\n\tpython main.py citibike.csv"
        return

    # Question 1
    averageTripDuration(df)

    # Setup Figure
    fig = plt.figure(figsize=(10,10))
    grid = GridSpec(2, 2, wspace=.75)

    # Question 2
    plotGender(df, grid[0, 0])
    plotType(df, grid[0, 1])

    # Question 3
    plotTime(df, grid[1,:])

    plt.show()

if __name__ == '__main__':
    main()