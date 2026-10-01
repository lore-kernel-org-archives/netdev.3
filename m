Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6828C009
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860397; cv=none; b=RU2CQiJoY1BP7jJZ5zX8F3AIuawQjAmO5Ct4M6l5qSsv9itjbLCehuSSQQLGYEL0g40Dl29sj991mdhpD3H4hE/QjB3HUQLvmF9MP+tTvnAJMdI9LUMaT7AHCerZCD38Ko+jBl1lI151fNv3ayJplD/olI1ynnYeZD9IrK8OGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860397; c=relaxed/simple;
	bh=l6PZ0EJfBfauKq10sqKgYTNawWRS3yi0MtxaDTxoQ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TIY7IO6Fxq/V+o2WVkeAEWLX4o3UrUMxOD3g2LXZAbXV0GqENPL+kjyrNpzBn9pJbvs8SaDcvN/sbdwsvO4Zh3UIhdaShTEYy/wQyxclxHnR5A02ttghkaXQQbZK1NtoR7aSpQ8h+6IsSNWo3jcctucivlmvsVDAuxUK82yhbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPamUyGz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPamUyGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790860394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YCr1nSro9nXfhD/8wA5q9Mpjbs1FTJrQllg8NIyvStU=;
	b=OPamUyGzHL1AeRSEQf1lRkWJYiRqAwTXaLQoiMqYQyBOy8vFB6e72FrFJ3Bd1yFVU3FlB7
	OivQ36lhfQ65aykSvC14ZRq3prccvipd//HVrXRtw3ahTTRBpgAbPbvYprzKYx15V3cjmX
	WeWgqYAF1DzYFAqno1ih2AqyT8INtdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-4EhTjCYwNQC-xCv0Uxuiig-1; Thu,
 01 Oct 2026 09:13:10 -0400
X-MC-Unique: 4EhTjCYwNQC-xCv0Uxuiig-1
X-Mimecast-MFC-AGG-ID: 4EhTjCYwNQC-xCv0Uxuiig_1790860389
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE99A180ACF4;
	Thu,  1 Oct 2026 13:13:08 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E12ED1800361;
	Thu,  1 Oct 2026 13:13:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.3-rc6
Date: Thu,  1 Oct 2026 15:12:35 +0200
Message-ID: <20261001131235.98504-1-pabeni@redhat.com>
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

The following changes since commit f2c53ea949c5048f96b3dbb5a5ee7131ce4ff2de:

  Merge tag 'net-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-09-24 11:45:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc6

for you to fetch changes up to e23a64eb244356ee47c0620f0722d51bd88db522:

  Merge tag 'nf-26-09-30' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2026-10-01 12:00:40 +0200)

----------------------------------------------------------------
Including fixes from Bluetooth, WiFi and netfilter.

We are actively retargeting several non-urgent fixes towards next, but
the traffic on the ML looks ever-increasing, and propagating the
push-back towards subsystems is not immediate.

No known outstanding regressions.

Current release - regressions:

  - netfilter: nft_set_rbtree: skip transaction elements during GC

Previous releases - regressions:

  - sched: cls_api: reclaim an empty proto on the error path

  - core:
    - fix checksum offsets in skb_splice_from_iter()
    - cap skb->queue_mapping when the tx queue is picked

  - page_pool: fix use-after-free in page_pool_recycle_ring_bulk()

  - wifi:
    - mac80211: fix slab-out-of-bounds read in ieee80211_monitor_select_queue()
    - mac80211: drop oversized fragments to avoid extra_len overflow

  - netfilter:
    - flowtable: restore ieee80211 forward path

  - bluetooth: hci_conn: Lock parent access during enhanced SCO setup

  - eth: bcmgenet: allocate RX buffers as page fragments

  - eth: stmmac: fix rx Scatter-Gather support

  - eth: octeontx2-pf: fix aura BPID assignment when CONFIG_DCB is enabled

  - eth: gve: DQO: accept TSO packets with non-protocol gso_type bits

  - eth: r8169: disable EEE on RTL8168h/8111h

Previous releases - always broken:

  - tcp: refresh TS.Recent for accepted old ACKs

  - wifi:
    - ath11k: reset ar->num_stations on hardware start
    - cfg80211: fix RTS threshold setting for single-radio PHY

  - bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()

  - eth: bcmgenet: fix NULL dereference in set_coalesce before first open

Misc:
  - Eric is retiring from google and updating his contact info

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aamir Ahmed (1):
      wifi: wfx: validate MIB read length before copying to caller

Alireza Asgari (2):
      net: fix checksum offsets in skb_splice_from_iter()
      selftests: net: cover UDP splice checksum fragment alignment

