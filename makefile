LATEX = pdflatex -interaction=nonstopmode -file-line-error

%.pdf: %.tex
	$(LATEX) -output-directory "$(@D)" "$<"
	$(LATEX) -output-directory "$(@D)" "$<"
	$(LATEX) -output-directory "$(@D)" "$<"
