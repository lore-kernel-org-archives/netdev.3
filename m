Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293170;
	b=d93NIBw96xVt4h07TmYsTRXweQ3yw7C0MrqmFGY5qPXU0wojPS07qiRQLlCaDlFARr/i
	 a+mc8WR9fYG7PdwGUvx3yIy9zCnlMg5Ts2BVenyn0SEkLwRaHrRAuIharXHNQ8T3dnGWB
	 voumMo4PUEfGIO4Ts7QEpKNGn0u9MFQrEyoI6KtcMPiw0lFoCceWvj9rUgyUHc/cZV+do
	 7a9lXbnGgTNlWaJDAm7LS9F+BqCoYYfuCF1Cz1RaJ2euzDxiOxnbRJWHevJrQscImcx5L
	 P95FUVfln+7epQv4CmcesTHcmybRW7NepCcCkcwpGwFG8skN6oR36VvxJrAw6bgZ/6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ExDthG7GX5iobRnoo1yTcF17aQF/47k2yLGWN7hAE7w=;
	b=Oe4PtSuM6fNKaQ2OKTwB9E/by8nK0BDPyuRsESU0RfCNNAplY36ahHCFl8XVSa0Hxwij
	 8PUb/tQrcswUqL3IYaZcdPHXV6WRcHuLp1UdqqLQP3y4gugjqohoykGD3uwNwOL7G+EFH
	 +JoacClLo+qHE5Bq+ML5ouVeiAlOeax1XTU6mnz8VU8hmVNzw8GAp6YqYB+HXKp6Y39yd
	 v4G0j29hq97WHzjvP2KcJ/WQzX4219WrwJXl1Q0PRoQdizlHJ83ON7WoFOL7IQXsgua60
	 ClOzg7zVhebMXt44gGrzhy3yHBKUsr3z4dFRCGIWDYGlnrdmD98eiQqJ3/IhlQ0E57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8mtWech;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D5606A31A;
	Thu, 29 Oct 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8mtWech
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE85E1F01816;
	Thu, 29 Oct 2026 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293169;
	bh=ExDthG7GX5iobRnoo1yTcF17aQF/47k2yLGWN7hAE7w=;
	h=From:To:Cc:Subject:Date;
	b=X8mtWechd0jk8IdQxioAQSXB3gFoNA4XFBjo/Z7PQx49HqLK6XqxRf1VoBGI7Gm06
	 ZK+JBzgt9rB397v8dE6XwK3zlLB4LZYQUD/E+qd9C2I5elhq2U39BjsdrrYKmC7jgI
	 duGKsTGqBsEOb0+tbZEFmKe0XXWkPIEbvpW9giItKGVRHscNBoxzQ2jZ5ace9RCE5l
	 /QtOvJ8r+Ls0w8r1mmoHPXG6+E+roFJc1Ci0i5eFlEeMieh9dSs99YcmAy9XVB65Wc
	 pHudAeCJCzrKCkPd4m7q/r2NNwRphw0bXi7DRxZOPCU8t8JYdjG8O0ntVQocBXnYLZ
	 zQJ2DPs3Oau0A==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.4-rc1
Date: Thu, 29 Oct 2026 09:59:28 -0700
Message-ID: <20261029165928.3587812-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 734bef548a96e8774d6eef5dfa2026c6edc4e80b:

  Merge tag 'net-next-7.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-10-22 15:58:00 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.4-rc1

for you to fetch changes up to 8f44631ba02afe9fff2f0a0fb66560ab19df87fd:

  tun: drop batched packets while the device is down (2026-10-29 09:25:58 -0700)

----------------------------------------------------------------
Current release - new code bugs:

 - mctp: usblib: fix assertion breaking esoteric builds

Previous releases - regressions:

 - eth: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl

 - eth: mlx4: always create the eth and ib auxiliary devices

 - Revert advertising the TCP MSS from the configured MTU

 - eth: tg3: invert restart quirk logic to restrict SNP power-down bypass

 - eth: bnxt: recycle agg buffers when Rx head buffer allocation fails

- netlink: check sk_rcvbuf before charging the dump skb

