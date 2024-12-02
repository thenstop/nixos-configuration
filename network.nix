{ config, ... }:
{
  # Kernel parameters for low internet latency
  environment.etc = {
    "sysctl.d/10-networking.conf" = {
      text = ''
        net.core.netdev_max_backlog = 16384
        net.ipv4.tcp_fastopen = 3
        net.ipv4.tcp_max_tw_buckets = 2000000
        net.ipv4.tcp_tw_reuse = 1
        net.ipv4.tcp_fin_timeout = 10
        net.ipv4.tcp_slow_start_after_idle = 0
        net.ipv4.tcp_keepalive_time = 60
        net.ipv4.tcp_keepalive_intvl = 10
        net.ipv4.tcp_keepalive_probes = 6
        net.ipv4.tcp_mtu_probing = 1
        net.core.default_qdisc = cake
        net.ipv4.tcp_congestion_control = bbr
      '';
    };
  };

  # Load TCP_BBR module
  boot.kernelModules = [
    "tcp_bbr"
  ];
}
