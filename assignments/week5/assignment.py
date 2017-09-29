import csv
import datetime

def load(csv_file):
  """
    Loads the data from the file in the provided argument into a 2D array
  """
  with open(csv_file) as csvDataFile:
      return [row for row in csv.reader(csvDataFile, delimiter=';')]

table = load('/Users/jhejderup/Documents/algo-ds/assignments/week5/brwaa_2010-2015.csv')

def cmpf(a , b):
    #0 = incident_id
    return int(a[0]) > int(b[0])
def cmpfDatum(a , b):
    #import datetime
    #6 = datum
    # 2008/01/03 00:00:00.000000000
    return datetime.datetime.strptime(a[6][:-10],'%Y/%m/%d %H:%M:%S') > datetime.datetime.strptime(b[6][:-10],'%Y/%m/%d %H:%M:%S')



def insertionSort(table, f, limit=15,*args, **kwargs):
    subtable = table[1:limit+1]
    for index in range(1,len(subtable)):
        currentvalue = subtable[index]
        position = index
        while position > 0 and f(subtable[position-1],currentvalue,*args, **kwargs):
            subtable[position] = subtable[position-1]
            position = position-1
        subtable[position]=currentvalue
    return subtable


print([row[6][:-10] for row in table[1:15+1]])
print([row[6][:-10] for row in insertionSort(table, cmpfDatum)])
