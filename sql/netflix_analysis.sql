-- =========================================================
-- Netflix Python & SQL Analysis
-- SQL Analysis Queries
-- =========================================================


-- 1. View the complete dataset
SELECT *
FROM netflix_titles;


-- 2. Count total number of titles
SELECT COUNT(*) AS total_titles
FROM netflix_titles;


-- 3. Movies vs TV Shows
SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type
ORDER BY total_titles DESC;


-- 4. Content added by year
SELECT
    YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;


-- 5. Top 10 countries by number of titles
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;


-- 6. Content distribution by rating
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;


-- 7. Movies vs TV Shows by release year
SELECT
    release_year,
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year, type
ORDER BY release_year, type;


-- 8. Top directors with the most titles
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;


-- 9. Most recently added titles
SELECT
    title,
    type,
    date_added,
    release_year
FROM netflix_titles
WHERE date_added IS NOT NULL
ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC
LIMIT 10;


-- 10. Average movie duration
SELECT
    AVG(
        CAST(REPLACE(duration, ' min', '') AS UNSIGNED)
    ) AS average_movie_duration_minutes
FROM netflix_titles
WHERE type = 'Movie'
AND duration LIKE '%min';


-- 11. Number of titles released each year
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year DESC;


-- 12. Most common ratings for Movies
SELECT
    rating,
    COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = 'Movie'
AND rating IS NOT NULL
GROUP BY rating
ORDER BY total_movies DESC;


-- 13. Most common ratings for TV Shows
SELECT
    rating,
    COUNT(*) AS total_tv_shows
FROM netflix_titles
WHERE type = 'TV Show'
AND rating IS NOT NULL
GROUP BY rating
ORDER BY total_tv_shows DESC;


-- 14. Titles released after 2015
SELECT
    title,
    type,
    release_year,
    rating
FROM netflix_titles
WHERE release_year > 2015
ORDER BY release_year DESC;


-- 15. Summary of Netflix content
SELECT
    type,
    COUNT(*) AS total_titles,
    MIN(release_year) AS earliest_release,
    MAX(release_year) AS latest_release
FROM netflix_titles
GROUP BY type;


-- 16. Top 10 genres
SELECT
    listed_in AS genre,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE listed_in IS NOT NULL
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;


-- 17. Titles by release year and content type
SELECT
    release_year,
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movies,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_shows
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;


-- 18. Directors with more than 5 titles
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(*) > 5
ORDER BY total_titles DESC;


-- 19. Titles with missing director information
SELECT
    COUNT(*) AS missing_director_count
FROM netflix_titles
WHERE director IS NULL;


-- 20. Titles with missing country information
SELECT
    COUNT(*) AS missing_country_count
FROM netflix_titles
WHERE country IS NULL;