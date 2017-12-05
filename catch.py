#!/usr/bin/env python

import sys
from scapy.all import *

def parse_icmp(pkt):
    try:
        payload = str(pkt[Raw].load).rstrip()
    except IndexError:
        return

    sys.stdout.write(payload[16:32])

sniff(filter="icmp[icmptype] == icmp-echo", prn=parse_icmp)
