SELECT
  replies.* ,
  vld.channel_id,
  vld.gender,
  vld.race,
  vld.int_race,
  vld.int_gender,
  (case when vld.comment_count = 2 then 0
  else 
  0 end) reply_count,
  (CASE
      WHEN vld.type = 'teen' THEN 1
    ELSE
    0
  END
    ) AS is_channel_teen
FROM
  `hatespeech-2019.Child_Comments.Replies_Comments` replies
LEFT JOIN
  `hatespeech-2019.Video_Details.All_Video_Level_Details_Combined`  vld
ON
  replies.video_id = vld.video_id
  where replies.video_id in (select distinct video_id from `hatespeech-2019.Video_Details.All_Video_Level_Details_Combined`  vld)