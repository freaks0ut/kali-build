#!/bin/bash

burp=$(find / -name burp*.jar 2>/dev/null | tail -1)

# Check if Burp JAR file was found
if [[ -z "$burp" ]]; then
  echo "Error: Burp JAR file not found."
  exit 1
fi

# Start Burp Suite to serve the CA certificate
/bin/bash -c "timeout 60 /usr/bin/java -Djava.awt.headless=true -jar $burp < <(echo y) &" 
sleep 45

# Attempt to fetch the certificate
curl -s --retry 5 --retry-connrefused http://localhost:8080/cert -o /tmp/cacert.der
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to retrieve Burp Suite CA certificate."
  exit 1
fi

echo "Burp Suite CA certificate downloaded successfully."
exit 0
