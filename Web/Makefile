all: js json resources.html

js: 1a/manyboxplots.js 1b/lod_and_effect.js 1c/corr_w_scatter.js 1d/cistrans.js 2a/phe_vs_time.js 2b/lod_by_time.js nav/nav.js

json: 2a/phe_vs_time.json

resources.html: resources.md
	R -e 'library(markdown);markdownToHTML("resources.md", "resources.html")'

1a/manyboxplots.js: 1a/manyboxplots.coffee
	coffee -c 1a/manyboxplots.coffee

1b/lod_and_effect.js: 1b/lod_and_effect.coffee
	coffee -cb 1b/lod_and_effect.coffee

1c/corr_w_scatter.js: 1c/corr_w_scatter.coffee
	coffee -cb 1c/corr_w_scatter.coffee

1d/cistrans.js: 1d/cistrans.coffee
	coffee -cb 1d/cistrans.coffee

2a/phe_vs_time.js: 2a/phe_vs_time.coffee
	coffee -c 2a/phe_vs_time.coffee

2b/lod_by_time.js: 2b/lod_by_time.coffee
	coffee -c 2b/lod_by_time.coffee

nav/nav.js: nav/nav.coffee
	coffee -bc nav/nav.coffee

2a/phe_vs_time.json: 2a/phe.csv 2a/phe2json.R
	cd 2a;Rscript phe2json.R

web: js
	scp *.html *.css *.png *.pdf broman-2:public_html/posters/ENAR2014/
	cd 1a;scp *.html *.js broman-2:public_html/posters/ENAR2014/1a/
	cd 1b;scp *.html *.js broman-2:public_html/posters/ENAR2014/1b/
	cd 1c;scp *.html *.js broman-2:public_html/posters/ENAR2014/1c/
	cd 1d;scp *.html *.js broman-2:public_html/posters/ENAR2014/1d/
	cd 2a;scp *.html *.js broman-2:public_html/posters/ENAR2014/2a/
	cd 2b;scp *.html *.js broman-2:public_html/posters/ENAR2014/2b/
	cd nav;scp *.js broman-2:public_html/posters/ENAR2014/nav/
	cd panels;scp *.js broman-2:public_html/posters/ENAR2014/panels/
	cd panels/scatterplot;scp *.js broman-2:public_html/posters/ENAR2014/panels/scatterplot
