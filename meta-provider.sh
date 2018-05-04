#! /bin/bash

PROVIDER_HOME="/data01/install"
PROJECT=${2}
PORT=${3}
RETVAL=0
case "${1}" in
    start)
	    cd ${PROVIDER_HOME}
		java -jar Dserver.port=${PORT} ${PROJECT}
		PID=$!
		sleep 10
		if [[ "${PID}" == "$(ps aux | grep "[j]ava -jar -Dserver.port=${PORT} ${PROJECT}" | awk '{print $2}')" ]]; then
		      echo "Provider Start Success."
			  RETVAL=0
	     else
		      echo "Provider Start Failed!"
			  RETVAL=1
		 fi
		 ;;
	stop)
	    if [[ "$(ps aux | grep "[j]ava -jar -Dserver.port=${PORT} ${PROJECT}"  |wc -1)" == "0" ]]; then
		            echo "Provider not running ,Skiping Stop"
					exit 0
		 fi
		 ps aux | grep "[j]ava -jar -Dserver.port=${PORT} ${PROJECT}" |awk '{print "kill -9 " $2}' |sh
         echo "Provider is Stopping."
         EXIT_FLAG=0
         for ((i=0;i<10;i++));do
              if [[ "$(ps aux |grep "[j]ava -jar -Dserver.port=${PORT} ${PROJECT}"  |wc -1)" == "0" ]]; then
                   EXIT_FLAG=1
                     break
              fi
              sleep 1
         done
         if [["$[EXIT_FLAG]"=="1"]];then
            echo "Provider Stop Success."
            RETVAL=0
         else
            echo "Provider Stop Timeout."
            RETVAL=0	 
		 fi
		 ;;
	*)	 
		 
		echo "Usage： Provider.sh  {start|stop} {*.war}"
		exit 1
		;;
esac
 
exit ${RETVAL}
		 