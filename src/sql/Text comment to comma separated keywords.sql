 select comments_table.* except(text), ARRAY_TO_STRING(split(text," "),",") as comment_keywords , split(text," ") as text
 from `hatespeech-2019.Parent_Comments.Parent_Comments_Video_Details` as comments_table
