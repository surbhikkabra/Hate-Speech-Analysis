GOAL

This code uses Python language to parse the json (nested json) and convert it in a form which can be consumed by GCP (Big Query for further analysis.

DESCRIPTION

The data is obtained from Youtube by making Rest API calls. The output is in the form of nested json. The expectation is to upload all the data on an analytical platform(Big Query by Google Cloud) so that further analysis can be carried out.
However, Big query expects new-line delimited json as the input. Hence, this code parses the unformatted json and transforms it into a new-line delimited json.
