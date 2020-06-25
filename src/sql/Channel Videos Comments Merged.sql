WITH
  KEYWORD_CLASSIFICATION AS (
  SELECT
    comment_id,
    mild_hs,
    hs,
    mild_profanity,
    profanity,
    sexual,
    mild_sexual,
    (mild_hs+ hs + mild_profanity + profanity + sexual + mild_sexual) AS hate_comments_count,
    (mild_hs + hs) AS all_hs,
    (mild_profanity + profanity) AS all_profanity,
    (sexual + mild_sexual) AS all_sexual
  FROM
    `hatespeech-2019.Final_Dataset.Keyword_Classification_Merged`),
  CHANNEL_LEVEL_DETAILS AS (
  SELECT
    channel_id,
    published_at as channel_published_at,
    subscriber_count AS channel_subscriber_count,
    video_count AS channel_video_count,
    view_count AS channel_view_count
  FROM
    `hatespeech-2019.Video_Details.kid_preteen_gender_race_channel_details`
  UNION ALL
  SELECT
    channel_id,
    published_at as channel_published_at,
    subscriber_count AS channel_subscriber_count,
    video_count AS channel_video_count,
    view_count AS channel_view_count
  FROM
    `hatespeech-2019.Video_Details.teen_gender_race_channel_details` ),
  COMMENTS AS (
  SELECT
    * except(is_teen)
  FROM
    `hatespeech-2019.Final_Dataset.Parent_Child_Merged`),
  VIDEO_LEVEL_DETAILS AS (
  SELECT
    * EXCEPT(race,
      video_id,
      gender,
      int_race,
      int_gender,
      published_at,
      duration),
    published_at AS video_timestamp,
    video_id,
    TRIM(REGEXP_EXTRACT(duration,r"PT[\d]*"),'PT') AS duration_mins
  FROM
    `hatespeech-2019.Video_Details.video_id_details`)
SELECT
  * except(row_number_1)
FROM (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY comment_id) AS row_number_1
  FROM (
    SELECT
      DISTINCT comments.comment_id,
      EXTRACT(hour
      FROM
        timestamp) AS comment_hour_of_the_day,
      FORMAT_DATETIME('%Y-%m-%d',DATETIME(timestamp)) as comment_date,
      comments.* EXCEPT(comment_id),
      kc.* EXCEPT(comment_id),
      cld.* EXCEPT(channel_id),
      case when (race <> 'white') then 1 else 0 end as is_poc,
      vld.video_timestamp,
      vld.dislike_count,
      vld.like_count,
      vld.duration_mins as v_duration_min,
      DATETIME_DIFF(DATETIME(vld.video_timestamp), DATETIME(cld.channel_published_at),MONTH) as channel_age_at_video_posting
    FROM
      KEYWORD_CLASSIFICATION kc
    LEFT JOIN
      COMMENTS
    ON
      TRIM(kc.comment_id) = TRIM(comments.comment_id)
    LEFT JOIN
      VIDEO_LEVEL_DETAILS vld
    ON
      vld.video_id = comments.video_id
    LEFT JOIN
      CHANNEL_LEVEL_DETAILS cld
    ON
      cld.channel_id = vld.channel_id))
WHERE
  row_number_1 = 1