{ config, ... }:

{
  # Kernel parameters for low-latency
  # check https://wiki.archlinux.org/title/Gaming#Improving_Performance for explanations
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

  # Kernel parameters for low internet latency
  environment.etc = {
    "sysctl.d/99-gaming.conf" = {
      text = ''
        net.core.default_qdisc = cake
        net.ipv4.tcp_congestion_control = bbr
        net.ipv4.tcp_fastopen = 3
        net.ipv4.tcp_slow_start_after_idle = 0
        net.ipv4.tcp_keepalive_time = 60
        net.ipv4.tcp_keepalive_intvl = 10
        net.ipv4.tcp_keepalive_probes = 6
        net.ipv4.tcp_mtu_probing = 1
        net.ipv4.tcp_sack = 1
        net.ipv4.tcp_fin_timeout = 5
        vm.max_map_count = 2147483642
      '';
    };
  };

  # Load TCP_BBR module
  boot.kernelModules = [
    "tcp_bbr"
  ];

  # Limit keyboard polling
  boot.extraModprobeConfig = ''
    options usbhid kbpoll=8
    options usbhid mousepoll=1
  '';

  # Disable Mouse Debounce
  environment.etc = {
    "libinput/local-overrides.quirks" = {
      text = ''
        [Never Debounce]
        MatchUdevType=mouse
        ModelBouncingKeys=1
      '';
    };
  };

  # Allow lamzu.net Software to run
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001c", TAG+="uaccess"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="373e", ATTRS{idProduct}=="001e", TAG+="uaccess"
  '';
}
