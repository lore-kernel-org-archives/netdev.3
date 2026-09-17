Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E594516174
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661505; cv=none; b=K2tpZ5hHqDnysuGHz8vxSWWMUF8/fZKuGni7sOKrpKO49X8+FQIWd2VC8oB0DNrCfFyhmLjk1CaOSI3ImvA6II1BcqM8mWGaMKOPiSZWhEr0mvCxoYuEPIHAUROZmcuD0umAn9F8kJwWKOfDjH38gDq9uTBvmDbALYgULtOW1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661505; c=relaxed/simple;
	bh=MAgHPugn9Mlm7BgzvpvgPqx3rEl1axLfGpnTHt/jbiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I9+O/g0B7YCkxsgFV0jfFoEJhXDVnvm20IIPPDu5r5ice72nv562/RA1BughmL6Ifzw5Mz8VLYS/2y8/ghnxxVuTVd5GSI6X5R6xsmzOL0npl02k+7E3KD11ETLzcYAtZ7lVqY5fF0d4ehE4MjPLnmhQi+utup6BnWYFQLqdnfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdM+MhJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdM+MhJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789661500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AA6ytuyu8e9Ag5D0RaaEukKBqabr/aQPMXklGmI2Eik=;
	b=fdM+MhJKh/s/gecO3SHaCe1qcqg0n1BeWH3GQzmH7/Pts6W7EhfkMY/BifFgSfY3tB314I
	JQf54d0DHjJPOB3K9CCFhIYbZS8bkEO9vdkzyEmO/nNzLyd6vXCXCRK55aGyuy687P8Ge8
	YtTRRwLOxvDXKv60vt2mOtufBKo5ALk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-BQ5JQ_usOLmv8vGo4VuQGw-1; Thu,
 17 Sep 2026 12:11:36 -0400
X-MC-Unique: BQ5JQ_usOLmv8vGo4VuQGw-1
X-Mimecast-MFC-AGG-ID: BQ5JQ_usOLmv8vGo4VuQGw_1789661495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DD481802557;
	Thu, 17 Sep 2026 16:11:35 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3399B1800586;
	Thu, 17 Sep 2026 16:11:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.3-rc4
Date: Thu, 17 Sep 2026 18:11:23 +0200
Message-ID: <20260917161123.383876-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Linus!

The following changes since commit 78445023439506ebd83b86d40b1e428a3b309d4a:

  Merge tag 'net-7.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-09-10 14:07:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc4

for you to fetch changes up to 3b95a04eb5f95bf6a016a1bb9ff37d3eee48de63:

  Merge branch 'mptcp-misc-fixes-for-v7-3-rc4' (2026-09-17 08:14:39 -0700)

----------------------------------------------------------------
Including fixes from Netfilter, Bluetooth, IPSec and WiFi.

Previous releases - regressions:

  - netfilter: hold reference on ct until flow is released

  - bridge:
    - move switchdev call outside rcu
    - vlan: fix bugs caused by switchdev deletion errors

  - wifi:
    - mac80211: reset state when starting AP fails
    - cfg80211: don't free driver-owned scan requests

  - tcp: don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().

  - mptcp: return sk_wait_data() errors from recvmsg()

  - xfrm: serialize state GC with device state flush

  - drop_monitor: synchronize tracepoint unregistration on error path

  - bluetooth:
    - eir: validate service data length before reading UUID
    - hci_sync: serialize local codec list cleanup
    - RFCOMM: avoid socket lock inversion in listener cleanup

  - eth: lan743x: fix RX checksum use-after-free

  - eth: mvpp2: prevent buffer overflow in page_pool allocation

Previous releases - always broken:

  - core: lock the socket in sock_gettstamp()

  - neighbour: enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.

  - sched: codel: bound the dropping loop per dequeue call

  - wifi: mac80211: include TIM bitmap control for buffered S1G mcast traffic

  - psp: avoid conflicts with skb->decrypted and sk_validate_xmit_skb()

  - xfrm: fix stack OOB read in iptfs_skb_reset_frag_walk()

  - bluetooth: hci_qca: do not write to the serial port after it is closed

  - dsa: mxl862xx: disable the stats poll on teardown

  - eth: stmmac: fix TSO header length truncation

  - eth: ip_tunnel: initialize `options_len` before referencing options

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aamir Ahmed (1):
      Bluetooth: eir: validate service data length before reading UUID

