Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892819;
	b=u41IUGzugyUehma3rdGFbIlcU2P1cCksA7mnkHTvxr+yx91TSPT/CSLTykX9BPYScSzY
	 CGfcyAyBnqBrW4HapMT8cJLVSPZXE7G2QsZO/CkR4+mD/Q/u1B7wkODXTFwt4w6Zc3W59
	 4qdkazXRVyf/dtL+pfKpVG40jEgjJNxgOLHMM2Taxu3NJUekV8/zDfowAUWlvQKfT127L
	 BoLkaUluzjdqOVsdFrLIZ8o50Nmkp/kB3V8Zo/bbMDpyL65C7oGu2DPAuT1bellVhy/V2
	 FipM8KLMpiT/tXHAU2WNp56Hg12FlO95Xl1Pu1FQlGo00GNfYZqSEL5mv3Bsx3I4OuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892819;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=U/qs36Jp3pe8YexJ8rYcCBgAJ2fyiIJK01edAOYbdlY=;
	b=ccBgvMEXWVsgnQ5+Dq2QOF5s+OWJ63NAWo86kTZ9YIsTjEynlx+yNe9hrMmZaXbVqgiL
	 vOTNoZqnJXaLWrILE9gBQkdedsY02IqarUWvJxdP/o9xXni4xRY8mITiLXK1RAkp4gvtO
	 ngqlmUxv+gy8Tcnv+zITf88IcUHlypEwl0fnfvfH30/m5807cI4DDSkIsnNUhKNZH4CJB
	 YycSkSBRMurayB6hvPM64aSpleYF4VwOrr4EalQxjEuGxYuOYfjheiFTi3uaLd58C+NXF
	 /E4W1ftS62qsp76wVPidKkP7gy0fvpRYoamQJEoJva5Kb8uWBqnpSCd3BxFda4nfIAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qok6ryom;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C52606A33C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 15:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47C52606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qok6ryom
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793892817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U/qs36Jp3pe8YexJ8rYcCBgAJ2fyiIJK01edAOYbdlY=;
	b=Qok6ryomaLc5obKLOUL65zUseqMZg65tUeQFfJ0/REmJlvXH7c2TDwbUJdTlEcr1VqcAbS
	koeSL+IsZIuqGBR+Yltmm3hoijBS9g6JHK2g4bLNRzccbV/xxTFCaYTIjjoqBIqjPF5e6m
	2mJsg7TEgPtVkJPnckBivufAr86C44A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-BVFB7IJLPvWTWZknOx7f6w-1; Thu,
 05 Nov 2026 10:33:31 -0500
