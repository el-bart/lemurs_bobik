FROM debian:12
RUN apt-get update && apt-get dist-upgrade -y

# debian 12 has KiCad 6.0 by default - installing 7.0 from newer rc instead
#RUN apt-get update && apt-get install -y --no-install-recommends \
#    kicad \
#    kicad-packages3d
RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      ca-certificates \
      openssl && \
    cd /tmp/ && \
    wget "https://ftp.debian.org/debian/pool/main/k/kicad/kicad_7.0.10+dfsg-1~bpo12+1_amd64.deb" && \
    wget "https://ftp.debian.org/debian/pool/main/k/kicad/kicad-libraries_7.0.10+dfsg-1_all.deb" && \
    wget "https://ftp.debian.org/debian/pool/main/k/kicad-footprints/kicad-footprints_7.0.10-1~bpo12+1_all.deb" && \
    wget "https://ftp.debian.org/debian/pool/main/k/kicad-packages3d/kicad-packages3d_7.0.10-1~bpo12+1_all.deb" && \
    wget "https://ftp.debian.org/debian/pool/main/k/kicad-symbols/kicad-symbols_7.0.10-1~bpo12+1_all.deb" && \
    wget "https://ftp.debian.org/debian/pool/main/k/kicad-templates/kicad-templates_7.0.9-1~bpo12+1_all.deb" && \
    apt-get install -y ./*.deb && \
    rm *.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
    prusa-slicer

RUN apt-get update && apt-get install -y --no-install-recommends \
    fakeroot \
    make \
    gzip \
    tar \
    zip

COPY \
  generate_bom \
  generate_stl \
  list_cu_layers \
  print_on_error \
  /usr/local/bin/
