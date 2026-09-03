Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0649EC60
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455270; cv=none; b=m6o6LReUtoAtwAOrmMmrSGRd4VK98Z8ny5eO85h7riyd4BYCPbRk8yyESsy8a5ebtazSVp5Opt92IpsKD2wPMMGhjYdlDXLXSmwYY0d14lrJrYdAgbA03lXhRChjWr9ccDZKYOQ8u1z8O9j76rFciHPk6BKkibmuFrfVCR4Tv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455270; c=relaxed/simple;
	bh=1mAusGE2WjZjp2lU0prL79NM/ZtzNKAJZRVPuIeOUmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AY04FfA3ngMNUCBnrqTyobusl9NlstdCfpzhTrszUbHZGIDnvweGRfHfk/S/XLPLHlq0uRM8+NdlRq132JyjO87sonN/Eum3XVxEAbOGtsF+QotwIBoV/T2bv73I4SxrHqDPXmwQunHYFkJw92fIxMesGPT68d5Nev/pXjykSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PYTcoeja; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYTcoeja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788455267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s+EZtMHgeGqsFph8/8MM9BHrlRmIxU3w55YSmxrBHfs=;
	b=PYTcoejaSETwGAD9hDycSg1dvCVKkHRvSzFDgpiaD+JX2PHv760angazdCSF3WwN3+m/Pi
	IsWYt6m8zWioHCY3SQN2baYTmXV8ect16grc2U8bZZu97BuSJlmZqYUw82lZV0IWl5sYJ2
	Cz8ATga/UUxRA42sk9bsa1Zvwz5xqqM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-2BKyY_5PNFaO6Zd2PaDL9g-1; Thu,
 03 Sep 2026 13:07:46 -0400
X-MC-Unique: 2BKyY_5PNFaO6Zd2PaDL9g-1
X-Mimecast-MFC-AGG-ID: 2BKyY_5PNFaO6Zd2PaDL9g_1788455265
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DED3119792DD;
	Thu,  3 Sep 2026 17:07:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 194701800643;
	Thu,  3 Sep 2026 17:07:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.3-rc2
Date: Thu,  3 Sep 2026 19:07:35 +0200
Message-ID: <20260903170735.107840-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus!

The following changes since commit 1b78070aaef63512688aebfbc82365ef9d6660f1:

  Merge tag 'net-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-08-27 13:53:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc2

for you to fetch changes up to 66817a9794263cd2a5dc4e99bf8e5fcc5ff7181e:

  net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list() (2026-09-03 12:20:38 +0200)

----------------------------------------------------------------
Including fixes from bluetooth.

Previous releases - regressions:

  - page_pool: keep frag_offset aligned for odd-sized requests

  - sched: fix u32 duplicate handle when node ID pool is exhausted

  - udp: create exceptions before socket matching

  - igmp: convert struct ip_sf_list to RCU

  - ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit

  - rds: acquire the fastpath locks in rds_conn_shutdown()

  - tipc:
    - protect node reset trace dump with node lock
    - fix NULL deref in tipc_named_node_up() on empty publication list

  - bluetooth:
      L2CAP: fix out-of-bounds write in l2cap_ecred_connect
      hci_core: fix race condition during device registration

  - eth: mlx5e: prevent stale XSK buffer release on refill retries

  - eth: bridge: don't truncate the port group walk on teardown

Previous releases - always broken:

  - gro: fix nesting of TCP GSO SKBs in skb_gro_receive_list()

  - sched: fix skb sizing and action leak on reoffload delete

  - tcp: fix use-after-free in do_tcp_getsockopt()

  - af_packet: don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().

  - sctp: fix soft lockup from unpadded ASCONF-ACK parameter iteration

  - iptunnel: fix stale transport header during tunnel decapsulation

  - eth: vxlan: fix use-after-free in vxlan_mdb_remote_src_del()

  - eth: bonding: fix uninitialized transport header access in alb_determine_nd()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aleksandr Nogikh (1):
      Bluetooth: hci_core: Fix race condition during device registration

