#!/bin/bash

if [ "$1" = "ups.discovery" ]; then
  hosts=${2:-localhost}  # Default to 'localhost' if not provided

  echo -e "{\n\t\"data\":["
  first=1

  # Process the hosts (either provided or default to 'localhost')
  IFS=',' read -ra ADDR <<< "$hosts"
  for host in "${ADDR[@]}"; do
    # Capture the output of /bin/upsc
    discovered_output=$(/bin/upsc -l "$host" 2>&1 | grep -v SSL)

    # Process each line of the output
    IFS=$'\n'  # Set IFS to newline for proper line splitting
    for discovered in $discovered_output; do
      if [[ ! "$discovered" =~ ^Error ]]; then
        if [ $first -eq 0 ]; then
          echo -e ","
        fi
        echo -e "\t\t{ \"{#UPSNAME}\": \"${discovered}\", \"{#UPSHOST}\": \"${host}\" }"
        first=0
      fi
    done
  done

  echo -e "\t]\n}"

else

  if [ $# -eq 2 ]; then
    ups=$1 # interpret the first parameter as the UPS name
    key=$2 # interpret the second parameter as the key
  elif [ $# -eq 3 ]; then
    ups="$1@$2" # interpret the first parameter as the UPS name and the second as the host name
    key=$3 # interpret the third parameter as the key
  fi

  if [[ $key == ups.status ]]; then
    state=$(/bin/upsc $ups $key 2>&1 | grep -v SSL)
    case "$state" in
      "OL")        echo 1 ;;  #'On line (mains is present)' ;;
      "OB")        echo 2 ;;  #'On battery' ;;
      "LB")        echo 3 ;;  #'Low battery' ;;
      "RB")        echo 4 ;;  #'The battery needs to be replaced' ;;
      "CHRG")      echo 5 ;;  #'The battery is charging' ;;
      "DISCHRG")   echo 6 ;;  #'The battery is discharging (inverter is providing load power)' ;;
      "BYPASS")    echo 7 ;;  #'UPS bypass circuit is active, no battery protection available' ;;
      "CAL")       echo 8 ;;  #'UPS is currently performing runtime calibration (on battery)' ;;
      "OFF")       echo 9 ;;  #'UPS is offline and is not supplying power to the load' ;;
      "OVER")      echo 10 ;; #'UPS is overloaded' ;;
      "TRIM")      echo 11 ;; #'UPS is trimming incoming voltage (called "buck" in some hardware)' ;;
      "BOOST")     echo 12 ;; #'UPS is boosting incoming voltage' ;;
      "OL CHRG")   echo 13 ;; #'On battery (mains absent) and the battery is charging' ;;
      "OB DISCHRG") echo 14 ;; #'On battery discharging (mains absent)
      *)           echo 0 ;;  #'unknown state' ;;
    esac
  else
    output=$(/bin/upsc $ups $key 2>&1 | grep -v SSL)

    if [ "$output" == "Error: Variable not supported by UPS" ]; then
      echo -1
    else
      echo "$output"
    fi
  fi

fi