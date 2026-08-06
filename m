Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC243AFCF2;
	Thu,  6 Aug 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041002; cv=none; b=ZOzAn1yC2b0CYsNj6X7oGaRGEs4vJQlOL+LhL5x768FKC78ZPBPfqeScAuMSTwqPOJ8+7lyVXz9miy+q11chV0kopK9W/R0pMwYvo9LHTVXMjyGFGSgiZBnk7Umf6YnIjsHFCPhjgJBpM+1vnj8C7JMqrFBMUODo8IraYcyCh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041002; c=relaxed/simple;
	bh=r6xupwPkom6gN0OrkOpqSMntjpLQbnOXNnwCjln3dAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmZW5CyAMSKookdSKK86+fCXK9YqsTAjLq/+/PTLuTqbqlUrhH4AtL+9C+LrWNNM68JwZwe6DD0lwY2Ax8R4OEHJ8qH4RfWurrhK6zSC48w5QZEUHH88iGhTEBFH0UYVr/rCNSvUjfZhC/AABUerP/qH7UQ+nXYalDTnRiI3Rs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgRvR3eD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgRvR3eD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1291F000E9;
	Thu,  6 Aug 2026 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041000;
	bh=q8L/Q3f/vyR1HpytOpV4fjv9GQdR7zdHnXsB8Q6As48=;
	h=From:To:Cc:Subject:Date;
	b=JgRvR3eDx/Xe74G/LLaS4eC7Rp+nk6ZrNRyrzcn+wB3rv89wxmgkZTRoCJtAVvHo/
	 6PZHLNVEogwy8m8ap60vcFTuPGNvB9X45Xfh/LLJ2AhDUZ7/MkJ9sgjao7OO9s2XHO
	 SYT1+sijikNOMSHT0cVF4WtmB69L+xK+fOUnKjuctOKNgd5nAA23/Q6NXHj6VLLXUl
	 B3VBDtTrCdMak/VOJ2fJOcIfMOQBnTNnUne8LewFrSfdaRXd4yYQWGDr4TxCrdveRb
	 5XkPAV8FVJaRZQQsvBG3KdjvdtKizOmnvbCq2StDc6dcj4mlh7qx93bTH9sIy5fuzm
	 UyRJcrPbwvrkw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.2-rc7
Date: Thu,  6 Aug 2026 11:29:59 -0700
Message-ID: <20260806182959.2963546-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 2812e64e1575e05500a35c405aaa6e99b7d7930b:

  Merge tag 'net-7.2-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-30 09:18:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc7

for you to fetch changes up to b0ce5fd9fabe7c79463cf4602217d4dfeff5b1fd:

  igc: fix netdev not re-attached after resume if interface is down (2026-08-06 10:21:28 -0700)

----------------------------------------------------------------
Including fixes from netfilter.

Looks like our attempt to keep the PRs smaller have only prevented
this one from getting even bigger. In the last 9 days there were
405 postings explicitly tagged with [PATCH net], vs 687
with [PATCH net-next]. 37% of posted patches being fixes is pretty
crazy, and that's likely undercounting because LLM "researchers"
more often post fixes without knowing to tag the patches for specific
trees. I don't have historic data.

In any case, we keep adjusting the criteria. The next PR will be smaller.

Current release - regressions:

 - net: defer netdev KOBJ_ADD uevent until the device is published,
   previously rtnl_lock would serialize the accesses vs publishing

 - net: explicitly cancel work to avoid races with ref tracker exit

 - qrtr: ns: raise lookup limit to 128

 - eth: hns3: fix speed configuration residue after driver reload

Previous releases - regressions:

 - tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss(),
   regressed flows with MSS and scaling_ratio variability

 - Revert "net: thunderbolt: Enable end-to-end flow control also
   in transmit", broke some platforms (no packets coming thru)

 - eth: stmmac: resume PHY before hardware setup when opening
   the interface

Previous releases - always broken:

 - another pile of fixes for less common protocols (SCTP, TLS, SMC etc.)

 - close a couple of AF_PACKET bugs and ways it can build skbs
   problematic for the rest of the stack

 - bridge: mrp: fix uninitialised bytes on the wire

 - net: devmem: prevent net-iov / page mixing, avoid crashes

 - eth: atlantic: free RX pages of consumed but not refilled buffers

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Ahmad Byagowi (1):
      ptp: ocp: Fix board ID over-read