Previous releases - always broken:

 - net: fix frag_list leak in skb_segment_list() error path

 - sctp: reject forged cookie peer_addr with unknown address family

 - vxlan: keep reserved_bits across changelink

 - net: limit priority VLAN untag depth

 - inet: frags: prevent acceptance of partially authenticated reassembly

 - gro: do not GRO GSO packets with inconsistent payload

 - tcp: avoid double destroy in tcp_abort() of an unaccepted child

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aamir Ahmed (1):
      gve: fix out-of-bounds read in gve_get_flow_rule_entry()

Alexandre Cassen (2):
      net/sched: act_api: inherit filter offload flags only on new actions
      selftests: tc-testing: test offload flags of reused matchall actions

Allison Henderson (4):
      net/rds: include the scope id in the sendmsg connection cache check
      net/rds: keep the connected peer's scope id apart from the bound one
      net/rds: do not fail init when CONFIG_SYSCTL=n
      net/rds: do not initialize transports after rds_init() failed

Anil Kaushik (1):
      gtp: Require 'CAP_NET_ADMIN' when joining the gtp multicast group

Antonio Quartulli (1):
      net/sched: fix packet reordering on requeue

Binbin Deng (1):
      net: atlantic: Unregister before clearing RXNFC rules

Cheng Yongkang (1):
      net: tun: hold napi_mutex when deleting NAPI in tun_detach_all()

Chuck Lever (2):
      tls: Honor O_NONBLOCK in tls_sw_splice_read()
      selftests: tls: Cover splice on a nonblocking socket

Coia Prant (4):
      net: pcs: xpcs-plat: fix runtime PM initialization
      net: pcs: xpcs-plat: fix clock lifecycle for !CONFIG_PM builds
      net: pcs: xpcs-rk: fix cleanup action error message
      MAINTAINERS: list DW XPCS platform driver and binding under XPCS entry

Cosmin Ratiu (2):
      net/mlx5e: SHAMPO: Do not merge PSP packets
      net/mlx5: Only set num_doorbells on a fully initialized SF

Daniel Machon (8):
      net: sparx5/lan969x: do not read past skb->len when injecting a frame
      net: sparx5: fix tx DCB index drift in fdma xmit
      net: lan966x: do not inject uninitialised bytes past skb->len
      net: lan966x: do not warn on MAC entries that are not port destined
      net: lan966x: fix the DB dataptr of frames from ndo_xdp_xmit
      net: lan966x: release the in-flight slot of a stale TX skb
      net: microchip: fdma: fix DCB corruption under sustained load
      net: lan966x: don't disable hardirqs in fdma tx clear path

Daniel Palmer (1):
      net: i825xx: 82596: use MMIO accessors for the MVME16x PORT/CA registers

David Yang (2):
      net: hisilicon: hisi_femac: Stop the receiver before releasing the RX ring
      net: dsa: motorcomm: Fix function parameter types

Dharmender Garg (2):
      bnge: cap RSS contexts and RX rings to the RSS table size
      bnge: fix RSS table sizing for large RX ring counts

Dimitri Daskalakis (1):
      eth: fbnic: Correct packet header prefetch

Divyanshu Jha (1):
      net: usb: cdc_ncm: add Apple Silicon MacBook Air (05ac:1903) device ID

Dong Yibo (1):
      net: rnpgbe: Accept link-down events without speed magic

Dudu Lu (5):
      net/sched: etf: initialise the sock_exterr_skb before filling it
      net/sched: gred: keep the qdisc lock while updating the table
      net/sched: taprio: unwind the netdevice notifier if register_qdisc() fails
      net: xps: bound the cleanup loop by the old map's num_tc
      net-sysfs: reject a one-entry RPS flow table

Eric Dumazet (9):
      net: fix frag_list leak in skb_segment_list() error path
      net: harden qdisc_pkt_len_segs_init() against malicious GSO packets
      ipmr: clear skb->cb[] in reg_vif_xmit()
      ixgbe: reserve TX timestamp after skb preparation
      ppp: linearize and segment bridged packets when required
      net: add eth_type_trans_careful()
      loopback: use eth_type_trans_careful()
      net: use eth_type_trans_careful() in __dev_forward_skb2()
      openvswitch: use eth_type_trans_careful() in internal_dev_recv()

