FROM ghcr.io/quarto-dev/quarto:1.10.19

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-venv \
    && rm -rf /var/lib/apt/lists/*
COPY requirements.txt ./
RUN python3 -m venv /opt/site-venv \
    && /opt/site-venv/bin/pip install --no-cache-dir -r requirements.txt
ENV PATH="/opt/site-venv/bin:${PATH}"

COPY . .
EXPOSE 4000
CMD ["quarto", "preview", "--host", "0.0.0.0", "--port", "4000", "--no-browser"]