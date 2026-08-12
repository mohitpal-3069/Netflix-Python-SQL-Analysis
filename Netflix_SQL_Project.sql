USE netflix_db;SHOW TABLES;USE netflix_db;

SELECT COUNT(*) AS total_rows
FROM netflix_titles;SELECT *
FROM netflix_titles
LIMIT 10;DESCRIBE netflix_titles;SELECT *
FROM netflix_titles
WHERE type = 'Movie';SELECT *
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY release_year DESC;SELECT *
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY release_year DESC
LIMIT 5;SELECT title, type, release_year
FROM netflix_titles;SELECT DISTINCT type
FROM netflix_titles;SELECT DISTINCT rating
FROM netflix_titles;SELECT *
FROM netflix_titles
WHERE type = 'Movie'
AND release_year > 2020;SELECT *
FROM netflix_titles
WHERE release_year = 2020
OR release_year = 2021;SELECT *
FROM netflix_titles
WHERE release_year IN (2020, 2021, 2022);SELECT *
FROM netflix_titles
WHERE type = 'Movie'
AND release_year BETWEEN 2018 AND 2020;SELECT *
FROM netflix_titles
WHERE title LIKE 'The%';SELECT *
FROM netflix_titles
WHERE title LIKE '%Love%';SELECT *
FROM netflix_titles
WHERE director IS NULL;SELECT *
FROM netflix_titles
WHERE director IS NOT NULL;SELECT COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = 'Movie';SELECT COUNT(*) AS total_tv_shows
FROM netflix_titles
WHERE type = 'TV Show';SELECT MIN(release_year) AS oldest_year
FROM netflix_titles;SELECT MAX(release_year) AS newest_year
FROM netflix_titles;SELECT AVG(release_year) AS average_year
FROM netflix_titles;SELECT type, COUNT(*) AS total
FROM netflix_titles
GROUP BY type;SELECT release_year, COUNT(*) AS total
FROM netflix_titles
GROUP BY release_year
ORDER BY total DESC;SELECT release_year, COUNT(*) AS total
FROM netflix_titles
GROUP BY release_year
HAVING COUNT(*) > 3
ORDER BY total DESC;WHERE  → filters individual rows
HAVING → filters groupsSELECT UPPER(title) AS title_upper
FROM netflix_titles;SELECT LOWER(title) AS title_lower
FROM netflix_titles;SELECT title, LENGTH(title) AS title_length
FROM netflix_titles
ORDER BY title_length DESC;SELECT CONCAT(title, ' - ', type) AS title_info
FROM netflix_titles;SELECT
    title,
    release_year,
    CASE
        WHEN release_year >= 2020 THEN 'Recent'
        WHEN release_year >= 2010 THEN 'Moderate'
        ELSE 'Old'
    END AS category
FROM netflix_titles;SELECT title, YEAR(date_added) AS added_year
FROM netflix_titles;SELECT title, MONTH(date_added) AS added_month
FROM netflix_titles;SELECT *
FROM netflix_titles
WHERE type = 'Movie'
AND release_year = (
    SELECT MAX(release_year)
    FROM netflix_titles
    WHERE type = 'Movie'
);SELECT UPPER(title) AS title_upper
FROM netflix_titles;-- =========================================================
-- Remaining Netflix SQL Analysis Queries
-- =========================================================

-- 23. Titles containing the word "Love"
SELECT *
FROM netflix_titles
WHERE title LIKE '%Love%';


-- 24. Titles with missing director information
SELECT *
FROM netflix_titles
WHERE director IS NULL;


-- 25. Movies vs TV Shows
SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type
ORDER BY total_titles DESC;


-- 26. Average release year by content type
SELECT
    type,
    AVG(release_year) AS average_release_year
FROM netflix_titles
GROUP BY type;


-- 27. Titles added in 2021
SELECT *
FROM netflix_titles
WHERE date_added LIKE '%2021%';


-- 28. Top 5 countries by number of titles
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;


-- 29. Ratings with more than 5 titles
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
HAVING COUNT(*) > 5
ORDER BY total_titles DESC;


-- 30. Movies released after 2015
SELECT *
FROM netflix_titles
WHERE type = 'Movie'
AND release_year > 2015
ORDER BY release_year DESC;


-- 31. Longest movie
SELECT
    title,
    duration
FROM netflix_titles
WHERE type = 'Movie'
AND duration LIKE '%min'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;


-- 32. Movies vs TV Shows by release year
SELECT
    release_year,
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year, type
ORDER BY release_year, type;


-- 33. Most common rating
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC
LIMIT 1;


-- 34. 10 most recently added titles
SELECT
    title,
    type,
    date_added,
    release_year
FROM netflix_titles
WHERE date_added IS NOT NULL
ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC
LIMIT 10;


-- 35. Top 10 directors by number of titles
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
  AND duration IS NOT NULL
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;-- 32. Average movie duration
SELECT AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS avg_movie_duration
FROM netflix_titles
WHERE type = 'Movie'
  AND duration IS NOT NULL;


-- 33. Shortest movie
SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
  AND duration IS NOT NULL
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
LIMIT 1;


-- 34. Movies longer than average duration
SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
  AND duration IS NOT NULL
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) >
      (
          SELECT AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED))
          FROM netflix_titles
          WHERE type = 'Movie'
            AND duration IS NOT NULL
      );


