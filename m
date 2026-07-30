Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391933D4E2
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421595; cv=none; b=dEEsOj/Au7W1/1SeRM5QIsBXiI71tqOyKYWvBphIMz4Q745VpuRUmNPcPVIG1ynqldwnzp9z5YTLVq63RLJEwM9p5E8lpuHc1yNZqbfZRbWHao6nplubF+6mC7smfaIPYT4EfN3eGUhnvpxmA6xhuNK7aq3TBgw6JHeULTqgRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421595; c=relaxed/simple;
	bh=QprjggifuyqazlTHCCGYHw7/sWM4UrCLatR8jkKYchs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S98E0RrQyGVWyhsiorXFXD9C4wpJp+Zs64vP661FB+QUAs1BwjuwmmUXSZiz0emIm7F3RhkTGgthI7sDL5yOwgHLFGqHlaavbFo4VWxcDBeLWYNGyykbUY7Flsx/DQqIH4seaeO1XSMO+buBaeQnWzLzUSP/CZ2by5qwx0suu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKokisfv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKokisfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785421590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9ouGdchZ5fhdy0GzGKRzM7BuFHNuq9AUEd1xA9+g5Xg=;
	b=QKokisfvlnoNi+Eo5mqQCjfK3lG8igt09oryqrOONO9KF0I3msUyiAbi2vX/0Yu2QpsjJ3
	B3reoGO4sMw1DS2fut4oa5cILBPo4foskE//4ynfrGp4pcQ4OwdY/t3mMZCBIwEKF1YFkA
	X68lOfO7D0+iGTC8mSowOpwuDhpyETA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-vnQig-INP_28SZkoFJehDQ-1; Thu,
 30 Jul 2026 10:26:24 -0400
X-MC-Unique: vnQig-INP_28SZkoFJehDQ-1
X-Mimecast-MFC-AGG-ID: vnQig-INP_28SZkoFJehDQ_1785421583
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2680E18002A2;
	Thu, 30 Jul 2026 14:26:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.174])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A23B414;
	Thu, 30 Jul 2026 14:26:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.2-rc6
Date: Thu, 30 Jul 2026 16:25:57 +0200
Message-ID: <20260730142557.354953-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi Linus!

The following changes since commit d326f83e819c53aa05c40d64f5805d6237b6aa1b:

  Merge tag 'net-7.2-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-23 12:58:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc6

for you to fetch changes up to 451c9075d6c53f2438d110addbeeeea6fac18567:

  qede: sync udp_tunnel ports outside qede_lock in the recovery path (2026-07-30 15:16:38 +0200)

----------------------------------------------------------------
This is again larger than usual: the backlog accumulated in the past weeks
is not done yet. I'm not aware of any known pending regression.

Including fixes from netfilter, Bluetooth, WiFi and CAN.

Current release - regressions:

  - eth: tun/vhost: revert avoid ptr_ring tail-drop when a qdisc is present

  - bluetooth: remove unnecessary hci_conn_get in create_conn_sync

  - can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

Previous releases - regressions:

  - core: do not send ICMP/NDISC Redirects when peer allocation fails

  - ipv6: take nexthop lock for f6i_list walks in replace check and notify

  - wifi: fix an ath12k MLO regression impacting WCN7850/QCC2072.

  - netfilter: nf_tables: make nft_object rhltable per table

  - af_unix: fix listen() succeeding on sockets in the wrong state

  - openvswitch: fix potential UAF on meter attach failure

  - bluetooth:
    - fix advertising data UAFs
    - avoid deadlocks in iso_sock_timeout

  - smc: fix socket use-after-free during link group termination

  - dpll: use pin owner's dpll ref for pin-level attribute reporting

  - eth: veth: convert frag_list skbs before running XDP

  - eth: ice: wait for reset completion in ice_resume()

  - eth: igc: remove napi_synchronize() in igc_down()

  - eth: vxlan: use pskb_network_may_pull() for transmit path header pulls

Previous releases - always broken:

  - xsk: fix AF_XDP multi-buffer Tx descriptor reclaim

  - psp: fix NULL genl_sock deref race with concurrent netns teardown

  - netfilter: widen NAT rewrite delta to s32 in sip_help_tcp()

  - can: peak_usb: fix double free of transfer buffer on URB submit error

  - dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister

  - sctp: prevent peer transport count overflow

  - eth: idpf: bound interrupt-vector register fill to the allocated array

  - dsa: mt7530: error out on failed reads in MT7531 PHY polling

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aaron Ma (1):
      ice: wait for reset completion in ice_resume()

