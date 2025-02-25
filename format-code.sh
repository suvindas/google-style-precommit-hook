#!/usr/bin/env sh

VERSION=1.25.2 # Or your preferred version
JARFILE=google-java-format-$VERSION-all-deps.jar

mkdir -p .cache
cd .cache

if [ ! -f "$JARFILE" ]; then
    curl -LJO "https://github.com/google/google-java-format/releases/download/v$VERSION/$JARFILE"
    chmod 755 "$JARFILE"
fi

cd ..

# Find all Java files in the project
java_files=$(find . -name "*.java") # Find all .java files

if [[ -n "$java_files" ]]; then
    echo "Formatting all Java files:"
    echo "$java_files"

    echo "$java_files" | xargs -0 -n 1 java -jar .cache/"$JARFILE" --aosp --replace # Use xargs for robust filename handling

else
    echo "No Java files found in the project."
fi