Fang Xieyan (1):
      net: sched: em_ipt: validate hook value from netlink

Fernando Fernandez Mancera (1):
      devlink: region: fix snapshot id leak on kernel-allocated ids

Florian Fainelli (2):
      net: dsa: mv88e6xxx: fix 6351 family statistics snapshot
      net: dsa: mv88e6xxx: fix 88E6171 statistics type

Gal Pressman (1):
      net/mlx5e: IPsec, Fix out-of-bounds comparison of neighbour keys

Greg Thelen (1):
      selftests/net: tcp_mmap: remove unused -k option and keepflag

Hangbin Liu (1):
      selftests: gro: remove unused variable total_data

Hannes Laimer (2):
      vxlan: keep reserved_bits across changelink
      selftests: forwarding: vxlan_reserved: add gbp changelink test

Hanson Wang (1):
      net: usb: aqc111: fix set_mac_address return value

Henry Martin (1):
      netlink: fix out-of-bounds bitmap access clearing stale mc groups

Ido Schimmel (2):
      ipmr: fully initialize the synthetic IP header in ipmr_get_route()
      ipmr, ip6mr: validate packets injected into the register vif on xmit

Jacob Keller (2):
      ice: use reference counting and SRCU for PTP port access
      ice: set in_use only after preparing Tx timestamp index

Jakub Kicinski (21):
      Merge branch 'net-pse-pd-si3474-two-driver-fixes'
      Merge branch 'net-rds-scope-aware-sendmsg-connection-cache'
      Merge branch 'net-usb-pegasus-fix-receive-length-handling'
      Merge branch 'net-sched-act_api-keep-the-offload-flags-of-shared-actions'
      Merge branch 'ipmr-ip6mr-fix-several-info-leaks'
      Merge branch 'net-usb-cdc_ncm-cdc_mbim-fix-netpoll-lockup-in-tx_fixup'
      Merge branch 'net-dsa-mv88e6xxx-88e6171-stats-fixes'
      Merge branch 'revert-advertising-the-tcp-mss-from-the-configured-mtu'
      Merge branch 'net-bcmgenet-fixes-for-a-failed-resume-and-the-ring-rebuild'
      Merge branch 'tls-honor-o_nonblock-in-tls_sw_splice_read'
      Merge branch 'net-pcs-xpcs-fix-runtime-pm-and-clock-lifecycle'
      Merge branch 'bnge-fixes'
      Merge branch 'ice-e82x-reduced-timestamp-processing-logic-fixes'
      eth: bnxt: recycle agg buffers when Rx head buffer allocation fails
      eth: bnxt: resize Rx head buffers when rx-copybreak changes
      eth: bnxt: don't leak buffers when XDP agg buffer allocation fails
      eth: bnxt: free XDP frags when xdp_do_redirect() fails
      eth: bnxt: hand XDP frags over to the copybreak skb
      Merge branch 'eth-bnxt-fix-rx-buffer-leaks-under-oom'
      Merge branch 'net-fix-eth_type_trans-crashes-on-skbs-coming-from-the-stack'
      Merge branch 'netlink-fix-a-dump-livelock-with-a-notification-queued'

Jamal Hadi Salim (2):
      net/sched: sch_teql: fix slaves_lock IRQ deadlock
      net/sched: act_ife: do not consume the inner header on egress

James Clark (1):
      net: ethernet: ti: am65-cpts: fix support for PTP_EXTTS_REQUEST2 ioctl

James Lee (1):
      net: mctp: usblib: Fix broken assertion

Jamie Nguyen (1):
      selftests: net: txtimestamp: fix out-of-bounds read in raw UDP checksum

Jhonata Poma-Hansen (2):
      netlink: check sk_rcvbuf before charging the dump skb
      selftests: net: netlink-dumps: start a dump with a notification queued

Jiayuan Chen (2):
      tls: fix the open record check in the max payload size setsockopt
      bonding: fix out-of-bounds read of arp_ip_target

Jin Li (1):
      selftests: net: forwarding: bridge_vlan_mcast: Allow default startup query interval to vary by HZ

