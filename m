Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89284471436
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190894; cv=none; b=XwXMQtjYd8bLJiTuXhMYB1ONpvcL4OzsAUYPzbS94BjNm0LyniUWCGtUgTz8WZ7nOWaCha78DasU/fYTELetUi0/b27/5VlkGlSia/MQYHkLm3ZZvK2Q7blb832GHZ2TPjHswmvOmS9tqXqW9yRVQ/nTfHygGrgM+s+keBCrLSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190894; c=relaxed/simple;
	bh=fNRb+MhoPHah1DGy+hMnZps37KLDwfcHFe1TFlGARoM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z13tKT2inRnGHmJsx6pDfZC4IGRoPfOWQPeDXHZJMiPTLu+VuXlswjASxCigto99Keq8yDXnRFLZJmVVv2plryTthKafKwyZvUuDH2G2SCjwWcjBXABSBiK16GVsG5Jfzm12GUnFD3+apJV+IwotyP4keIjTmVeSNwb+il2K9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vfo2VBkJ; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vfo2VBkJ"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93903622880so4613385a.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788190891; x=1788795691; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9nXSSD4fyQN+J+EbbxVyey4WwMpGXC28hK97yPjWWis=;
        b=Vfo2VBkJnd57AMwpCtt3hM4PYhVUDR9Mq8G6kCo7u7B9+DX2NkPPfek87fmB4dtZOH
         0znVlGd4yxVhmTpTrjNmPW+NYXmRpuQD/2cdNhy2Ic02oDfNuGgmjA7I1D6gZnAdpDDD
         y8VKRD/Q8I5DhkYK+TT2vA4T1RY0jwj6rw4+p1g55Ve/hEKJyEzANoFEyQmGBe2fIDr9
         ZCHvtRlNslacTSMnDsrUUqUzd1k/GsGuHwp8SuHk+uHHO0tuDcbYjnhKTvJNUlIQrHfb
         RECACCQK6eLnM2oVTrbyEc+emyGoZBsH5kLdFezA7Scn/5i5lHjbA0mtwP3BkP2uXl/4
         AVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788190891; x=1788795691;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9nXSSD4fyQN+J+EbbxVyey4WwMpGXC28hK97yPjWWis=;
        b=CBvzWp8ZEJf3Hf7zO+hv1vhxfIstoAZZ6vkz93mgkI3sIyEllHsRvGUrCRZQaYUaUk
         frnIC4g22obRIokTrXhdJuGLtA3BPOtwLkJBWukwDTMD94Bhk22cspXnfpyJMaVUgioN
         gBFY+gNsHqBpdDJ7HuOdgIDQn8XzMKO3wmPBFpbDETpleA94+9leQFqTl7dCO+JaVEKd
         37n5T01VIWemnHnND578vkrMLPFIWYLKggSgQ6t5c4w0b0yc3E0DE3wFcv7ZO5+RT8IV
         Y4f9J0e6sTs0I0yGb4nsK/Sz+D3nPMg+fmmba/pPwQ3khI5PA7XwkB/rJxsqJpRCvCbp
         r+Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqfyEBVRPu1Dhgqcmvgu9evIrtO8chXBjHhh0qn8wSi2NiHDB3HzEtvVopH+wWBptnPTlFSe6A=@vger.kernel.org
X-Gm-Message-State: AFuF++l1SqYze4/xa61LxhYquGZgOyYU/yQmYzJFIIt/72+cM3+gUAAe
	Hf4Mb1zc9nBw//QCZTmKdFugapWe/Y1D/tEfXWUXu2LY2PN1sEo1FztKcADMBUW+45BKKJYHJxF
	F72mpj+koLEnkeQ==
X-Received: from qvxm11.prod.google.com ([2002:ad4:466b:0:b0:8eb:a61b:cc64])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b8a:b0:936:ef9c:8bef with SMTP id af79cd13be357-93936bca574mr994042785a.2.1788190890613;
 Mon, 31 Aug 2026 08:41:30 -0700 (PDT)
Date: Mon, 31 Aug 2026 15:41:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260831154129.4048178-1-edumazet@google.com>
Subject: [PATCH net-next] net: optimize netif_is_l3_master() and netif_is_l3_slave()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

IFF_L3MDEV_MASTER and IFF_L3MDEV_SLAVE flags are only set and used
by the VRF driver (CONFIG_NET_VRF).

netif_is_l3_master() and netif_is_l3_slave() are called in multiple
performance-critical fast paths (such as GRO, IP routing/FIB lookups,
TCP/UDP processing, etc.).

When CONFIG_NET_VRF is disabled, neither flag can ever be set on any
net_device.

Adding IS_ENABLED(CONFIG_NET_VRF) allows the compiler to optimize
these checks away as false at compile time, eliminating unnecessary
conditional branches in the fast path when VRF is not enabled.

scripts/bloat-o-meter shows a nice code size reduction on a kernel
built with CONFIG_NET_VRF=n (and CONFIG_NET_L3_MASTER_DEV=y):

