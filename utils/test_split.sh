#!/bin/bash
set -e

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ./utils/test_split.sh [DATASET] [PRE-PROCESSING] [DATASET PATH]"
    echo "[DATASET]: is the number associated with the dataset selection"
    echo "Dataset Options:"
    echo "1 - Python Encoder Dataset"
    echo "2 - Assembly Decoder Dataset"
    echo "3 - Powershell Dataset"
    echo "[PRE-PROCESSING]: is the number associated with a pre-processing option"
    echo "Preprocessing Options:"
    echo "0 - used for raw corpus token counts"
    echo "1 - Preprocessing without the Intent Parser (IP)"
    echo "2 - Preprocessing with the Intent Parser (IP)"
    echo "[DATASET PATH] if not indicated it is './datasets/'" 
    exit 1
fi;

SDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WDIR=$SDIR"/../"

DATASET=$WDIR"/datasets/"
if [ -n "$3" ]; then
    DATASET=$3
fi

#echo "sdir $SDIR"
#echo "wdir $WDIR"
rm -rf $WDIR/processed_dataset
mkdir $WDIR/processed_dataset

function echo_time() {
    date +"%Y-%m-%d %H:%M:%S.%6N  $*"
}

# Assumes running from
# home directory.



echo "Dataset path setted with: $DATASET"

if [ $1 -eq 1 ]; then
    echo_time "You selected the Python Encoder dataset"
    # Convert Python Dataset to JSON
    echo_time "Converting and moving the dataset ..."
    python text_to_json.py $DATASET/encoder/encoder-dev.in $DATASET/encoder/encoder-dev.out
    python text_to_json.py $DATASET/encoder/encoder-train.in $DATASET/encoder/encoder-train.out
    python text_to_json.py $DATASET/encoder/encoder-test.in $DATASET/encoder/encoder-test.out
    mv $WDIR/encoder-*.json $WDIR/processed_dataset/

    #double check this
    echo_time "Extracting raw data ..."
    cd $WDIR/processed_dataset/
    python $SDIR/preproc/our_extract_raw_data.py $1 $2 # > raw_data.txt
    # Preprocess Assembly Dataset
    echo_time "Preprocessing ..."
    python $SDIR/preproc/json_to_seq2seq.py encoder-train.json.seq2seq encoder-train.intent encoder-train.snippet
    python $SDIR/preproc/json_to_seq2seq.py encoder-test.json.seq2seq encoder-test.intent encoder-test.snippet
    python $SDIR/preproc/json_to_seq2seq.py encoder-dev.json.seq2seq encoder-dev.intent encoder-dev.snippet



elif [ $1 -eq 2 ]; then
    echo_time "You selected the Assembly Decoder dataset"
    # Convert Assembly Dataset to JSON
    echo_time "Converting and moving the dataset ..."
    python text_to_json.py $DATASET/decoder/decoder-dev.in $DATASET/decoder/decoder-dev.out
    python text_to_json.py $DATASET/decoder/decoder-train.in $DATASET/decoder/decoder-train.out
    python text_to_json.py $DATASET/decoder/decoder-test.in $DATASET/decoder/decoder-test.out
    mv $WDIR/decoder-*.json $WDIR/processed_dataset/

    #double check this
    echo_time "Extracting raw data ..."
    cd $WDIR/processed_dataset/
    python $SDIR/preproc/our_extract_raw_data.py $1 $2 # > raw_data.txt
    # Preprocess Assembly Dataset
    echo_time "Preprocessing ..."
    python $SDIR/preproc/json_to_seq2seq.py decoder-train.json.seq2seq decoder-train.intent decoder-train.snippet
    python $SDIR/preproc/json_to_seq2seq.py decoder-test.json.seq2seq decoder-test.intent decoder-test.snippet
    python $SDIR/preproc/json_to_seq2seq.py decoder-dev.json.seq2seq decoder-dev.intent decoder-dev.snippet

elif [ $1 -eq 3 ]; then
    echo_time "You selected the Powershell dataset"
    # Convert Powershell Dataset to JSON
    echo_time "Converting and moving the dataset ..."
    python text_to_json.py $DATASET/powershell-train.in $DATASET/powershell-train.out
    python text_to_json.py $DATASET/powershell-dev.in $DATASET/powershell-dev.out
    python text_to_json.py $DATASET/powershell-test.in $DATASET/powershell-test.out
    mv $WDIR/powershell-*.json $WDIR/processed_dataset/

    #double check this
    echo_time "Extracting raw data ..."
    cd $WDIR/processed_dataset/
    python $SDIR/preproc/our_extract_raw_data.py $1 $2 # > raw_data.txt
    # Preprocess Assembly Dataset
    echo_time "Preprocessing ..."
    python $SDIR/preproc/json_to_seq2seq.py powershell-train.json.seq2seq powershell-train.intent powershell-train.snippet
    python $SDIR/preproc/json_to_seq2seq.py powershell-test.json.seq2seq powershell-test.intent powershell-test.snippet
    python $SDIR/preproc/json_to_seq2seq.py powershell-dev.json.seq2seq powershell-dev.intent powershell-dev.snippet

fi
cd $WDIR

echo "Done!"









