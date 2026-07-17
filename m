Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBC3F9A0B
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294793; cv=none; b=E4JaeXiTQOUoHcD4KLLGB0Xd9mjBtw15hKdbrLEN6tkbDQIa7n0ZXLZfAZo+EpopkghdgOmNhZP7z0msluQAfDeLMLAdqRsbG4qAm8AHskZ2oAzgtEvAR19//oVva2JPLWWGymCix7UreczKPTaB5CFbSEqX6YBZopoq04zwXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294793; c=relaxed/simple;
	bh=EGWGcgihx/pXimS/Bo4ACmj6Bt3vwTKhq8EazLBF5kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8wsLgC2FQdVZvo3laMWMli2jNS/ST8CIY70rYb243z3hO9MvkAIADF97L1+mcfHutofDUuZ9C75LqJoeh7muLWKfNz71dg55UbV44a6GTBThrtZN5SC8tAreTSN5RKcfvKMNqVb/nDswaAaknhmyt+zCukI+GsmLfSylR4jt/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duIYTqAr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duIYTqAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784294790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N9f23Blzla2y0WaPV7pjZ+UAWH+PaZwhP50jeMLNB7A=;
	b=duIYTqAr+oyajsTpsoKP418v6OhUzfYQB2OwD2A+zID3vOQ2JVHULV9NMNcl4KsFArndLN
	EwvpSvrrrq5hlU/dFu9zfbD97Lf+oA7xLmudFqJKxh5G/zcST3Ji2Q8hronmY9WnuxwgQA
	vUlg4wXp7XtHB7JDhfAuByIDbhPS8wY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-3xcOuW4zMAq2_SQQFjisQw-1; Fri,
 17 Jul 2026 09:26:24 -0400
X-MC-Unique: 3xcOuW4zMAq2_SQQFjisQw-1
X-Mimecast-MFC-AGG-ID: 3xcOuW4zMAq2_SQQFjisQw_1784294783
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32A811955EB5;
	Fri, 17 Jul 2026 13:26:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.163])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40416D72;
	Fri, 17 Jul 2026 13:26:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.2-rc4
Date: Fri, 17 Jul 2026 15:26:10 +0200
Message-ID: <20260717132610.363857-1-pabeni@redhat.com>
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

This is one day later than usual, due to concurrent conferences. For
the same reason it's also dominated by subsystem PRs. Still for the
same reason, the next week's PR is expected to be larger than usual.

The following changes since commit 2c7c88a412aa6d09cd04b414211b4ef8553b5309:

  Merge tag 'net-7.2-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-09 08:26:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.2-rc4

for you to fetch changes up to 56d96fededd61192cd7cc8d2b0f36adfd59036c3:

  mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n (2026-07-17 13:20:38 +0200)

----------------------------------------------------------------
Including fixes from Wireless, IPsec, Netfilter and Bluetooth.

Current release - new code bugs:

  - netfilter: flowtable: use correct direction to set up tunnel route

Previous releases - regressions:

  - wifi:
    - mac80211:
      - free AP_VLAN bc_buf SKBs outside IRQ lock
      - defer link RX stats percpu free to RCU
      - fix double free on alloc failure
    - cfg80211: convert pmsr_free_wk to wiphy_work to fix deadlock

  - ipv4: free fib_alias with kfree_rcu() on insert error path

  - sched: act_tunnel_key: Defer dst_release to RCU callback

  - xfrm: fix sk_dst_cache double-free in xfrm_user_policy()

  - bluetooth: fix locking in unpair_device/disconnect_sync

  - can: add locking for raw flags bitfield

  - openvswitch: reject oversized nested action attrs

  - eth: bnxt_en: handle partially initialized auxiliary devices

  - eth: ppp: defer channel free to an RCU grace period to fix UAF

Previous releases - always broken:

  -  netfilter: xt_nat: reject unsupported target families

  -  wifi:
     - brcmfmac: fix heap overflow on a short auth frame
     - cfg80211: add missing FTM API validation

  - xfrm:
    - reject optional IPTFS templates in outbound policies
    - policy: preallocate inexact bins before xfrm_hash_rebuild reinsert

  - bluetooth: revalidate LOAD_CONN_PARAM queued update

  - can: fix lockless bound/ifindex race and silent RX_SETUP failure

  - eth: mlx5: free mlx5_st_idx_data on final dealloc

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()

