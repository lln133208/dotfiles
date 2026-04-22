#!/bin/bash
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
s=$(git status --porcelain 2>/dev/null)
r=""
if [ -n "$s" ]; then
  staged=$(echo "$s" | grep -c '^[MADRCT]')
  modified=$(echo "$s" | grep -c '^.[MD]')
  deleted=$(echo "$s" | grep -cE '^D.|^.D ')
  untracked=$(echo "$s" | grep -c '^??')
  [ "$staged" -gt 0 ] 2>/dev/null && r="${r}+${staged} "
  [ "$modified" -gt 0 ] 2>/dev/null && r="${r}~${modified} "
  [ "$deleted" -gt 0 ] 2>/dev/null && r="${r}-${deleted} "
  [ "$untracked" -gt 0 ] 2>/dev/null && r="${r}?${untracked} "
fi
stash=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
[ "$stash" -gt 0 ] 2>/dev/null && r="${r}S${stash} "
ab=$(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
if [ -n "$ab" ]; then
  ahead=$(echo "$ab" | awk '{print $1}')
  behind=$(echo "$ab" | awk '{print $2}')
  [ "$ahead" -gt 0 ] 2>/dev/null && r="${r}⇡${ahead} "
  [ "$behind" -gt 0 ] 2>/dev/null && r="${r}⇣${behind} "
fi
r=$(echo "$r" | sed 's/ $//')
[ -n "$r" ] && printf "[%s]" "$r"
