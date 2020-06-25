select comment_id,
sum(case when comment_keywords in (select distinct badword from `hatespeech-2019.HateSpeech.List_Of_Bad_Words` where classification = 'sexual' ) then 1 else 0  end) as sexual,  
sum(case when comment_keywords in (select distinct badword from `hatespeech-2019.HateSpeech.List_Of_Bad_Words` where classification = 'mild_hs' ) then 1 else 0  end) as mild_hs,
sum(case when comment_keywords in (select distinct badword from `hatespeech-2019.HateSpeech.List_Of_Bad_Words` where classification = 'hs' ) then 1 else 0 end) as hs,
sum(case when comment_keywords in (select distinct badword from `hatespeech-2019.HateSpeech.List_Of_Bad_Words` where classification = 'profanity' ) then 1 else 0 end) as profanity,
sum(case when comment_keywords in (select distinct badword from `hatespeech-2019.HateSpeech.List_Of_Bad_Words` where classification = 'drug/alcohol' ) then 1 else 0 end) as drug_or_alcohol,
sum(case when comment_keywords in (select distinct badword from `hatespeech-2019.HateSpeech.List_Of_Bad_Words` where classification = 'mild_profanity' )then 1 else 0 end) as  mild_profanity,
sum(case when comment_keywords in (select distinct badword from `hatespeech-2019.HateSpeech.List_Of_Bad_Words` where classification = 'mild_sexual' )then 1 else 0 end) as  mild_sexual,
sum(case when REGEXP_CONTAINS(comment_keywords , (r"(a\*\*\*)") ) then 1
         when REGEXP_CONTAINS(comment_keywords , (r"(d\*\*\*)") ) then 1
         when REGEXP_CONTAINS(comment_keywords , (r"(c\*\*\*)") ) then 1
         when REGEXP_CONTAINS(comment_keywords , (r"(s\*\*\*)") ) then 1
         when REGEXP_CONTAINS(comment_keywords , (r"(\*\*\*)") ) then 1
         when REGEXP_CONTAINS(comment_keywords , (r"(b\*\*\*\*)") ) then 1
         when REGEXP_CONTAINS(comment_keywords , (r"(n\*\*\*\*)") ) then 1
         else 0 end) as  extra_stars
from `hatespeech-2019.HateSpeech.Parents_comments_with_split_keywords` xyz   cross join 
UNNEST(text) as comment_keywords
group by comment_id
