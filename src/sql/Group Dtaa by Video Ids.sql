SELECT
  video_id,
  comment_date,
  comment_hour_of_the_day,
  SUM(CASE WHEN(hate_comments_count <> 0) THEN 1
    ELSE
    0
  END
    ) AS count_hate_comments,
  (COUNT(comment_id) - SUM(CASE WHEN(hate_comments_count <> 0) THEN 1
      ELSE
      0
    END
      )) AS count_non_hate_comments,
  COUNT(comment_id) AS total_comments,
  SUM(all_hs) AS all_hs,
  SUM(all_sexual) AS all_sexual,
  SUM(all_profanity) AS all_profanity
FROM
  `hatespeech-2019.Final_Dataset.Channel_Videos_Comments_Merged`
WHERE
  EXTRACT(year
  FROM
    video_timestamp) >= 2010
  AND EXTRACT(year
  FROM
    video_timestamp) < 2018
GROUP BY
  video_id,
  comment_date,
  comment_hour_of_the_day