Abdun Nihaal (1):
      can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()

Aditya Garg (1):
      net: mana: Return error code from mana_create_rxq()

Aldo Ariel Panzardo (1):
      Bluetooth: SCO: give the socket its own sco_conn reference

Alvin Šipraga (1):
      MAINTAINERS: make Luiz a maintainer and myself reviewer for Realtek DSA

Asim Viladi Oglu Manizada (1):
      sctp: prevent peer transport count overflow

Aswin Karuvally (1):
      s390/qeth: Check CAP_NET_ADMIN for private ioctls

Avi Weiss (4):
      can: ctucanfd: unmap BAR0 using base address
      can: ctucanfd: mark error-active controller status valid
      can: ctucanfd: handle bus error interrupts
      can: ctucanfd: use self-test mode for PRESUME_ACK

Baochen Qiang (8):
      wifi: ath12k: fix out-of-bounds clear_bit in ath12k_mac_dp_peer_cleanup()
      wifi: ath12k: factor out peer assoc send-and-wait into a helper
      wifi: ath12k: keep ATH12K_PEER_ML_ID_VALID set in ath12k_sta::ml_peer_id
      wifi: ath12k: add support for HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP
      wifi: ath12k: introduce host_alloc_ml_id hardware parameter
      wifi: ath12k: do not advertise MLD peer ID for firmware-allocate devices
      wifi: ath12k: defer dp_peer registration when firmware allocates MLD peer ID
      wifi: ath12k: resolve PENDING ML peer ID from MLO_PEER_MAP HTT event

Cen Zhang (Microsoft) (1):
      net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds

Charles Vosburgh (1):
      sctp: validate Adaptation Indication parameter length

Chengfeng Ye (2):
      net: pktgen: fix proc entry use-after-free
      Bluetooth: hci_sync: Fix advertising data UAFs

Chenguang Zhao (4):
      forcedeth: fix UAF of txrx_stats in nv_remove
      net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller
      net: sxgbe: free TX rings on RX allocation failure
      net: sxgbe: check descriptor ring allocation failures

Christian Marangi (1):
      net: phylink: put link_gpio if phylink_create fails

Daniel Golle (3):
      net: dsa: mt7530: check bus->read() errors in the MDIO regmap backend
      net: dsa: mt7530: error out on failed reads in ATC/VTCR command polling
      net: dsa: mt7530: error out on failed reads in MT7531 PHY polling

David Carlier (1):
      igc: remove napi_synchronize() in igc_down()

David Corvaglia (1):
      net: bridge: mrp: fix Option TLV length in MRP_Test frames

David Lee (1):
      netfilter: ipset: do not update comments from kernel-side hash adds

Dawei Feng (2):
      ice: fix memory leak in ice_lbtest_prepare_rings()
      e1000: fix memory leak in e1000_probe()

Dawid Osuchowski (1):
      ice: fix VF interrupts cleanup

Deepanshu Kartikey (1):
      wifi: cfg80211: validate IEs in cfg80211_wext_siwgenie()

Denis V. Lunev (1):
      qede: sync udp_tunnel ports outside qede_lock in the recovery path

Eric Dumazet (7):
      net: do not send ICMP/NDISC Redirects when peer allocation fails
      vxlan: re-fetch eth header after route_shortcircuit()
      vxlan: unclone skb head before modifying eth header in route_shortcircuit()
      vxlan: use neigh_ha_snapshot() in route_shortcircuit()
      vxlan: use pskb_network_may_pull() in route_shortcircuit()
      vxlan: use pskb_network_may_pull() for transmit path header pulls
      net: udp_tunnel: fix memory leak in udp_tunnel_nic_unregister()

Eric Joyner (1):
      ethtool: Embed FEC hist ranges as buffer in struct

Greg Kroah-Hartman (3):
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
      Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
      Bluetooth: btusb: Fix short read errors in btusb_qca_send_vendor_req()

Guangshuo Li (1):
      can: etas_es58x: es58x_read_bulk_callback(): fix RX buffer leak on URB resubmit failure