X-MC-Unique: BVFB7IJLPvWTWZknOx7f6w-1
X-Mimecast-MFC-AGG-ID: BVFB7IJLPvWTWZknOx7f6w_1793892810
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68AC91956055;
	Thu,  5 Nov 2026 15:33:30 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (unknown [10.44.48.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF7F5195608C;
	Thu,  5 Nov 2026 15:33:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.4-rc2
Date: Thu,  5 Nov 2026 16:33:15 +0100
Message-ID: <20261105153315.213214-1-pabeni@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Linus!

The following changes since commit 4dd16e31135ea8437a720222df34e8745f385d6d:

  Merge tag 'net-7.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-29 08:17:05 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.4-rc2

for you to fetch changes up to fafbc4051123d5459ea6950899cec08ed946e278:

  tcp: ipv6: free ireq->ipv6_opt after an RCU grace period (2026-11-05 15:07:23 +0100)

----------------------------------------------------------------
Including fixes from Bluetooth, IPsec, WiFi and CAN.

Current release - regressions:

  - eth: wwan: mhi_wwan_ctrl: send a DTR drop before it can be coalesced

Previous releases - regressions:

  - core:
    - use a dedicated flag to track disabled napi instances
    - frags: limit the truesize of a reassembly queue
    - reject a negative TCP header offset in qdisc_pkt_len_segs_init()y

  - tcp:
    - reject unhashed sockets during established lookups
    - free ireq->ipv6_opt after an RCU grace period

  - ipv6:
    - fix fib6 walker UAF on NLM_F_REPLACE
    - raw: fix use-after-free in rawv6_send_hdrinc()

  - wifi:
    - mac80211: reinstate IEEE80211_TX_CTL_AMPDU, fix ath9k stall
    - brcmfmac: map msgbuf RX packet IDs bidirectional, fix firmware
      crash loop

  - vsock: size receive SKBs from declared payload

  - xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()

  - bluetooth: hci_sync: copy the LE accept list under hdev->lock

  - ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked

  - can: protect the receive lists with a per-device lock

  - eth: bnxt: don't keep MSI-X vectors added before FW reserves them

  - eth: vxlan: stop rejecting dynamic FDB entries with a nexthop ID

Previous releases - always broken:

  - sched: sch_qfq: prevent aggregate self-replacement

  - bridge: disable MRP ports before the FDB flush in del_nbp()

  - mptcp: do not use fast open on MP_JOIN subflows

  - ipv6: serialize multicast router socket ownership

  - bluetooth: hci_core: keep link-key filtering inside RCU

  - eth: atl1c: drop oversized RX frames instead of panicking

  - eth: stmmac: a bunch of XDP path fixes

  - eth: b53: enable IGMP and MLD control packet CPU copies

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Akhil Arul (1):
      Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained

Alex Austin (3):
      sfc: ptp: drop the stale frequency reset in efx_ptp_start()
      sfc: ptp: serialize host and MC synchronization transactions
      sfc: ptp: avoid racing PPS timestamp updates

Alex Kazinsky (1):
      wifi: rsi: Skip TX aggregation setup for non-QoS frames

Alexander Goodkind (1):
      net: ethernet: mediatek: preserve sibling PPE bindings

Alexei Starovoitov (1):
      net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()

Andrea Mayer (1):
      seg6: fix transport header for inner IPv4 with IP options

Antony Antony (9):
      xfrm: state: reject mark with bits outside its mask on add
      xfrm: state: reject mark with bits outside its mask on ALLOCSPI
      xfrm: policy: reject mark with bits outside its mask on add
      xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
      xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
      xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
      xfrm: include mark in MIGRATE_STATE SA collision check
      xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
      docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple

Avi Weiss (1):
      net: skbuff: reject zero MPLS TTL before decrementing

Bart Van Assche (1):
      mctp i3c: Fix locking in an error path

Binbin Deng (3):
      Bluetooth: hci_core: Initialize IRK before publication
      Bluetooth: hci_core: Initialize link key before publication
      Bluetooth: hci_core: Initialize LTK before publication

Björn Töpel (1):
      eth: fbnic: Report the logical RX queue to XDP

Bryam Vargas (2):
      net/iucv: take a private, writable frame before rewriting it in place
      net/smc: don't spin in smc_rx_recvmsg() while a pipe holds spliced data

Catherine L (1):
      Bluetooth: btintel: fix buffer over-read in fw payload

Cen Zhang (7):
      Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
      Bluetooth: hci_sync: Protect resolving-list lookups
      Bluetooth: hci_core: Keep link-key filtering inside RCU
      Bluetooth: SMP: Protect link keys during LTK derivation
      Bluetooth: SMP: Protect LTK encryption with RCU
      Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
      Bluetooth: hci_core: Initialize advertising RPA work only once

Cen Zhang (Microsoft) (1):
      ipv6: fix fib6 walker UAF on NLM_F_REPLACE

Cheng Yongkang (1):
      net: bridge: disable MRP ports before the FDB flush in del_nbp()

Chengfeng Ye (2):
      xfrm: retry inexact policy lookup after node reinsertion
      batman-adv: Close OGM aggregation before transmission

Chris Lu (3):
      Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
      Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
      Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD

ChunYuZhiQiang (2):
      can: dev: can_fill_info(): don't wake up controller if interface is down
      can: dev: can_tdc_fill_info(): don't read automatic TDCV if interface is down

Colton Pawielski (1):
      net: 8139cp: keep Rx masked while NAPI is scheduled

Cosmin Ratiu (1):
      wifi: wext: Limit notifier event flushes to the device's netns

Cunhao Lu (3):
      can: skb: make echo skb freeing safe in any IRQ context
      can: skb: make CAN skb allocation failure paths IRQ-safe
      can: dev: can_put_echo_skb(): free skb on invalid echo index

Daehyeon Ko (1):
      vhost/vsock: size receive SKBs from declared payload

Daniel Machon (2):
      net: lan966x: don't free XDP buffers in fdma tx clear with budget 0
      net: sparx5/lan969x: release the in-flight slot of a stale TX skb

Deepanshu Kartikey (1):
      batman-adv: avoid WARN_ON for orig_ifinfo allocation failure

Eric Dumazet (7):
      tcp: do not let tcp_collapse() drive sk_forward_alloc negative
      inet: frags: limit the truesize of a reassembly queue
      soreuseport: annotate data-races around reuse->socks[] and num_socks
      xfrm: iptfs: fix skb leak on error in __input_process_payload()
      ipmr, ip6mr: queue netlink route queries out of band
      tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
      tcp: ipv6: free ireq->ipv6_opt after an RCU grace period

Federico Musto (1):
      net: atl1c: drop oversized RX frames instead of panicking

Fernando Fernandez Mancera (1):
      net/smc: fix limit_smc_hs sysctl on big-endian architecture

Florian Fainelli (3):
      net: dsa: b53: Enable IGMP and MLD control packet CPU copies
      net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
      net: dsa: b53: restore the NSP IMP port 2 Gbps mode

Fourie Zhang (1):
      xfrm4: use a full socket for local errors

Franck Baur (1):
      net: jme: keep RX MAC clock enabled for WoL

Guillaume Nault (1):
      tcp: Fix dup-ack detection on non-SACK bidirectional data transfer.

Hengyu Liang (1):
      l2tp: only return sessions of the given tunnel in l2tp_session_get()

Hyunwoo Kim (2):
      inet: reject unhashed sockets during established lookups
      net: restore refcount ordering for lockless socket access

Ido Schimmel (1):
      vxlan: Stop rejecting dynamic FDB entries with a nexthop ID

Ismail Tarim (1):
      Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()

Jakub Kicinski (4):
      Merge tag 'batadv-net-pullrequest-20261030' of https://git.open-mesh.org/batadv
      Merge branch 'net-ethernet-mtk_wed-misc-fixes'
      Merge branch 'ptp-make-virtual-clock-sampling-and-teardown-failure-safe'
      docs: netdev: try to force agents to disclose info for fixes

Jamal Hadi Salim (1):
      net/sched: clamp skb->queue_mapping before indexing the tx queue

James Clark (2):
      net: ethernet: ti: am65-cpts: adjust perout genf following ptp changes
      net: ethernet: ti: am65-cpsw-nuss: Enable timestamping of unicast PTP packets

James Hilliard (6):
      ptp: drain virtual clock sysfs operations before unregistering children
      ptp: unwind partially completed virtual clock creation
      ptp: vclock: propagate physical clock sampling errors
      ptp: vclock: serialize extended samples with counter updates
      ptp: vclock: preserve missing hardware timestamps
      net: stmmac: take ownership of saved RX state at poll entry

Jason Perlow (1):
      wifi: brcmfmac: map msgbuf RX packet IDs bidirectional

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Joas Antonio dos Santos (2):
      net/mlx5: macsec: free struct mlx5_fs_id after an RCU grace period
      tipc: raise the minimum bearer MTU to fit tunnel and crypto overhead

Joonhoe Kim (1):
      net: qrtr: announce local services again once our HELLO is sent

Joseph Kain (1):
      net: stop defer_count outliving the deferred-free list

Kaixuan Li (1):
      can: isotp: check the frame type, not just the length

Kevin Dewald (3):
      Bluetooth: hci_event: Clear explicit connect state on LE connection
      Bluetooth: MGMT: Clear disabled connection parameters when loading none
      Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery

Kuniyuki Iwashima (3):
      ipv6: Flush exception route while replacing nexthop.
      ipv6: Flush rt->from in rt6_uncached_list_flush_dev().
      ipv4: Call rt_add_uncached_list() if !do_cache in ip_route_input_slow().

Kyle Zeng (5):
      batman-adv: mcast: validate tracker padding before forwarding
      net/sched: sch_qfq: prevent aggregate self-replacement
      tcp: wait for TIME_WAIT teardown before freeing per-netns ehash
      ip6mr: Serialize multicast router socket ownership
      mptcp: pm: kernel: use RCU to free endpoint listeners

Liu Changjie (1):
      can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records

Lorenzo Bianconi (9):
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: copy XDP metadata in AF_XDP zero-copy RX
      net: stmmac: fix VLAN tag stripping on short and non-linear RX frames
      net: stmmac: fix XDP RX buffer DMA sync length
      net: stmmac: initialize est_lock at probe time
      net: stmmac: pass the desired EST enable state to est_configure()
      net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()
      net: stmmac: set XDP metadata length on the page_pool RX path

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
      Bluetooth: hci_core: Convert hci_conn flags to a bitmap
      Bluetooth: L2CAP: Hold incoming data until encryption key size is known
      Bluetooth: hci_sync: Update the CIS host feature when enabling LE

Marc Kleine-Budde (3):
      Merge patch series "can: skb: make echo skb freeing safe in any IRQ context"
      Merge patch series "can: protect the receive lists with a per-device lock"
      Merge patch series "can: dev: can_fill_info(): don't wake up controller if interface is down"

Masafumi Suzuki (1):
      sctp: account for chunk padding in sctp_init_cause()

Maxime Chevallier (1):
      net: Use a dedicated flag to track disabled napi instances

Michael McAllister (1):
      Bluetooth: qca: Fix the WCN3950 NVM baud rate offset

Nguyen Dinh Phi (1):
      vsock: reject negative tv_usec in SO_VM_SOCKETS_CONNECT_TIMEOUT

Nguyen Ngoc Thang (1):
      net: phy: don't require RTNL to detach a PHY from an unregistered netdev

Oliver Hartkopp (6):
      can: replace ARPHRD_CAN type checks with can_get_ml_priv()
      can: isotp: check the return values of can_rx_register() in isotp_bind()
      can: protect the receive lists with a per-device lock
      can: raw, isotp: copy socket options outside of lock_sock()
      can: proc: skip stats calculation after reset in can_stat_update()
      can: proc: remove pointers from CAN specific proc output

Paolo Abeni (10):
      Merge branch 'net-stmmac-xdp-path-fixes'
      Merge branch 'sfc-fix-ptp-synchronization-races'
      Merge branch 'net-stmmac-re-apply-taprio-offload-in-__stmmac_open-and-stmmac_resume'
      Merge tag 'for-net-2026-11-02' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'ipsec-2026-11-02' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'inet-fix-lockless-ehash-walk-races'
      Merge tag 'wireless-2026-11-02' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'ip-fix-route-leak-and-unregister_netdevice-stuck'
      Merge branch 'fix-tcp-retransmissions-on-ns-nsp-socs'
      Merge tag 'linux-can-fixes-for-7.4-20261103' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Peter Hunt (1):
      net: wwan: mhi_wwan_ctrl: send a DTR drop before it can be coalesced

Prasad Koya (1):
      macvlan: fix allmulti reference counting in passthru mode

Qihang (2):
      xfrm: interface: validate the IP header on xmit
      cipso: fix optlen corruption in cipso_v4_delopt()

Qingfang Deng (1):
      tcp: initialize send sequence numbers before deferring TFO

Ray Zhang (1):
      net: count last skb of each sk_backlog pass in __release_sock()

Runyu Xiao (1):
      can: proc: reset pkg_stats atomics individually

Sabrina Dubroca (1):
      xfrm: espintcp: reorder operations within espintcp_init_sk

Sahil Chandna (1):
      net: mana: Add support to process throttled EQEs

Shubham Antil (1):
      xfrm: zero-initialise km_event in the replay-notify path

Steffen Klassert (1):
      Merge branch 'xfrm: state: exact mark/mask match for control-plane SA lookups'

Sven Eckelmann (11):
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: clear ROAM flag when re-adding a pending local client
      batman-adv: tt: send ROAM_ADV on each roamed back client
      batman-adv: tt: ignore ROAM flag of received ADD changes
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't drop local events queued during TVLV update
      batman-adv: tt: limit local table to single TVLV response size

Thomas Fourier (1):
      net: ipa: Fix double free of the interrupt structure on config error

Timur Stukan (2):
      bonding: 3ad: don't set BOND_LINK_FAIL on a slave that is not up
      bonding: fix missing down path on speed/duplex failure after FAIL->UP

Tobias Wilken (1):
      Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller

Toke Høiland-Jørgensen (1):
      wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()

Tung Nguyen (1):
      tipc: reject attaching bearer of different media to the same occupied device

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Vincent Mailhol (1):
      can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

Vlad Poenaru (1):
      bnxt_en: Don't keep MSI-X vectors added before FW reserves them

Weigang He (1):
      wifi: mac80211: reload TDLS header pointer after skb_linearize()

Xia Yan (3):
      veth: keep carrier off when resizing channels with a down peer
      selftests: net: check veth carrier after changing channel counts
      ipv6: fix device binding after failed datagram connect

Yifan Zhang (2):
      Bluetooth: validate retained LE Create CIS command length
      Bluetooth: validate retained LE Set CIG Parameters command length

Yilin Zhang (1):
      mptcp: do not use Fast Open on MP_JOIN subflows

Yingjie Wang (1):
      ipv6: reject wrapped temporary address preferred lifetimes

Yu Zhang (1):
      ptp: fix use-after-free in extts_fifo_show() reading tsevqs unlocked

Zhi-Jun You (4):
      net: ethernet: mtk_wed: skip ring reset in wdma_tx_ring_setup for WED v3
      net: ethernet: mtk_wed: fix reset condition for rx wdma
      net: ethernet: mtk_wed: free up rings during detach
      net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986

Zhou Qiuyue (1):
      ipv6: raw: fix use-after-free in rawv6_send_hdrinc()

Zijing Yin (1):
      wifi: cfg80211: fix out-of-bounds read in valid_rule()

 Documentation/networking/can.rst                   |  16 +-
 .../networking/xfrm/xfrm_migrate_state.rst         |  25 +-
 Documentation/process/maintainer-netdev.rst        |   4 +
 drivers/bluetooth/btintel.c                        |  24 +-
 drivers/bluetooth/btmtk.c                          |  49 +++-
 drivers/bluetooth/btqca.c                          |   3 +-
 drivers/net/bonding/bond_main.c                    |  78 +++---
 drivers/net/can/dev/netlink.c                      |  21 +-
 drivers/net/can/dev/skb.c                          |  16 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c         |   7 +-
 drivers/net/dsa/b53/b53_common.c                   |  69 ++++-
 drivers/net/dsa/b53/b53_priv.h                     |   1 +
 drivers/net/dsa/b53/b53_regs.h                     |  17 ++
 drivers/net/dsa/bcm_sf2.c                          |   5 +
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |  33 +++
 drivers/net/ethernet/broadcom/bgmac-platform.c     |   3 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  34 ++-
 drivers/net/ethernet/jme.c                         |  37 ++-
 drivers/net/ethernet/jme.h                         |   1 +
 drivers/net/ethernet/mediatek/mtk_ppe.c            |   5 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |  27 +-
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c    |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |   2 +-
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |   6 +
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  10 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  88 ++++++-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   9 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  22 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |  19 +-
 drivers/net/ethernet/realtek/8139cp.c              |   8 +-
 drivers/net/ethernet/sfc/ptp.c                     | 108 +++++---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |   2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c   |  61 ++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h   |   8 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 217 +++++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  46 +---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  94 ++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   4 +-
 drivers/net/ethernet/ti/am65-cpts.c                |  67 +++--
 drivers/net/ipa/ipa_interrupt.c                    |  12 +-
 drivers/net/macvlan.c                              |  10 +
 drivers/net/mctp/mctp-i3c.c                        |   3 +-
 drivers/net/phy/phy_device.c                       |   8 +-
 drivers/net/veth.c                                 |   5 +-
 drivers/net/vxlan/vxlan_core.c                     |  14 +-
 .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  |   2 +-
 drivers/net/wireless/rsi/rsi_91x_core.c            |   2 +-
 drivers/net/wwan/mhi_wwan_ctrl.c                   |  11 +
 drivers/ptp/ptp_clock.c                            |   5 +
 drivers/ptp/ptp_private.h                          |   7 +-
 drivers/ptp/ptp_sysfs.c                            |  24 +-
 drivers/ptp/ptp_vclock.c                           | 123 ++++++---
 drivers/vhost/vsock.c                              |  34 ++-
 include/linux/can/can-ml.h                         |   3 +
 include/linux/can/core.h                           |   2 +-
 include/linux/can/dev.h                            |   2 +-
 include/linux/can/skb.h                            |   4 +-
 include/linux/mroute_base.h                        |   2 +
 include/linux/netdevice.h                          |   2 +
 include/linux/ptp_clock_kernel.h                   |   2 +-
 include/linux/tcp.h                                |   3 +
 include/net/bluetooth/hci_core.h                   | 104 ++++----
 include/net/espintcp.h                             |   5 +-
 include/net/inet_frag.h                            |   9 +
 include/net/iw_handler.h                           |   8 +-
 include/net/mana/gdma.h                            |  19 +-
 include/net/mana/mana.h                            |   1 +
 include/net/netns/can.h                            |   2 +-
 include/net/xfrm.h                                 |   7 +
 net/batman-adv/bat_iv_ogm.c                        |   7 +-
 net/batman-adv/distributed-arp-table.c             |   1 +
 net/batman-adv/main.c                              |  12 +-
 net/batman-adv/multicast_forw.c                    |   5 +-
 net/batman-adv/tp_meter.c                          |   2 +-
 net/batman-adv/translation-table.c                 | 215 +++++++++++-----
 net/batman-adv/types.h                             |   8 +-
 net/bluetooth/hci_conn.c                           |  92 +++----
 net/bluetooth/hci_core.c                           |  54 ++--
 net/bluetooth/hci_event.c                          | 212 ++++++++++------
 net/bluetooth/hci_sync.c                           | 223 +++++++++++++----
 net/bluetooth/iso.c                                |  20 +-
 net/bluetooth/l2cap_core.c                         |  26 +-
 net/bluetooth/mgmt.c                               |  51 ++--
 net/bluetooth/smp.c                                |  53 ++--
 net/bridge/br_if.c                                 |   6 +-
 net/can/af_can.c                                   |  60 +++--
 net/can/af_can.h                                   |   2 +-
 net/can/bcm.c                                      |  64 ++---
 net/can/gw.c                                       |   9 +-
 net/can/isotp.c                                    | 230 ++++++++++-------
 net/can/j1939/main.c                               |   2 +-
 net/can/proc.c                                     |  95 ++++---
 net/can/raw.c                                      | 278 ++++++++++++---------
 net/core/dev.c                                     |  27 +-
 net/core/filter.c                                  |   2 +-
 net/core/skbuff.c                                  |  19 +-
 net/core/sock.c                                    |   6 +-
 net/core/sock_reuseport.c                          |  17 +-
 net/ipv4/cipso_ipv4.c                              |   9 +-
 net/ipv4/inet_connection_sock.c                    |  16 +-
 net/ipv4/inet_fragment.c                           |   5 +
 net/ipv4/inet_hashtables.c                         |   7 +-
 net/ipv4/inet_timewait_sock.c                      |   4 +-
 net/ipv4/ipmr.c                                    | 104 ++++----
 net/ipv4/route.c                                   |   2 +
 net/ipv4/syncookies.c                              |   4 +-
 net/ipv4/tcp_fastopen.c                            |   4 +-
 net/ipv4/tcp_input.c                               |  14 +-
 net/ipv4/tcp_ipv4.c                                |  21 +-
 net/ipv4/xfrm4_output.c                            |   7 +-
 net/ipv6/addrconf.c                                |   3 +-
 net/ipv6/datagram.c                                |   4 +
 net/ipv6/inet6_hashtables.c                        |   6 +-
 net/ipv6/ip6_fib.c                                 |  50 +++-
 net/ipv6/ip6mr.c                                   | 112 +++++----
 net/ipv6/raw.c                                     |   3 +
 net/ipv6/route.c                                   |  20 +-
 net/ipv6/seg6_local.c                              |  69 +++--
 net/ipv6/tcp_ipv6.c                                |   7 +-
 net/iucv/af_iucv.c                                 |   9 +
 net/l2tp/l2tp_core.c                               |  13 +-
 net/mac80211/tdls.c                                |   3 +-
 net/mac80211/tx.c                                  |   2 +
 net/mptcp/pm_kernel.c                              |   1 +
 net/mptcp/subflow.c                                |  11 +
 net/qrtr/af_qrtr.c                                 |  53 +++-
 net/sched/sch_generic.c                            |  41 ++-
 net/sched/sch_qfq.c                                |   3 +
 net/sched/sch_taprio.c                             |   5 +
 net/sctp/sm_make_chunk.c                           |   9 +-
 net/smc/smc_rx.c                                   |  39 ++-
 net/smc/smc_sysctl.c                               |   6 +-
 net/tipc/bearer.c                                  |  50 +++-
 net/tipc/bearer.h                                  |   9 +-
 net/tipc/udp_media.h                               |   2 +-
 net/vmw_vsock/af_vsock.c                           |   3 +-
 net/wireless/core.c                                |   2 +-
 net/wireless/reg.c                                 |   3 +
 net/wireless/wext-core.c                           |  33 +--
 net/xfrm/espintcp.c                                |  43 ++--
 net/xfrm/xfrm_interface_core.c                     |   8 +
 net/xfrm/xfrm_iptfs.c                              |   3 +-
 net/xfrm/xfrm_policy.c                             |  14 +-
 net/xfrm/xfrm_replay.c                             |   6 +-
 net/xfrm/xfrm_state.c                              | 101 ++++++--
 net/xfrm/xfrm_user.c                               |  81 ++++--
 tools/testing/selftests/net/fib_nexthops.sh        |  40 ++-
 .../tcp_bidir_fast_retransmit_nosack.pkt           |  42 ++++
 tools/testing/selftests/net/veth.sh                |  81 +++++-
 153 files changed, 3250 insertions(+), 1432 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_bidir_fast_retransmit_nosack.pkt

