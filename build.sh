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
    cat mathjax-template.html ${d}/${d}.md > ${d}/temp.md
    npx --yes markdown-to-html-cli --source ${d}/temp.md --output dist/${d}.html
    rm ${d}/temp.md
    if [ -d ${d}/${d}-assets ]; then
        cp -r ${d}/${d}-assets dist
    fi
done
