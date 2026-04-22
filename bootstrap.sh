#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"; 

MODE="";
DO_PULL=false;

for arg in "$@"; do
	case "$arg" in
		--no-pull|-P) DO_PULL=false ;;
		--diff|-d)    MODE="diff" ;;
		--dry-run|-n) MODE="dry-run" ;;
		--force|-f)   MODE="force" ;;
		*) echo "Unknown option: $arg"; exit 1;;
	esac;
done;

if $DO_PULL; then
	git pull origin main;
fi;

RSYNC_EXCLUDES=(
	--exclude ".git/"
	--exclude ".DS_Store"
	--exclude ".osx"
	--exclude "bootstrap.sh"
	--exclude "brew.sh"
	--exclude "linux-brew.sh"
    --exclude "linux-brew-base.sh"
	--exclude "remove.sh"
	--exclude "setup-ws.sh"
	--exclude "README.md"
	--exclude "LICENSE-MIT.txt"
)

function diffIt() {
	local found_diff=0;

	# Patterns that are excluded from rsync (mirrored for find)
	local find_excludes=(
		-not -path "./.git/*"
		-not -name ".DS_Store"
		-not -name ".osx"
		-not -name "bootstrap.sh"
		-not -name "brew.sh"
		-not -name "linux-brew.sh"
		-not -name "linux-brew-base.sh"
		-not -name "remove.sh"
		-not -name "setup-ws.sh"
		-not -name "README.md"
		-not -name "LICENSE-MIT.txt"
	);

	while IFS= read -r -d '' src; do
		local relpath="${src#./}";
		local dst="${HOME}/${relpath}";

		if [ ! -e "$dst" ]; then
			echo "new file: ${relpath}";
			found_diff=1;
		elif ! diff -q "$src" "$dst" > /dev/null 2>&1; then
			found_diff=1;
			if command -v git &>/dev/null; then
				# git diff --no-index exits 1 when files differ; suppress that
				git --no-pager diff --no-index --color=always "$dst" "$src" || true;
			else
				diff -u "$dst" "$src" || true;
			fi;
		fi;
	done < <(find . -type f "${find_excludes[@]}" -print0 | sort -z);

	if [ "$found_diff" -eq 0 ]; then
		echo "No differences found — files are already in sync.";
	fi;
}

function dryRunIt() {
	rsync "${RSYNC_EXCLUDES[@]}" \
		--dry-run --itemize-changes \
		-avh --no-perms . ~;
}

function doIt() {
	rsync "${RSYNC_EXCLUDES[@]}" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$MODE" == "diff" ]; then
	diffIt;
elif [ "$MODE" == "dry-run" ]; then
	dryRunIt;
elif [ "$MODE" == "force" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Show diff first, sync, or cancel? (d/s/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Dd]$ ]]; then
		diffIt;
		read -p "Proceed with sync? (y/n) " -n 1;
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			doIt;
		fi;
	elif [[ $REPLY =~ ^[Ss]$ ]]; then
		doIt;
	fi;
fi;
unset -f diffIt dryRunIt doIt;
