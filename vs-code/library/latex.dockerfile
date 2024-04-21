# latex
RUN apt-get -y install \
  latexmk \
  texinfo \
  texlive-luatex \
  texlive-latex-extra \
  texlive-bibtex-extra \
  texlive-formats-extra \
  texlive-fonts-extra \
  texlive-lang-all

RUN mkdir /home/user/texmf \
  && curl -k 'https://raw.githubusercontent.com/darwiin/yaac-another-awesome-cv/master/yaac-another-awesome-cv.cls' \
  -o /home/user/texmf/yaac-another-awesome-cv.cls
