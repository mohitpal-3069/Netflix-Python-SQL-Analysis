import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("netflix_titles.csv")

df["date_added"] = pd.to_datetime(df["date_added"], errors="coerce")

df["date_added"].dt.year.value_counts().sort_index().plot(kind="line", marker="o")

plt.title("Content Added to Netflix by Year")
plt.xlabel("Year")
plt.ylabel("Number of Titles Added")

plt.show()