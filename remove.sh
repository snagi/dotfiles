for file in .*; do
	[ -r ~/"$file" ] && [ -f ~/"$file" ] && rm -rf ~/"$file";
done;

for file in *; do
	[ -r ~/"$file" ] && [ -f ~/"$file" ] && rm -rf ~/"$file";
	[ -r ~/"$file" ] && [ -d ~/"$file" ] && rm -rf ~/"$file";
done;

rm -rf ~/.oh-my-zsh
rm -rf ~/.zcompdump*