Alexander Hölzl (1):
      can: vxcan: Kconfig: fix description stating no local echo provided

Andre Carvalho (1):
      selftests: netconsole: only restore MAC when it changed on resume

Antony Antony (1):
      xfrm: reject optional IPTFS templates in outbound policies

Arnd Bergmann (1):
      wifi: mac80211: allocate backup ieee80211_nan_sched_cfg off stack

Asim Viladi Oglu Manizada (1):
      net: openvswitch: reject oversized nested action attrs

Bryam Vargas (2):
      wifi: mac80211_hwsim: clamp virtio RX length before skb_put
      net/iucv: take a reference on the socket found in afiucv_hs_rcv()

Cen Zhang (6):
      xfrm: cache the offload ifindex for netlink dumps
      xfrm: clear mode callbacks after failed mode setup
      wifi: cfg80211: cancel sched scan results work on unregister
      wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock
      wifi: cfg80211: use wiphy work for socket owner autodisconnect
      Bluetooth: MGMT: revalidate LOAD_CONN_PARAM queued update

Chen YanJun (1):
      xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()

Christophe JAILLET (1):
      wifi: cfg80211: Fix an error handling path in cfg80211_wext_siwscan()

Corentin Labbe (1):
      wifi: ralink: RT2X00: init EEPROM properly

Dawei Feng (2):
      wifi: libertas: fix memory leak in helper_firmware_cb()
      wifi: mac80211: fix memory leak in ieee80211_register_hw()

Eric Dumazet (1):
      tcp: fix TIME_WAIT socket reference leak on PSP policy failure

Fan Wu (1):
      can: esd_usb: kill anchored URBs before freeing netdevs

Florian Westphal (2):
      ipvs: reload ip header after head reallocation
      netfilter: xt_physdev: masks are not c-strings

HE WEI (ギカク) (1):
      wifi: cfg80211: bound element ID read when checking non-inheritance

Haofeng Li (1):
      wifi: cfg80211: validate EHT MLE before MLD ID read

Ivan Vecera (1):
      dpll: fix NULL pointer dereference in dpll_msg_add_pin_ref_sync()

Jamal Hadi Salim (1):
      net/sched: act_tunnel_key: Defer dst_release to RCU callback

James Raphael Tiovalen (1):
      macsec: fix promiscuity refcount leak in macsec_dev_open()

Julian Anastasov (1):
      ipvs: fix more places with wrong ipv6 transport offsets

Laxman Acharya Padhya (1):
      Bluetooth: btrtl: validate firmware patch bounds

Lee Jones (1):
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Maoyi Xie (3):
      wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
      wifi: mac80211: defer link RX stats percpu free to RCU
      wifi: brcmfmac: cyw: fix heap overflow on a short auth frame

Marc Kleine-Budde (2):
      Merge patch series "can: bcm: collected fixes"
      Merge patch series "net: can: isotp-fixes"

Mikhail Gavrilov (1):
      Bluetooth: mgmt: Translate HCI reason in Device Disconnected event

Norbert Szetei (1):
      ppp: defer channel free to an RCU grace period to fix pppol2tp RX UAF

Oliver Hartkopp (14):
      can: raw: add locking for raw flags bitfield
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal
      can: bcm: fix stale rx/tx ops after device removal
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
      can: bcm: track a single source interface for ANYDEV timeout/throttle ops
      can: isotp: use unconditional synchronize_rcu() in isotp_release()
      can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
      can: isotp: serialize TX state transitions under so->rx_lock

Pablo Neira Ayuso (1):
      netfilter: flowtable: use correct direction to set up tunnel route

Pagadala Yesu Anjaneyulu (1):
      wifi: mac80211: ibss: wait for in-flight TX on disconnect

Paolo Abeni (5):
      Merge tag 'wireless-2026-07-09' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'ipsec-2026-07-10' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'nf-26-07-10' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-net-2026-07-13' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'linux-can-fixes-for-7.2-20260716' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Pauli Virtanen (4):
      Bluetooth: hci_sync: extend conn_hash lookup critical sections
      Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
      Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
      Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: convert pmsr_free_wk to wiphy_work to fix deadlock

Pengpeng Hou (5):
      wifi: rsi: avoid reading TKIP MIC keys for non-TKIP ciphers
      wifi: libertas: reject short monitor TX frames
      wifi: rsi: bound background scan probe request copy
      wifi: libipw: fix key index receive bound checks
      wifi: rsi: validate beacon length before fixed buffer copy

