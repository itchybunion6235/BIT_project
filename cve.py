import argparse
import nmap3
import pprint

parser = argparse.ArgumentParser(description='This is my help')
args = parser.parse_args()
nmap = nmap3.Nmap()
results = nmap.scan_top_ports("10.100.1.0/24")
pprint.pprint(results)