Joas Antonio dos Santos (2):
      net: dcb: initialize PFC value before calling getpfccfg
      net: mctp: free reassembly head skb when key_add fails on SOM

Jérémy Jean (1):
      inet: frags: prevent acceptance of partially authenticated reassembly

Kaho Jiang (1):
      net: ipv4: add zero check for snd_cwnd_clamp

Kaifeng Wang (1):
      tcp: reject devmem tx with fastopen and repair

Kamil Sawicki (1):
      net: limit priority VLAN untag depth

Karol Kolacinski (1):
      ice: E822: keep Tx timestamps disabled during offset calibration

Kiran Kumar K (1):
      octeontx2-af: fix inner LC ltype match for RSS flowkey

Kuniyuki Iwashima (1):
      ipv6: Protect multiple routes insertion by table lock.

Kyle Zeng (6):
      net: sched: prevent scheduling deactivated qdiscs
      net/packet: check TX_RING fragments before memory accounting
      gro: do not GRO GSO packets with inconsistent payload
      tcp: avoid double destroy in tcp_abort() of an unaccepted child
      tcp: fix reordering addition overflow in MTU probing
      tcp: initialize mapped children before route lookup

Linkui Xiao (1):
      net: bridge: netlink: do not clear the vlan info dump error

Linmao Li (1):
      r8152: Use BMSR to detect the link state

Naman Gulati (1):
      netdev-genl: ignore NETDEV_UNREGISTER rebroadcasts

Nandor Kracser (1):
      tls: avoid field-spanning write when copying crypto info

Nicolai Buchwitz (7):
      net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
      net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll
      net: bcmgenet: recover from a failed resume
      net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt
      octeontx2-pf: fix skb use-after-free on ipsec transmit drop
      octeontx2-pf: pass the skb to otx2_dma_unmap_skb_frags()
      octeontx2-pf: fix skb use-after-free with ipsec crypto offload

Noam D. Eliyahu (1):
      tg3: Invert restart quirk logic to restrict SNP power-down bypass

Paolo Abeni (5):
      gtp: hold RCU in gtp_genl_send_echo_req()
      Merge branch 'net-rds-fix-init-failures-leaving-built-in-transports-on-a-dead-core'
      Merge branch 'vxlan-keep-reserved_bits-on-changelink'
      Merge branch 'net-sched-sch_teql-fix-transmit-path-regressions'
      Merge branch 'octeontx2-pf-fix-ipsec-transmit-error-paths'

Paul Moses (1):
      xsk: restore UMEM flags after failed pool assignment

Peter Morrow (1):
      net/mlx4: always create the eth and ib auxiliary devices

Piotr Kubik (2):
      net: pse-pd: si3474: keep detection enabled on the other PIs
      net: pse-pd: si3474: validate the channels of a PI

Prashant Sengar (1):
      net: usb: lan78xx: avoid NULL PHY dereference in WoL setup

Qingfang Deng (2):
      pppoe: drop discovery frames with no MAC header
      pppoe: wait for RCU readers before reusing a socket

Rishikesh Jethwani (1):
      tls: keep TX and RX hardware offload on the same device

Rosen Penev (1):
      net: bgmac: fix TX DMA unmapping and slot cleanup

Sicong Huang (1):
      nfp: flower: fix use-after-free in neighbour update work

Tao Gong (1):
      net: dsa: mt7530: trap frames to conduit in MFC on EN7581 and AN7583

Tristan Madani (1):
      ppp: fix stale pointer access after pskb_may_pull in ppp_ccp_peek

Tung Nguyen (1):
      tipc: fix refcount panic in tipc_rcv() when receiving shared skb

Wei Jie Law (2):
      net: usb: pegasus: do not advance rx_skb->data on dropped frames
      net: usb: pegasus: check rx pkt_len against the received length

Xia Yan (1):
      macvlan: fix passthru promiscuity accounting while down

Xiao Liang (1):
      tun: drop batched packets while the device is down

Xingyuan Mo (1):
      sctp: reject forged cookie peer_addr with unknown address family

Yingjie Wang (1):
      tcp: limit tcp_tso_rtt_log to a valid shift count

