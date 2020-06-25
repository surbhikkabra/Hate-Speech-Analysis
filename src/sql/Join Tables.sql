SELECT
  vd.channel_id,
  vd.comment_count,
  vd.dislike_count,
  vd.duration,
  vd.favorite_count,
  vd.like_count,
  vd.video_id,
  vd.view_count,
  vp.published_at,
  vp.year_of_publishing,
  vt.int_video_id,
  vt.int_channel_id,
  gr.gender AS gender,
  gr.race AS race,
  cic.comment_count AS channel_comment_count,
  cic.type,
  int_values.int_race,
  int_values.int_gender
FROM
  `hatespeech-2019.Video_Details.video_id_details` vd
LEFT JOIN
  `hatespeech-2019.Video_Details.video_id_published_at` vp
ON
  vp.video_id = vd.video_id
LEFT JOIN
  `hatespeech-2019.Video_Details.video_channel_id_translation` vt
ON
  vt.video_id = vd.video_id
LEFT JOIN
  `hatespeech-2019.Video_Details.Gender_Race` gr
ON
  gr.channel_id = vd.channel_id
LEFT JOIN
  `hatespeech-2019.Video_Details.channel_id_classification` cic
ON
  cic.channel_id = vd.channel_id
LEFT JOIN
  `hatespeech-2019.Video_Details.teen_int_channel_id_gender_race` teen_int
ON
  teen_int.int_channel_id = vt.int_channel_id
LEFT JOIN
  `hatespeech-2019.Video_Details.Categorical_To_int_Translation` int_values
ON
  int_values.int_channel_id = vt.int_channel_id