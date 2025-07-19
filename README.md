# VPN Connect

A simple command-line script that makes it easier to connect to TryHackMe or Hack The Box using OpenVPN.  
No GUI. No extra steps. Just run it, pick your config, and you're connected.

---

## Why This Exists

If you've ever spun up a new VM and had to set up VPN access for TryHackMe or Hack The Box, you already know the hassle. You have to download the `.ovpn` file, install OpenVPN, run the connection manually, remember the command-line flags, and kill the process when you're done.

This script takes care of that. It gives you a straightforward way to connect, disconnect, and check your status. You just drop your `.ovpn` config file into the right folder, launch the script, and pick what you want to do.

The goal was to make something that feels smooth for day-to-day lab work. And if you're learning, this is also a good script to take apart and tweak. It's written to be clean and easy to follow.

---

## What It Does

- Connects to TryHackMe or Hack The Box using OpenVPN, in the background
- Finds your `.ovpn` file automatically (if it’s in the right folder)
- Lets you choose which config to use if there's more than one
- Disconnects with one menu choice
- Shows your VPN status and public IP
- Opens the right config download pages if you need them

---

## Getting Set Up

1. Clone the repo using SSH:
   ```bash
   git clone git@github.com:yourusername/vpn-connect.git
   cd vpn-connect