Ahmed Naseef (1):
      net: phy: mediatek: do not report link and per-speed LED rules together

Aleksandr Nogikh (1):
      xfrm: add missing RCU read lock in xfrm_send_migrate_state()

Ali Ahmet Memis (1):
      wifi: wilc1000: fix out-of-bounds read in P2P public action frames

Andrea Mayer (1):
      seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP decapsulation

Aohan Mei (1):
      rds: ib: use rds_conn_drop() on protocol version mismatch

Bogdan Nicolae (1):
      wifi: brcmfmac: cyw: pass PMKID to firmware if present

Cen Zhang (Microsoft Security FORGE Labs) (1):
      xfrm: hold net_device reference under RCU in bundle creation

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: validate TX skb length in send_sync

Chengfeng Ye (2):
      xfrm: serialize state GC with device state flush
      Bluetooth: hci_sync: Serialize local codec list cleanup

Chris Lu (2):
      Bluetooth: btmtk: fix wrong status for short WMT FUNC_CTRL events
      Bluetooth: btmtksdio, btmtkuart: validate WMT event length before struct access

Chunfeng Song (1):
      rust: net: phy: fix off-by-one bit positions in device status accessors

Daehyeon Ko (1):
      wifi: libipw: reject TKIP frames without a full MIC

Daniel Golle (1):
      net: dsa: mxl862xx: disable the stats poll on teardown

Daniel Zahka (2):
      net: psp: avoid conflicts with skb->decrypted and sk_validate_xmit_skb()
      selftests: drv-net: psp: test PSP and TCP ULP mutual exclusion

Devin Wittmayer (1):
      wifi: mac80211: refuse to make a monitor active when it has no queue

Dmitriy Okunev (1):
      net: mvpp2: prevent buffer overflow in page_pool allocation

Dong Chenchen (1):
      ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup

Doruk Tan Ozturk (1):
      wifi: mwifiex: bound the pairwise-cipher OUI walk to the IE length

Eric Dumazet (10):
      xfrm: add missing rcu_read_lock(), skb_dst_force() and dev_hold() for xfrm_trans_reinject()
      tcp: do not let tcp_rmem be set below 4096
      pppoatm: ensure a writable skb header and linear data
      drop_monitor: synchronize tracepoint unregistration on error path
      drop_monitor: use timer_shutdown_sync() to prevent timer rearming during teardown
      drop_monitor: use raw_cpu_ptr() in tracepoint probes
      drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
      netlink: do not free nlk->groups while lockless readers can use it
      net: lock the socket in sock_gettstamp()
      net: skbuff: do not leave stale header offsets after pskb_carve()

Fan Wu (1):
      wifi: wcn36xx: Fix potential use-after-free in TX ack timer teardown

Farhad Alemi (1):
      net: remove WARN_ON_ONCE() from the dev_fill_forward_path() loop check

Fernando Fernandez Mancera (1):
      netfilter: nf_tables: fix device name and prefix match in hook lookup

Gris Ge (1):
      net: ip_tunnel: initialize `options_len` before referencing options

Guanglei Zhu (3):
      net: wwan: mhi_wwan_mbim: guard against a cyclic NDP chain
      net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value
      net: wwan: t7xx: validate the netif index in t7xx_ccmni_recv_skb()

Henry Martin (1):
      xfrm: iptfs: fix runt reassembly panic from short inner tot_len

Hohyun Sim (1):
      net: fddi: skfp: fix NULL deref when setting the MAC address while down

Ibrahim Abdelkader (1):
      Bluetooth: hci_qca: Do not write to the serial port after it is closed

Inbal Schussheim (2):
      tcp: exclude old ACKs from tcp fast path
      selftests: net: packetdrill: test exclusion of old ACK from TCP fast path

Ivan Pustogarov (1):
      wifi: mac80211: avoid out-of-bounds read for empty PREQ elements

