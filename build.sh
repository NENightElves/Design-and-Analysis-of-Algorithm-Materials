. ./config.sh

rm -r dist
mkdir dist

for d in ${tasks}; do
    npx @marp-team/marp-cli ${d}/${d}.md -o dist/${d}.html --html --theme ${theme}
done
