#!/usr/bin/env bash

# Simple move this file into your Rails `script` folder. Also make sure you `chmod +x puma.sh`.
# Please modify the CONSTANT variables to fit your configurations.

# The script will start with config set by $PUMA_CONFIG_FILE by default

source /etc/profile.d/rbenv.sh

PUMA_CONFIG_FILE=config/puma.rb
PUMA_PID_FILE=tmp/pids/puma.pid
PUMA_SOCKET=tmp/sockets/puma.sock
PUMA_APP_DIR=/webapps/digester.io/current

# check if puma process is running
puma_is_running() {
  if [ -S $PUMA_SOCKET ] ; then
    if [ -e $PUMA_PID_FILE ] ; then
      if pgrep -F $PUMA_PID_FILE > /dev/null ; then
        return 0
      else
        echo "No puma process found"
      fi
    else
      echo "No puma pid file found"
    fi
  else
    echo "No puma socket found"
  fi

  return 1
}

case "$1" in
  start)
    echo "Starting puma..."
    rm -f $PUMA_SOCKET
    if [ -e $PUMA_CONFIG_FILE ] ; then
      bundle exec puma --config $PUMA_CONFIG_FILE --dir $PUMA_APP_DIR
    else
      bundle exec puma --daemon --bind unix://$PUMA_SOCKET --pidfile $PUMA_PID_FILE --dir $PUMA_APP_DIR
    fi

    echo "done"
    ;;

  stop)
    echo "Stopping puma..."
      kill -s SIGTERM `cat $PUMA_PID_FILE`
      rm -f $PUMA_PID_FILE
      rm -f $PUMA_SOCKET

    echo "done"
    ;;

  restart)
    if puma_is_running ; then
      echo "Hot-restarting puma..."
      kill -s SIGUSR2 `cat $PUMA_PID_FILE`

      echo "Doublechecking the process restart..."
      sleep 5
      if puma_is_running ; then
        echo "done"
        exit 0
      else
        echo "Puma restart failed :/"
      fi
    fi

    echo "Trying cold reboot"
    bin/puma.sh start
    ;;

  *)
    echo "Usage: bin/puma.sh {start|stop|restart}" >&2
    ;;
esac
