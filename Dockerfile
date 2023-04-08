FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y telnetd netcat openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y net-tools

RUN useradd -m -p $(openssl passwd -1 1234) test

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY health_check.py /app/health_check.py

# Expose telnet and health check ports
EXPOSE 23
EXPOSE 9001

CMD ["/entrypoint.sh"]

