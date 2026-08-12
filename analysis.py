import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("netflix_titles.csv")

df["date_added"] = pd.to_datetime(df["date_added"], errors="coerce")


# Graph 1
df["date_added"].dt.year.value_counts().sort_index().plot(
    kind="line",
    marker="o"
)

plt.title("Content Added to Netflix by Year")
plt.xlabel("Year")
plt.ylabel("Number of Titles")

plt.savefig("screenshots/step1_content_added_by_year.png")
plt.close()


# Graph 2
df["type"].value_counts().plot(
    kind="bar"
)

plt.title("Movies vs TV Shows on Netflix")
plt.xlabel("Content Type")
plt.ylabel("Number of Titles")
plt.xticks(rotation=0)

plt.savefig("screenshots/step2_movies_vs_tv_shows.png")
plt.close()

print("Graphs saved successfully!")# Graph 3 - Top 10 Genres

genres = df["listed_in"].str.split(", ").explode()

genres.value_counts().head(10).sort_values().plot(
    kind="barh"
)

plt.title("Top 10 Genres on Netflix")
plt.xlabel("Number of Titles")
plt.ylabel("Genre")

plt.savefig("screenshots/step3_top_10_genres.png")
plt.close()# Graph 4 - Top 10 Countries

countries = df["country"].dropna().str.split(", ").explode()

countries.value_counts().head(10).sort_values().plot(
    kind="barh"
)

plt.title("Top 10 Countries by Netflix Content")
plt.xlabel("Number of Titles")
plt.ylabel("Country")

plt.savefig("screenshots/step4_top_10_countries.png")
plt.close()# Graph 5 - Content by Rating

df["rating"].value_counts().sort_values().plot(
    kind="barh"
)

plt.title("Netflix Content by Rating")
plt.xlabel("Number of Titles")
plt.ylabel("Rating")

plt.savefig("screenshots/step5_content_by_rating.png")
plt.close()

print("All 5 graphs saved successfully!")