#!/bin/bash
# Flush existing rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Create custom chains
iptables -N syn-flood

# SYN Flood Protection
iptables -A syn-flood -m limit --limit 10/sec --limit-burst 15 -j RETURN
iptables -A syn-flood -j LOG --log-prefix "SYN flood: "
iptables -A syn-flood -j DROP

# Block specific patterns
iptables -A INPUT -m string --hex-string "|efbbbf30783030303230303031|" --algo bm --to 65535 -j DROP
iptables -A INPUT -m string --hex-string "|efbbbf307830303030303030303030433032313130|" --algo bm --to 65535 -j DROP
iptables -A INPUT -m string --hex-string "|efbbbfefbbbf307830303030303030303030433032313130|" --algo bm --to 65535 -j DROP
iptables -A INPUT -m string --hex-string "|efbbbfefbbbfefbbbf30783030363030453030|" --algo bm --to 65535 -j DROP
iptables -A INPUT -m string --hex-string "|efbbbfefbbbfefbbbfefbbbf30783030363030453038|" --algo bm --to 65535 -j DROP
iptables -A INPUT -m string --hex-string "|efbbbfefbbbfefbbbfefbbbfefbbbf30783030303230303031|" --algo bm --to 65535 -j DROP

# Block specific UDP ports
iptables -A INPUT -p udp --dport 16000:29000 -j DROP

# Set up additional protection rules
iptables -A INPUT -m state --state NEW -j SET --add-set scanned_ports src,dst
iptables -A INPUT -p udp -m string --algo bm --hex-string "|434e432041545441434b|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|434e4320464c4f4f44|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4841434b4552|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4841434b|" -j DROP
iptables -A INPUT -m u32 --u32 "12&0xFFFF=0xFFFF" -j DROP
iptables -A INPUT -m string --algo bm --from 28 --to 29 --string "farewell" -j DROP
iptables -A INPUT -p udp -m length --length 1025 -j DROP
iptables -A INPUT -p udp --dport 61327 -j DROP
iptables -A INPUT -p icmp --fragment -j DROP
iptables -A OUTPUT -p icmp --fragment -j DROP
iptables -A FORWARD -p icmp --fragment -j DROP
iptables -A INPUT -p udp --source-port 123:123 -m state --state ESTABLISHED -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|736b6964|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|736b69646e6574|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4a554e4b2041545441434b|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4a554e4b20464c4f4f44|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|484f4c442041545441434b|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|534554484946594f554445434f4445544849534f4e45594f554152455355434841464147484548454845|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|434e43|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|434e432ee92041545441434b|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|434e4320464c4f4f44|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4841434b4552|" -j DROP
iptables -A INPUT -p udp -m string --algo bm --hex-string "|4841434b|" -j DROP

# Save the rules
iptables-save > /etc/iptables/rules.v4