Ahmed Naseef (1):
      net: phy: mediatek: fix TX blink masks using the RX bits

Alexandra Winter (1):
      s390/ism: Fix UAF of sba and ieq during ism_dev_exit()

Alok Tiwari (2):
      bnge: Fix NULL pointer dereference in aux device release
      bnge: use int for bnge_fix_rings_count() return value

Antonio Quartulli (7):
      ovpn: skip rehash for peers already removed from by_id
      ovpn: rehash peer in by_transp_addr table on CMD_PEER_SET
      ovpn: ensure socket is owned by ovpn before deref sk_user_data
      ovpn: zero-initialize sockaddr before learning a floated endpoint
      ovpn: hash floated peer by transport identity only
      ovpn: disable IPv4 redirects on MP interfaces
      ovpn: ensure TCP vars are initialized first

Baul Lee (3):
      net/x25: fix use-after-free of the socket by its timers
      net: bridge: mrp: fix uninitialised bytes on the wire
      sctp: keep chunk->transport in step with the list it is queued on

Bhargava Marreddy (1):
      bnge: Fix resource leak in bnge_init_nic() error path

Bobby Eshleman (1):
      net/mlx5e: fix BQL reset on SQ re-activation

Cen Zhang (Microsoft) (1):
      net/openvswitch: check Ethernet header length in key_extract()

Chengfeng Ye (1):
      netfilter: ebt_nflog: pin the NFLOG backend

Chris Mi (1):
      net/mlx5: SF, Handle function changed event

Daming Li (1):
      net: smc: fix splice entry lifetime imbalance in smc_rx_splice

Dongli Zhang (1):
      net: tap: set skb->dev before parsing virtio net header in tap_get_user_xdp()

Doruk Tan Ozturk (2):
      net/packet: reset the MAC header on the packet-socket transmit path
      net: usb: ipheth: fix carrier_work UAF on disconnect

Dragos Tatulea (1):
      net: Defer netdev KOBJ_ADD uevent until the device is published

Eric Dumazet (3):
      netfilter: nf_flow_table: drop existing skb dst before skb_dst_set_noref()
      net: remove WARN_ON_ONCE() from sk_mc_loop()
      net/atm: fix slab-out-of-bounds read in vcc_setsockopt()

Fan XinRan (1):
      net: thunderbolt: Tear down DMA paths before stopping the rings

Fan Ye (1):
      Revert "net: thunderbolt: Enable end-to-end flow control also in transmit"

Florian Westphal (3):
      netfilter: ipset: add small wrappers for hash and bucket sizes
      netfilter: ipset: add and use mtype_del_cidr_all helper
      netfilter: ipset: switch to rcu work

Gang Yan (1):
      selftests: mptcp: join: mark tests with data corruption as failed

Henry Martin (1):
      net/ncsi: fix heap OOB read in NCSI_CMD_SEND_CMD payload length

Hidayath Khan (2):
      s390/qeth: validate user buffer length in SNMP and ARP query ioctls
      dibs: initialise dibs->lock in dibs_dev_alloc()

Ivan Vecera (1):
      MAINTAINERS: dpll: zl3073x: replace Prathosh Satish with Min Li

Jakub Kicinski (10):
      Merge branch 'vsock-virtio-fix-worker-access-after-virtqueue-teardown'
      Merge branch 'xsk-harden-tx-metadata-validation-against-races'
      Merge tag 'ovpn-net-20260730' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'net-atlantic-fix-two-ring-teardown-leaks'
      Merge branch 'bnxt_en-bug-fixes'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'mptcp-misc-fixes-for-v7-2-rc6'
      Merge branch 'tls-fix-plaintext-sk_msg-ring-over-fill'
      Merge branch 'net-fix-hard_header_len-races-in-packet-send-paths'
      net: avoid theoretical races with ref drain

Jamal Hadi Salim (2):
      net/sched: cls_route: fix fastmap use-after-free on filter
      net/sched: cls_api: Always acquire rtnl_lock when destroying locked classifiers

