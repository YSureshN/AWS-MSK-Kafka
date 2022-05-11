#/etc/init.d/zookeeper
DAEMON_PATH=/home/ubuntu/kafka/bin
DAEMON_NAME=zookeeper
# check that networking is up.
#[ ${NETWORKING} = "no"] && exit 0

PATH=$PATH:$DAEMON_PATH

# see how we are called.

case "$1" in
    start)
        # start daemon.
        pid='ps ax | grep -i 'org.apache.zookeeper' | grep -v grep | awk '{print $1}''
        if [ -n "$pid" ]
            then 
                echo "zookeeper is already running";
        else
            echo "starting $DAEMON_NAME";
            $DAEMON_PATH/zookeeper-server-start.sh -daemon /home/kafka/config/zookeeper-properties
        fi
        ;;
    
    stop)
        echo "shutting down $DAEMON_NAME";
        $DAEMON_PATH/zookeeper-server-stop.sh
        ;;

    restart)
        $0 stop
        sleep 2
        $0 restart
        ;;

    status)
        pid='ps ax | grep -i 'org.apache.zookeeper' | grep -v grep | awk '{print $1}''
        if [ -n "$pid" ]
            then
            echo "zookeeper is running as PID:$pid"
        else
            echo "zookeeper is not running"
        fi
        ;;
    *)
        echo "usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0
        



        