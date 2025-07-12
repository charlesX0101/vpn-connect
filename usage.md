VPN-Connect — Usage Guide

This guide walks you through everything you need to know to use VPN-Connect effectively. It's meant to be clear enough for first-time users but also useful for people who rebuild lab environments often.

---

Step 1 — Download Your VPN Config

Before running the script, you’ll need to download your `.ovpn` file from either TryHackMe or Hack The Box. These files are unique to your account, like a private key. You’ll need to log in and download them manually.

TryHackMe: https://tryhackme.com/access
Hack The Box: https://app.hackthebox.com/access

Look for something like “Download Configuration File.” On TryHackMe, the file is usually named after your username (e.g., yourname.ovpn).

If you're not sure where to go, launch the VPN-Connect script and choose option [4] Open VPN Config Pages from the menu. This will open the correct websites in your browser to help you get the right file.

---

Step 2 — Place the File in the Right Folder

Move your `.ovpn` file into the ovpn/ directory inside the VPN-Connect project folder. For example:

mv ~/Downloads/yourname.ovpn ~/projects/vpn-connect/ovpn/

If the ovpn/ folder doesn't exist, you can create it manually:

mkdir -p ovpn

---

Step 3 — Run the Script

To launch the interactive menu (TUI), run:

./vpn_connect.sh

You’ll see:

=== VPN-Connect ===
[1] VPN Connect Box
[2] Disconnect VPN
[3] Show VPN Status
[4] Open VPN Config Pages
[5] Exit

Choose option [1] to connect. The script will:
- Scan the ovpn/ folder for any .ovpn files.
- Let you pick which one to use.
- Start the connection in the background using OpenVPN.

---

Step 4 — Check Your Status

You can confirm that the VPN is running by selecting option [3] from the menu. It will:
- Check if the OpenVPN process is active
- Show your current public IP address (to verify routing through the VPN)

---

Step 5 — Disconnect

To stop the VPN connection, choose option [2] from the menu. This will safely terminate the OpenVPN process.

---

Optional — Use the Config Page Shortcut

Any time you need to get a new VPN config file, select option [4] Open VPN Config Pages from the menu. You’ll be asked which platform (TryHackMe or Hack The Box) you’re using. Once selected, your browser will open the correct page where you can download your .ovpn file.

This is especially helpful if you're setting up a new machine or re-downloading a lost config.

---

Advanced Usage (Direct Commands)

If you prefer to skip the menu:

./vpn_connect.sh connect       # Start VPN connection
./vpn_connect.sh disconnect    # Stop VPN
./vpn_connect.sh status        # Show VPN + IP status

---

Common Issues

“No .ovpn files found”
Make sure you placed your .ovpn file inside the ovpn/ folder. You can also enter the filename manually if prompted.

“VPN connects but I don’t see any output”
This script runs OpenVPN in the background. Use the status option to check your connection and IP.

“Trying to use both TryHackMe and HTB configs”
If you’re storing both in the ovpn/ folder, be sure you know which filename belongs to which service. The script can’t auto-detect which platform each file belongs to.

---

Final Notes

This tool is meant to save time when doing repeated lab setups or bouncing between VMs. It’s especially helpful if you’re still learning how VPN routing works and want to avoid wrestling with command-line syntax every time.

If you're more advanced, feel free to use it as a base and expand it to suit your needs.