Jiawen Liu (1):
      net: hisilicon: hix5hd2_gmac: remove redundant NAPI delete

Jiayuan Chen (1):
      tcp: fix TFO max_qlen accounting across reuseport migration

Jijie Shao (2):
      net: hns3: fix speed configuration residue after driver reload
      MAINTAINERS: add myself as a maintainer for Hisilicon Network Subsystem

Jozsef Kadlecsik (2):
      netfilter: ipset: rework cidr bookkeeping
      netfilter: ipset: switch ext_size to atomic64_t

Julian Anastasov (2):
      ipvs: avoid out-of-bounds write in ip_vs_nat_icmp
      ipvs: return the csum validation for forward hook

Jérémy Jean (1):
      tls: rx: restore msg_iter before TLS 1.3 optimistic retry

Keegan Freyhof (1):
      bnxt_en: Fix PTP PPS setting bug

Kyle Zeng (1):
      ipv6: prevent in6_dev_get() from resurrecting inet6_dev

Laurent Vivier (1):
      usbnet: cap max_mtu for drivers without bind callback

Mahanta Jambigi (1):
      net/smc: fix qentry overwrite for CONFIRM_LINK and ADD_LINK_CONT in smc_llc_event_handler()

Marco Baffo (1):
      ovpn: limit keepalive values to one day

Matthieu Baerts (NGI0) (3):
      mptcp: options: reset DSS fields in case of unexpected size
      mptcp: avoid combining some incoming suboptions
      mptcp: remove MPC && MPJ check

Maximilian Immanuel Brandtner (1):
      tls: don't abort the connection on signal-interrupted sends

Michael Chan (1):
      bnxt_en: Disable EOP for TPA on all chips to prevent data corruption

Michael Guralnik (1):
      net/mlx5: fw_tracer, return NULL on create error

Nathan Gao (1):
      tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss()

Nikhil P. Rao (2):
      pds_core: keep the health thread stopped during reset
      pds_core: cancel pending PCI reset work on AER recovery

Or Har-Toov (1):
      devlink: fix net namespace reference leak in reload

Paolo Abeni (2):
      Merge branch 'net-sched-fix-qdisc-graft-hierarchy-validation'
      mptcp: reclaim forward-allocated memory on RX path errors

Pavel Begunkov (1):
      net: devmem: prevent net-iov / page mixing

Pengpeng Hou (1):
      net: prestera: validate firmware header length

Philipp David (1):
      igc: fix netdev not re-attached after resume if interface is down

Qihang Tang (3):
      net: remove CAP_SYS_RAWIO zero-padding in dev_validate_header
      packet: use consistent hard_header_len in non-ring send paths
      packet: use consistent hard_header_len in TX_RING send path

Qing Luo (2):
      sctp: fix addip_serial increment on ASCONF_ACK allocation failure
      mptcp: pm: fix data race in add_addr timer callback

Qingfang Deng (1):
      ovpn: fix incorrect use of rcu_access_pointer()

Ralf Lici (1):
      ovpn: add missing rtnl_link_ops->get_size callback

Satish Kharat (1):
      enic: fix tx_hang_reset use-after-free on device removal

Sergey V. Frolov (1):
      net: octeontx2-pf: Fix UB in shift operation

Shardul Bankar (1):
      mptcp: pm: fix memory leak from alloc-during-teardown race

Shay Drory (1):
      net/mlx5e: TC, Check if flow is PEER before acquiring devcom lock

Shravya KN (3):
      bnxt_en: Move RSS table fill outside __bnxt_hwrm_vnic_set_rss()
      bnxt_en: Determine and store default RX ring in vnic structure
      bnxt_en: Refresh VNIC default ring on queue restart if needed

Sidraya Jayagond (1):
      net/smc: fix TOCTOU race between smc_listen_out() and listener close

Stanislav Fomichev (6):
      xsk: require at least 16 bytes of TX metadata
      xsk: pass TX metadata pointer by reference
      xsk: clear metadata pointer when no timestamp is requested
      xsk: validate launch-time metadata size
      xsk: move xsk_tx_metadata_request() to xdp_sock_drv.h
      xsk: validate metadata when processing requests

Stefan Agner (1):
      net: stmmac: resume PHY before hardware setup when opening the interface

