select child.*, 
case when (classification.sexual > 0 or classification.mild_sexual > 0 or classification.hs > 0 or classification.mild_hs > 0  or classification.profanity > 0 or classification.mild_profanity > 0 )
     then 1  
     else 0
     end is_author_hateful
from `hatespeech-2019.Child_Comments.Replies_Comments_Video_Details` child,
      `hatespeech-2019.HateSpeech.Child_Replies_Keyword_Classification` classification
      where classification.comment_id = child.comment_id