Allison Henderson (5):
      net/rds: use wq_has_sleeper() in release_in_xmit()
      net/rds: use clear_bit_unlock() in release_refill()
      net/rds: clear cp_flags bits individually in rds_conn_path_reset()
      net/rds: acquire RDS_IN_XMIT in rds_tcp_reset_callbacks()
      net/rds: don't let rds_conn_shutdown() consume a concurrent drop

Aohan Mei (1):
      net/sched: cls_flower: validate mask pointer after nla_next()

Aswin Karuvally (1):
      s390/ctcm: Prevent XID null dereference

Baul Lee (1):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_remote_src_del()

Bryam Vargas (1):
      net/iucv: fix the recvmsg window update

Cen Zhang (Microsoft Security FORGE Labs) (2):
      tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
      tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

Charles Vosburgh (1):
      sctp: validate chunk length in the inqueue parser

Chengfeng Ye (1):
      tipc: protect node reset trace dump with node lock

Chris Lew (1):
      net: qrtr: Send HELLO message on endpoint register

Daehyeon Ko (2):
      vsock/virtio: validate packet source for connected sockets
      vsock/vmci: validate packet source for connected sockets

David Laight (1):
      tipc: Dont send random pad bytes in RESET/ACTIVATE messages

Dong Chenchen (1):
      net: iptunnel: fix stale transport header during tunnel decapsulation

Eric Dumazet (13):
      net: icmp: avoid invalid transport header access in icmp_send tracepoint
      tcp: use GFP_ATOMIC in tcp_send_active_reset()
      igmp: convert struct ip_sf_list to RCU
      ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
      ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
      ipv6: mcast: fix delay calculation in igmp6_join_group()
      ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
      ipv6: mcast: use jiffies_delta_to_clock_t() in igmp6_mc_seq_show()
      ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit
      ipv6: sr: restore network header before routing and forwarding
      net: bonding: annotate lockless writes with WRITE_ONCE()
      bonding: alb: fix uninitialized transport header access in alb_determine_nd()
      bonding: do not clear curr_active_slave prematurely when releasing all slaves

Florian Schauer (1):
      page_pool: keep frag_offset aligned for odd-sized requests

Gerd Rausch (1):
      net/rds: tcp: don't force RDS_CONN_RESETTING over a concurrent shutdown

Gongwei Li (1):
      Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()

HW He (1):
      net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()

Henry Martin (1):
      sctp: fix soft lockup from unpadded ASCONF-ACK parameter iteration

Håkon Bugge (1):
      net/rds: acquire the fastpath locks in rds_conn_shutdown()

Ian Lin (1):
      net: usb: qmi_wwan: add Compal EXM-G1x support

Ido Schimmel (4):
      ipv6: Fix redirect exception creation for UDP/RAW sockets
      ipv4: udp: Create exceptions before socket matching
      ipv6: udp: Create exceptions before socket matching
      selftests: net: Add exception cache tests

Ilya Maximets (2):
      netlink: specs: fix the conntrack filter type
      netlink: specs: add missing mask attributes for conntrack dump

Jakub Kicinski (10):
      Merge branch 'netlink-specs-fixes-for-conntrack-dump-filtering'
      Merge branch 'net-mlx5e-prevent-stale-xsk-buffer-release-on-refill-retries'
      Merge branch 'net-sched-fix-remaining-actions-notification-accounting-issues'
      Merge branch 'tcp-fix-use-after-free-in-do_tcp_getsockopt'
      Merge branch 'fix-to-possible-skb-leak-due-to-race-condtion-in-tx-path'
      Merge branch 'vsock-validate-packet-sources-after-bound-lookup-fallback'
      Merge tag 'for-net-2026-08-31' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'ipv6-mcast-rcu-and-timer-fixes'
      Merge branch 'mitigate-a-side-channel-in-routing-exception-caches'
      Merge branch 'net-rds-own-the-fastpath-locks-across-connection-teardown'

