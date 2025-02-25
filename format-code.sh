#!/usr/bin/env sh

VERSION=1.25.2
JARFILE=google-java-format-$VERSION-all-deps.jar

mkdir -p .cache
cd .cache

if [ ! -f "$JARFILE" ]; then
    curl -LJO "https://github.com/google/google-java-format/releases/download/v$VERSION/$JARFILE"
    chmod 755 "$JARFILE"
fi

cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*\.java$" )

if [[ -n "$changed_java_files" ]]; then  # Check if any files were found
    echo "Formatting these files:"
    echo "$changed_java_files"

    # Use xargs to handle potential spaces in filenames
    echo "$changed_java_files" | xargs -0 -n 1 java -jar .cache/"$JARFILE" --aosp --replace

else
    echo "No staged Java files found to format."
fi
