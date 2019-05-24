if [ $1 ]; then
	echo "Close Port $1 $( sudo firewall-cmd --zone=public --remove-port=$1/tcp --permanent )"
	echo "Reload $( sudo firewall-cmd --reload )"
else
	echo "Please indicate a port."
fi
