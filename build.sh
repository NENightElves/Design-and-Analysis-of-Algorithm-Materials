. ./config.sh

if [ -d dist ]; then
    rm -r dist
fi
mkdir dist

for d in ${marps}; do
    npx --yes @marp-team/marp-cli ${d}/${d}.md -o dist/${d}.html --html --theme ${theme}
    if [ -d ${d}/${d}-assets ]; then
        cp -r ${d}/${d}-assets dist
    fi
done

for d in ${mds}; do
    npx --yes markdown-to-html-cli --source <(cat math-template.html ${d}/${d}.md) --output dist/${d}.html
    if [ -d ${d}/${d}-assets ]; then
        cp -r ${d}/${d}-assets dist
    fi
done