Toke Høiland-Jørgensen (1):
      net/sched: sch_cake: drop WARN_ON(1) for malformed packets in ACK filter

Weiming Shi (2):
      vsock/virtio: read virtqueues under worker locks
      vsock/virtio: avoid refilling the RX queue after teardown

Will Chen (1):
      bnxt: fix memory leak in bnxt_queue_mem_alloc error cases

Wyatt Feng (1):
      mptcp: fastopen: only mark MPTFO subflows with SYN data

Xiang Mei (Microsoft) (1):
      bonding: alb: re-check primary_is_promisc under RTNL in bond_alb_monitor

Xin Long (1):
      sctp: clear control chunk transport if it is being removed

Xuanqiang Luo (1):
      udp: fix potential use-after-free in tunnel segmentation

Yangyu Chen (2):
      net: atlantic: free stranded TX buffers on ring deinit
      net: atlantic: free RX pages of consumed but not refilled buffers

Yi Cong (1):
      net: usb: ax88179_178a: fix skb leak in ax88179_tx_fixup()

Yuejie Shi (1):
      ipv6: fix Route Information option length validation

Zhiling Zou (5):
      ipvs: stop estimator after disabled calc phase
      inet: frags: publish queues before arming timer
      net: openvswitch: reallocate update replies for mismatched IDs
      ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
      xdp: reject clones that overrun skb_shared_info tailroom

Zihan Xi (3):
      ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
      packet: synchronize pressure clearing with ring reconfiguration
      mac802154: fix netdev use-after-free in beacon worker

Zijie Huang (2):
      net/sched: reject overly deep qdisc hierarchies
      selftests/tc-testing: add qdisc hierarchy depth tests

chanyoung (2):
      tls: don't leave a full plaintext sk_msg ring unpushed
      selftests: tls: add a test for splicing onto a full plaintext record