Petr Wozniak (2):
      xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
      xfrm: fix stale skb->prev after async crypto steals a GSO segment

Qianyu Luo (1):
      xfrm: nat_keepalive: avoid double free on send error

Rafael Beims (2):
      wifi: mwifiex: fix roaming to different channel in host_mlme mode
      wifi: mwifiex: fix permanently busy scans after multiple roam iterations

Runyu Xiao (2):
      wifi: rt2x00: avoid full teardown before work setup in probe
      wifi: brcmfmac: initialize SDIO data work before cleanup

Ruoyu Wang (2):
      Bluetooth: hci_qca: Clear memdump state on invalid dump size
      bnxt_en: Handle partially initialized auxiliary devices

Shahar Tzarfati (1):
      wifi: mac80211: recalculate rx_nss on IBSS peer capability update

Shuhao Fu (1):
      can: j1939: fix lockless local-destination check

Stéphane Grosjean (1):
      can: peak: Modification of references to email accounts being deleted

Weiming Shi (3):
      ipv4: fib: free fib_alias with kfree_rcu() on insert error path
      sctp: validate STALE_COOKIE cause length before reading staleness
      mpls: fix NULL deref in mpls_valid_fib_dump_req() on CONFIG_INET=n

Wyatt Feng (1):
      netfilter: xt_nat: reject unsupported target families

Xiang Mei (4):
      wifi: mac80211: fix unsol_bcast_probe_resp double free on alloc failure
      wifi: mac80211: fix fils_discovery double free on alloc failure
      wifi: p54: validate RX frame length in p54_rx_eeprom_readback()
      Bluetooth: qca: fix NVM tag length underflow in TLV parser

Xiang Mei (Microsoft) (4):
      xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
      xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
      xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
      netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()

Xin Long (1):
      sctp: fix auth_hmacs array size in struct sctp_cookie

Xuanqiang Luo (1):
      llc: fix SAP refcount leak when creating incoming sockets

Yizhou Zhao (2):
      netfilter: ecache: fix inverted time_after() check
      netfilter: nf_conncount: fix zone comparison in tuple dedup

Yousef Alhouseen (1):
      wifi: mac80211_hwsim: avoid treating MCS as legacy rate index

Zhao Li (14):
      wifi: nl80211: free RNR data on MBSSID mismatch
      wifi: mac80211: validate extension-frame layout before RX
      wifi: cfg80211: derive S1G beacon TSF from S1G fields
      wifi: ieee80211: validate MLE common info length
      wifi: nl80211: validate nested MBSSID IE blobs
      wifi: nl80211: constrain MBSSID TX link ID range
      wifi: cfg80211: validate PMSR measurement type data
      wifi: cfg80211: validate PMSR FTM preamble range
      wifi: cfg80211: reject unsupported PMSR FTM location requests
      wifi: cfg80211: reject empty PMSR peer lists
      wifi: mac80211: avoid non-S1G AID fallback for S1G assoc
      wifi: mac80211: validate deauth frame length before reason access
      wifi: cfg80211: validate rx/tx MLME callback frame lengths before access
      wifi: cfg80211: validate assoc response length before status and IE access

Zhengyang Chen (1):
      selftests: netfilter: add bridge tunnel flowtable regression

Zhiling Zou (1):
      wifi: mac80211: free ack status frame on TX header build failure

