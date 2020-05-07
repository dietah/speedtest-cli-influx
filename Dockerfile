FROM python:2-alpine

RUN mkdir -p /app/speedtest/
RUN apk add --update curl
RUN curl https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -o /app/speedtest/speedtest-cli
RUN chmod +x /app/speedtest/speedtest-cli

ADD speedtest.sh /app/speedtest/

CMD sh -c /app/speedtest/speedtest.sh
