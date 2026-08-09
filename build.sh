. ./config.sh

for d in ${tasks}; do
    npx @marp-team/marp-cli ${d}.md -o ${d}.html --html --theme ${theme}
done
