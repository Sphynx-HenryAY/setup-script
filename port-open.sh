if [ $1 ]; then
	echo "Open Port $1 $( sudo firewall-cmd --zone=public --add-port=$1/tcp --permanent )"
	echo "Reload $( sudo firewall-cmd --reload )"
else
	echo "Please indicate a port."
fi
