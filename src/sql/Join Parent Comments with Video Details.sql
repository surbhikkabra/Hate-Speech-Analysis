SELECT
  comments.* except(channel_id),
  vld.channel_id,
  vld.gender,
  vld.race,
  vld.int_race,
  vld.int_gender,
  (CASE
      WHEN vld.type = 'teen' THEN 1
    ELSE
    0
  END
    ) AS is_channel_teen
FROM
  `hatespeech-2019.Parent_Comments.Comments` comments
LEFT JOIN
  `hatespeech-2019.Video_Details.Parent_Video_Level_Details_Combined` vld
ON
  comments.video_id = vld.video_id