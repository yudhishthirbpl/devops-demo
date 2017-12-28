#!/bin/sh

SELENIUM_NODE_PORT=5555
SELENIUM_NODE_PID_FILE="/tmp/selenium-${SELENIUM_NODE_PORT}.pid"
SELENIUM_HOME="/home/ykaushik/ci-cd/selenium"
SELENIUM_SERVER_ROLE="node"

# Check for missing binaries (stale symlinks should not happen)
SELENIUM_JAR="${SELENIUM_HOME}/selenium-server-standalone.jar"
test -r "${SELENIUM_JAR}" || { echo "${SELENIUM_JAR} not installed";
        if [ "$1" = "stop" ]; then exit 0;
        else exit 5; fi; }
        
mkdir -p /tmp/selenium

case "${1:-''}" in
    'start')
        if test -f ${SELENIUM_NODE_PID_FILE}
        then
            echo "Selenium is already running."
        else
            /usr/bin/java -Dwebdriver.chrome.driver="${SELENIUM_HOME}/chromedriver" -jar ${SELENIUM_HOME}/selenium-server-standalone.jar -role ${SELENIUM_SERVER_ROLE} -nodeConfig "${SELENIUM_HOME}/nodeConfig.json" -log /tmp/selenium/${SELENIUM_NODE_PORT}-output.log & 
			echo $! > ${SELENIUM_NODE_PID_FILE}
            echo "Starting Selenium node..."

            error=$?
            if test $error -gt 0
            then
                echo "${bon}Error $error! Couldn't start Selenium!${boff}"
            fi
        fi
    ;;
    'stop')
        if test -f ${SELENIUM_NODE_PID_FILE}
        then
            echo "Stopping Selenium node..."
            PID=`cat ${SELENIUM_NODE_PID_FILE}`
            kill -3 $PID
            if kill -9 $PID ;
                then
                    sleep 2
                    test -f ${SELENIUM_NODE_PID_FILE} && rm -f ${SELENIUM_NODE_PID_FILE}
                else
                    echo "Selenium node could not be stopped..."
                    test -f ${SELENIUM_NODE_PID_FILE} && rm -f ${SELENIUM_NODE_PID_FILE}
                fi
        else
            echo "Selenium is not running."
        fi
        ;;
    'restart')
        if test -f ${SELENIUM_NODE_PID_FILE}
        then
            kill -HUP `cat ${SELENIUM_NODE_PID_FILE}`
            test -f ${SELENIUM_NODE_PID_FILE} && rm -f ${SELENIUM_NODE_PID_FILE}
            sleep 1
            #export DISPLAY=localhost:99.0
            /usr/bin/java -Dwebdriver.chrome.driver="${SELENIUM_HOME}/chromedriver" -jar ${SELENIUM_HOME}/selenium-server-standalone.jar -role ${SELENIUM_SERVER_ROLE} -nodeConfig "${SELENIUM_HOME}/nodeConfig.json" -log /tmp/selenium/${SELENIUM_NODE_PORT}-output.log &
            echo $! > ${SELENIUM_NODE_PID_FILE}
            echo "Reload Selenium node..."
        else
            echo "Selenium node isn't running..."
        fi
        ;;
    *)      # no parameter specified
        echo "Usage: $SELF start|stop|restart"
        exit 1
    ;;
esac
