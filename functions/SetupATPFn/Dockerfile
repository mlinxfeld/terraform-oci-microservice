FROM oraclelinux:7-slim as ol7

RUN  yum -y install yum-utils && \
     yum -y install oracle-release-el7 && \
     yum-config-manager --enable ol7_oracle_instantclient && \
     yum -y install oracle-instantclient18.3-basic && \
     yum install -y unzip && \
     rm -rf /var/cache/yum

COPY tde_wallet.zip /usr/lib/oracle/18.3/client64/lib/network/admin/

WORKDIR /usr/lib/oracle/18.3/client64/lib/network/admin/
RUN unzip -o tde_wallet.zip -d /usr/lib/oracle/18.3/client64/lib/network/admin/ 
COPY sqlnet.ora /usr/lib/oracle/18.3/client64/lib/network/admin/

FROM fnproject/python:3.6-dev as build-stage

WORKDIR /function

ADD requirements.txt /function/

RUN pip3 install --target /python/  --no-cache --no-cache-dir -r requirements.txt && \			 
    rm -fr ~/.cache/pip /tmp* requirements.txt func.yaml Dockerfile .venv

ADD . /function/

RUN rm -fr /function/.pip_cache

FROM fnproject/python:3.6

WORKDIR /function

COPY --from=build-stage /function /function

COPY --from=build-stage /python /python

RUN mkdir -p /usr/lib/oracle/

COPY --from=ol7 /usr/lib/oracle/. /usr/lib/oracle/

RUN ln -s /usr/lib/oracle/18.3/client64/lib/libclntsh.so.18.1 /usr/lib/oracle/18.3/client64/lib/libclntsh.so

RUN ls -latr /usr/lib/oracle/18.3/client64/lib/*.*

RUN ls -latr /usr/lib/oracle/18.3/client64/lib/network/admin/*.*

ENV PYTHONPATH=/python

ENV LD_LIBRARY_PATH=/usr/lib/oracle/18.3/client64/lib

ENV TNS_ADMIN=/usr/lib/oracle/18.3/client64/lib/network/admin

ARG ARG_ADMIN_ATP_PASSWORD=password1
ENV OCIFN_ADMIN_ATP_PASSWORD=$ARG_ADMIN_ATP_PASSWORD

ARG ARG_ATP_USER=admin1
ENV OCIFN_ATP_USER=$ARG_ATP_USER

ARG ARG_ATP_PASSWORD=password1
ENV OCIFN_ATP_PASSWORD=$ARG_ATP_PASSWORD

ARG ARG_ATP_ALIAS=alias1
ENV OCIFN_ATP_ALIAS=$ARG_ATP_ALIAS

RUN apt-get install libaio1

ENTRYPOINT ["/python/bin/fdk", "/function/func.py", "handler"]

