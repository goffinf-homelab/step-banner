#!/bin/bash

BANNER_TEXT=$1;
BANNER_TEXT_CHAR=${2:-#};
BANNER_TEXT2=${3:-"NOT_SET"};
BANNER_TEXT3=${4:-"NOT_SET"};
BANNER_TEXT4=${5:-"NOT_SET"};
BANNER_TEXT5=${6:-"NOT_SET"};
BANNER_TEXT6=${7:-"NOT_SET"};

get_longest_banner_len () {
  local BANNER_TEXT_LEN="${#BANNER_TEXT}";
  if [ "$BANNER_TEXT2" != "NOT_SET" ]; then
    if [[ "${#BANNER_TEXT2}" -gt "${BANNER_TEXT_LEN}" ]]; then
      BANNER_TEXT_LEN="${#BANNER_TEXT2}";
    fi;
    if [ "$BANNER_TEXT3" != "NOT_SET" ]; then
      if [[ "${#BANNER_TEXT3}" -gt "${BANNER_TEXT_LEN}" ]]; then
        BANNER_TEXT_LEN="${#BANNER_TEXT3}";
      fi;
      if [ "$BANNER_TEXT4" != "NOT_SET" ]; then
        if [[ "${#BANNER_TEXT4}" -gt "${BANNER_TEXT_LEN}" ]]; then
          BANNER_TEXT_LEN="${#BANNER_TEXT4}";
        fi;
        if [ "$BANNER_TEXT5" != "NOT_SET" ]; then
          if [[ "${#BANNER_TEXT5}" -gt "${BANNER_TEXT_LEN}" ]]; then
            BANNER_TEXT_LEN="${#BANNER_TEXT5}";
          fi;
          if [ "$BANNER_TEXT6" != "NOT_SET" ]; then
            if [[ "${#BANNER_TEXT6}" -gt "${BANNER_TEXT_LEN}" ]]; then
              BANNER_TEXT_LEN="${#BANNER_TEXT6}";
            fi;
          fi;
        fi;
      fi;
    fi;
  fi;
  BANNER_TEXT_LEN="${BANNER_TEXT_LEN}+4";
  echo "$BANNER_TEXT_LEN";
}

BANNER_TEXT_LEN=$(get_longest_banner_len);

BANNER_BORDER=$(for ((i=1; i<=$BANNER_TEXT_LEN; i++));do printf "%s" "$BANNER_TEXT_CHAR";done;printf "\n");

echo "";
echo "$BANNER_BORDER";
echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR} ${BANNER_TEXT}";
if [ "$BANNER_TEXT2" != "NOT_SET" ]; then
  echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR}";
  echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR} ${BANNER_TEXT2}";
  if [ "$BANNER_TEXT3" != "NOT_SET" ]; then
    echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR}";
    echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR} ${BANNER_TEXT3}";
	if [ "$BANNER_TEXT4" != "NOT_SET" ]; then
      echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR}";
      echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR} ${BANNER_TEXT4}";
      if [ "$BANNER_TEXT5" != "NOT_SET" ]; then
        echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR}";
        echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR} ${BANNER_TEXT5}";
        if [ "$BANNER_TEXT6" != "NOT_SET" ]; then
          echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR}";
          echo "${BANNER_TEXT_CHAR}${BANNER_TEXT_CHAR} ${BANNER_TEXT6}";
        fi;
      fi;
    fi;
  fi;
fi;
echo "$BANNER_BORDER";
echo "";
