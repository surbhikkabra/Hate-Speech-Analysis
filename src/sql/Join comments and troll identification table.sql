select comments.* , troll.is_author_troll from 
`hatespeech-2019.Final_Dataset.Comment_Keyword_Classification` comments
left join `hatespeech-2019.Final_Dataset.Troll_Identification` troll
on  troll.authorChannelId = comments.authorChannelId