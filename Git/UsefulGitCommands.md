# Useful Git Commands

## Sync forked repos

```bash
git fetch upstream

git checkout master

git merge upstream/master
```

## Revert un-pushed commit

```bash
git reset --hard HEAD~1
```

## Remove merged old N branches

```bash
git branch -r --merged master --sort=committerdate | grep -v master | sed 's/origin\///' | fmt -1 | head -n -100 | xargs -n 1 git push --delete origin
```

## Remove local branches without remote

```bash
git checkout master

git fetch -p 

git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
```

## Change the capitalization of filenames

```bash
git mv src/collision/b2AABB.js src/collision/B2AABB.js
```

## Others

```bash
git branch --all --merged remotes/origin/master | grep --invert-match master | grep --invert-match webrtc | grep --invert-match release | grep --invert-match HEAD | grep "remotes/origin/" | cut -d "/" -f 3- | xargs -n 1 git push --delete origin^C
```

```bash
git branch -v | grep -E 'ahead|behind' | sed -r 's/[ *]\s(\S*).*(\[(ahead|behind).+?\]).*/\1 \2/g'
```

```bash
git branch -v | grep -E 'ahead|behind' --invert-match | grep --invert-match master | cut -d "/" -f 3-
```

## View history for part of a file (like a function)

```bash
git log -L 15,26:path/to/file
```