Zhiping Zhang (1):
      net/mlx5: free mlx5_st_idx_data on final dealloc

 .mailmap                                           |   4 +-
 drivers/bluetooth/btqca.c                          |   2 +-
 drivers/bluetooth/btrtl.c                          |   5 +-
 drivers/bluetooth/hci_qca.c                        |   4 +
 drivers/dpll/dpll_netlink.c                        |   3 +
 drivers/net/can/Kconfig                            |   7 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |   2 +-
 drivers/net/can/peak_canfd/peak_canfd_user.h       |   2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |   4 +-
 drivers/net/can/sja1000/peak_pci.c                 |   4 +-
 drivers/net/can/sja1000/peak_pcmcia.c              |   4 +-
 drivers/net/can/usb/esd_usb.c                      |   5 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c            |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |   4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c         |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c        |   2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h        |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  39 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c   |   1 +
 drivers/net/macsec.c                               |   7 +-
 drivers/net/ppp/ppp_generic.c                      |  18 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |   6 +
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |   8 +-
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |   4 +-
 drivers/net/wireless/intersil/p54/txrx.c           |   8 +
 drivers/net/wireless/marvell/libertas/firmware.c   |   1 +
 drivers/net/wireless/marvell/libertas/tx.c         |   7 +
 drivers/net/wireless/marvell/libertas_tf/main.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   2 +-
 drivers/net/wireless/marvell/mwifiex/join.c        |   1 -
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |  12 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c       |   2 +-
 drivers/net/wireless/rsi/rsi_91x_hal.c             |   8 +
 drivers/net/wireless/rsi/rsi_91x_mgmt.c            |  12 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  16 +-
 include/linux/can/dev/peak_canfd.h                 |   2 +-
 include/linux/ieee80211-eht.h                      |  12 +-
 include/net/bluetooth/hci_core.h                   |   1 +
 include/net/cfg80211.h                             |   4 +-
 include/net/sctp/structs.h                         |   3 +-
 include/net/xfrm.h                                 |   2 +
 net/bluetooth/hci_event.c                          |  18 +-
 net/bluetooth/hci_sync.c                           |  66 ++-
 net/bluetooth/mgmt.c                               | 105 +++-
 net/can/bcm.c                                      | 646 ++++++++++++++++-----
 net/can/isotp.c                                    | 298 +++++++---
 net/can/j1939/transport.c                          |  18 +-
 net/can/raw.c                                      |  66 +--
 net/core/dev.c                                     |  10 +-
 net/ipv4/fib_trie.c                                |   2 +-
 net/ipv4/tcp_ipv4.c                                |   6 +-
 net/ipv6/netfilter.c                               |   4 +-
 net/ipv6/tcp_ipv6.c                                |   6 +-
 net/ipv6/xfrm6_policy.c                            |   1 +
 net/iucv/af_iucv.c                                 |   4 +
 net/llc/llc_conn.c                                 |   1 -
 net/mac80211/cfg.c                                 |  11 +-
 net/mac80211/ibss.c                                |  13 +-
 net/mac80211/iface.c                               |   8 +-
 net/mac80211/main.c                                |   3 +-
 net/mac80211/mlme.c                                |  12 +-
 net/mac80211/nan.c                                 |  35 +-
 net/mac80211/rx.c                                  |  34 +-
 net/mac80211/sta_info.c                            |  15 +-
 net/mac80211/tx.c                                  |  17 +-
 net/mac80211/util.c                                |   3 +
 net/mpls/af_mpls.c                                 |   3 +
 net/netfilter/ipvs/ip_vs_app.c                     |  10 +-
 net/netfilter/ipvs/ip_vs_core.c                    |   3 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |   6 +-
 net/netfilter/nf_conncount.c                       |   6 +-
 net/netfilter/nf_conntrack_ecache.c                |   2 +-
 net/netfilter/nf_flow_table_core.c                 |   6 +-
 net/netfilter/xt_nat.c                             |   9 +
 net/netfilter/xt_physdev.c                         |   5 -
 net/openvswitch/flow_netlink.c                     | 201 +++++--
 net/sched/act_tunnel_key.c                         |  14 +-
 net/sctp/sm_statefuns.c                            |  23 +-
 net/wireless/core.c                                |  14 +-
 net/wireless/core.h                                |   4 +-
 net/wireless/mlme.c                                | 101 +++-
 net/wireless/nl80211.c                             |  25 +-
 net/wireless/pmsr.c                                |  34 +-
 net/wireless/scan.c                                |  18 +-
 net/wireless/sme.c                                 |   6 +-
 net/xfrm/xfrm_device.c                             |  13 +-
 net/xfrm/xfrm_iptfs.c                              |   1 +
 net/xfrm/xfrm_nat_keepalive.c                      |  15 +-
 net/xfrm/xfrm_policy.c                             |   4 +-
 net/xfrm/xfrm_state.c                              |  12 +-
 net/xfrm/xfrm_user.c                               |  41 +-
 .../drivers/net/netconsole/netcons_resume.sh       |   3 +-
 .../selftests/net/netfilter/nft_flowtable.sh       |  55 ++
 98 files changed, 1681 insertions(+), 601 deletions(-)