-- 35. Number of movies and TV shows by release year
SELECT release_year,
       SUM(type = 'Movie') AS movies,
       SUM(type = 'TV Show') AS tv_shows
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year DESC;


-- 36. Top 5 countries by number of titles
SELECT country,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;


-- 37. Titles added in the latest year
SELECT title, type, date_added
FROM netflix_titles
WHERE YEAR(date_added) = (
    SELECT MAX(YEAR(date_added))
    FROM netflix_titles
    WHERE date_added IS NOT NULL
);


-- 38. Most common rating
SELECT rating,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC
LIMIT 1;


-- 39. Movies and TV shows added each year
SELECT YEAR(date_added) AS added_year,
       type,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added), type
ORDER BY added_year DESC, total_titles DESC;


-- 40. Top 10 directors by number of titles
SELECT director,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;


-- 41. Titles without a country
SELECT title, type
FROM netflix_titles
WHERE country IS NULL;


-- 42. Titles without a rating
SELECT title, type
FROM netflix_titles
WHERE rating IS NULL;


-- 43. Movies with duration greater than 120 minutes
SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
  AND duration IS NOT NULL
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 120
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC;


-- 44. Number of titles by year added
SELECT YEAR(date_added) AS added_year,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY added_year DESC;


-- 45. Top 10 years by number of releases
SELECT release_year,
       COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY total_titles DESC
LIMIT 10;


-- 46. Movies vs TV Shows percentage
SELECT type,
       COUNT(*) AS total_titles,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS percentage
FROM netflix_titles
GROUP BY type;


-- 47. Directors with more than 1 title
SELECT director,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(*) > 1
ORDER BY total_titles DESC;


-- 48. Ratings having more than 5 titles
SELECT rating,
       COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
HAVING COUNT(*) > 5
ORDER BY total_titles DESC;


-- 49. Titles containing "Love" (case-insensitive)
SELECT title, type
FROM netflix_titles
WHERE title LIKE '%Love%';


-- 50. Final project summary
SELECT
    COUNT(*) AS total_titles,
    SUM(type = 'Movie') AS total_movies,
    SUM(type = 'TV Show') AS total_tv_shows,
    COUNT(DISTINCT country) AS unique_countries,
    COUNT(DISTINCT rating) AS unique_ratings,
    MIN(release_year) AS oldest_release_year,
    MAX(release_year) AS newest_release_year
CREATE VIEW movie_tv_summary AS
SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;CREATE OR REPLACE VIEW titles_by_release_year AS
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;CREATE OR REPLACE VIEW titles_by_country AS
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_titles DESC;-- 4. Titles by rating
CREATE OR REPLACE VIEW titles_by_rating AS
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;


-- 5. Top directors by number of titles
CREATE OR REPLACE VIEW top_directors AS
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;


-- 6. Movies vs TV Shows by release year
CREATE OR REPLACE VIEW content_by_release_year AS
SELECT
    release_year,
    SUM(type = 'Movie') AS total_movies,
    SUM(type = 'TV Show') AS total_tv_shows
FROM netflix_titles
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;


-- 7. Recent Netflix additions
CREATE OR REPLACE VIEW recent_additions AS
SELECT
    title,
    type,
    date_added,
    release_year
FROM netflix_titles
WHERE date_added IS NOT NULL
ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC
LIMIT 20;


-- 8. Movies by duration
CREATE OR REPLACE VIEW movie_duration_data AS
SELECT
    title,
    duration
FROM netflix_titles
WHERE type = 'Movie'
AND duration IS NOT NULL;


-- 9. Titles with missing director
CREATE OR REPLACE VIEW missing_director_titles AS
SELECT
    title,
    type,
    release_year
FROM netflix_titles
WHERE director IS NULL;


-- 10. Overall Netflix summary
CREATE OR REPLACE VIEW netflix_summary AS
SELECT
    COUNT(*) AS total_titles,
    SUM(type = 'Movie') AS total_movies,
    SUM(type = 'TV Show') AS total_tv_shows,
    COUNT(DISTINCT country) AS unique_countries,
    COUNT(DISTINCT rating) AS unique_ratings,
    MIN(release_year) AS oldest_release_year,
    MAX(release_year) AS newest_release_year
FROM netflix_titles;CREATE OR REPLACE VIEW netflix_summary AS
SELECT
    COUNT(*) AS total_titles,
    SUM(type = 'Movie') AS total_movies,
    SUM(type = 'TV Show') AS total_tv_shows,
    COUNT(DISTINCT country) AS unique_countries,
    COUNT(DISTINCT rating) AS unique_ratings,
    MIN(release_year) AS oldest_release_year,
    MAX(release_year) AS newest_release_year
FROM netflix_titles;USE netflix_db;

-- Check that all 9 views exist
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- Verify every view
SELECT * FROM movie_duration_data;
SELECT * FROM missing_director_titles;
SELECT * FROM content_by_release_year;
SELECT * FROM movie_tv_summary;
SELECT * FROM titles_by_rating;
SELECT * FROM titles_by_country;
SELECT * FROM recent_additions;
SELECT * FROM netflix_summary;
SELECT * FROM titles_by_release_year;