{ config, ... }:

{
  # Kernel parameters for low-latency - check https://wiki.archlinux.org/title/Gaming#Improving_Performance for explanations
  environment.etc = {
    "tmpfiles.d/gaming.conf" = {
      text = ''
        w /proc/sys/vm/compaction_proactiveness - - - - 0
        w /proc/sys/vm/watermark_boost_factor - - - - 1
        w /proc/sys/vm/min_free_kbytes - - - - 1048576
        w /proc/sys/vm/watermark_scale_factor - - - - 500
        w /proc/sys/vm/swappiness - - - - 10
        w /sys/kernel/mm/lru_gen/enabled - - - - 5
        w /proc/sys/vm/zone_reclaim_mode - - - - 0
        w /sys/kernel/mm/transparent_hugepage/enabled - - - - madvise
        w /sys/kernel/mm/transparent_hugepage/shmem_enabled - - - - advise
        w /sys/kernel/mm/transparent_hugepage/defrag - - - - never
        w /proc/sys/vm/page_lock_unfairness - - - - 1
        w /proc/sys/kernel/sched_child_runs_first - - - - 0
        w /proc/sys/kernel/sched_autogroup_enabled - - - - 1
        w /proc/sys/kernel/sched_cfs_bandwidth_slice_us - - - - 3000
        w /sys/kernel/debug/sched/base_slice_ns  - - - - 3000000
        w /sys/kernel/debug/sched/migration_cost_ns - - - - 500000
        w /sys/kernel/debug/sched/nr_migrate - - - - 8
      '';
    };
  };

  # Force flat mouse acceleration - good for FPS games, remove this whole code block if on laptop
  environment.etc = {
    "X11/xorg.conf.d/00-mouse.conf" = {
      text = ''
        Section "InputClass"
                Identifier "libinput pointer catchall"
                MatchIsPointer "on"
                MatchDevicePath "/dev/input/event*"
                Driver "libinput"
                Option "AccelProfile" "flat"
        EndSection
      '';
    };
  };

  # Set keyboard polling rate, does nothing on 99% of laptops because they use ps/2 for the keyboard, might want to disable if your laptop uses USB
  environment.etc = {
    "modprobe.d/keyboard.conf" = {
      text = ''
        options usbhid kbpoll 8
      '';
    };
  };
}
