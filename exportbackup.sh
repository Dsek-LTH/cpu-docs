#!/bin/sh

#admin_key="insert your privat key here"

#Start export
#export_date=$(date +"%Y-%m-%d")
folder='run_info/'
download='cpu_backup.zip'
export_init="${folder}export_init.json"
file_op_info="${folder}file_op_info.json"
redirect_link="${folder}redirect.txt"
destination_folder='cpu_docs_backup'

curl -s -o $export_init -X POST https://cpu.dsek.se/api/collections.export_all \
  -H "Authorization: Bearer $admin_key"

export_request_status=$(jq -r '.status' $export_init)
if [ "$export_request_status" != "200" ]; then
  echo "Failed to initialize export. Error code: ${export_request_status}"
  exit 1
fi
op_id=$(jq -r '.data.fileOperation.id' $export_init)

echo "Operation ID: $op_id"

while true; do 
  curl -s -o $file_op_info https://cpu.dsek.se/api/fileOperations.info \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $admin_key" \
  --data "{\"id\":\"$op_id\"}" 

  export_info_status=$(jq -r '.status' $file_op_info)
  export_completion_status=$(jq -r '.data.state' $file_op_info)
  if [ "$export_info_status" == "429" ]; then
    echo "Rate limited operation"
    exit 1
  elif [ "$export_completion_status" == "complete" ]; then
    echo "EXPORT COMPLETE"
    break
  else
    echo "EXPORTING... $export_completion_status"
    sleep 5
  fi 
done 

#-L -o export.zip
curl -o $redirect_link -X POST https://cpu.dsek.se/api/fileOperations.redirect \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $admin_key" \
  --data "{\"id\": \"$op_id\"}"

download_url=$(grep -oP '(?<=href=")https://cpu.dsek.se/api/files.get[^"]*' $redirect_link)

if [[ -z "$download_url" ]]; then
  echo "No export URL generated"
  exit 1
fi

curl -L -o $download $download_url

sleep 5

rm -r $destination_folder
unzip $download -d $destination_folder
bash upload.sh