IP Tables Firewall Rules Setup

This repository contains a Node.js script and a shell script to configure a comprehensive set of iptables rules for enhanced network security. The setup includes protections against SYN flood attacks, specific UDP port blocks, and various string patterns that are known to be associated with malicious activity.
Files

    setup-firewall.js: A Node.js script that generates and executes a shell script to apply iptables rules. It creates a shell script with predefined iptables commands, makes it executable, and runs it.

    firewall-rules.sh: A shell script that contains the iptables commands for setting up firewall rules. It includes rules for SYN flood protection, blocking specific UDP ports, filtering based on string patterns, and additional security measures.

Features

    SYN Flood Protection: Includes a custom chain to handle SYN flood attacks.
    Pattern Blocking: Drops packets containing specific hex patterns known to be associated with malicious traffic.
    UDP Port Blocking: Blocks UDP traffic on certain ports.
    Additional Security Rules: Includes various rules for enhanced protection against common threats.

Usage

    Clone the repository:

    git clone https://github.com/rauandeveloper/IptablesFirewall.git
    cd IptablesFirewall

Install Node.js if not already installed.

    apt install nodejs -y; apt install npm -y; npm install child_process;

Install Node.js if not already installed.

Run the Node.js script to set up the firewall rules:

    node setup-firewall.js

    The script will create and execute the firewall-rules.sh script, applying the iptables rules and saving them.

Requirements

    Node.js
    iptables installed on the server

Contributing

Feel free to open issues or submit pull requests if you have suggestions or improvements.
