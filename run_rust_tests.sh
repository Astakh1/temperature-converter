#!/bin/bash

echo "##teamcity[testSuiteStarted name='Rust Tests']"

cargo test --release --test integration_tests -- --nocapture 2>&1 | grep -E '^test .* \.\.\. (ok|FAILED)$' | while read line
do
    test_name=$(echo "$line" | awk '{print $2}')
    status=$(echo "$line" | awk '{print $3}')
    
    echo "##teamcity[testStarted name='$test_name']"
    
    if [ "$status" = "FAILED" ]; then
        echo "##teamcity[testFailed name='$test_name']"
    fi
    
    echo "##teamcity[testFinished name='$test_name']"
done

echo "##teamcity[testSuiteFinished name='Rust Tests']"

echo "=== Детальный вывод тестов ==="
cargo test --release --test integration_tests --verbose