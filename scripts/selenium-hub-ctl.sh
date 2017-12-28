#!/bin/sh




SELENIUM_HUB_PORT=4444
SELENIUM_HUB_PID_FILE="/tmp/selenium-${SELENIUM_HUB_PORT}.pid"
SELENIUM_HOME="/home/ykaushik/ci-cd/selenium"
SELENIUM_SERVER_ROLE="hub"

# Check for missing binaries (stale symlinks should not happen)
SELENIUM_JAR="${SELENIUM_HOME}/selenium-server-standalone.jar"
test -r "${SELENIUM_JAR}" || { echo "${SELENIUM_JAR} not installed";
        if [ "$1" = "stop" ]; then exit 0;
        else exit 5; fi; }
        
mkdir -p /tmp/selenium

case "${1:-''}" in
    'start')
        if test -f ${SELENIUM_HUB_PID_FILE}
        then
            echo "Selenium is already running."
        else
            /usr/bin/java -jar ${SELENIUM_HOME}/selenium-server-standalone.jar -port ${SELENIUM_HUB_PORT}  -role ${SELENIUM_SERVER_ROLE} -log /tmp/selenium/${SELENIUM_HUB_PORT}-output.log & 
			echo $! > ${SELENIUM_HUB_PID_FILE}
            echo "Starting Selenium..."

            error=$?
            if test $error -gt 0
            then
                echo "${bon}Error $error! Couldn't start Selenium!${boff}"
            fi
        fi
    ;;
    'stop')
        if test -f ${SELENIUM_HUB_PID_FILE}
        then
            echo "Stopping Selenium..."
            PID=`cat ${SELENIUM_HUB_PID_FILE}`
            kill -3 $PID
            if kill -9 $PID ;
                then
                    sleep 2
                    test -f ${SELENIUM_HUB_PID_FILE} && rm -f ${SELENIUM_HUB_PID_FILE}
                else
                    echo "Selenium could not be stopped..."
                    test -f ${SELENIUM_HUB_PID_FILE} && rm -f ${SELENIUM_HUB_PID_FILE}
                fi
        else
            echo "Selenium is not running."
        fi
        ;;
    'restart')
        if test -f ${SELENIUM_HUB_PID_FILE}
        then
            kill -HUP `cat ${SELENIUM_HUB_PID_FILE}`
            test -f ${SELENIUM_HUB_PID_FILE} && rm -f ${SELENIUM_HUB_PID_FILE}
            sleep 1
            #export DISPLAY=localhost:99.0
            /usr/bin/java -jar ${SELENIUM_HOME}/selenium-server-standalone.jar -port ${SELENIUM_HUB_PORT}  -role ${SELENIUM_SERVER_ROLE} -log /tmp/selenium/${SELENIUM_HUB_PORT}-output.log & 
			echo $! > ${SELENIUM_HUB_PID_FILE}
            echo "Reload Selenium..."
        else
            echo "Selenium isn't running..."
        fi
        ;;
    *)      # no parameter specified
        echo "Usage: $SELF start|stop|restart"
        exit 1
    ;;
esac
