# Define your JSON file path
JSON_FILE="./greeting-cards.json" # Change this to your JSON file path
DOWNLOAD_FOLDER="/Users/monsichasris/Documents/MJS/major-studio-1/project03/download_cards/cardImgDownload"

# Create the download directory if it doesn't exist
mkdir -p "$DOWNLOAD_FOLDER"

# Parse JSON
jq -c '.[] | select(.id != null and .img_preview != null) | {id: .id, url: .img_preview}' "$JSON_FILE" | \
while IFS= read -r item; do
    # Extract the details from the JSON object
    URL=$(echo "$item" | jq -r '.url')
    ID=$(echo "$item" | jq -r '.id')

    # Create a valid filename
    FILE_NAME="${ID}.jpg"
    FILE_PATH="$DOWNLOAD_FOLDER/$FILE_NAME"

  # Check if URL is not null or empty
if [ -n "$URL" ] && [ "$URL" != "null" ]; then
    # Download the image using curl or wget
    if curl -L -o "$FILE_PATH" "$URL"; then
        echo "Downloaded: $FILE_PATH"
    else
        echo "Failed to download: $URL"
    fi
else
    echo "URL is empty or null for ID: $ID"
fi

    
    echo "Downloaded: $FILE_PATH"
done