Jakub Kicinski (13):
      Merge branch 'neighbour-small-fixes-for-rtm_-get-set-neightbl'
      Merge tag 'nf-26-09-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-net-2026-09-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'af_unix-fix-inconsistent-scc_index'
      Merge branch 'net-sched-fix-action-batch-deletion-cleanup'
      Merge branch 'net-drop_monitor-fix-concurrency-issues-preemption-warning-and-buffer-overrun'
      Merge tag 'ipsec-2026-09-16' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'wireless-2026-09-16' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      eth: fbnic: ring the doorbell if a burst ends in a drop
      Merge branch 'net-stmmac-restore-previous-state-if-tc_setup_dwmac510_mqprio-fails'
      Merge branch 'net-psp-avoid-conflicts-with-skb-decrypted-and-sk_validate_xmit_skb'
      dpll: reject a reference sync pin which is not on the pin's dpll
      Merge branch 'mptcp-misc-fixes-for-v7-3-rc4'

Jamal Hadi Salim (4):
      net/sched: hhf: cap hh_flows_limit at change time
      selftests/tc-testing: add hhf hh_limit cap tests
      net/sched: codel: bound the dropping loop per dequeue call
      selftests/tc-testing: add codel/fq_codel interval boundary cases

James Clark (1):
      net: macb: fix ordering around PTP timestamp read

Jiangshan Yi (2):
      wifi: libertas_tf: fix UAF in lbtf_free_adapter()
      wifi: brcmsmac: fix UAF in brcms_free_timer()

Johannes Berg (35):
      .get_maintainer.ignore: add myself
      wifi: cfg80211: don't get the radio mask for netdev-less wdevs
      wifi: cfg80211: check IP header size in cfg80211_classify8021d()
      wifi: cfg80211: don't free driver-owned scan requests
      wifi: cfg80211: only group hidden BSSes with beacon entries
      wifi: cfg80211: don't filter by BSS type when removing stale entries
      wifi: cfg80211: ibss: ref BSS entry for joined event
      wifi: cfg80211: fix NAN regulatory enforcement
      wifi: cfg80211: reduce RTNL holding in regulatory enforcement
      wifi: mac80211: don't apply peer rates to off-channel frames
      wifi: mac80211: don't drop scan probe requests for lack of peer rates
      wifi: mac80211: don't start a ROC while scanning
      wifi: mac80211: don't warn when an IBSS has no channel to scan
      wifi: mac80211: don't offload TC setup on AP_VLAN interfaces
      wifi: mac80211: suppress chanctx warning for debugfs reset
      wifi: mac80211: abort chanswitch when leaving a mesh
      wifi: mac80211: reset state when starting AP fails
      wifi: mac80211: reset the LED state when ifup fails
      wifi: mac80211: only operate on TDLS peers in the TDLS code
      wifi: cfg80211: restore netns_immutable on failures
      wifi: cfg80211: undo netns switch if renaming the wiphy fails
      wifi: mac80211: unlist vifs when their netdev is unregistered
      wifi: cfg80211: get the wiphy out of a dying network namespace
      wifi: mac80211_hwsim: don't hand frames to mac80211 while stopping
      wifi: mac80211: don't allow injecting frames wider than the chanctx
      wifi: mac80211: reset the AP_VLAN tailroom counter on ifdown
      wifi: mac80211: require a peer station for TDLS setup confirm
      wifi: mac80211: don't allow link changes when iface is down
      wifi: mac80211: don't RCU-dereference the mesh CSA settings we just set
      wifi: mac80211: don't access the TSF of a down interface
      wifi: mac80211: add HE 6 GHz capability in the scan elems len
      wifi: mac80211: mesh: reset the CSA state when leaving
      wifi: mac80211: mesh: release the channel if start fails
      wifi: mac80211: set up the TX info early to fix failure paths
      Merge tag 'ath-current-20260914' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Juan Perdomo (1):
      Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup

Karl Mehltretter (1):
      wifi: brcmfmac: fix lost 802.1x TX completion wakeup

Krzysztof Kozlowski (1):
      wifi: ath12k: ahb: Revert undocumented ABI and dead code

Kuniyuki Iwashima (7):
      neighbour: Add missing RCU annotation for neightbl_dump_info().
      neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
      neighbour: Don't render blackhole_netdev via RTM_GETNEIGHTBL.
      neighbour: Skip default parms when resumed in neightbl_dump_info().
      tcp: Don't call skb_clone_and_charge_r() for close()d listener in tcp_v6_do_rcv().
      af_unix: Unify scc_index when finalising SCC in __unix_walk_scc().
      selftest: af_unix: Add test case with mixed lowpoint in scm_rights.c.

