from google.cloud import bigquery
from google.cloud import bigquery_storage_v1beta1
from google.oauth2 import service_account
from google_auth_oauthlib import flow
import os


def get_credentials():
    # appflow = flow.InstalledAppFlow.from_client_secrets_file(
    #     'client_stores.json',
    #     scopes=['https://www.googleapis.com/auth/bigquery'])
    #
    # appflow.run_console()
    # return appflow.credentials

    credentials = service_account.Credentials.from_service_account_file(
        'service-account.json',
        scopes=["https://www.googleapis.com/auth/cloud-platform"],
    )
    return credentials


def create_client():
    credentials = get_credentials()
    print("Authentication Successful")
    return bigquery.Client(project='hatespeech-2019', credentials=credentials)


def create_storage_client():
    credentials = get_credentials()
    print("Authentication Successful")
    return bigquery_storage_v1beta1.BigQueryStorageClient(
        credentials=credentials
    )


def get_job_config():
    job_config = bigquery.LoadJobConfig()
    job_config.source_format = bigquery.SourceFormat.NEWLINE_DELIMITED_JSON
    job_config.autodetect = True
    return job_config


def get_table_ref(client, dataset_id, table_id):
    dataset_ref = client.dataset(dataset_id)
    return dataset_ref.table(table_id)


def execute_job(client, source_file, comment_type):
    if comment_type == "parent":
        dataset_id = 'Parent_Comments'
        table_id = 'Comments'

    elif comment_type == "child":
        dataset_id = 'Child_Comments'
        table_id = 'Replies'

    table_ref = get_table_ref(client, dataset_id, table_id)
    print("Uploading the data....from {}".format(source_file))
    job = client.load_table_from_file(source_file, table_ref, location="us", job_config=get_job_config())
    job.result()  # Waits for table load to complete.
    print("Loaded {} rows into {}:{}.".format(job.output_rows, dataset_id, table_id))


def run_job(source_file_name, client, comment_type):
    source_file = open(source_file_name, "rb")
    execute_job(client, source_file, comment_type)
    print("Processed Delimited file {} ".format(source_file_name))
    source_file.close()

    os.remove(source_file_name)
    print("Deleted Delimited file {} ".format(source_file_name))


def get_rows_from_table():
    client = create_client()
    bqstorageclient = create_storage_client()
    dataset_id = 'Final_DataSet'
    table_id = 'Channel_Videos_Comments_Merged'
    table_ref = get_table_ref(client, dataset_id, table_id)
    rows = client.list_rows(
        table_ref
    )
    dataframe = rows.to_dataframe(bqstorage_client=bqstorageclient)
    return dataframe

