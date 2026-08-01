-- SQL Portfolio Project: UC Enrollment Analysis, Using IPEDS 2024 Data

--- Demonstrates SELECT, ORDER BY, GROUP BY, Aggregate Functions, CASE WHEN, JOIN, CTE, and Window Functions
---------------------------------------------------------



-- Query 1: Creating an overview of all UC campuses


SELECT
    institution_name, total_enrollment, undergraduate_enrollment, graduate_enrollment
FROM institutions i
JOIN enrollment e
    ON i.unitid = e.unitid
ORDER BY total_enrollment DESC;
---------------------------------------------------------



-- Query 2: Determining enrollment composition


SELECT
    institution_name, undergraduate_enrollment, graduate_enrollment,
    ROUND(undergraduate_enrollment * 100.0 /
        total_enrollment, 1) 
    AS undergraduate_pct,
    ROUND(graduate_enrollment * 100.0 /
        total_enrollment,1) 
    AS graduate_pct
FROM institutions i
JOIN enrollment e
ON i.unitid = e.unitid
ORDER BY undergraduate_pct DESC;
---------------------------------------------------------



-- Query 3: Categorizing campuses by enrollment size


SELECT
    institution_name, total_enrollment,
    CASE
        WHEN total_enrollment >= 40000
            THEN 'Very Large'
        WHEN total_enrollment >= 25000
            THEN 'Large'
        WHEN total_enrollment >= 15000
            THEN 'Medium'
        ELSE 'Small'
    END AS enrollment_size
FROM institutions i
JOIN enrollment e
ON i.unitid = e.unitid
ORDER BY total_enrollment DESC;
---------------------------------------------------------



-- Query 4: Retrieving Average demographics across the UC system


SELECT
    ROUND(AVG(ug_white_pct),1) AS avg_white,
    ROUND(AVG(ug_black_pct),1) AS avg_black,
    ROUND(AVG(ug_hispanic_pct),1) AS avg_hispanic,
    ROUND(AVG(ug_asian_pct),1) AS avg_asian,
    ROUND(AVG(ug_women_pct),1) AS avg_women
FROM demographics;
---------------------------------------------------------



-- Query 5: Selecting campuses and enrollment numbers that are above the UC average enrollment


WITH above_average 
    AS (SELECT unitid, total_enrollment
    FROM enrollment
    WHERE total_enrollment >
    (SELECT AVG(total_enrollment)
        FROM enrollment))
SELECT
    i.institution_name, a.total_enrollment
FROM above_average a
JOIN institutions i
    ON a.unitid = i.unitid
ORDER BY a.total_enrollment DESC;
---------------------------------------------------------



-- Query 6: Comparing Hispanic enrollment at individual institutions to UC system average

SELECT
    i.institution_name, d.ug_hispanic_pct,
    ROUND(d.ug_hispanic_pct -
        (SELECT AVG(ug_hispanic_pct)
            FROM demographics
            WHERE ug_hispanic_pct IS NOT NULL), 1) -- Removes UCSF, where there are no undergraduate programs
    AS pct_points_from_average
FROM institutions i
JOIN demographics d
    ON i.unitid = d.unitid
WHERE d.ug_hispanic_pct IS NOT NULL
ORDER BY pct_points_from_average DESC;
---------------------------------------------------------


-- Query 7: Ranking campuses by enrollment

SELECT

    institution_name,

    total_enrollment,

    RANK() OVER(

        ORDER BY total_enrollment DESC

    ) AS enrollment_rank

FROM institutions i

JOIN enrollment e
ON i.unitid = e.unitid;
---------------------------------------------------------



-- Query 8: Creating institutional enrollment and nonresident student demographic profile


SELECT
    institution_name, total_enrollment, graduate_enrollment, undergraduate_enrollment, grad_nonresident_pct,
	COALESCE(ug_nonresident_pct, 0) AS ug_nonresident_pct
FROM institutions i
JOIN enrollment e
ON i.unitid = e.unitid
JOIN demographics d
ON i.unitid = d.unitid
ORDER BY total_enrollment DESC;