Yongjian Wang (2):
      Revert "selftests: net: packetdrill: add tests for advertised MSS with PMTU exceptions"
      Revert "net: advertise TCP MSS from the configured MTU, not the learned PMTU"

Zhewei Yuan (1):
      tcp: Fix fastreuse cache initialization on first bind

Zhiling Zou (3):
      ipmr: only copy pktinfo to cache reports
      ipmr: drop packets with unknown ingress VIF
      tcp: check congestion control restriction first

Zizhen Liu (1):
      net: skbuff: propagate shared-frag marker in skb_zerocopy()

alex todadze (1):
      net: stmmac: fix rx checksum offload with extended descriptors

owen kwan (1):
      net/sched: sch_teql: fix use-after-free on lower qdisc drop

yanxia (1):
      veth: fix stale peer max_mtu on XDP program replacement

Ömer Mete Kaya (1):
      usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

 Documentation/netlink/specs/gtp.yaml               |   1 +
 Documentation/networking/ip-sysctl.rst             |   2 +
 Documentation/networking/tls-offload.rst           |  16 +-
 MAINTAINERS                                        |   2 +
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/dsa/motorcomm/chip.c                   |   4 +-
 drivers/net/dsa/mt7530.c                           |   7 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  10 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |   2 +-
 drivers/net/ethernet/broadcom/bgmac.c              |  51 +++---
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c     |   6 +-
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h     |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  58 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 102 ++++++++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   1 +
 drivers/net/ethernet/broadcom/tg3.c                |  48 ++----
 drivers/net/ethernet/google/gve/gve_flow_rule.c    |   1 +
 drivers/net/ethernet/hisilicon/hisi_femac.c        |   1 +
 drivers/net/ethernet/i825xx/82596.c                |  25 +--
 drivers/net/ethernet/intel/ice/ice_adapter.c       |  17 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h       |  17 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           | 174 +++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h           |  10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  40 +++--
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   8 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |   5 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   9 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  19 ++-
 drivers/net/ethernet/mellanox/mlx4/intf.c          |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   6 +
 .../mellanox/mlx5/core/en_accel/en_accel.h         |   6 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   3 +
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h         |  13 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |   2 +-
 drivers/net/ethernet/microchip/fdma/fdma_api.c     |  30 +++-
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |   8 +-
 .../net/ethernet/microchip/lan966x/lan966x_mac.c   |   4 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  19 ++-
 .../net/ethernet/microchip/lan966x/lan966x_ptp.c   |  10 +-
 .../net/ethernet/microchip/sparx5/sparx5_fdma.c    |   3 +-
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  15 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c  |   7 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h   |   2 +
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |  24 ++-
 drivers/net/ethernet/stmicro/stmmac/descs.h        |   6 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |  25 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  19 ++-
 drivers/net/ethernet/ti/am65-cpts.c                |   1 +
 drivers/net/gtp.c                                  |  47 ++++--
 drivers/net/loopback.c                             |   8 +-
 drivers/net/macvlan.c                              |   3 +-
 drivers/net/mctp/mctp-usblib-test.c                |   4 +-
 drivers/net/pcs/pcs-xpcs-plat.c                    |  62 ++++++--
 drivers/net/pcs/pcs-xpcs-rk.c                      |   2 +-
 drivers/net/ppp/ppp_generic.c                      |  96 +++++++++++-
 drivers/net/ppp/pppoe.c                            |   8 +
 drivers/net/pse-pd/si3474.c                        |  23 ++-
 drivers/net/tun.c                                  |  10 ++
 drivers/net/usb/aqc111.c                           |   8 +-
 drivers/net/usb/cdc_mbim.c                         |   5 +-
 drivers/net/usb/cdc_ncm.c                          |  13 +-
 drivers/net/usb/lan78xx.c                          |   9 ++
 drivers/net/usb/pegasus.c                          |  16 +-
 drivers/net/usb/r8152.c                            |  10 +-
 drivers/net/usb/usbnet.c                           |  24 ++-
 drivers/net/veth.c                                 |   5 +-
 drivers/net/vxlan/vxlan_core.c                     |   2 +-
 include/linux/etherdevice.h                        |  28 ++++
 include/linux/ppp_channel.h                        |   1 +
 include/net/inet_frag.h                            |   1 +
 include/net/ip.h                                   |  25 ---
 include/net/ip6_route.h                            |  37 -----
 include/net/xfrm.h                                 |  17 ++
 net/bridge/br_netlink.c                            |   2 +-
 net/core/dev.c                                     |  42 ++++-
 net/core/gro.c                                     |   5 +-
 net/core/net-sysfs.c                               |   7 +
 net/core/netdev-genl.c                             |   6 +
 net/core/skbuff.c                                  |  11 +-
 net/dcb/dcbnl.c                                    |   2 +
 net/devlink/region.c                               |   5 +
 net/ipv4/inet_connection_sock.c                    |   3 +-
 net/ipv4/inet_fragment.c                           |   5 +
 net/ipv4/ip_fragment.c                             |   3 +-
 net/ipv4/ipmr.c                                    |  27 +++-
 net/ipv4/metrics.c                                 |   5 +
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/sysctl_net_ipv4.c                         |   2 +
 net/ipv4/tcp.c                                     |  26 ++-
 net/ipv4/tcp_cong.c                                |   4 +-
 net/ipv4/tcp_ipv4.c                                |  10 +-
 net/ipv4/tcp_offload.c                             |  12 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv6/ip6_fib.c                                 |   4 -
 net/ipv6/ip6mr.c                                   |   5 +-
 net/ipv6/reassembly.c                              |   3 +-
 net/ipv6/route.c                                   |  19 ++-
 net/mctp/route.c                                   |  10 +-
 net/netlink/af_netlink.c                           |  12 +-
 net/openvswitch/vport-internal_dev.c               |   8 +-
 net/packet/af_packet.c                             |  12 +-
 net/rds/af_rds.c                                   |  29 +++-
 net/rds/bind.c                                     |   4 +-
 net/rds/ib_sysctl.c                                |   2 +-
 net/rds/rdma_transport.c                           |   3 +
 net/rds/rds.h                                      |   3 +
 net/rds/recv.c                                     |  11 +-
 net/rds/send.c                                     |   9 +-
 net/rds/sysctl.c                                   |   2 +-
 net/rds/tcp.c                                      |   5 +-
 net/sched/act_api.c                                |   3 +
 net/sched/act_ife.c                                |   4 +
 net/sched/em_ipt.c                                 |   3 +
 net/sched/sch_etf.c                                |   1 +
 net/sched/sch_generic.c                            |  14 +-
 net/sched/sch_gred.c                               |  16 +-
 net/sched/sch_taprio.c                             |   6 +-
 net/sched/sch_teql.c                               |  60 ++++---
 net/sctp/ipv6.c                                    |   6 +-
 net/sctp/sm_make_chunk.c                           |  24 +--
 net/sctp/sm_statefuns.c                            |   2 +-
 net/tipc/bearer.c                                  |   4 +
 net/tls/tls_device.c                               |  24 +++
 net/tls/tls_main.c                                 |  26 ++-
 net/tls/tls_sw.c                                   |   9 +-
 net/xdp/xsk_buff_pool.c                            |   2 +
 tools/testing/selftests/bpf/prog_tests/empty_skb.c |  19 ++-
 .../selftests/net/forwarding/bridge_vlan_mcast.sh  |   3 +-
 .../selftests/net/forwarding/vxlan_reserved.sh     |  15 ++
 tools/testing/selftests/net/lib/gro.c              |   2 -
 tools/testing/selftests/net/netlink-dumps.c        | 102 ++++++++++++
 .../net/packetdrill/tcp_advmss_pmtu_ipv4.pkt       |  67 --------
 .../net/packetdrill/tcp_advmss_pmtu_ipv6.pkt       |  67 --------
 tools/testing/selftests/net/tcp_mmap.c             |   6 +-
 tools/testing/selftests/net/tls.c                  |  31 ++++
 tools/testing/selftests/net/txtimestamp.c          |  23 +--
 .../tc-testing/tc-tests/filters/matchall.json      |  71 +++++++++
 142 files changed, 1596 insertions(+), 684 deletions(-)
 delete mode 100644 tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
 delete mode 100644 tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
