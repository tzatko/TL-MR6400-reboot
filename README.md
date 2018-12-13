# TL-MR6400-reboot
TL-MR6400 automated reboot after connection loss

My TL-MR6400 router is losing LTE connection every now and then and only reboot helps to make it work again.
This script is checking whether we are still online and reboots the router when we are not.
It's dirty but it works.

You need to change the Authorization HTTP header manually. Currently, there is just dummy USERNAME:PASSWORD included in the script. Change it to your actual credentials. Of course, you need to change the IP to your actual IP as well.
