-- =====================================================
-- SQL Portfolio Project
-- IPEDS UC Enrollment Database
-- Schema
-- =====================================================

-- Drop existing tables (allows rerunning the script)

DROP TABLE IF EXISTS distance_learning;
DROP TABLE IF EXISTS demographics;
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS institutions;


-- =====================================================
-- Institutions
-- =====================================================

CREATE TABLE institutions (
    unitid              INTEGER PRIMARY KEY,
    institution_name    TEXT NOT NULL,
    year                INTEGER NOT NULL
);


-- =====================================================
-- Enrollment
-- =====================================================

CREATE TABLE enrollment (

    unitid                          INTEGER PRIMARY KEY,

    total_enrollment                INTEGER,
    fte_enrollment                  INTEGER,

    full_time_enrollment            INTEGER,
    part_time_enrollment            INTEGER,

    undergraduate_enrollment        INTEGER,

    first_time_undergraduate        INTEGER,
    transfer_undergraduate          INTEGER,
    continuing_undergraduate        INTEGER,
    nondegree_undergraduate         INTEGER,

    full_time_undergraduate         INTEGER,
    part_time_undergraduate         INTEGER,

    graduate_enrollment             INTEGER,
    full_time_graduate              INTEGER,
    part_time_graduate              INTEGER,

    CONSTRAINT fk_enrollment
        FOREIGN KEY (unitid)
        REFERENCES institutions(unitid)
);


-- =====================================================
-- Demographics
-- =====================================================

CREATE TABLE demographics (

    unitid                  INTEGER PRIMARY KEY,

    -- Undergraduate

    ug_white_pct            NUMERIC(5,2),
    ug_black_pct            NUMERIC(5,2),
    ug_hispanic_pct         NUMERIC(5,2),
    ug_asian_pct            NUMERIC(5,2),
    ug_nhpi_pct             NUMERIC(5,2),
    ug_aian_pct             NUMERIC(5,2),
    ug_two_or_more_pct      NUMERIC(5,2),
    ug_unknown_pct          NUMERIC(5,2),
    ug_nonresident_pct      NUMERIC(5,2),
    ug_women_pct            NUMERIC(5,2),

    -- Graduate

    grad_white_pct          NUMERIC(5,2),
    grad_black_pct          NUMERIC(5,2),
    grad_hispanic_pct       NUMERIC(5,2),
    grad_asian_pct          NUMERIC(5,2),
    grad_nhpi_pct           NUMERIC(5,2),
    grad_aian_pct           NUMERIC(5,2),
    grad_two_or_more_pct    NUMERIC(5,2),
    grad_unknown_pct        NUMERIC(5,2),
    grad_nonresident_pct    NUMERIC(5,2),
    grad_women_pct          NUMERIC(5,2),

    CONSTRAINT fk_demographics
        FOREIGN KEY (unitid)
        REFERENCES institutions(unitid)
);


-- =====================================================
-- Distance Learning
-- =====================================================

CREATE TABLE distance_learning (

    unitid                      INTEGER PRIMARY KEY,

    ug_distance_only_pct        NUMERIC(5,2),
    ug_some_distance_pct        NUMERIC(5,2),
    ug_no_distance_pct          NUMERIC(5,2),

    grad_distance_only_pct      NUMERIC(5,2),
    grad_some_distance_pct      NUMERIC(5,2),
    grad_no_distance_pct        NUMERIC(5,2),

    CONSTRAINT fk_distance
        FOREIGN KEY (unitid)
        REFERENCES institutions(unitid)
);