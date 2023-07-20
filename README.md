# Covid-Data
SELECT * FROM guardian_league.subject_level_data;

SELECT Institution, COUNT(*) AS Total_Count
FROM subject_level_data
GROUP BY Institution;

-- 1. How does student satisfaction with teaching, course, and feedback vary across different institutions?
SELECT
    Institution,
    AVG(`Satisfied with Course`) AS avg_course_satisfaction,
    AVG(`Satisfied with Teaching`) AS avg_teaching_satisfaction,
    AVG(`Satisfied with Feedback`) AS avg_feedback_satisfaction
FROM
    subject_level_data
GROUP BY
    Institution limit 10;
    
-- 2. Is there a correlation between student-to-staff ratio and student satisfaction levels?

SELECT
    Institution,
    `Student to Staff Ratio`,
    AVG(`Satisfied with Course`) AS avg_course_satisfaction,
    AVG(`Satisfied with Teaching`) AS avg_teaching_satisfaction,
    AVG(`Satisfied with Feedback`) AS avg_feedback_satisfaction
FROM
    subject_level_data
GROUP BY
    Institution,
    `Student to Staff Ratio`
    limit 10;

    
-- 3. What is the distribution of spend per student across institutions 
-- and how does it relate to other metrics such as student satisfaction 
-- and value-added score?

SELECT
    Institution,
    `Spend per Student`,
    AVG(`Satisfied with Course`) AS avg_course_satisfaction,
    AVG(`Satisfied with Teaching`) AS avg_teaching_satisfaction,
    AVG(`Satisfied with Feedback`) AS avg_feedback_satisfaction,
    AVG(`Value Added Score`) AS avg_value_added_score
FROM
   subject_level_data
GROUP BY
    Institution,
    `Spend per Student`
    limit 10;
    
-- 4. Which institutions have the highest and lowest average entry tariff, 
-- and how does it impact their value-added scores?
SELECT
    Institution,
    AVG(`Average Entry Tariff`) AS avg_entry_tariff,
    AVG(`Value Added Score`) AS avg_value_added_score
FROM
   subject_level_data
GROUP BY
    Institution
ORDER BY
    avg_entry_tariff DESC
    limit 10;

-- 5. How do different subjects perform in terms of value-added scores and career outcomes after 15 months?
SELECT subject,
       AVG('Value Added Score') AS avg_value_added_score,
       AVG('Career after 15 months') AS avg_career_outcomes
FROM subject_level_data
GROUP BY subject;

-- 6. Is there a relationship between the student-to-staff ratio and the institution's rank?

SELECT
  AVG(`Student to Staff Ratio`) AS avg_student_to_staff_ratio,
  AVG(`Rank`) AS avg_institution_rank,
  (SUM(`Student to Staff Ratio` * `Rank`) - COUNT(`Student to Staff Ratio`) * AVG(`Student to Staff Ratio`) * AVG(`Rank`)) / (COUNT(`Student to Staff Ratio`) * VAR_POP(`Student to Staff Ratio`)) AS slope,
  AVG(`Rank`) - (SUM(`Student to Staff Ratio` * `Rank`) - COUNT(`Student to Staff Ratio`) * AVG(`Student to Staff Ratio`) * AVG(`Rank`)) / (COUNT(`Student to Staff Ratio`) * VAR_POP(`Student to Staff Ratio`)) * AVG(`Student to Staff Ratio`) AS intercept
FROM subject_level_data;


-- 7. How does the guardian score correlate with other metrics like student satisfaction, value-added score, or career outcomes?
SELECT
    (SUM(('Guardian Score' - guardian_avg) * ('Satisfied with Teaching' - satisfaction_avg)) / (COUNT(*) * STDDEV('Guardian Score') * STDDEV('Satisfied with Teaching'))) AS correlation_student_satisfaction,
    (SUM(('Guardian Score' - guardian_avg) * ('Value Added Score' - value_added_avg)) / (COUNT(*) * STDDEV('Guardian Score') * STDDEV('Value Added Score'))) AS correlation_value_added_score,
    (SUM(('Guardian Score' - guardian_avg) * ('Career after 15 months' - outcomes_avg)) / (COUNT(*) * STDDEV('Guardian Score') * STDDEV('Career after 15 months'))) AS correlation_career_outcomes
FROM
    (SELECT
        'Guardian Score',
        'Satisfied with Teaching',
        'Value Added Score',
       'Career after 15 months',
        (SELECT AVG('Guardian Score') FROM subject_level_data) AS guardian_avg,
        (SELECT AVG('Satisfied with Teaching') FROM subject_level_data) AS satisfaction_avg,
        (SELECT AVG('Value Added Score') FROM subject_level_data) AS value_added_avg,
        (SELECT AVG('Career after 15 months') FROM subject_level_data) AS outcomes_avg
        from subject_level_data) as Subquery;
        
-- 8. Are there any notable differences in value-added scores between institutions of different ranks?
-- 9. Does the average entry tariff have an impact on student satisfaction levels or career outcomes?
-- 10. Which institutions have the highest continuation rates, and are there any factors like student satisfaction or value-added score that contribute to this?

SELECT
'Rank', 
    AVG(`Spend per Student`) AS avg_spend_per_student,
    AVG(`Average Entry Tariff`) AS avg_entry_tariff
FROM
subject_level_data
GROUP BY
    'Rank';
