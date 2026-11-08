#!/bin/bash
TARGET_USER="${1:-$USER}"

mem_to_human() {
  local mem=$1
  if [[ $mem =~ ^([0-9]+)K$ ]]; then
    local kb=${BASH_REMATCH[1]}
    local gb=$(echo "scale=1; $kb / 1024 / 1024" | bc)
    echo "${gb}G"
  elif [[ $mem =~ ^([0-9]+)M$ ]]; then
    local mb=${BASH_REMATCH[1]}
    local gb=$(echo "scale=1; $mb / 1024" | bc)
    echo "${gb}G"
  else
    echo "$mem"
  fi
}

time_to_seconds() {
  local time=$1
  local seconds=0
  
  if [[ $time =~ ^([0-9]+):([0-9]+):([0-9]+)$ ]]; then
    seconds=$((${BASH_REMATCH[1]} * 3600 + ${BASH_REMATCH[2]} * 60 + ${BASH_REMATCH[3]}))
  elif [[ $time =~ ^([0-9]+):([0-9]+)$ ]]; then
    seconds=$((${BASH_REMATCH[1]} * 60 + ${BASH_REMATCH[2]}))
  fi
  echo $seconds
}

while true; do
  clear
  date
  echo "User: $TARGET_USER"
  printf "%-10s %-8s %-10s %-8s %-10s %-8s %-4s %-5s %-8s\n" "JOBID" "TIME" "NODE" "MaxMem" "CPUTime" "CPU%" "GPU" "GPU%" "GPUMem"
  printf "%-10s %-8s %-10s %-8s %-10s %-8s %-4s %-5s %-8s\n" "----------" "--------" "----------" "--------" "----------" "--------" "----" "-----" "--------"
  
  for jobid in $(squeue -u "$TARGET_USER" -h -o "%i"); do
    elapsed=$(squeue -j $jobid -h -o "%M")
    node=$(squeue -j $jobid -h -o "%N")
    ncpus=$(squeue -j $jobid -h -o "%C")
    
    maxrss_human="N/A"
    avecpu="N/A"
    cpu_pct="N/A"

    stats=$(sstat -j ${jobid}.batch --format=MaxRSS,AveCPU --noheader 2>/dev/null)
    if [ -z "$stats" ]; then
      stats=$(sstat -j ${jobid}.interactive --format=MaxRSS,AveCPU --noheader 2>/dev/null)
    fi
    if [ -n "$stats" ]; then
      maxrss=$(echo $stats | awk '{print $1}')
      avecpu=$(echo $stats | awk '{print $2}')
      maxrss_human=$(mem_to_human "$maxrss")

      elapsed_sec=$(time_to_seconds "$elapsed")
      cpu_sec=$(time_to_seconds "$avecpu")

      if [ $elapsed_sec -gt 0 ] && [ $ncpus -gt 0 ]; then
        cpu_pct=$(echo "scale=1; $cpu_sec * 100 / $elapsed_sec / $ncpus" | bc)
      fi
    fi

    # GPU count requested by the job, parsed from gres (e.g. gres/gpu:2, gres/gpu:a100:2)
    gres=$(squeue -j $jobid -h -o "%b")
    ngpus=0
    if [[ $gres =~ gpu([:=][A-Za-z][A-Za-z0-9_-]*)?[:=]([0-9]+) ]]; then
      ngpus=${BASH_REMATCH[2]}
    fi

    gpu_pct="N/A"
    gpu_mem="N/A"
    if [ "$ngpus" -gt 0 ]; then
      # Run nvidia-smi inside the job's allocation; --overlap shares the job's GPUs
      # instead of requesting new ones. timeout keeps a busy node from freezing the loop.
      gpu_stats=$(timeout 5 srun --jobid="$jobid" --overlap --ntasks=1 --gres="gpu:$ngpus" \
        nvidia-smi --query-gpu=utilization.gpu,memory.used --format=csv,noheader,nounits 2>/dev/null)
      if [ -n "$gpu_stats" ]; then
        gpu_pct=$(echo "$gpu_stats" | awk -F', ' '{s += $1; n++} END {printf "%.0f", s / n}')
        gpu_mem=$(echo "$gpu_stats" | awk -F', ' '{s += $2} END {printf "%.1fG", s / 1024}')
      fi
    fi

    printf "%-10s %-8s %-10s %-8s %-10s %-8s %-4s %-5s %-8s\n" "$jobid" "$elapsed" "$node" "$maxrss_human" "$avecpu" "$cpu_pct" "$ngpus" "$gpu_pct" "$gpu_mem"
  done
  sleep 10
done