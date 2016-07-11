#!/bin/sh

while read -r line; do
    $($line) &
done
