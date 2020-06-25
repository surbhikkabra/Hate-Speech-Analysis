import json
import sys
import glob
import numpy
from upload_to_big_query import run_job, create_client


def get_new_line_delimited_file(input_file_name, comment_type):

    output_file = open(input_file_name.split('.')[0] + str(comment_type) + "_delimited.json", "w+")
    input_file = open(input_file_name)

    for line in input_file:
        if line != "\n":
            data = json.loads(line)
            for k, v in data.items():
                for k1, v1 in v.items():
                    if v1:
                        if comment_type == "parent":
                            data = v1
                        elif comment_type == "child":
                            data = v1[0]

                        output_file.write(str(data) + "\n")

    print("Generated Delimited file {} ".format(output_file))
    output_file.close()
    input_file.close()
    return output_file.name

def get_file_names_in_directory(dir_name):
    result = []
    for file in glob.glob(str(dir_name) + "/" + "*.json"):
        result.append(file)

    return result


def main(root_directory, comment_type):
    client = create_client()

    input_file_names = get_file_names_in_directory(root_directory);

    for input_file in input_file_names:
        output_file = get_new_line_delimited_file(input_file, comment_type)
        run_job(output_file, client, comment_type)


if __name__ == "__main__":
    root_directory = sys.argv[1]
    comment_type = sys.argv[2]

    accepted_comment_types = ["parent", "child"]
    if comment_type not in accepted_comment_types:
        print("Invalid comment type: {}. Please choose from: {}", comment_type, accepted_comment_types)

    else:
        main(root_directory, comment_type)
