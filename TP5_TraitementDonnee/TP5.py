import pandas as pd
import matplotlib.pyplot as plt

def generateBarChart(df):
    nbFemmes = len(df[df.Sexe == 'F'])
    nbHommes = len(df[df.Sexe == 'M'])

    x = [1, 2]
    y = [nbFemmes, nbHommes]
    labels = ["F", "M"]

    plt.bar(x,y, tick_label = labels, width=0.5, color= ['pink', 'pink'])

    plt.xlabel("Sexe")
    plt.ylabel("Nombre d'élèves")
    plt.title("Répartition Femmes/Hommes chez les élèves")
    plt.text(1, nbFemmes +0.5, nbFemmes, horizontalalignment='center')
    plt.text(2, nbHommes +0.5, nbHommes, horizontalalignment='center')
    plt.savefig("py_ChartBar.png")

def generateBoxPlotChart(df):

    collegeData = df[df["Niveau d'études"] == "Collège"]["Âge"]
    lyceeData = df[df["Niveau d'études"] == "Lycée"]["Âge"]
    universiteData = df[df["Niveau d'études"] == "Université"]["Âge"]
    primaireData = df[df["Niveau d'études"] == "Primaire"]["Âge"]

    data = [primaireData, collegeData, lyceeData, universiteData]

    fig1, ax1 = plt.subplots()
    ax1.set_title("Âges en fonction du niveau d'études")
    ax1.set_xlabel("Âge")
    ax1.set_ylabel("Niveau d'études")
    ax1.boxplot(data)

    plt.grid()
    plt.savefig("py_BoxPlotChart.png")

def lire(nomFichier):
    df = pd.read_csv(nomFichier, sep='\t', encoding="iso-8859-1")

    df = df.sort_values(['Identité', 'Âge'])
    df = df.drop_duplicates(['Identité', 'Sexe'], keep='last')    

    generateBoxPlotChart(df)
    plt.clf()
    generateBarChart(df)

lire("eleves.tsv")