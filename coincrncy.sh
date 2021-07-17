#!/bin/bash

# User input
read -p "Enter the coin name : " coin
read -p "Enter your national currency : " crncy

# Creating files
touch temp.json price.txt

# Fetching the API aand stroing json response in file
curl -o temp.json -X 'GET' \
  'https://api.coingecko.com/api/v3/coins/'$coin'/market_chart?vs_currency='$crncy'&days='$days'' \
  -H 'accept: application/json' &> /dev/null

# Pattern finding in file
grep -o -P '(?<=,).*(?=]],"m)' temp.json > price.txt

# Assigning the price value in file to variable
while read val
do
	p=$val
done < price.txt

# Converting the scientific notation price to decimal
price=`printf "%.15f" $p`

echo "The value of $coin in $crncy is = $price"
rm temp.json