Jamal Hadi Salim (2):
      net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
      selftests: tc-testing: add u32 node ID pool exhaustion test

James Nugraha (1):
      net: amd-xgbe: discard rx packets with bad FCS

Jerome Tollet (2):
      net/mlx5e: Prevent stale XSK buffer release on refill retry
      net/mlx5e: Prevent stale XSK buffer release on MPWQE refill retry

Jun Yang (1):
      net: bridge: mcast: don't truncate the port group walk on teardown

Kaiwen Shi (1):
      mac802154: fix data race and NULL deref on local->assoc_dev

Kiran K (1):
      Bluetooth: btintel_pcie: Clear automask on spurious interrupts

Kiran Kumar K (1):
      octeontx2-af: fix CN20K default MCAM rule removal on port cleanup

Koichiro Den (1):
      net: ntb_netdev: Fix statistics races

Kuniyuki Iwashima (2):
      af_packet: Don't cast tpacket_hdr.tp_len to int in tpacket_parse_header().
      net: Remove conflicting altnames for dying netns in __dev_change_net_namespace().

Laxman Acharya Padhya (3):
      Bluetooth: btintel: validate version TLV value lengths
      Bluetooth: btintel: bound firmware ID by TLV length
      Bluetooth: btintel: propagate version TLV parsing errors

Lorenzo Bianconi (3):
      net: stmmac: fix dma mapping leak in stmmac_tso_xmit()
      net: airoha: enable RX_DONE interrupt for RX queue 31
      net: stmmac: reconfigure RX packet parser table in stmmac_hw_setup() after reset

Maciej Fijalkowski (1):
      ipvlan: unregister upper devices outside pnodes_lock

Nicolai Buchwitz (1):
      net: macb: exclude software FCS from TX byte statistics

Norbert Szetei (1):
      net: psp: do not inherit the Rx association on clone

Pauli Virtanen (3):
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Qingfang Deng (2):
      ppp: ppp_async: simplify tty disc_data access
      ppp: ppp_synctty: simplify tty disc_data access

Selvamani Rajagopal (4):
      net: ethernet: oa_tc6: Protect skb pointer used by two different kernel instances
      net: ethernet: oa_tc6: Improve the error recovery
      net: ethernet: oa_tc6: Disable tx queues on fatal error
      net: ethernet: oa_tc6: Fix for the wrong data type

Sunil Goutham (1):
      octeontx2-af: Fix limiting SRIOV VF count logic

Tung Nguyen (1):
      tipc: fix NULL deref in tipc_named_node_up() on empty publication list

Victor Nogueira (3):
      net/sched: act_api: budget all shared attributes in notify skbs
      net/sched: act_api: size the RTM_GETACTION reply from the actions
      net/sched: act_api: fix skb sizing and action leak on reoffload delete

Xin Long (1):
      sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START

Xuanqiang Luo (1):
      raw: annotate disconnect-side IPv4 match writers