Andrea Mayer (1):
      seg6: ensure packet data is writable before modifying SRH and IPv6 DA

Anirudh Virdi (1):
      net/mlx5: Fix slab-out-of-bounds when handling team device events

Aohan Mei (1):
      netfilter: nft_flow_offload: drop flowtable reference on init error path

Baha Mesleh (1):
      octeontx2-af: mcs: Fix SC resource cleanup loop

Bartosz Golaszewski (1):
      net: phy: aquantia: fix system interface type not updated in forced mode

Binbin Deng (1):
      net/mctp: publish the mctp_dev only after it is initialised

Cen Zhang (Microsoft) (1):
      wifi: mac80211: fix slab-out-of-bounds read in ieee80211_monitor_select_queue()

Chandrashekar Devegowda (3):
      Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
      Bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
      Bluetooth: btintel_pcie: reject oversized TX packets in send_frame()

Chengfeng Ye (7):
      Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
      Bluetooth: hci_core: Serialize fragmented ISO packet queueing
      Bluetooth: hci_sync: Fix inquiry cache use-after-free
      Bluetooth: RFCOMM: Fix initial port reference race
      Bluetooth: Serialize SMP remote OOB data access
      Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
      Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown

Christian Melendez (1):
      MAINTAINERS: add missing entry for b53.rst

David S. Miller (1):
      Merge branch 'tcp-old-acks'

Eric Dumazet (3):
      MAINTAINERS: update Eric Dumazet's email address
      net: restrict SO_RESERVE_MEM to TCP sockets and cap max value
      ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()

Felix Fietkau (2):
      wifi: mac80211: prevent AP VLAN tx from other interfaces
      wifi: mac80211: set info->band for 802.3 encap offload frames

Fernando Fernandez Mancera (1):
      netfilter: bpf: reject invalid NAT manipulation types

Florian Fainelli (2):
      net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
      net: systemport: Fix RUNT MIB counter register offset calculation

Florian Westphal (1):
      netfilter: ipset: do not update comments from kernel-side adds

Geetha sowjanya (1):
      octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

Georgios Karantzas (1):
      wifi: ath9k_htc: bound TX aggregation to MAX_TX_BUF_SIZE

Guangshuo Li (1):
      wifi: iwlegacy: 3945: free EEPROM data on remove

Hannu Varjoranta (1):
      gve: DQO: accept TSO packets with non-protocol gso_type bits

Harshit Mogalapalli (1):
      net: microchip: vcap: stop scanning after deleting key field

Heyang Tan (1):
      wifi: p54: validate firmware record lengths

Ilkka Lappeteläinen (1):
      net/packet: prevent TX_RING byte count overflow

Jakub Kicinski (5):
      Merge branch 'net-systemport-collection-of-fixes'
      Merge tag 'for-net-2026-09-28' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'octeontx2-misc-fixes-for-rvu-drivers'
      Merge branch 'fix-udp-splice-checksum-alignment-across-fragments'
      Merge tag 'wireless-2026-09-30' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jamal Hadi Salim (4):
      net/sched: cls_api: reclaim an empty proto on the error path
      net/sched: fq_codel: match the no-drop threshold to the packet size
      net/sched: sch_codel: match the no-drop threshold to the packet size
      net: cap skb->queue_mapping when the tx queue is picked

Jari Seppälä (1):
      octeontx2-pf: Fix RSS indirection table size

Jeff Jo (2):
      tcp: refresh TS.Recent for accepted old ACKs
      selftests: net: check timestamp echo after an old ACK

Johannes Berg (1):
      Merge tag 'ath-current-20260921' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Julian Anastasov (3):
      ipvs: fix missing counter decrement in lblc
      ipvs: do not create invisible templates
      ipvs: filter some flags received in the backup server

Jun Yang (1):
      sctp: check RCV_SHUTDOWN after the sendmsg connect wait

Jérémy Jean (1):
      tipc: prevent GCM nonce reuse on peer key changes

Linmao Li (1):
      Bluetooth: hci_core: Fix inquiry cache timestamps on 64-bit systems

Lorenzo Bianconi (2):
      net: stmmac: fix rx Scatter-Gather support
      net: mvneta: clear XDP pfmemalloc flag between frames

Mina Almasry (1):
      net: page_pool: fix use-after-free in page_pool_recycle_ring_bulk()

Nguyen Ngoc Thang (1):
      Bluetooth: hci_sync: don't drain cmd_sync backlog on unregister

