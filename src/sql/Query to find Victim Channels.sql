SELECT
  c.*,
  case when (temp.number_of_victim_channels is null) then 0 else temp.number_of_victim_channels end as number_of_victim_channels
FROM
  `hatespeech-2019.Final_Dataset.Channel_Videos_Comments_Merged` c left join
  (
  SELECT
    authorChannelId,
    COUNT(DISTINCT channel_id) AS number_of_victim_channels
  FROM
    `hatespeech-2019.Final_Dataset.Channel_Videos_Comments_Merged`
  WHERE
    hate_comments_count > 0
  GROUP BY
    authorChannelId
  HAVING
    number_of_victim_channels > 1) AS temp
on
  c.authorChannelId = temp.authorChannelId