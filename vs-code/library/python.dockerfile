# python
RUN apt-get install -y \
  python3 \
  python3-pip 

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN python -m pip install pip 
RUN pip3 install markupsafe
RUN pip3 install \
  grip \
  python-lsp-server 