Hariprasad Kelam (1):
      octeontx2-af: Block VFs from clobbering special CGX PKIND state

Hidayath Khan (1):
      dibs: fix use-after-free of dmb_node in loopback attach/detach/unregister

Ilya Maximets (3):
      net: openvswitch: fix skb leak on flow key update failure during recirculation
      net: openvswitch: fix skb leak on flow key update failure during ct
      net: openvswitch: fix potential UAF on meter attach failure

Ivan Vecera (1):
      dpll: use pin owner's dpll ref for pin-level attribute reporting

Jakub Kicinski (10):
      Merge branch 'xsk-fix-af_xdp-multi-buffer-tx-descriptor-reclaim'
      Merge tag 'nf-26-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'vxlan-fixes-for-skb-header-pulling-cloning-and-concurrency-in-tx-path'
      Merge tag 'for-net-2026-07-28' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'wireless-2026-07-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'revert-tun-tap-vhost-net-apply-qdisc-backpressure-on-full-ptr_ring-to-reduce-tx-drops'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-dsa-mt7530-fix-swallowed-mdio-read-errors'
      Merge branch 'net-openvswitch-fix-skb-leak-on-flow-key-update-failure'
      Merge branch 'net-dsa-realtek-use-devm_mutex_init'

James Gao (1):
      can: peak_usb: add bounds check for USB channel index

Jason Xing (2):
      xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
      xsk: drain continuation descs after overflow in xsk_build_skb()

Jiale Yao (2):
      Bluetooth: L2CAP: fix UAF in l2cap_le_connect_rsp
      Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame

Jiawen Wu (1):
      net: libwx: fix FDIR ATR queue mismatch for software VLAN packets

Johannes Berg (1):
      Merge tag 'ath-current-20260727' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

John Ericson (2):
      af_unix: fix listen() succeeding on sockets in the wrong state
      selftests/net/af_unix: test listen() rejects wrong socket states

Jonas Köppeler (1):
      net/sched: sch_cake: skip clearing unused tins during rate adjustment

Joshua Hay (1):
      idpf: adjust TxQ ring count minimum

Julian Anastasov (5):
      ipvs: adjust double hashing when fwd method changes
      ipvs: fix the checksum validations
      ipvs: fix places with wrong packet offsets
      ipvs: do not mangle ICMP replies for non-first fragments
      ipvs: clear the nfct flag under lock

Kiran Kella (1):
      psp: fix NULL genl_sock deref race with concurrent netns teardown

Lorenzo Bianconi (1):
      selftests: netfilter: nft_flowtable.sh: fix offload counter verification for tunnel tests

Lucas Martins Alves (1):
      can: c_can: c_can_chip_config(): keep controller in init mode until bittiming is configured

Luiz Angelo Daros de Luca (4):
      net: dsa: realtek: rtl8365mb: use devm_mutex_init for mib_lock
      net: dsa: realtek: use devm_mutex_init for regmap lock
      net: dsa: realtek: use devm_mutex_init for vlan_lock
      net: dsa: realtek: use devm_mutex_init for l2_lock

Maciej Fijalkowski (4):
      xsk: provide sufficient space in pool->tx_descs
      xsk: reclaim invalid Tx descriptors in ZC batch path
      selftests/xsk: fix too-many-frags multi-buffer Tx test
      selftests/xsk: account reclaimed invalid Tx descriptors

Maoyi Xie (1):
      can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error

Marc Kleine-Budde (2):
      Merge patch series "can: j1939: resend lost patches for buffer init and netdevice tracking"
      can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure

Matt Fleming (1):
      veth: convert frag_list skbs before running XDP

Matt Vollrath (1):
      igbvf: Fix leak in TX DMA error cleanup

Michael Bommarito (1):
      idpf: bound interrupt-vector register fill to the allocated array

Minhong He (1):
      can: isotp: check register_netdevice_notifier() error in module init

Nazim Amirul (1):
      net: stmmac: Fix E2E delay mechanism

Oleksij Rempel (1):
      can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer

Oliver Hartkopp (1):
      can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

Pablo Neira Ayuso (3):
      netfilter: nf_conntrack_expect: add and use nf_ct_expect_related_pair()
      netfilter: nf_tables: make nft_object rhltable per table
      netfilter: xt_hashlimit: validate hashtable supports XT_HASHLIMIT_RATE_MATCH

