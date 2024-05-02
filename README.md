Racoon - Clickjacking Testing Tool
Overview
Racoon is a clickjacking testing tool designed to check whether an application is vulnerable to clickjacking attacks. It provides developers with a simple and efficient way to test their application's URL for clickjacking vulnerabilities.

Features
Quick and easy clickjacking vulnerability testing.
Automated scanning of application URLs.
Detailed reports on clickjacking vulnerability status.
Lightweight and easy to use.
Installation
Clone the repository:
bash
Copy code
git clone https://github.com/yourusername/racoon.git
Navigate to the Racoon directory:
bash
Copy code
cd racoon
Install dependencies:
Copy code
pip install -r requirements.txt
Usage
Run Racoon with the target application URL:
arduino
Copy code
python racoon.py https://www.example.com
Racoon will scan the provided URL for clickjacking vulnerabilities.
View the generated report to identify any clickjacking vulnerabilities.
