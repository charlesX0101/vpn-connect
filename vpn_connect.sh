#!/bin/bash

# vpn_connect.sh - VPN-Connect Box
# CLI tool for managing TryHackMe and Hack The Box .ovpn connections

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVPN_DIR="$SCRIPT_DIR/ovpn"

show_help() {
  echo "Usage:"
  echo "  ./vpn_connect.sh connect         Start VPN connection in background"
  echo "  ./vpn_connect.sh disconnect      Stop OpenVPN process"
  echo "  ./vpn_connect.sh status          Show VPN and IP status"
  echo "  ./vpn_connect.sh help            Show this help message"
}

connect_vpn() {
  local selected_file=""
  local ovpn_files=()

  if [[ ! -d "$OVPN_DIR" ]]; then
    echo "Error: Directory not found: $OVPN_DIR"
    return 1
  fi

  shopt -s nullglob
  ovpn_files=("$OVPN_DIR"/*.ovpn)
  shopt -u nullglob

  if [[ ${#ovpn_files[@]} -eq 0 ]]; then
    echo "No .ovpn files found in $OVPN_DIR"
    echo "Download your VPN config from:"
    echo "  - TryHackMe: https://tryhackme.com/access"
    echo "  - Hack The Box: https://app.hackthebox.com/access"
    read -p "Enter filename manually (must be placed in $OVPN_DIR): " manual_file
    selected_file="$OVPN_DIR/$manual_file"
    if [[ ! -f "$selected_file" ]]; then
      echo "Error: File not found: $selected_file"
      return 1
    fi
  elif [[ ${#ovpn_files[@]} -eq 1 ]]; then
    selected_file="${ovpn_files[0]}"
    echo "Found one .ovpn file: $(basename "$selected_file")"
  else
    echo "Multiple .ovpn files found:"
    for i in "${!ovpn_files[@]}"; do
      echo "  [$((i+1))] $(basename "${ovpn_files[$i]}")"
    done
    read -p "Select file number or type filename manually: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#ovpn_files[@]} )); then
      selected_file="${ovpn_files[$((choice-1))]}"
    else
      selected_file="$OVPN_DIR/$choice"
      if [[ ! -f "$selected_file" ]]; then
        echo "Error: File not found: $selected_file"
        return 1
      fi
    fi
  fi

  echo "Connecting using: $(basename "$selected_file")"
  sudo openvpn --config "$selected_file" --daemon
  echo "VPN launched in background."
}

disconnect_vpn() {
  echo "Attempting to stop OpenVPN..."
  sudo killall openvpn && echo "OpenVPN stopped." || echo "No OpenVPN process found."
}

show_status() {
  echo
  echo "VPN Process Status:"
  if pgrep -x openvpn >/dev/null; then
    echo "OpenVPN is running."
  else
    echo "OpenVPN is not running."
  fi
  echo
  echo "External IP Address:"
  curl -s https://ifconfig.me || echo "Unable to retrieve external IP."
  echo
}

main_menu() {
  while true; do
    clear
    echo "=== VPN-Connect ==="
    echo "[1] VPN Connect Box"
    echo "[2] Disconnect VPN"
    echo "[3] Show VPN Status"
    echo "[4] Open VPN Config Pages"
    echo "[5] Exit"
    echo
    read -p "Choose an option: " opt

    case "$opt" in
      1) connect_vpn; sleep 1 ;;
      2) disconnect_vpn; read -p "Press Enter to return to menu..." ;;
      3) show_status; read -p "Press Enter to return to menu..." ;;
      4)
        echo
        echo "Open VPN Config Page:"
        echo "[1] TryHackMe"
        echo "[2] Hack The Box"
        echo "[3] Back to Menu"
        read -p "Choose an option: " site_choice
        case "$site_choice" in
          1)
            xdg-open "https://tryhackme.com/access" >/dev/null 2>&1 &
            read -p "Opened TryHackMe. Press Enter to return..." ;;
          2)
            xdg-open "https://app.hackthebox.com/access" >/dev/null 2>&1 &
            read -p "Opened Hack The Box. Press Enter to return..." ;;
          3) ;;
          *) echo "Invalid option."; sleep 1 ;;
        esac
        ;;
      5) echo "Exiting..."; exit 0 ;;
      *) echo "Invalid option."; sleep 1 ;;
    esac
  done
}

# Entry point
if [[ -z "$1" ]]; then
  main_menu
else
  case "$1" in
    connect) connect_vpn ;;
    disconnect) disconnect_vpn ;;
    status) show_status ;;
    help) show_help ;;
    *) echo "Unknown command: $1"; show_help ;;
  esac
fi
