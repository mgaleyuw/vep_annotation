#!/bin/bash

while getopts "i:o:l:" option; do
  case $option in
    i) FILE="$OPTARG" ;;
    o) OUTPUT="$OPTARG" ;;
    l) LOG="$OPTARG" ;;
  esac
done

expression=$( echo 'rmarkdown::render("/n/scripts/vep_annotation/one_table_vep.Rmd",params=list(vepfile="'$FILE'", logfile="'$LOG'"), output_file="'$OUTPUT'")' )

Rscript -e "$expression"