Kyle Zeng (1):
      xfrm: fix compat ALLOCSPI request use-after-free

Lachlan Hodges (1):
      wifi: mac80211: include TIM bitmap control for buffered S1G mcast traffic

Laxman Acharya Padhya (1):
      Bluetooth: hci_codec: validate vendor codec count length

Linmao Li (1):
      wifi: mwifiex: prevent authentication frame length truncation

Linus Walleij (1):
      net: ethernet: cortina: Ack RX overrun interrupt correctly

Lorenzo Bianconi (4):
      net: stmmac: fix TSO header length truncation
      net: stmmac: do not overwrite phc_index when no PTP clock is registered
      net: stmmac: propagate FPE preemption-class mapping errors
      net: stmmac: preserve real_num_tx_queues on mqprio setup failure

Luiz Augusto von Dentz (2):
      Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
      Bluetooth: ISO: set BT_LISTEN before requesting a BIG sync

Maher Azzouzi (1):
      esp: downgrade zerocopy managed frags before mutating skb frags

Mariano Baragiola (1):
      wifi: virt_wifi: free skb when disconnected

Mark Amirkan (4):
      net: lan743x: fix RX checksum use-after-free
      net/packet: clear RX owner on VNET header error
      mptcp: return sk_wait_data() errors from recvmsg()
      net/packet: avoid truncating TPACKET_V3 private size

Nicolai Buchwitz (1):
      net: bcmgenet: restore the hardware filters on open

Nicolas Escande (1):
      wifi: ath11k: cleanup arsta in ath11k_mac_peer_cleanup_all()

Nicolas Thibert (1):
      Bluetooth: btusb: fix NXP IW610 composite device handling

Nikolay Aleksandrov (2):
      net: bridge: mst: move switchdev call outside rcu
      net: bridge: vlan: fix bugs caused by switchdev deletion errors

Pablo Neira Ayuso (2):
      netfilter: nf_nat: unregister and release hooks on error
      netfilter: flowtable: hold reference on ct until flow is released

Paolo Abeni (4):
      Merge branch 'tcp-exclude-old-acks-from-fast-path'
      mptcp: avoid unneeded actions on subflow reset
      mptcp: close race between scheduler and state change
      mptcp: fix bad accounting in __mptcp_subflow_push_pending()

Peng Hao (1):
      wifi: mwifiex: fix IRQ leak using wrong index in MSI-X error path

Pengpeng Hou (1):
      wifi: mwifiex: validate scan response extents

Radek Podgorny (2):
      Bluetooth: put the peer's on-air address on air when we cannot resolve
      Bluetooth: keep dst_type with dst when reusing an LE connection

Rik van Riel (1):
      wifi: mac80211: avoid WARN in set_bitrate_mask when sdata not in driver

Roshan Kumar (1):
      xfrm: iptfs: fix stack OOB read in iptfs_skb_reset_frag_walk()

Runyu Xiao (1):
      wifi: wlcore: release runtime PM ref on regdomain config failure

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: fix off-by-one bounds check in RX submit

Shengzhuo Wei (2):
      wifi: p54: validate curve data length in the calibration curve converters
      wifi: p54: require a full exp_if record in PDR_INTERFACE_LIST

Shmulik Cohen (3):
      wifi: libipw: reject too-short beacon and probe responses
      wifi: libipw: reject too-short association responses
      wifi: ipw2x00: bound management frame length to the receive buffer

Siwei Zhang (1):
      xfrm: use hlist_del_init_rcu for state_cache and state_cache_input

Slawomir Stepien (4):
      wifi: cfg80211: verify if AP_VLAN belongs to the correct AP
      wifi: cfg80211: do not support direct add of station to AP_VLAN interfaces
      wifi: cfg80211: move link_id validation earlier in nl80211_new_station()
      wifi: cfg80211: check if AP has been started or joined a mesh before adding new station

Stanislaw Gruszka (1):
      wifi: iwlegacy: fix broadcast stations deallocation

ThangNN99 (1):
      Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained

Theodor Arsenij Larionov Trichkine (1):
      netfilter: nft_nat: fully initialise new_addr in netmap setup

Tianchu Chen (2):
      wifi: rsi: fix heap OOB write on key removal
      wifi: wilc1000: fix RX buffer OOB-write in wilc_wlan_handle_isr_ext()

