#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
	echo "Missing parameters:"
	echo "Usage: command <year> <month_num [1-12]> <day_num [1-31]> <account_name> <amount> [<notes>]" 
	exit
fi

function month_to_number()
{
    local month_str=$1
    
    if [ "$1" == "1" ]; then
        echo "January"
    elif [ "$1" == "2" ]; then
        echo "February"
    elif [ "$1" == "3" ]; then
        echo "March"
    elif [ "$1" == "4" ]; then
        echo "April"
    elif [ "$1" == "5" ]; then
        echo "May"
    elif [ "$1" == "6" ]; then
        echo "June"
    elif [ "$1" == "7" ]; then
        echo "July"
    elif [ "$1" == "8" ]; then
        echo "August"
    elif [ "$1" == "9" ]; then
        echo "September"
    elif [ "$1" == "10" ]; then
        echo "October"
    elif [ "$1" == "11" ]; then
        echo "November"
    elif [ "$1" == "12" ]; then
        echo "December"
    else
        echo "unknown_month"
        exit
    fi
}

year=$1
month_num=$2
day=$3
account=$4
amount=$5
notes=$6 || ""

month=$(month_to_number "${month}")

echo "MATCH (y:FinancialYear {name:'${year}'})-[]->(m:FinancialMonth {name:'${month}'})-[]->(acct:FinancialAccount {name:'${account}'})"
echo "CREATE (debit:AccountDebit {date: date('${year}-${month_num}-${day}'), amount:${amount}, notes:'${notes}'})<-[rel:ENTRY]-(acct) RETURN acct, rel, debit;"