Łukasz Patron (1):
      net: qrtr: ns: Raise lookup limit to 128

 Documentation/netlink/specs/ovpn.yaml              |   4 +
 MAINTAINERS                                        |   3 +-
 drivers/dibs/dibs_main.c                           |   2 +-
 drivers/net/bonding/bond_alb.c                     |  10 +-
 drivers/net/ethernet/amd/pds_core/core.h           |   1 +
 drivers/net/ethernet/amd/pds_core/main.c           |  14 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  51 +++-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |   1 +
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c    |   2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c     |   9 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |   2 -
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c     |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  64 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   7 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |   5 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |   1 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   6 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  10 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   6 +-
 .../net/ethernet/marvell/prestera/prestera_pci.c   |   3 +
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_priv.h   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/tx.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   4 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  10 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |  29 ++
 .../mellanox/mlx5/core/sf/diag/sf_tracepoint.h     |   8 +
 .../net/ethernet/mellanox/mlx5/core/sf/hw_table.c  |  22 ++
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h    |  12 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  13 +-
 drivers/net/ovpn/main.c                            |  64 +++--
 drivers/net/ovpn/netlink-gen.c                     |  20 +-
 drivers/net/ovpn/netlink.c                         |   6 +
 drivers/net/ovpn/peer.c                            | 172 +++++++++---
 drivers/net/ovpn/peer.h                            |   1 +
 drivers/net/ovpn/socket.c                          |   9 +
 drivers/net/phy/mediatek/mtk.h                     |   8 +-
 drivers/net/tap.c                                  |  24 +-
 drivers/net/thunderbolt/main.c                     |  33 ++-
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/net/usb/ipheth.c                           |  11 +-
 drivers/net/usb/usbnet.c                           |   3 +-
 drivers/ptp/ptp_ocp.c                              |   4 +-
 drivers/s390/net/ism_drv.c                         |  19 +-
 drivers/s390/net/qeth_core_main.c                  |   3 +
 drivers/s390/net/qeth_l3_main.c                    |   5 +
 include/linux/dibs.h                               |   2 +-
 include/linux/netdevice.h                          |  11 +-
 include/linux/netfilter/ipset/ip_set.h             |   6 +-
 include/net/addrconf.h                             |   4 +-
 include/net/ip_vs.h                                |  21 +-
 include/net/libeth/xsk.h                           |   2 +-
 include/net/sch_generic.h                          |   1 +
 include/net/xdp_sock.h                             |  47 +---
 include/net/xdp_sock_drv.h                         |  77 +++++-
 net/atm/common.c                                   |  14 +-
 net/bridge/br_mrp.c                                |   6 +-
 net/bridge/netfilter/ebt_nflog.c                   |  17 +-
 net/core/datagram.c                                |   3 +
 net/core/dev.c                                     |   2 +
 net/core/dev.h                                     |   1 +
 net/core/net-sysfs.c                               |  14 +
 net/core/net-sysfs.h                               |   1 +
 net/core/netdev_work.c                             |  16 ++
 net/core/sock.c                                    |   1 -
 net/core/xdp.c                                     |   2 +-
 net/devlink/dev.c                                  |   1 +
 net/ipv4/fib_semantics.c                           |  67 +++--
 net/ipv4/inet_connection_sock.c                    |  20 +-
 net/ipv4/inet_fragment.c                           |  10 +-
 net/ipv4/tcp_input.c                               |   2 +-
 net/ipv4/udp_offload.c                             |   4 +-
 net/ipv6/ip6_tunnel.c                              |   3 +
 net/ipv6/route.c                                   |   8 +-
 net/mac802154/scan.c                               |   4 +
 net/mptcp/fastopen.c                               |   7 +-
 net/mptcp/options.c                                |  67 ++++-
 net/mptcp/pm.c                                     |  19 +-
 net/mptcp/pm_userspace.c                           |   4 +
 net/mptcp/protocol.c                               |   6 +
 net/mptcp/protocol.h                               |   8 +-
 net/mptcp/subflow.c                                |   5 -
 net/ncsi/ncsi-netlink.c                            |   4 +
 net/netfilter/ipset/ip_set_bitmap_gen.h            |   4 +-
 net/netfilter/ipset/ip_set_core.c                  |  52 ++--
 net/netfilter/ipset/ip_set_hash_gen.h              | 306 ++++++++++++++-------
 net/netfilter/ipset/ip_set_hash_ipportnet.c        |   4 +-
 net/netfilter/ipset/ip_set_hash_net.c              |   4 +-
 net/netfilter/ipset/ip_set_hash_netiface.c         |   4 +-
 net/netfilter/ipset/ip_set_hash_netnet.c           |  12 +-
 net/netfilter/ipset/ip_set_hash_netport.c          |   4 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c       |  12 +-
 net/netfilter/ipset/ip_set_list_set.c              |   4 +-
 net/netfilter/ipvs/ip_vs_core.c                    |  69 ++---
 net/netfilter/ipvs/ip_vs_est.c                     |  10 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   2 +-
 net/netfilter/nf_flow_table_ip.c                   |   3 +
 net/openvswitch/datapath.c                         |  29 +-
 net/openvswitch/flow.c                             |  11 +-
 net/packet/af_packet.c                             |  72 +++--
 net/qrtr/ns.c                                      |   2 +-
 net/sched/cls_api.c                                |  17 +-
 net/sched/cls_route.c                              |  35 ++-
 net/sched/sch_api.c                                |   9 +
 net/sched/sch_cake.c                               |   1 -
 net/sctp/associola.c                               |   4 +
 net/sctp/outqueue.c                                |   1 +
 net/sctp/sm_make_chunk.c                           |   3 +-
 net/smc/af_smc.c                                   |   3 +-
 net/smc/smc_llc.c                                  |   3 +-
 net/smc/smc_rx.c                                   |  19 +-
 net/tls/tls_sw.c                                   |  18 +-
 net/vmw_vsock/virtio_transport.c                   |  14 +-
 net/x25/af_x25.c                                   |   4 +-
 net/x25/x25_timer.c                                |  25 +-
 net/xdp/xdp_umem.c                                 |   2 +
 net/xdp/xsk.c                                      |  11 +-
 net/xdp/xsk_buff_pool.c                            |   6 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +-
 tools/testing/selftests/net/tls.c                  |  94 +++++++
 .../tc-testing/tc-tests/qdiscs/depth.json          |  74 +++++
 127 files changed, 1583 insertions(+), 590 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/depth.json
