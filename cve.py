import argparse
import subprocess
import pprint
import re

def arguments():
    parser = argparse.ArgumentParser(description='Tool to detect whether host is vulnerable to CVE-2020-11969')
    parser.add_argument('ip_address',metavar='IP',help="Target IP or range of IP's to be scanned")
    args = parser.parse_args()
    return args

def isVuln(veci):
    hosti = {}
    for i in veci:
        result_http = re.search('(Not)*\sVulnerable',i)
        ip_http = re.search('\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}',i)
        if not(result_http):
            hosti[ip_http.group(0)] = "Not Vulnerable"
        if ip_http and result_http:
            hosti[ip_http.group(0)] = result_http.group(0).strip()
    return hosti

def main():
    args = arguments()
    http = subprocess.check_output(["nmap","--script","http_check.nse",args.ip_address])
    veci = re.findall('Nmap scan[\s\S]*?MAC',http.decode())
    hosti = isVuln(veci)
    rmi = subprocess.check_output(["nmap","--script","rmi_check.nse",args.ip_address])
    veci = re.findall('Nmap scan[\s\S]*?MAC',rmi.decode())
    hosti2 = isVuln(veci)
    for k, v in hosti.items():
        if(hosti[k] == hosti2[k]):
            print(k,v)
        else:
            print(k,"Not Vulnerable")

if __name__ == '__main__':
	main()