Paolo Abeni (1):
      Merge tag 'linux-can-fixes-for-7.2-20260729' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Pauli Virtanen (19):
      Bluetooth: ISO: clear iso_data always when detaching conn from hcon
      Bluetooth: ISO: fix CONNECTED -> CLOSED transition on shutdown/release
      Bluetooth: ISO: lock sk in iso_sock_getname
      Bluetooth: ISO: lock sk in iso_connect_ind
      Bluetooth: ISO: fix timeout vs sync_timeout typo in check_bcast_qos
      Bluetooth: ISO: validate sockaddr_iso first in iso_sock_rebind_bis()
      Bluetooth: ISO: hold sk properly in iso_conn_ready
      Bluetooth: ISO: fix leaking sk after socket release
      Bluetooth: ISO: avoid deadlocks in iso_sock_timeout
      Bluetooth: ISO: ensure no dangling hcon references in iso_conn
      Bluetooth: ISO: fix refcounting of iso_conn
      Bluetooth: ISO: fix race of kfree vs kref_get_unless_zero
      Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
      Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
      Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
      Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
      Bluetooth: hci_sync: hold conn in hci_past_sync() callback
      Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
      Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync

Pengpeng Hou (5):
      can: ctucanfd: add missing MODULE_DEVICE_TABLE()
      can: peak_usb: validate uCAN receive record lengths
      can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
      can: softing: fw_parse(): validate firmware record spans
      can: ems_usb: validate CPC message lengths

Przemyslaw Korba (1):
      ice: suppress DPLL errors during reset recovery

Sangho Lee (2):
      Bluetooth: HIDP: reject frames without a transaction header
      Bluetooth: HIDP: validate numbered report payloads

Shuangpeng Bai (1):
      ipv6: release fib6_null_entry on subtree failure

Simon Schippers (4):
      Revert "tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
      Revert "ptr_ring: move free-space check into separate helper"
      Revert "vhost-net: wake queue of tun/tap after ptr_ring consume"
      Revert "tun/tap: add ptr_ring consume helper with netdev queue wakeup"

Stanislaw Gruszka (1):
      wifi: iwlegacy: replace BUG_ON() with WARN_ON() on num_stations check

Suman Ghosh (1):
      octeontx2-pf: Set correct sequence for carrier off and tx queue stop

Tetsuo Handa (1):
      can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking

Tu Nguyen (1):
      can: rcar_canfd: change the initializing flow for clocks and resets

Wei Fang (1):
      ptp: netc: fix potential interrupt storm caused by incorrect unbind order

Wenjia Zhang (1):
      MAINTAINERS: Update SHARED MEMORY COMMUNICATIONS (SMC) maintainer entries

Xiang Mei (2):
      netfilter: nf_conntrack_sip: widen NAT rewrite delta to s32 in sip_help_tcp()
      rds: tcp: hold the RCU lock across ipv6_chk_addr() in rds_tcp_laddr_check()

Xiang Mei (Microsoft) (3):
      netfilter: nft_payload: fix mask build for partial field offload
      nexthop: take nh->lock for f6i_list walks in replace check and notify
      nexthop: avoid unlocked f6i_list walk in nh_rt_cache_flush

Xuanqiang Luo (3):
      fou: Fix use-after-free in fou_create()
      net/smc: fix socket use-after-free during link group termination
      bpf: lwt: Fix dst reference leak on reroute failure

Yehyeong Lee (1):
      net: mpls: initialize rtm_tos in mpls_getroute()

Yuho Choi (1):
      idpf: Fix mailbox IRQ name leak on request failure

Yun Lu (1):
      rtase: fix double free of multi-frag skb on DMA map failure

Yuxiang Yang (1):
      sctp: reject stale cookies with mismatched verification tags

Zhao Li (4):
      wifi: mac80211: fix tid_tx use-after-free on BA session stop
      wifi: mwifiex: use the subframe length when parsing A-MSDU TDLS frames
      wifi: cfg80211: publish PMSR request before starting the driver
      wifi: mac80211: validate individual TWT params before driver setup

