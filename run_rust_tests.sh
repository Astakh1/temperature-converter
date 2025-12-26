#!/bin/bash

echo "##teamcity[testSuiteStarted name='Rust Tests']"

# Запускаем тесты и фильтруем только строки с результатами
cargo test --release --test integration_tests -- --format=terse 2>&1 | grep -E '^test .* \.\.\. (ok|FAILED)$' | while read line
do
    test_name=$(echo "$line" | cut -d' ' -f2)
    status=$(echo "$line" | cut -d' ' -f3)
    
    echo "##teamcity[testStarted name='$test_name']"
    
    if [ "$status" = "FAILED" ]; then
        echo "##teamcity[testFailed name='$test_name']"
    fi
    
    echo "##teamcity[testFinished name='$test_name']"
done

echo "##teamcity[testSuiteFinished name='Rust Tests']"

echo "=== Детальный вывод тестов ==="
cargo test --release --test integration_tests --verbose