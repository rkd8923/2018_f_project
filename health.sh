#! /bin/bash
for((;;))
do 
  CPU=`top -n 1 | grep -i cpu\(s\)| awk '{print $8}' | tr -d "%id," | awk '{print 100-$1}'`
  echo "CPU $CPU %"
  DISK_TOTAL=`df -P | grep -v ^Filesystem | awk '{sum += $2} END { print sum; }'`
  DISK_USED=`df -P | grep -v ^Filesystem | awk '{sum += $3} END { print sum; }'`
  DISK_PER=`echo "100*$DISK_USED/$DISK_TOTAL" | bc -l`
  echo "DISK $DISK_PER %"
  T=`ifconfig -s`
  RX=0
  TX=0
  i=0
  for x in $T;
  do
    if [ `expr $i % 11` -eq 2 ];then
      RX=$(($RX+$x))
    fi
    if [ `expr $i % 11` -eq 6 ];then
      TX=$(($TX+$x))
    fi
    i=$(($i+1))
  done
  echo "RX $RX"
  echo "TX $TX"
  sleep 3
done
  
