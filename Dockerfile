FROM python:2.7

# Add the python LDAP module
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
                    python-dev libldap2-dev libsasl2-dev libssl-dev \
                    curl

RUN pip install python-ldap

# Add the LDAP auth daemon from our fork of https://github.com/nginxinc/nginx-ldap-auth
RUN curl -L https://raw.githubusercontent.com/Mapscape/nginx-ldap-auth/master/nginx-ldap-auth-daemon.py > /usr/local/bin/nginx-ldap-auth-daemon.py \
 && chmod +x /usr/local/bin/nginx-ldap-auth-daemon.py

EXPOSE 8888

# Run the daemon application
CMD ["python", "-u", "/usr/local/bin/nginx-ldap-auth-daemon.py"]

