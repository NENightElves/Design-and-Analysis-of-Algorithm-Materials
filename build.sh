. ./config.sh

if [ -d dist ]; then
    rm -r dist
fi
mkdir dist

for d in ${tasks}; do
    npx @marp-team/marp-cli ${d}/${d}.md -o dist/${d}.html --html --theme ${theme}
    if [ -d ${d}/${d}-assets ]; then
        cp -r ${d}/${d}-assets dist
    fi
done
