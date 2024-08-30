FROM redhat/ubi8:latest
RUN yum install -y wget
WORKDIR /casa
RUN wget --content-disposition https://casa.nrao.edu/download/distro/casa/release/rhel/casa-6.6.4-34-py3.10.el8.tar.xz
# Install these now for caching
RUN yum install -y tar xz perl
RUN tar -xvf casa-6.6.4-34-py3.10.el8.tar.xz
RUN rm -f casa-6.6.4-34-py3.10.el8.tar.xz
ENV PATH="/casa/casa-6.6.4-34-py3.10.el8/bin:${PATH}"
# Make CASA download its data
ENV HOME=/casa
RUN mkdir -p $HOME/.casa/data
RUN casa --log2term -c "exit"
# Now use config.py
COPY config.py ./
ENV CASASITECONFIG=/casa/config.py
ENTRYPOINT [ "casa" ]