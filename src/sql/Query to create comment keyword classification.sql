SELECT
  * EXCEPT(ROW_NUMBER)
FROM (
  SELECT
    *,ROW_NUMBER() OVER (PARTITION BY comment_id) AS row_number
  FROM
    (select distinct comments.comment_id, keyword.mild_hs,keyword.hs,keyword.mild_profanity ,keyword.profanity ,keyword.sexual,keyword.mild_sexual , comments.* except(comment_id)
from  `hatespeech-2019.Final_Dataset.Keyword_Classification_Merged` keyword  left join  
`hatespeech-2019.Final_Dataset.Parent_Child_Merged` comments
on trim(keyword.comment_id) = trim(comments.comment_id))   )
WHERE
  row_number = 1


