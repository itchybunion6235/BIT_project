import argparse
import nmap3
import pprint

parser = argparse.ArgumentParser(description='This is my help')
args = parser.parse_args()
nmap = nmap3.Nmap()
results = nmap.scan('192.168.10.10',args=)
pprint.pprint(results)