if [ -z "$1" ]
then
echo -e USAGE:\\n./compile.sh MANUSCRIPTNAME\\nDO NOT USE MANUSCRIPTNAME.tex !!!
exit 1
fi
R --no-save --no-restore < compile.R
pdflatex "$1.tex"
bibtex "$1.aux"
pdflatex "$1.tex"
pdflatex "$1.tex"
pdflatex "$1.tex"