Tzung-Bi Shih (1):
      Bluetooth: btmtksdio: Fix PM runtime reference leak in shutdown

Weiming Shi (1):
      Bluetooth: coredump: Quiesce dump work on unregister

Wyatt Feng (1):
      net: xfrm: reject unrepresentable espintcp transport headers

Xuanqiang Luo (2):
      net/sched: act_api: release tail references on DELACTION failure
      selftests: tc-testing: test action batch deletion failure cleanup

Yige Jiang (1):
      net: netsec: fix device_node reference leak on phy_np

Zhao Li (1):
      wifi: mwifiex: validate action frame fixed fields

Zhiling Zou (3):
      ipv6: xfrm: use full sockets in local error paths
      xfrm: save input state data before secpath resets
      openvswitch: avoid reallocating confirmed conntrack labels

Zihan Xi (1):
      wifi: virt_wifi: don't transfer operstate before register

 .get_maintainer.ignore                             |   2 +
 Documentation/netlink/specs/rt-neigh.yaml          |   3 +
 Documentation/networking/ip-sysctl.rst             |   4 +-
 drivers/bluetooth/btintel_pcie.c                   |   8 +-
 drivers/bluetooth/btmtk.c                          |   7 +-
 drivers/bluetooth/btmtksdio.c                      |  24 +++-
 drivers/bluetooth/btmtkuart.c                      |  20 +++-
 drivers/bluetooth/btusb.c                          |  17 +++
 drivers/bluetooth/hci_qca.c                        |  14 ++-
 drivers/dpll/dpll_netlink.c                        |  17 ++-
 drivers/net/dsa/mxl862xx/mxl862xx.c                |  23 ++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  19 ++-
 drivers/net/ethernet/cadence/macb_ptp.c            |   9 ++
 drivers/net/ethernet/cortina/gemini.c              |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  42 +++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   9 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   2 +-
 drivers/net/ethernet/socionext/netsec.c            |   2 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  99 +++++++++++-----
 drivers/net/fddi/skfp/skfddi.c                     |   3 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c             |  27 +++--
 drivers/net/wireless/ath/ath11k/mac.c              |  25 ++--
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |  51 +-------
 drivers/net/wireless/ath/wcn36xx/dxe.c             |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   2 +
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |   5 +-
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |   4 +
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |   4 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   9 ++
 .../wireless/intel/ipw2x00/libipw_crypto_tkip.c    |  12 +-
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |   6 +
 drivers/net/wireless/intel/iwlegacy/common.c       |   2 +-
 drivers/net/wireless/intersil/p54/eeprom.c         |  22 +++-
 drivers/net/wireless/marvell/libertas_tf/main.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  12 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |   2 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |  54 ++++++---
 drivers/net/wireless/marvell/mwifiex/util.c        |  10 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  14 +++
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   9 ++
 drivers/net/wireless/rsi/rsi_91x_mgmt.c            |   2 -
 drivers/net/wireless/ti/wlcore/main.c              |   4 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  39 ++++---
 drivers/net/wireless/virtual/virt_wifi.c           |   4 +-
 drivers/net/wwan/mhi_wwan_mbim.c                   |  28 +++--
 drivers/net/wwan/t7xx/t7xx_netdev.c                |   4 +
 include/linux/ieee80211-mesh.h                     |   4 +-
 include/net/bluetooth/coredump.h                   |   2 +
 include/net/codel.h                                |   5 +
 include/net/codel_impl.h                           |  16 ++-
 include/net/mac80211.h                             |   5 +-
 include/net/sock.h                                 |   2 +
 net/atm/pppoatm.c                                  |  42 +++----
 net/bluetooth/coredump.c                           |  65 +++++++----
 net/bluetooth/eir.c                                |  10 +-
 net/bluetooth/hci_codec.c                          |  36 +++---
 net/bluetooth/hci_conn.c                           |  21 ++++
 net/bluetooth/hci_core.c                           |  18 ++-
 net/bluetooth/hci_sync.c                           |   2 +
 net/bluetooth/iso.c                                |  53 +++++++--
 net/bluetooth/rfcomm/sock.c                        |  13 ++-
 net/bridge/br_mst.c                                |  20 ++--
 net/bridge/br_vlan.c                               |  31 +++--
 net/core/dev.c                                     |   2 +-
 net/core/drop_monitor.c                            |  18 +--
 net/core/neighbour.c                               |  35 ++++--
 net/core/skbuff.c                                  |  32 ++++-
 net/core/sock.c                                    |  16 ++-
 net/ipv4/esp4.c                                    |   6 +
 net/ipv4/icmp.c                                    |  17 +--
 net/ipv4/ip_tunnel_core.c                          |  16 ++-
 net/ipv4/sysctl_net_ipv4.c                         |   4 +-
 net/ipv4/tcp_input.c                               |   3 +-
 net/ipv4/tcp_ulp.c                                 |   4 +
 net/ipv6/esp6.c                                    |   6 +
 net/ipv6/seg6_local.c                              |   3 +
 net/ipv6/tcp_ipv6.c                                |   3 +-
 net/ipv6/xfrm6_output.c                            |  10 +-
 net/mac80211/cfg.c                                 |  18 ++-
 net/mac80211/debugfs.c                             |   2 +-
 net/mac80211/debugfs_netdev.c                      |   9 ++
 net/mac80211/ieee80211_i.h                         |   2 +-
 net/mac80211/iface.c                               |  39 ++++++-
 net/mac80211/main.c                                |   4 +
 net/mac80211/mesh.c                                |  34 ++++--
 net/mac80211/offchannel.c                          |   7 ++
 net/mac80211/pm.c                                  |   8 +-
 net/mac80211/rate.c                                |   8 ++
 net/mac80211/scan.c                                |   2 +-
 net/mac80211/tdls.c                                |  40 ++++---
 net/mac80211/tx.c                                  | 115 +++++++++++-------
 net/mptcp/protocol.c                               |  13 ++-
 net/mptcp/protocol.h                               |   3 +-
 net/mptcp/subflow.c                                |  11 ++
 net/netfilter/nf_flow_table_core.c                 |  12 +-
 net/netfilter/nf_nat_core.c                        |  46 +++++---
 net/netfilter/nf_tables_api.c                      |  22 ++--
 net/netfilter/nft_nat.c                            |   2 +-
 net/netlink/af_netlink.c                           |  42 +++++--
 net/netlink/diag.c                                 |  20 +++-
 net/openvswitch/conntrack.c                        |   2 +-
 net/packet/af_packet.c                             |   4 +-
 net/packet/internal.h                              |   2 +-
 net/psp/psp_sock.c                                 |   4 +
 net/rds/ib_cm.c                                    |   2 +-
 net/sched/act_api.c                                |  11 +-
 net/sched/sch_hhf.c                                |   9 +-
 net/unix/garbage.c                                 |  17 +--
 net/wireless/core.c                                | 129 +++++++++++++--------
 net/wireless/core.h                                |  18 ++-
 net/wireless/ibss.c                                |  36 +++---
 net/wireless/nl80211.c                             |  64 ++++++----
 net/wireless/rdev-ops.h                            |   3 +
 net/wireless/reg.c                                 |  52 +++++++--
 net/wireless/reg.h                                 |  16 +++
 net/wireless/scan.c                                |  43 +++++--
 net/wireless/util.c                                |  38 ++++--
 net/xfrm/espintcp.c                                |   6 +-
 net/xfrm/xfrm_input.c                              |  22 +++-
 net/xfrm/xfrm_iptfs.c                              |  12 +-
 net/xfrm/xfrm_policy.c                             |  20 +++-
 net/xfrm/xfrm_state.c                              |   9 +-
 net/xfrm/xfrm_user.c                               |  18 +--
 rust/kernel/net/phy.rs                             |  38 +++---
 tools/testing/selftests/drivers/net/config         |   1 +
 tools/testing/selftests/drivers/net/psp.py         |  46 ++++++++
 tools/testing/selftests/net/af_unix/scm_rights.c   |  17 +++
 .../net/packetdrill/tcp_rfc5961_reject-old-ack.pkt |  29 +++++
 .../tc-testing/tc-tests/actions/batch-delete.json  | 115 ++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/codel.json          |  72 ++++++++++++
 .../tc-testing/tc-tests/qdiscs/fq_codel.json       |  72 ++++++++++++
 .../tc-tests/qdiscs/hhf_flows_limit.json           | 128 ++++++++++++++++++++
 136 files changed, 2059 insertions(+), 669 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_reject-old-ack.pkt
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/batch-delete.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf_flows_limit.json

