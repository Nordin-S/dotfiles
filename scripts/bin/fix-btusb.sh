#!/bin/bash
sudo modprobe -r btusb && sudo systemctl restart bluetooth && sudo modprobe btusb
