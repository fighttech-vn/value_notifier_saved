#!/bin/bash
set -e

flutter pub get
flutter pub publish

echo "Deploy Done !!!"