#!/usr/bin/env bash
set -euo pipefail
LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")
RANGE="${LAST_TAG:+${LAST_TAG}..HEAD}"
echo "# Changelog" > CHANGELOG.md
echo "" >> CHANGELOG.md
echo "## [Unreleased] - $(date +%Y-%m-%d)" >> CHANGELOG.md
echo "### Added" >> CHANGELOG.md
git log $RANGE --pretty=format:"- %s (%h)" --grep="^feat" --grep="^add" -i >> CHANGELOG.md || true
echo -e "
### Fixed" >> CHANGELOG.md
git log $RANGE --pretty=format:"- %s (%h)" --grep="^fix" --grep="^bug" -i >> CHANGELOG.md || true
echo -e "
### Changed" >> CHANGELOG.md
git log $RANGE --pretty=format:"- %s (%h)" --grep="^refactor" --grep="^chore" --grep="^perf" -i >> CHANGELOG.md || true
