
enar2014.pdf: enar2014.tex Figs/dot1a.pdf
	pdflatex enar2014

Figs/dot1a.pdf: R/dots.R
	cd R;R CMD batch dots.R