Zihan Xi (1):
      ipv4: avoid divide by zero in fib_rebalance

 Documentation/netlink/specs/conntrack.yaml         |  21 +-
 drivers/bluetooth/btintel.c                        |  44 +-
 drivers/bluetooth/btintel_pcie.c                   |   3 +
 drivers/bluetooth/hci_mrvl.c                       |   3 +-
 drivers/net/bonding/bond_alb.c                     |  15 +-
 drivers/net/bonding/bond_main.c                    |  18 +-
 drivers/net/bonding/bond_options.c                 |   4 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |   3 +-
 drivers/net/ethernet/cadence/macb.h                |   3 +
 drivers/net/ethernet/cadence/macb_main.c           |  21 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  33 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   7 +-
 drivers/net/ethernet/oa_tc6.c                      | 258 +++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  61 ++-
 drivers/net/gtp.c                                  |   5 +
 drivers/net/ipvlan/ipvlan_main.c                   |   4 +-
 drivers/net/ntb_netdev.c                           |  47 +-
 drivers/net/ppp/ppp_async.c                        |  82 +---
 drivers/net/ppp/ppp_synctty.c                      |  83 +---
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/vxlan/vxlan_mdb.c                      |   8 +
 drivers/s390/net/ctcm_mpc.c                        |   3 +-
 include/linux/igmp.h                               |   7 +-
 include/linux/skbuff.h                             |   5 +
 include/net/af_vsock.h                             |   3 +
 include/net/if_inet6.h                             |   2 -
 include/net/ip.h                                   |   3 +-
 include/net/tcp.h                                  |   3 +-
 include/trace/events/icmp.h                        |  13 +-
 net/bluetooth/hci_core.c                           |   4 +-
 net/bluetooth/l2cap_core.c                         |  33 +-
 net/bluetooth/msft.c                               |   2 +-
 net/bridge/br_multicast.c                          |  13 +-
 net/core/dev.c                                     |  25 +-
 net/core/gro_cells.c                               |   2 +
 net/core/page_pool.c                               |   3 +-
 net/core/sock.c                                    |   3 +
 net/ipv4/fib_semantics.c                           |   2 +-
 net/ipv4/igmp.c                                    | 210 +++++----
 net/ipv4/tcp.c                                     |  32 +-
 net/ipv4/tcp_cong.c                                |   4 +-
 net/ipv4/tcp_dctcp.c                               |   4 +-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv4/tcp_offload.c                             |  22 +-
 net/ipv4/tcp_output.c                              |   6 +-
 net/ipv4/tcp_timer.c                               |   6 +-
 net/ipv4/udp.c                                     |  15 +-
 net/ipv6/exthdrs.c                                 |   4 +-
 net/ipv6/ip6_gre.c                                 |   6 +-
 net/ipv6/mcast.c                                   | 148 +++---
 net/ipv6/route.c                                   |   2 +-
 net/ipv6/tcpv6_offload.c                           |  15 +-
 net/ipv6/udp.c                                     |  13 +
 net/iucv/af_iucv.c                                 |  42 +-
 net/mac802154/ieee802154_i.h                       |   7 +-
 net/mac802154/main.c                               |   1 +
 net/mac802154/scan.c                               |  51 +-
 net/mptcp/protocol.c                               |   3 +-
 net/mptcp/protocol.h                               |   2 +-
 net/packet/af_packet.c                             |   5 +-
 net/qrtr/af_qrtr.c                                 |  66 ++-
 net/qrtr/ns.c                                      |  35 +-
 net/rds/connection.c                               |  89 +++-
 net/rds/ib_recv.c                                  |   9 +-
 net/rds/send.c                                     |  14 +-
 net/rds/tcp.c                                      | 101 ++--
 net/rds/tcp_listen.c                               |   6 +-
 net/sched/act_api.c                                |  37 +-
 net/sched/cls_flower.c                             |   5 +
 net/sched/cls_u32.c                                |  32 +-
 net/sctp/inqueue.c                                 |   6 +-
 net/sctp/sm_make_chunk.c                           |  14 +-
 net/sctp/sm_sideeffect.c                           |  11 +-
 net/tipc/link.c                                    |   6 +-
 net/tipc/name_table.c                              |  30 +-
 net/tipc/node.c                                    |   2 +
 net/vmw_vsock/af_vsock.c                           |  32 ++
 net/vmw_vsock/virtio_transport_common.c            |   3 +-
 net/vmw_vsock/vmci_transport.c                     |  34 +-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/exception_cache.sh     | 521 +++++++++++++++++++++
 tools/testing/selftests/net/test_vxlan_mdb.sh      |   6 +
 .../selftests/tc-testing/tc-tests/filters/u32.json |  23 +
 86 files changed, 1839 insertions(+), 703 deletions(-)
 create mode 100755 tools/testing/selftests/net/exception_cache.sh

