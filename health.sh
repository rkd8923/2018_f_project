#! /bin/bash
for((;;))
do 
  CPU=`top -n 1 | grep -i cpu\(s\)| awk '{print $5}' | tr -d "%id," | awk '{print 100-$1}'`
  echo "$CPU"
:<<END
  for t in $CPU2
  do
    if [ ${t} != "%Cpu(s):" -a ${t} != "us," -a ${t} != "ni," -a ${t} != "sy," -a ${t} != "id," -a ${t} != "wa," -a ${t} != "hi," -a ${t} != "si," -a ${t} != "st" ];then
    echo "$t"
    #CPU_LOAD="$CPU_LOAD+$t" | bc -l
    CPU_LOAD=$(echo "$CPU_LOAD" "$t" | awk '{ printf "%f", $1 + $2 }') 
    echo "$CPU_LOAD"
    fi
  done
END
  DISK_TOTAL=`df -P | grep -v ^Filesystem | awk '{sum += $2} END { print sum; }'`
  DISK_USED=`df -P | grep -v ^Filesystem | awk '{sum += $3} END { print sum; }'`
  DISK_PER=`echo "100*$DISK_USED/$DISK_TOTAL" | bc -l`
  echo "$DISK_PER %"
  ifconfig -s

  sleep 5
done
  
