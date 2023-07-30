#!/bin/bash

#STILL IN PRODUCTION. DOES NOT WORK PROPERLY :(
# Function to create the SQL table
function create_table() {
    local rows=$1
    local cols=$2

    echo "CREATE TABLE IF NOT EXISTS my_table ("

    for ((i = 1; i <= cols; i++)); do
        echo -n "    Column$i VARCHAR(50)"
        if ((i < cols)); then
            echo ","
        else
            echo ""
        fi
    done

    echo ");"
}

# Function to insert data into the SQL table
function insert_data() {
    local rows=$1
    local cols=$2
    local file=$3

    echo "INSERT INTO my_table ("

    for ((i = 1; i <= cols; i++)); do
        echo -n "    Column$i"
        if ((i < cols)); then
            echo ","
        else
            echo ""
        fi
    done

    echo ") VALUES" > "$file"

    for ((i = 1; i <= rows; i++)); do
        echo -n "    ("

        for ((j = 1; j <= cols; j++)); do
            read -p "Enter value for row $i, column $j: " value
            echo -n "'$value'"
            if ((j < cols)); then
                echo -n ", "
            else
                echo ""
            fi
        done

        if ((i < rows)); then
            echo "    )," >> "$file"
        else
            echo "    );" >> "$file"
        fi
    done
}

# Main script
echo "Welcome to the SQL Table Creator!"
read -p "Enter the number of rows for the table: " num_rows
read -p "Enter the number of columns for the table: " num_cols

read -p "Enter the name of the new SQL file: " sql_file_name

create_table "$num_rows" "$num_cols"
insert_data "$num_rows" "$num_cols" "$sql_file_name"

echo "Table creation and data insertion completed. The SQL commands have been saved to the file '$sql_file_name'."
