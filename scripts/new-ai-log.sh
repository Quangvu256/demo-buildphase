#!/usr/bin/env bash
# Create a new AI log entry from ai-log/TEMPLATE.md and append it to ai-log/INDEX.md
# Usage: ./scripts/new-ai-log.sh <member> <topic-kebab-case>
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: $0 <member> <topic-kebab-case>" >&2
  exit 1
fi

member="$1"
topic="$2"
for v in "$member" "$topic"; do
  if [[ ! "$v" =~ ^[a-z0-9-]+$ ]]; then
    echo "Only lowercase a-z, 0-9 and '-' allowed: '$v'" >&2
    exit 1
  fi
done

root="$(cd "$(dirname "$0")/.." && pwd)"
date="$(date +%F)"
name="${date}_${member}_${topic}.md"
path="$root/ai-log/sessions/$name"

if [ -e "$path" ]; then
  echo "Already exists: ai-log/sessions/$name" >&2
  exit 1
fi

mkdir -p "$root/ai-log/sessions"
sed -e "s/{{DATE}}/$date/g" -e "s/{{MEMBER}}/$member/g" -e "s/{{TOPIC}}/$topic/g" \
  "$root/ai-log/TEMPLATE.md" > "$path"
echo "| $date | $member | $topic | [sessions/$name](sessions/$name) |" >> "$root/ai-log/INDEX.md"

echo "Created ai-log/sessions/$name"