add/remove: 2/5 grow/shrink: 18/71 up/down: 1593/-5642 (-4049)
Function                                     old     new   delta
ipip6_tunnel_lookup.constprop                  -     931    +931
tcp_v6_parse_md5_keys                       1607    1742    +135
ipip6_err                                    617     738    +121
bpf_lwt_xmit_reroute                        1492    1555     +63
ip6_pol_route                               1810    1843     +33
rt6_multipath_rebalance.part                1448    1480     +32
bpf_msg_pull_data                           1255    1287     +32
__unlikely_text_end                         3092    3124     +32
ipv6_add_addr                               2257    2287     +30
__ip4_datagram_connect                      1131    1158     +27
ip6_rt_cache_alloc                           476     500     +24
fib6_clean_tohost                            308     328     +20
sit_exit_rtnl_net                            461     477     +16
nf_nat_register_fn                           581     597     +16
ip6_forward                                 4573    4589     +16
inet_rtm_getroute                           2906    2922     +16
__pfx_ipip6_tunnel_lookup.constprop            -      16     +16
__ip_do_redirect                            2005    2021     +16
__bpf_skc_lookup                             449     464     +15
addrconf_add_dev                             134     136      +2
ip6_rcv_finish                               203     201      -2
icmp6_dev                                    159     153      -6
ipip6_tunnel_bind_dev                        419     409     -10
bpf_xdp_skc_lookup_tcp                       122     107     -15
bpf_tc_skc_lookup_tcp                        125     110     -15
rt6_nh_dump_exceptions                       243     227     -16
ip_mc_source                                1385    1369     -16
ip6_fragment                                2450    2434     -16
input_action_end_x                           278     262     -16
fib6_nh_age_exceptions.part                  822     806     -16
__pfx_ipip6_tunnel_lookup                     16       -     -16
__pfx_ip6_rt_get_dev_rcu                      16       -     -16
__addrconf_sysctl_register                   365     349     -16
bpf_xdp_sk_lookup_udp                        155     138     -17
bpf_xdp_sk_lookup_tcp                        155     138     -17
bpf_tc_sk_lookup_udp                         158     141     -17
bpf_tc_sk_lookup_tcp                         158     141     -17
addrconf_addr_gen                            339     322     -17
ip6_rcv_core                                2084    2066     -18
fib_nl2rule_locked                           517     499     -18
l3mdev_master_upper_ifindex_by_index_rcu      61      42     -19
ipip6_rcv                                   1960    1941     -19
addrconf_notify                             2563    2543     -20
l3mdev_fib_table_by_index                    304     282     -22
nf_nat_inet_fn                               777     754     -23
attach_rules                                 176     150     -26
ipv6_rcv                                     867     840     -27
ip_sublist_rcv                              1342    1315     -27
ip6_sublist_rcv                             1528    1501     -27
sit_tunnel_rcv                               498     470     -28
ndisc_send_redirect                         1474    1445     -29
ip_mr_input                                 1175    1143     -32
ip6_mr_input                                 627     595     -32
tcp_ao_add_cmd.cold                           33       -     -33
ip_error                                    1059    1023     -36
raw_sendmsg                                 5291    5253     -38
end_dt_vrf_core                              466     426     -40
ip_rcv                                       886     844     -42
ip_send_unicast_reply                       1487    1443     -44
udp_sendmsg                                 4135    4089     -46
delete_tempaddrs                             259     211     -48
udp6_gro_receive                            1142    1092     -50
udp4_lib_lookup_skb                          259     208     -51
l3mdev_fib_rule_match                        337     286     -51
ping_v4_sendmsg                             2692    2640     -52
tcp6_check_fraglist_gro                      341     288     -53
l3mdev_master_ifindex_rcu                     69      16     -53
ip6_dst_lookup_tail.constprop               1533    1480     -53
udp4_gro_receive                            1139    1085     -54
igmp_rcv                                    3215    3160     -55
ndisc_recv_ns                               1699    1642     -57
fib_netdev_event                             771     714     -57
l3mdev_link_scope_lookup                     124      65     -59
udp6_lib_lookup_skb                          173     113     -60
__ip_local_out                              1182    1120     -62
ipv6_frag_rcv                               3670    3601     -69
ip_route_output_key_hash_rcu                3024    2951     -73
__ip6_local_out                             1164    1091     -73
tcp_v6_send_response                        3056    2982     -74
rt6_fill_node                               4103    4027     -76
rawv6_sendmsg                               6225    6149     -76
l3mdev_fib_table_rcu                          92      16     -76
tcp4_gro_receive                            1375    1295     -80
ip6_xmit                                    2771    2690     -81
fib_select_path                             2190    2105     -85
tcp_v4_parse_md5_keys                       1160    1058    -102
ip_route_input_slow                         4471    4354    -117
ip6_pkt_drop.isra                            572     453    -119
l3mdev_update_flow                           516     360    -156
ip6_rt_get_dev_rcu                           182       -    -182
__ipv6_chk_addr_and_flags                    750     568    -182
ip_route_input_rcu.part                      941     743    -198
nf_confirm                                  1222     960    -262
ipv6_dev_get_saddr                          1321     918    -403
tcp_ao_add_cmd                              2643    2211    -432
ipip6_tunnel_lookup                         1004       -   -1004
Total: Before=33195512, After=33191463, chg -0.01%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 87cafc932e9e6584405821a87be0e31e0fc65b77..8454646d6a4548a63fef1c29b8119ba94c36bc71 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5606,12 +5606,12 @@ static inline bool netif_has_l3_rx_handler(const struct net_device *dev)
 
 static inline bool netif_is_l3_master(const struct net_device *dev)
 {
-	return dev->priv_flags & IFF_L3MDEV_MASTER;
+	return IS_ENABLED(CONFIG_NET_VRF) && (dev->priv_flags & IFF_L3MDEV_MASTER);
 }
 
 static inline bool netif_is_l3_slave(const struct net_device *dev)
 {
-	return dev->priv_flags & IFF_L3MDEV_SLAVE;
+	return IS_ENABLED(CONFIG_NET_VRF) && (dev->priv_flags & IFF_L3MDEV_SLAVE);
 }
 
 static inline int dev_sdif(const struct net_device *dev)
-- 
2.55.0.897.gb25b4bd76c-goog