Nicolai Buchwitz (3):
      net: bcmgenet: allocate RX buffers as page fragments
      net: ethtool: let tsconfig reach a PHY-only timestamp provider
      net: bcmgenet: fix NULL dereference in set_coalesce before first open

Nicolas Escande (1):
      wifi: ath11k: reset ar->num_stations on hardware start

Oleksij Rempel (1):
      r8169: disable EEE on RTL8168h/8111h

Pablo Neira Ayuso (2):
      netfilter: flowtable: generalize pending status bit
      netfilter: flowtable: restore ieee80211 forward path

Paolo Abeni (1):
      Merge tag 'nf-26-09-30' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pengpeng Hou (1):
      wifi: ath9k: reject short WMI command responses

Prathamesh Deshpande (1):
      net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dereference

Qishuai Liu (1):
      ipv6: fix prefix route expiry in modify_prefix_route()

Quentin Freimanis (2):
      net: sparx5: skip ptp deinit if init was skipped
      net: sparx5: make ports inherit the switch base mac address type

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Rolling Wireless RN947R

Ruide Cao (1):
      wifi: mac80211: reject invalid 320 MHz CSA bandwidth

Sagar Taunk (1):
      rust: net: netlink: validate attribute length before casting to `c_int`

Sai Teja Aluvala (1):
      Bluetooth: btintel: validate DDC record lengths

Sandeep Haemoon (1):
      net: ethernet: mtk_eth_soc: allocate dummy netdev sooner

Sang-Hoon Choi (1):
      Bluetooth: hci_core: free the HCI ID if naming fails

Stanislaw Gruszka (1):
      wifi: cfg80211: fix RTS threshold setting for single-radio PHY

Tianchu Chen (1):
      wifi: cw1200: fix TX padding OOB read leaking heap data to device

Toke Høiland-Jørgensen (1):
      wifi: ath9k: Clean up device initialisation guards

Weiming Shi (1):
      netfilter: nft_set_rbtree: skip transaction elements during GC

Wentao Liang (1):
      wifi: wlcore: Fix runtime PM leak in wlcore_remove()

Willem de Bruijn (1):
      net: extend IPv6 exthdr detection of tunneled packets

Xuanqiang Luo (1):
      pfcp: fix socket lifetime on netdevice registration failure

Yongzhao Chen (1):
      net: phy: qcom: at803x: Fix IPQ5018 short-cable DAC values

Yoshihisa Yamamoto (1):
      net: pcs: rzn1-miic: Clear MIIC protection state before unprotect sequence

Yuchao Zhang (1):
      wifi: mac80211: drop oversized fragments to avoid extra_len overflow

Yuqi Xu (3):
      wifi: mac80211: minstrel_ht: validate fixed rate index
      wifi: mac80211: handle empty FILS association request payload
      wifi: mac80211: validate TX status rate metadata

Zhao Li (6):
      wifi: mac80211: release mesh path quota on failed additions
      wifi: mac80211: account proxy paths against the mesh path limit
      wifi: mac80211: drain PS delivery work during station teardown
      wifi: mac80211: shut down RX BA session timer on teardown
      wifi: mac80211: keep fallback association elements alive
      wifi: cfg80211: preserve hidden-group beacon IE ownership

Zhiling Zou (3):
      wifi: mac80211: count only matching reservations in reserved switch
      wifi: mac80211: keep paired old chanctx alive
      ipvs: bound LBLCR and LBLC cache growth

