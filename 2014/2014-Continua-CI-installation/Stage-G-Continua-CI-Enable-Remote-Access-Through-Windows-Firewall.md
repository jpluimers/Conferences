# Stage G: Enable Remote Access to Continua CI Web Server Through Windows Firewall

By default the Windows Firewall neither allows http port 80 nor port 8080 to be accessible from the outside world.

These steps show you how to do that for both port 80 (the default http port for IIS) and port 8080 (the default port for the Continua CI web server configuration).

Alternatively, you can have Continua CI be served as a sub-part of the default http port. 

## Step G00: Windows firewall
![G00-Windows-firewall.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G00-Windows-firewall.png)

## Step G01: enable WWW services in firewall
![G01-enable-WWW-services-in-firewall.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G01-enable-WWW-services-in-firewall.png)

## Step G02: enable WWW services in firewall
![G02-enable-WWW-services-in-firewall.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G02-enable-WWW-services-in-firewall.png)

## Step G03: Windows firewall with advanced security
![G03-Windows-firewall-with-advanced-security.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G03-Windows-firewall-with-advanced-security.png)

## Step G04: Windows firewall with advanced security WWW
![G04-Windows-firewall-with-advanced-security-WWW.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G04-Windows-firewall-with-advanced-security-WWW.png)

## Step G05: Windows firewall with advanced security WWW details
![G05-Windows-firewall-with-advanced-security-WWW-details.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G05-Windows-firewall-with-advanced-security-WWW-details.png)

## Step G06: Windows firewall with advanced security New inbound rule
![G06-Windows-firewall-with-advanced-security-New-inbound-rule.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G06-Windows-firewall-with-advanced-security-New-inbound-rule.png)

## Step G07: Windows firewall with advanced security New inbound rule port 8080
![G07-Windows-firewall-with-advanced-security-New-inbound-rule-port-8080.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G07-Windows-firewall-with-advanced-security-New-inbound-rule-port-8080.png)

## Step G08: Windows firewall with advanced security New inbound rule port allow connection
![G08-Windows-firewall-with-advanced-security-New-inbound-rule-port-allow-connection.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G08-Windows-firewall-with-advanced-security-New-inbound-rule-port-allow-connection.png)

## Step G09: Windows firewall with advanced security New inbound rule port only private networks
![G09-Windows-firewall-with-advanced-security-New-inbound-rule-port-only-private-networks.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G09-Windows-firewall-with-advanced-security-New-inbound-rule-port-only-private-networks.png)

## Step G10: Windows firewall with advanced security New inbound rule port name 8080
![G10-Windows-firewall-with-advanced-security-New-inbound-rule-port-name-8080.png](Stage-G-Continua-CI-Enable-Remote-Access-Through-Windows-Firewall/G10-Windows-firewall-with-advanced-security-New-inbound-rule-port-name-8080.png)
