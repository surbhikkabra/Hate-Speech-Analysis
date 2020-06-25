SELECT
  * EXCEPT(ROW_NUMBER)
FROM (
  SELECT
    *,ROW_NUMBER() OVER (PARTITION BY video_id) AS row_number
  FROM
    `hatespeech-2019.Video_Details.Parent_Video_Level_Details_Combined`   )
WHERE
  row_number = 1