Zihan Xi (2):
      wifi: mac80211: fix mesh fast xmit path deletion UAF
      net: gso: limit recursive IP-in-IP segmentation

 .mailmap                                           |   2 +
 MAINTAINERS                                        |   9 +-
 drivers/bluetooth/btintel.c                        |  15 +-
 drivers/bluetooth/btintel_pcie.c                   |  12 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   8 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  34 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   2 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  14 +-
 drivers/net/ethernet/marvell/mvneta.c              |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c |  11 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  18 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   9 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  38 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  10 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |   1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   3 +
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   6 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  83 +++--
 drivers/net/pcs/pcs-rzn1-miic.c                    |   3 +
 drivers/net/pfcp.c                                 |   3 +
 drivers/net/phy/aquantia/aquantia_main.c           |   5 +-
 drivers/net/phy/qcom/at803x.c                      |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/wireless/ath/ath11k/mac.c              |   1 +
 drivers/net/wireless/ath/ath9k/hif_usb.c           |  19 +-
 drivers/net/wireless/ath/ath9k/htc.h               |   1 -
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |   7 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   8 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |  28 +-
 drivers/net/wireless/ath/ath9k/wmi.h               |   1 +
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |   1 +
 drivers/net/wireless/intersil/p54/fwio.c           |  42 ++-
 drivers/net/wireless/silabs/wfx/hif_tx.c           |   4 +-
 drivers/net/wireless/st/cw1200/bh.c                |   8 +-
 drivers/net/wireless/st/cw1200/txrx.c              |  14 +
 drivers/net/wireless/ti/wlcore/main.c              |   4 +-
 include/linux/netdevice.h                          |   3 +
 include/linux/netfilter_netdev.h                   |   2 +-
 include/linux/rtnetlink.h                          |   7 +-
 include/linux/skbuff.h                             |   2 +-
 include/net/bluetooth/hci_core.h                   |   5 +-
 include/net/gso.h                                  |   8 +
 include/net/netfilter/nf_flow_table.h              |   2 +-
 include/net/sch_generic.h                          |   9 +
 include/net/xdp.h                                  |   5 +
 net/bluetooth/hci_conn.c                           |  18 +-
 net/bluetooth/hci_core.c                           |  54 ++-
 net/bluetooth/hci_debugfs.c                        |   2 +-
 net/bluetooth/hci_sync.c                           |  19 +-
 net/bluetooth/rfcomm/tty.c                         |   7 +-
 net/bluetooth/smp.c                                |   2 +
 net/core/dev.c                                     |  80 +++--
 net/core/dev_ioctl.c                               |   3 +-
 net/core/gso.c                                     |   1 +
 net/core/page_pool.c                               |   2 +-
 net/core/skbuff.c                                  |   8 +-
 net/core/sock.c                                    |   4 +-
 net/ethtool/tsconfig.c                             |  24 +-
 net/ipv4/af_inet.c                                 |   3 +
 net/ipv4/tcp_input.c                               |   6 +
 net/ipv6/addrconf.c                                |   2 +-
 net/ipv6/ip6_offload.c                             |   4 +
 net/ipv6/seg6_iptunnel.c                           |   2 +-
 net/ipv6/seg6_local.c                              | 140 ++++++--
 net/mac80211/agg-rx.c                              |   2 +-
 net/mac80211/chan.c                                |  50 ++-
 net/mac80211/drop.h                                |   1 +
 net/mac80211/fils_aead.c                           |   8 +
 net/mac80211/ieee80211_i.h                         |   2 +-
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/mesh_pathtbl.c                        |  30 +-
 net/mac80211/mlme.c                                |   4 +-
 net/mac80211/rc80211_minstrel_ht.c                 |  89 ++++-
 net/mac80211/rx.c                                  |   6 +
 net/mac80211/spectmgmt.c                           |   4 +-
 net/mac80211/sta_info.c                            |   6 +-
 net/mac80211/status.c                              |  70 ++++
 net/mac80211/tx.c                                  |  45 ++-
 net/mctp/device.c                                  |   6 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |   2 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |   3 +
 net/netfilter/ipvs/ip_vs_lblc.c                    |   4 +
 net/netfilter/ipvs/ip_vs_lblcr.c                   |   3 +
 net/netfilter/ipvs/ip_vs_sync.c                    |  33 +-
 net/netfilter/nf_flow_table_core.c                 |   7 +-
 net/netfilter/nf_flow_table_offload.c              |  14 +-
 net/netfilter/nf_flow_table_path.c                 |   3 +
 net/netfilter/nf_nat_bpf.c                         |   3 +
 net/netfilter/nf_nat_core.c                        |   5 +-
 net/netfilter/nft_flow_offload.c                   |   7 +-
 net/netfilter/nft_set_rbtree.c                     |   2 +
 net/packet/af_packet.c                             |   3 +
 net/sched/act_ct.c                                 |   2 +-
 net/sched/act_skbedit.c                            |   5 +-
 net/sched/cls_api.c                                |  15 +-
 net/sched/sch_codel.c                              |   2 +-
 net/sched/sch_fq_codel.c                           |   4 +-
 net/sctp/socket.c                                  |   2 +-
 net/tipc/crypto.c                                  |  20 +-
 net/wireless/nl80211.c                             |  11 +-
 net/wireless/scan.c                                |  22 +-
 rust/kernel/net/netlink.rs                         |   9 +
 tools/testing/selftests/net/.gitignore             |   1 +
 tools/testing/selftests/net/Makefile               |   1 +
 .../selftests/net/packetdrill/tcp_old_ack_ts.pkt   |  22 ++
 tools/testing/selftests/net/udp_splice_checksum.c  | 378 +++++++++++++++++++++
 111 files changed, 1442 insertions(+), 345 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_old_ack_ts.pkt
 create mode 100644 tools/testing/selftests/net/udp_splice_checksum.c

