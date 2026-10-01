
#!/bin/bash

set -e

echo "========================================"
echo "فحص مشروع البيئة الذكية"
echo "========================================"

PROJECT_DIR=$(find . -type f -name "settings.gradle" | head -n 1 | xargs dirname)

if [ -z "$PROJECT_DIR" ]; then
    echo "لم يتم العثور على مشروع Android"
    exit 1
fi

echo "مجلد المشروع:"
echo "$PROJECT_DIR"

echo ""
echo "===== ملفات Java ====="

find "$PROJECT_DIR/app/src/main/java" -type f -name "*.java" -print

echo ""
echo "===== MainActivity.java ====="

MAIN=$(find "$PROJECT_DIR/app/src/main/java" -type f -name "MainActivity.java" | head -n 1)

if [ -z "$MAIN" ]; then
    echo "لم يتم العثور على MainActivity.java"
    exit 1
fi

echo "المسار:"
echo "$MAIN"

echo ""
echo "----- بداية الملف -----"
cat "$MAIN"
echo "----- نهاية الملف -----"

echo ""
echo "===== AndroidManifest.xml ====="

MANIFEST="$PROJECT_DIR/app/src/main/AndroidManifest.xml"

if [ -f "$MANIFEST" ]; then
    cat "$MANIFEST"
else
    echo "لم يتم العثور على AndroidManifest.xml"
fi

echo ""
echo "===== build.gradle ====="

find "$PROJECT_DIR/app" -maxdepth 1 -type f \( -name "build.gradle" -o -name "build.gradle.kts" \) -print -exec cat {} \;

echo ""
echo "========================================"
echo "انتهى الفحص بنجاح"
echo "========================================"
