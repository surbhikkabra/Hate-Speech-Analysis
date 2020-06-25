# Introduction
This code uses Python language to parse the json (nested json) and convert it in a form which can be consumed by GCP (Big Query for further analysis.

# Raw Youtube data to BigQuery
## Extract
        130M youtube comments from 63K youtube videos were already stored in a remote server on google cloud. The raw comments were in nested json

 //Add schema

        This raw data was read using a python script running on google cloud instance.


## Tranform
	The nested json was converted into bigquery compatible format (ndjson) using a python script 	
 	[Link to code](https://github.com/surbhikkabra/BigData/tree/master/src/python)
 

 ## Load
	Another python script was written to upload this data on big query 	//Link to code



# BigQuery to Google storage
## Extract
	Extracted data from previous job using SQL

## Tranform
  	SQL queries were written to clean the data (Link to SQL)[https://github.com/surbhikkabra/BigData/tree/master/src/sql]

 ## Load
 	Using google cloud console, The cleaned data was pushed to google storage for further analysis
