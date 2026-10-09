SELECT * FROM data.gym_workout LIMIT 10;

SELECT `User Number`, Gender, Fat_Percentage FROM data.gym_workout LIMIT 10;

SELECT `User Number`, Calories_Burned, `Workout_Frequency (days/week)`
FROM data.gym_workout WHERE `Workout_Frequency (days/week)` >= 4;

SELECT `User Number`, Avg_BPM, `Session_Duration (hours)` FROM data.gym_workout
ORDER BY `Session_Duration (hours)` DESC LIMIT 25;

SELECT DISTINCT Experience_Level FROM data.gym_workout
SELECT COUNT(*) FROM data.gym_workout 
WHERE Experience_Level = 3;

SELECT ROUND(AVG(Fat_Percentage), 2) FROM data.gym_workout;

SELECT level_name, COUNT(*) AS number_of_types_of_levels
FROM data.gym_workout
GROUP BY level_name
HAVING COUNT(*) > 400

SELECT `User Number`, Calories_Burned,
CASE
WHEN Calories_Burned >= 1000 THEN "Burned a whole lot"
WHEN Calories_Burned >= 700 THEN "Burned a lot"
ELSE "Burned some"
END AS calorie_category
FROM data.gym_workout
LIMIT 25;

WITH category AS (
SELECT Workout_Type, COUNT(*) AS number_in_different_groups
FROM data.gym_workout
GROUP BY Workout_Type
)
SELECT * FROM category;

SELECT `User Number`, level_name, `Water_Intake (liters)`,
RANK() OVER (
PARTITION BY level_name
ORDER BY `Water_Intake (liters)` DESC
) AS rank_category
FROM data.gym_workout;
