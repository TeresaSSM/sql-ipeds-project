-- =====================================================
-- SQL Portfolio Project
-- UC Enrollment Analysis (IPEDS 2024)
-- Author: Teresa McCarrell
--
-- Demonstrates:
-- SELECT
-- ORDER BY
-- GROUP BY
-- Aggregate Functions
-- CASE WHEN
-- JOIN
-- CTE
-- Window Functions
-- =====================================================


---------------------------------------------------------
-- Query 1
-- Overview of all UC campuses
---------------------------------------------------------

SELECT
    institution_name,
    total_enrollment,
    undergraduate_enrollment,
    graduate_enrollment
FROM institutions i
JOIN enrollment e
    ON i.unitid = e.unitid
ORDER BY total_enrollment DESC;



---------------------------------------------------------
-- Query 2
-- Enrollment composition
---------------------------------------------------------

SELECT
    institution_name,

    undergraduate_enrollment,
    graduate_enrollment,

    ROUND(
        undergraduate_enrollment * 100.0 /
        total_enrollment,
        1
    ) AS undergraduate_pct,

    ROUND(
        graduate_enrollment * 100.0 /
        total_enrollment,
        1
    ) AS graduate_pct

FROM institutions i
JOIN enrollment e
ON i.unitid = e.unitid

ORDER BY undergraduate_pct DESC;



---------------------------------------------------------
-- Query 3
-- Categorize campuses by enrollment size
---------------------------------------------------------

SELECT

    institution_name,

    total_enrollment,

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
-- Query 4
-- Average demographics across the UC system
---------------------------------------------------------

SELECT

    ROUND(AVG(ug_white_pct),1) AS avg_white,

    ROUND(AVG(ug_black_pct),1) AS avg_black,

    ROUND(AVG(ug_hispanic_pct),1) AS avg_hispanic,

    ROUND(AVG(ug_asian_pct),1) AS avg_asian,

    ROUND(AVG(ug_women_pct),1) AS avg_women

FROM demographics;



---------------------------------------------------------
-- Query 5
-- Campuses above the UC average enrollment
-- (CTE)
---------------------------------------------------------

WITH avg_enrollment AS (

    SELECT
        AVG(total_enrollment) AS avg_total

    FROM enrollment

)

SELECT

    institution_name,

    total_enrollment

FROM institutions i

JOIN enrollment e
ON i.unitid = e.unitid

CROSS JOIN avg_enrollment

WHERE total_enrollment > avg_total

ORDER BY total_enrollment DESC;



---------------------------------------------------------
-- Query 6
-- Hispanic enrollment compared to
-- UC system average
---------------------------------------------------------

WITH avg_demo AS (

    SELECT
        AVG(ug_hispanic_pct) AS avg_hispanic

    FROM demographics

)

SELECT

    institution_name,

    ug_hispanic_pct,

    ROUND(
        ug_hispanic_pct - avg_hispanic,
        1
    ) AS pct_points_from_average

FROM institutions i

JOIN demographics d
ON i.unitid = d.unitid

CROSS JOIN avg_demo

ORDER BY pct_points_from_average DESC;



---------------------------------------------------------
-- Query 7
-- Rank campuses by enrollment
-- (Window Function)
---------------------------------------------------------

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
-- Query 8
-- Combined institutional profile
---------------------------------------------------------

SELECT

    institution_name,

    total_enrollment,

    graduate_enrollment,

    ug_hispanic_pct,

    ug_asian_pct,

    ug_women_pct

FROM institutions i

JOIN enrollment e
ON i.unitid = e.unitid

JOIN demographics d
ON i.unitid = d.unitid

ORDER BY total_enrollment DESC;
