# Web Application Vulnerability Scanner

## Overview

The Web Application Vulnerability Scanner is a Bash script designed to scan web applications for potential security vulnerabilities. It checks for the OWASP Top 10 vulnerabilities and provides references and recommendations for each detected vulnerability.

## Features

- Checks for the following OWASP Top 10 vulnerabilities:
  - Injection
  - Broken Authentication
  - Sensitive Data Exposure
  - XML External Entities (XXE)
  - Broken Access Control
  - Security Misconfiguration
  - Cross-Site Scripting (XSS)
  - Insecure Deserialization
  - Using Components with Known Vulnerabilities
  - Insufficient Logging & Monitoring

- Provides references and recommendations for each detected vulnerability.
- Generates an output file with the scan results.
- User-friendly interactive interface.

## Usage

- Ensure you have Bash installed on your system.

### Running the Script

1. Clone or download the script to your local machine.

```
   git clone https://github.com/Ameer-clk/Application-Testing.git

```
2. Make the script executable:

```
   chmod +x web_scanner.sh

```
3. Run the scipt:

```
./web_scanner.sh

```