Zhiling Zou (3):
      ipvs: do not propagate one-packet flag to synced conns
      net: ipv6: clear suppressed fib6 rule result
      net: bridge: stop fast-leave after deleting a port group

Zihan Xi (3):
      tipc: avoid use-after-free in poll trace queue dumps
      Bluetooth: mgmt: fix UAF in pair command cancellation
      Bluetooth: mgmt: fix pending command UAF in EIR updates

Zijun Hu (1):
      Bluetooth: btintel: Validate length before parsing diagnostics TLV

 .mailmap                                           |   1 +
 Documentation/networking/af_xdp.rst                |  54 ++--
 MAINTAINERS                                        |   6 +-
 drivers/bluetooth/btintel.c                        |   3 +
 drivers/bluetooth/btmtk.c                          |  86 +++---
 drivers/bluetooth/btusb.c                          |  30 +-
 drivers/dibs/dibs_loopback.c                       |  47 +--
 drivers/dpll/dpll_core.c                           |  27 ++
 drivers/dpll/dpll_core.h                           |   1 +
 drivers/dpll/dpll_netlink.c                        |  60 +++-
 drivers/net/can/c_can/c_can_main.c                 |   8 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |  14 +-
 drivers/net/can/ctucanfd/ctucanfd_pci.c            |   3 +-
 drivers/net/can/rcar/rcar_canfd.c                  |  32 +-
 drivers/net/can/softing/softing_fw.c               |  46 ++-
 drivers/net/can/usb/ems_usb.c                      |  43 +++
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   1 -
 drivers/net/can/usb/gs_usb.c                       |   4 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |   1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   |  13 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   1 -
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c         |  40 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c        |  20 +-
 drivers/net/dsa/mt7530-mdio.c                      |  11 +-
 drivers/net/dsa/mt7530.c                           |  86 +++---
 drivers/net/dsa/realtek/rtl8365mb_main.c           |  16 +-
 drivers/net/dsa/realtek/rtl83xx.c                  |  14 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  19 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  10 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  27 ++
 .../net/ethernet/intel/ice/ice_vf_lib_private.h    |   1 +
 drivers/net/ethernet/intel/ice/virt/queues.c       |  21 ++
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   5 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   5 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |   2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |   2 -
 drivers/net/ethernet/intel/igc/igc_main.c          |   3 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |  12 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |   1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  79 +++++
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  22 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  29 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   7 -
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  19 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   8 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |   4 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c       |  44 +--
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   3 +
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   2 +
 drivers/net/phy/phylink.c                          |  29 +-
 drivers/net/tun.c                                  | 109 +------
 drivers/net/veth.c                                 |   4 +-
 drivers/net/vxlan/vxlan_core.c                     |  21 +-
 drivers/net/vxlan/vxlan_mdb.c                      |   4 +-
 drivers/net/wireless/ath/ath12k/core.c             |   2 +
 drivers/net/wireless/ath/ath12k/core.h             |   3 +
 drivers/net/wireless/ath/ath12k/dp_htt.c           |  49 +++
 drivers/net/wireless/ath/ath12k/dp_htt.h           |  12 +
 drivers/net/wireless/ath/ath12k/dp_peer.c          |  75 ++++-
 drivers/net/wireless/ath/ath12k/dp_peer.h          |   2 +
 drivers/net/wireless/ath/ath12k/hw.h               |   2 +
 drivers/net/wireless/ath/ath12k/mac.c              | 165 +++++++----
 drivers/net/wireless/ath/ath12k/peer.c             |  31 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  12 +
 drivers/net/wireless/intel/iwlegacy/common.c       |   7 +-
 drivers/net/wireless/intel/iwlegacy/debug.c        |   2 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   2 +-
 drivers/ptp/ptp_netc.c                             |  15 +-
 drivers/s390/net/qeth_core_main.c                  |   3 +
 drivers/vhost/net.c                                |  21 +-
 include/linux/ethtool.h                            |   1 +
 include/linux/if_tun.h                             |   3 -
 include/linux/netfilter/nf_conntrack_sip.h         |   2 +-
 include/linux/ptr_ring.h                           |  20 +-
 include/net/bluetooth/hci_core.h                   |   4 +-
 include/net/ip_vs.h                                |  45 ++-
 include/net/netfilter/nf_conntrack_expect.h        |   3 +
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/net/xdp_sock.h                             |   1 +
 include/net/xsk_buff_pool.h                        |   9 +-
 net/bluetooth/hci_conn.c                           |  14 +-
 net/bluetooth/hci_sync.c                           | 216 ++++++++++----
 net/bluetooth/hidp/core.c                          |  30 +-
 net/bluetooth/iso.c                                | 273 ++++++++++++-----
 net/bluetooth/l2cap_core.c                         |   5 +
 net/bluetooth/mgmt.c                               |  84 ++++--
 net/bluetooth/rfcomm/core.c                        |   5 +
 net/bluetooth/sco.c                                |  22 +-
 net/bridge/br_mrp.c                                |   2 +-
 net/bridge/br_multicast.c                          |   1 +
 net/can/isotp.c                                    | 330 +++++++++++++++------
 net/can/j1939/bus.c                                |   2 +
 net/can/j1939/j1939-priv.h                         |   3 +
 net/can/j1939/main.c                               |   8 +-
 net/can/j1939/transport.c                          |   4 +-
 net/core/lwt_bpf.c                                 |   4 +-
 net/core/pktgen.c                                  |   4 +-
 net/core/skbuff.c                                  |  18 +-
 net/ipv4/fou_core.c                                |   2 +-
 net/ipv4/netfilter/nf_nat_h323.c                   |  22 +-
 net/ipv4/nexthop.c                                 |  25 +-
 net/ipv4/route.c                                   |   2 -
 net/ipv4/udp_tunnel_nic.c                          |  32 +-
 net/ipv6/fib6_rules.c                              |   1 +
 net/ipv6/ip6_fib.c                                 |   1 +
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/ndisc.c                                   |   2 +
 net/mac80211/agg-tx.c                              |   4 +-
 net/mac80211/s1g.c                                 |   4 +
 net/mpls/af_mpls.c                                 |   1 +
 net/netfilter/ipset/ip_set_hash_gen.h              |   2 +-
 net/netfilter/ipvs/ip_vs_app.c                     |   4 +-
 net/netfilter/ipvs/ip_vs_conn.c                    | 192 +++++++++---
 net/netfilter/ipvs/ip_vs_core.c                    | 190 ++++++------
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |  19 +-
 net/netfilter/ipvs/ip_vs_proto_tcp.c               |  48 +--
 net/netfilter/ipvs/ip_vs_proto_udp.c               |  54 +---
 net/netfilter/ipvs/ip_vs_xmit.c                    |  42 ++-
 net/netfilter/nf_conntrack_expect.c                |  35 ++-
 net/netfilter/nf_conntrack_sip.c                   |   2 +-
 net/netfilter/nf_nat_sip.c                         |  22 +-
 net/netfilter/nf_tables_api.c                      |  34 +--
 net/netfilter/nft_payload.c                        |  12 +-
 net/netfilter/xt_hashlimit.c                       |  16 +-
 net/openvswitch/actions.c                          |  12 +-
 net/openvswitch/meter.c                            |  33 ++-
 net/psp/psp_nl.c                                   |  17 +-
 net/rds/tcp.c                                      |   8 +-
 net/sched/cls_u32.c                                |   7 +
 net/sched/sch_cake.c                               |   8 +-
 net/sctp/associola.c                               |   3 +
 net/sctp/sm_make_chunk.c                           |  17 +-
 net/smc/smc_core.c                                 |   2 +-
 net/tipc/socket.c                                  |   2 +-
 net/unix/af_unix.c                                 |   1 +
 net/wireless/pmsr.c                                |  22 +-
 net/wireless/wext-sme.c                            |   9 +
 net/xdp/xsk.c                                      | 255 ++++++++++++++--
 net/xdp/xsk_buff_pool.c                            |  13 +-
 net/xdp/xsk_queue.h                                |  65 ++--
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  |  50 ++--
 tools/testing/selftests/net/af_unix/.gitignore     |   1 +
 tools/testing/selftests/net/af_unix/Makefile       |   1 +
 tools/testing/selftests/net/af_unix/unix_listen.c  | 187 ++++++++++++
 .../selftests/net/netfilter/nft_flowtable.sh       |  14 +-
 158 files changed, 2905 insertions(+), 1317 deletions(-)
 create mode 100644 tools/testing/selftests/net/af_unix/unix_listen.c

