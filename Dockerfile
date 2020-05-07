FROM python:2-alpine

RUN mkdir -p /app/speedtest/
RUN mkdir -p /logs

RUN apk add --update curl
RUN curl https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -o /app/speedtest/speedtest-cli
RUN chmod +x /app/speedtest/speedtest-cli

ADD speedtest.sh /app/speedtest/
RUN chmod +x /app/speedtest/speedtest.sh
RUN rm -rf /var/lib/apt/lists/*

CMD sh -c /app/speedtest/speedtest.sh
