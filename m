Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB83366075;
	Thu, 27 Aug 2026 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863896; cv=none; b=DnVUKnfNOvwBJbpIvLbuggdcJF1k+XOf3dUO4ECJj4UFRqKlYaoh3c0FUrfuWjSY3xyM6jpHCShzasMcelAsVAIpBFdGZ4JnbNQM7lanCglPrG6OYyR7o9P5WbtErm/JVq8aw9Sa1vk2GVQ1w7Yy7yly1CE0prN7joVx6SkN820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863896; c=relaxed/simple;
	bh=xFjxa/dCnq7YMZ22xJ+8qPdYfJmyNqiRYUW5u4ucQ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MQe/M+Anbygcn8ufKvFYXxrOgqMYClh5ocNKfvZSacQK3/3VtUvuyxlIyEb2oDC5r2qexwBOi5an1eZr/wDg1oK6E+t5Ew49cnrG7UQXlqeQHMSgAd2OT5Zgdm7/2JBYgon2aNJezkQvt9ClPLv98ndIYnDsuF11KC3L91N/Hxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiUQ1IJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiUQ1IJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125031F000E9;
	Thu, 27 Aug 2026 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787863894;
	bh=BMiYNzoTbDh+Wsj+zicN5QdiYJUi2Ypttj1fKxwMkkY=;
	h=From:To:Cc:Subject:Date;
	b=fiUQ1IJxAx+8lQxeAo6kHXrCf5HO8PpEaa/sS2WPONwxt2TOsthdrp+BkncwzvNqQ
	 PDjVfzDm0t6SrB010qThCBv2L/8hezR8uOwGUfdppgMRYWzLBXAWLyldygZEYkAT9e
	 vbcX42CtB/AmYv2lmvjCZkapdvkWpR1qkn79Z5I0eQgY633OWcxxd9F2mf1J0vZigs
	 JDSvetv3kJG5PN7sCY7JkvdMaEpQLijIMbGCO1XDk5meQy1sKeCNjbPDpO+eFfDF4E
	 +ffFQZfVLOrb7MvO8RVQyCgWtAnSlydcqUYXFcay1Ey16a3b3dThLt13RHCYinLOso
	 LGSuMacyXppXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.3-rc1
Date: Thu, 27 Aug 2026 13:51:33 -0700
Message-ID: <20260827205133.1242124-1-kuba@kernel.org>
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

The following changes since commit 91ec2035134982b98fab0609a9fd8480e8217dc1:

  Merge tag 'net-next-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-08-20 08:16:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc1

for you to fetch changes up to 4a9d62a8774f130a5b8de26ca9f415e6050a9d51:

  Merge tag 'nf-26-08-27' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2026-08-27 13:13:18 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth, IPSec and Netfilter.

Current release - fix to a fix:

 - netfilter: ipset: remove need to allocate memory on delete operations

Current release - regressions:

 - macb: drop CONFIG_OF #if block, fix build

Previous releases - always broken:

 - stream of fixes for SCTP continues

 - inet: frags: strip GSO state from fragments before reassembly

 - virtio-net: ensure that TCP packets don't overflow gso_segs

 - tcp-ao: fix use-after-free of current_key on reconnect to another peer

 - page_pool: remove zone/policy GFP flags when allocating XArray entries

 - Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN

 - tls: device: fix out-of-bounds write in tls_append_frag()

 - eth: bnxt:
   - ring the doorbell when SW USO exits early, avoid packets stuck in Tx
   - gate TPH enablement behind BNXT_SUPPORTS_QUEUE_API check, avoid users
     of older NICs seeing non-actionable warning messages

 - eth: qede: fix NULL pointer dereference in TPA fragment processing

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abhijit Gangurde (1):
      net: ionic: Fetch RCQ sign bit from firmware

Aldo Ariel Panzardo (1):
      net: mctp: hold a reference to the route device in mctp_route_lookup()

Aleksandr Khromov (1):
      slip: fix use-after-free in sl_sync()

Alexandra Winter (1):
      net/iucv: filter frames in afiucv_hs_rcv() by ingress device

Ali Ahmet Memis (1):
      Bluetooth: btnxpuart: Validate the FW dump header length

Alice Mikityanska (6):
      virtio-net: Ensure that TCP packets don't overflow gso_segs
      net: Guard for gso_segs overflow in skb_segment
      selftests: net: Wait for netserver to launch
      selftests: net: Lower threshold on debug kernels for big_tcp_tunnels.sh
      selftests: net: Lower threshold with csum offload off in big_tcp_tunnels.sh
      selftests: net: Fix slow configurations in big_tcp_tunnels.sh

Allison Henderson (1):
      net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Andrea Mayer (1):
      ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

Anshumali Gaur (3):
      octeontx2-af: fix NULL deref in NIX TM tree debugfs read path
      octeontx2-af: fix out-of-bounds read setting MSI-X irq affinity
      octeontx2-vf: fix workqueue and netdev race in probe/remove

Anton Danilov (1):
      ipip: fix skb leak in collect_md mode when metadata_dst allocation fails

Asim Viladi Oglu Manizada (1):
      xfrm: ah6: validate routing header segments_left

Breno Leitao (1):
      net: fix spurious TX timeout after dev_activate()

Cen Zhang (Microsoft) (3):
      xsk: fix NULL pointer dereference in __xsk_rcv()
      ipv6: avoid divide by zero in rt6_multipath_rebalance
      gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free

Chengfeng Ye (3):
      Bluetooth: RFCOMM: serialize security confirmation handling
      Bluetooth: RFCOMM: serialize session teardown
      vsock/virtio: flush works in dependency order

Chris Lu (2):
      Bluetooth: btmtksdio: Take exclusive ownership of the SKB before TX
      Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Christian Marangi (1):
      net: phylink: correctly validate returned PCS in phylink_inband_caps

Daniel Machon (2):
      net: microchip: vcap: use port number instead of netdev name for debugfs
      net: sparx5: fix sleep in atomic context in MAC table access

Daniel Pawlik (1):
      net: airoha: npu: fix missing streaming DMA mask

Deepanshu Kartikey (1):
      usb: atm: usbatm: fix invalid ci_range initialization

Edoardo Pinci (1):
      net: dsa: mxl862xx: enable assisted learning on CPU port

Eric Biggers (1):
      netfilter: nft_set_pipapo_avx2: add missing vzeroupper

Eric Dumazet (8):
      selftests: net: packetdrill: add tests for advertised MSS with PMTU exceptions
      netdevsim: update queue NAPI association on queue reset
      ip6mr: do not clone dst in ip6mr_cache_report()
      inetpeer: randomize RB-tree node comparison using SipHash
      vlan: fix skb_under_panic and races when toggling HW VLAN offload
      net_sched: sch_fq: fix pacing delay underflow with pacing offload
      net/sched: act_skbmod: fix length calculations and avoid invalid header warnings
      slip: remove slip_hangup() to fix use-after-free in slip_receive_buf()

Fan Ye (1):
      net: thunderbolt: Count delivered packets in rx_packets and rx_bytes

Fernando Fernandez Mancera (2):
      netfilter: tproxy: use DEBUG_NET_WARN_ON_ONCE for protocol fallbacks
      netfilter: conncount: use DEBUG_NET_WARN_ON_ONCE on reaching count limit

Florian Westphal (1):
      netfilter: ipset: remove need to allocate memory on delete operations

Fourie Zhang (1):
      netfilter: nf_tables: don't queue packet path object notifications

Giuseppe Piscitelli (1):
      net/sched: sch_cake: fix autorate reconfiguration throttling

Gongwei Li (1):
      Bluetooth: hci_uart: Fix false success return in hci_uart_setup()

Guangshuo Li (3):
      Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
      Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative

Guenter Roeck (1):
      bnxt_en: Fix call to hardware monitoring event handler

Hang Nan (1):
      Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready

Harshit Varu (1):
      mptcp: fix uninitialized local_id in syncookie MP_JOIN reconstruction

Hidayath Khan (3):
      net/smc: fix socket refcount leak in smc_switch_conns()
      net/smc: stop killed, freed and out_of_sync sharing a byte
      net/smc: fix use-after-free in smc_rx_pipe_buf_release()

HyeongJun An (1):
      Bluetooth: eir: Fix OOB read in eir_get_service_data()

Hyunwoo Kim (3):
      net/tcp-ao: fix use-after-free of current_key on reconnect to another peer
      sctp: drop a chunk if its transport was removed
      Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn() to prevent infinite loop

Ibrahim Abdelkader (1):
      Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request

Ismail Tarim (2):
      Bluetooth: btmtk: Do not report success when subsys reset fails
      Bluetooth: btmtk: Do not discard the subsystem reset timeout

Jakub Kicinski (19):
      Merge tag 'nf-next-26-08-18' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'ipsec-2026-08-18' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'net-mlx5-preserve-speed-and-state-across-vport-modify-commands'
      Merge branch 'forcedeth-two-register-window-bounds-fixes'
      Merge branch 'ionic_rcq_shared' of https://github.com/abhijitG-xlnx/linux
      Merge branch 'net-ntb_netdev-fix-tx-completion-and-error-handling'
      Merge branch 'bridge-vxlan-fix-reading-neigh-ha-without-synchronization'
      Merge tag 'batadv-net-pullrequest-20260821' of https://git.open-mesh.org/batadv
      Merge branch 'net-ntb_netdev-fix-rx-statistics-accounting'
      Merge branch 'net-sparx5-misc-fixes-for-sparx5-and-lan969x'
      Merge branch 'net-smc-fix-out-of-bounds-and-use-after-free-in-smc-rv2-llc-processing'
      Merge branch 'xsk-pre-existing-af_xdp-tx-metadata-fixes-from-sashiko'
      Merge branch 'selftests-net-fixes-for-fin_ack_lat'
      Merge branch 'net-smc-fix-use-after-free-in-smc_rx_pipe_buf_release'
      Merge branch 'net-enetc-restore-rx-ring-congestion-mode-after-ring-reconfiguration'
      Merge tag 'for-net-2026-08-24' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'improve-stability-of-big_tcp_tunnels-sh-selftest'
      Merge branch 'net-stmmac-more-selftest-related-fixes'
      Merge tag 'nf-26-08-27' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jamal Hadi Salim (10):
      net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue
      net/sched: account classifier filter allocations to memcg
      net/sched: fq: add overflow bounds to quantum and initial quantum
      net/sched: fq_codel: clamp default quantum and mtu
      net/sched: sch_codel: clamp default mtu to avoid disabling CoDel
      net/sched: fq_pie: clamp default quantum to avoid signed overflow
      net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
      net/sched: sfq: clamp quantum to avoid signed overflow soft lockup
      net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
      net/sched: sch_htb: limit htb_classify inner-class filter hops

Jian Shen (1):
      net: hibmcge: fix page_pool DMA direction mismatch

Jiangshan Yi (1):
      bnx2x: fix double free in bnx2x_init_firmware() error path

Jiawen Wu (3):
      net: txgbe: fix MISC interrupt unmasking in non-MSI-X mode and device shutdown
      net: libwx: fix concurrent bitmap overwrite in PTP setup
      net: wangxun: use BIT_ULL() to prevent shift overflow on 32-bit archs

Jiayuan Chen (4):
      net: advertise TCP MSS from the configured MTU, not the learned PMTU
      tls: device: fix out-of-bounds write in tls_append_frag()
      tcp: fix corruption of urgent data on multi-segment retransmit
      selftests/net: packetdrill: add tcp_urg_ptr_retransmit

Joas Antonio dos Santos (1):
      ipvs: fix integer overflow in ftp helper port/address parsing

Joe Damato (2):
      net: bnxt: ring the doorbell when SW USO exits early
      bnxt_en: Write doorbell when linearizing skb fails

Jorijn van der Graaf (1):
      net: ipa: fix stalled modem TX queue after runtime resume

Jun Yang (2):
      sctp: distinguish sequence zero from wildcard in reconf lookup
      sctp: fix stream->outcnt underflow on duplicate RECONF responses

Junjie Cao (1):
      Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728

Koichiro Den (6):
      NTB: ntb_transport: Recycle TX entries before client callbacks
      net: ntb_netdev: Fix TX busy and drop handling
      NTB: ntb_transport: Fail TX enqueue when the QP link is down
      NTB: ntb_transport: Reject oversized TX buffers
      net: ntb_netdev: Avoid double-accounting netif_rx() drops
      net: ntb_netdev: Count packets dropped on RX refill failure

Kyle Zeng (3):
      ipv6: seg6: clear IPv4 control block on IPIP decapsulation
      batman-adv: reject unrepresentable multicast TVLV offsets
      net/packet: defer vmalloc TX_RING free until skbs finish

Long Li (1):
      net: mana: Cap MSI-X vectors to the device MSI-X table size

Lorenzo Bianconi (1):
      net: stmmac: drop gso_enabled_types and rely on netdev features

Lorenzo Stoakes (ARM) (1):
      Bluetooth: hci_bcm4377: Ignore reserved PHY in ext adv reports on BCM4378

Mahanta Jambigi (2):
      net/smc: free stashed qentry before overwrite in REQ_ADD_LINK to ADD_LINK transition
      net/smc: free pending qentry in smc_llc_flow_stop() before memset

Maher Azzouzi (1):
      esp: do not unref managed frag pages in esp_ssg_unref()

Manush Prajwal (1):
      net: ethernet: renesas: rswitch: fix device_node refcount leak in rswitch_get_port_node()

Marek Czernohous (2):
      forcedeth: fix off-by-one when saving/restoring non-PCI config space
      forcedeth: stop the tx_timeout register dump past the requested window

Mark Bloch (1):
      net/mlx5: E-Switch, use state lock for vport state changes

Maxime Chevallier (7):
      net: stmmac: selftests: Pass the IP proto mask in the TC selftest
      net: stmmac: selftests: Check multiple MMC counters
      net: stmmac: dwmac1000: Account for the primary MAC address for UC filtering
      net: stmmac: dwmac4: Account for the primary MAC address for UC filtering
      net: stmmac: dwxgmac: Account for the primary MAC address for UC filtering
      net: stmmac: selftests: Account for the UC filter list for filtering tests
      net: stmmac: selftests: Don't test flow control for small rx fifos

Md Rabbani (1):
      net: stmmac: fix device node reference leaks in stmmac_mtl_setup()

Mehrdad Afshari (1):
      net: usb: cdc_ncm: add Apple MacBook Pro USB product ID 0x1902

Mina Almasry (4):
      net: core: propagate unreadable flag in skb_zerocopy
      net: tcp: block mixing readable and unreadable frags
      net: core: check skb_frags_readable before uncloning in skb_copy_ubufs
      net: core: fix head-page leak in skb_zerocopy

Naveen Mamindlapalli (1):
      octeontx2-af: Fix TL3/TL2 link config ENA clearing

Nikolay Aleksandrov (2):
      net: bridge: arp/nd proxy: fix reading neigh ha
      vxlan: fix reading neigh ha

Norbert Szetei (4):
      openvswitch: only skb_tx_error() a packet we are about to drop
      net: skbuff: don't skb_tx_error() the source skb in skb_zerocopy()
      net: skbuff: don't touch shared zerocopy state in skb_tx_error()
      net: bridge: mcast: fix use-after-free of a master VLAN's multicast context

Or Har-Toov (2):
      net/mlx5: Move vport DOWN state check out of mlx5_query_vport_max_tx_speed()
      net/mlx5: E-Switch, preserve max tx speed on vport state modification

Pablo Neira Ayuso (10):
      netfilter: nf_conntrack_expect: consolidate check for insertion of dead expectation
      netfilter: ctnetlink: do not expose expectation DEAD flag
      netfilter: nf_tables: move set_update_list to nftables per-netns
      netfilter: nf_tables: call set ops .commit when building new ruleset blob
      netfilter: nf_tables: move hardware offload step after building the chain blob
      netfilter: x_tables: remove pr_debug
      netfilter: x_tables: replace pr_{info,err}() by pr_info_ratelimited()
      netfilter: nf_tables: skip double clone set expressions on element insert
      netfilter: nf_tables: set on dead bit when performing early element removal
      netfilter: nf_tables: remove leftover set_update_list

Paolo Abeni (4):
      Merge branch 'net-don-t-strip-zerocopy-frag-markers-from-a-forwarded-skb'
      Merge branch 'net-sched-fix-quantum-mtu-overflow-in-fq-fq_codel-sch_codel-fq_pie-hhf-sfq'
      Merge branch 'sctp-handle-wrapped-and-duplicate-reconf-responses'
      Merge branch 'guard-against-gso_segs-overflows'

Pascal Kneuper (1):
      net: stmmac: restore NET_IP_ALIGN in the RX DMA offset

Pauli Virtanen (4):
      Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
      Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN
      Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
      Bluetooth: hci_sync: add conditional locking annotations

Pavel Shpakovskiy (1):
      Bluetooth: mgmt: fix 'hdev->discovery.uuids' NULL dereference

Pengpeng Hou (1):
      net: qlcnic: validate unified ROM sections before loading

Qing Ming (2):
      gtp: serialize PDP context updates
      tcp: fix AO info use-after-free in tcp_ao_connect_init()

Qingshuang Fu (2):
      selftests/net: fix kill() argument order and wrapper cleanup in fin_ack_lat
      selftests/net: check fork() return value in fin_ack_lat

Radek Podgorny (1):
      Bluetooth: do not leak an hci_conn when a second LE connect is rejected

Rastislav Szabo (2):
      net/tcp: fix TCP-AO key deletion in VRFs
      selftests: net: tcp_ao: test VRF-scoped key deletion

Rong Zhang (1):
      net: page_pool: Remove zone/policy GFP flags when allocating XArray entries

Ruoyu Wang (2):
      net: bridge: Reject descending VLAN tunnel ranges
      net: ipa: balance runtime PM reference on remove error

Sabrina Dubroca (1):
      xfrm: espintcp: fix UAF during close

Sai Krishna (1):
      octeontx2-af: fix cn20k mailbox lifetime on repeated rvu_mbox_init()

Sanghyun Park (1):
      xfrm: Fix skb double-free in xfrm_dev_direct_output()

Sherry Sun (1):
      Bluetooth: btnxpuart: Check remote M.2 connector availability before pwrseq

Shiji Yang (1):
      net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF to 0x80

Stanislav Fomichev (2):
      xsk: align TX metadata layout across ABIs
      xsk: honor XDP_TX_METADATA in zero-copy path

Stefan Wahren (1):
      docs: oa-tc6-framework: Fix link to specification

Steffen Klassert (1):
      Revert "esp: do not unref managed frag pages in esp_ssg_unref()"

Suman Ghosh (1):
      octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup

Sven Eckelmann (8):
      batman-adv: bla: avoid CRC corruption due to parallel claim add
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: dat: atomically update mac addresses
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: bla: fix freeing of claims on meshif deletion

Tetsuo Handa (2):
      net: add missing ref_tracker_dir_exit() to net_passive_dec()
      net: fix a resource leak in copy_net_ns() error handling path

Thomas Walsh (1):
      bnxt_en: Gate TPH enablement behind BNXT_SUPPORTS_QUEUE_API check

Théo Lebrun (1):
      net: macb: drop CONFIG_OF #if block

Triet Hoang (1):
      tools: ynl: handle calloc failure in ynl_ntf_parse

Vaibhav Nagare (1):
      qede: Fix NULL pointer dereference in TPA fragment processing

Valentin Kindschi (2):
      Bluetooth: hci_conn: re-enable advertising only for peripheral role
      Bluetooth: hci_event: clear HCI_LE_ADV only on a created connection

Victor Nogueira (3):
      net/sched: add get_fill_size callbacks for actions missing them
      net/sched: act_ife: Only operate on Ethernet frames
      net/sched: sch_teql: restore skb->dev on the slave failure path

Vitaliy Sochnev (1):
      net: phy: air_en8811h: move LED GPIO configuration to config_init

Wei Fang (3):
      ptp: netc: fix period truncation and potential divide-by-zero in PEROUT
      net: enetc: restore RX ring congestion mode after ring reconfiguration
      net: enetc: restore RX ring congestion mode for ENETC v4

Weiming Shi (2):
      xdp: fix zero-copy frame layout
      sctp: fix NULL deref on untransmitted RECONF completion

Xiang Mei (2):
      xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
      net: qualcomm: rmnet: restore skb->dev on deaggregated frames

Xin Chen (1):
      Bluetooth: hci_core: use skb_get() instead of skb_clone() for req_skb

Xinyang Ge (1):
      inet: frags: strip GSO state from fragments before reassembly

Yehyeong Lee (3):
      net/smc: fix use-after-free of the LLC qentry in smc_llc_srv_add_link()
      net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
      net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

Yifei Chu (1):
      net/smc: release the internal TCP sock on IPPROTO_SMC socket creation failure

Yong Wang (1):
      tcp: clamp route advmss to TCP_MIN_MSS

Yuqi Xu (1):
      openvswitch: Fix CT limit teardown use-after-free

Yuyang Huang (1):
      ipv6: use RCU iterator to dump route exceptions

Zhan Xusheng (1):
      ethtool: remove unused __ETHTOOL_LINK_MODE_MASK_NWORDS

Zhiling Zou (4):
      xfrm: drop ESP-in-TCP packets with no ingress device
      batman-adv: fix stale receive device on merged fragments
      netfilter: validate L4 headers after userspace packet writes
      seg6: reset IP6CB after IPv6 decapsulation

Zihan Xi (4):
      xfrm: avoid lock inversion in nat keepalive work
      xfrm: fix xfrm_state_construct() auth-trunc leak
      xfrm: bound nat keepalive state collection
      net: l2tp: do not propagate multicast notification errors

bui duc phuc (2):
      net: ethernet: sun4i-emac: Fix IRQ error handling
      net: fec: only stop PTP if it was initialized

 Documentation/networking/oa-tc6-framework.rst      |   2 +-
 drivers/bluetooth/btmtk.c                          |  11 +-
 drivers/bluetooth/btmtksdio.c                      |  37 +-
 drivers/bluetooth/btnxpuart.c                      |  39 +-
 drivers/bluetooth/btrtl.c                          |  13 -
 drivers/bluetooth/btusb.c                          |   8 +
 drivers/bluetooth/hci_bcm.c                        |   1 +
 drivers/bluetooth/hci_bcm4377.c                    |   1 +
 drivers/bluetooth/hci_h5.c                         |   4 +-
 drivers/bluetooth/hci_intel.c                      |   1 +
 drivers/bluetooth/hci_ldisc.c                      |   2 +-
 drivers/bluetooth/hci_serdev.c                     |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   5 +-
 drivers/net/dsa/mxl862xx/mxl862xx.c                |   1 +
 drivers/net/ethernet/airoha/airoha_npu.c           |   2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c        |   4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  25 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c      |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c    |   2 +-
 drivers/net/ethernet/cadence/macb_main.c           |   4 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |  72 +++-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   9 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |  16 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  14 +-
 drivers/net/ethernet/freescale/fec_main.c          |   6 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c  |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   3 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/api.h  |   1 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c         |  21 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  43 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   6 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  11 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  20 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.c  |   3 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   5 +
 drivers/net/ethernet/mediatek/mtk_wed_regs.h       |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/xsk/tx.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  20 +-
 .../ethernet/mellanox/mlx5/core/esw/adj_vport.c    |  22 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  44 +-
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  |  11 +-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   |   5 +-
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c |  21 +
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.h |  14 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  19 +
 drivers/net/ethernet/nvidia/forcedeth.c            |   6 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |   6 +-
 drivers/net/ethernet/qlogic/qede/qede.h            |   8 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c   | 467 ++++++++++++---------
 .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c   |   1 +
 drivers/net/ethernet/renesas/rswitch_main.c        |  18 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  26 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   6 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |  57 ++-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c        |  18 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |   5 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |   2 +-
 drivers/net/gtp.c                                  |  23 +-
 drivers/net/ipa/ipa_main.c                         |   6 +-
 drivers/net/ipa/ipa_modem.c                        |  18 +-
 drivers/net/netdevsim/netdev.c                     |   2 +
 drivers/net/ntb_netdev.c                           |  38 +-
 drivers/net/phy/air_en8811h.c                      |  18 +-
 drivers/net/phy/phylink.c                          |   2 +-
 drivers/net/slip/slip.c                            |  19 +-
 drivers/net/thunderbolt/main.c                     |   6 +-
 drivers/net/usb/cdc_ncm.c                          |   6 +
 drivers/net/vxlan/vxlan_core.c                     |  20 +-
 drivers/ntb/ntb_transport.c                        |  38 +-
 drivers/ptp/ptp_netc.c                             |  10 +-
 drivers/usb/atm/usbatm.c                           |   4 +-
 include/linux/ethtool_netlink.h                    |   3 -
 include/linux/mlx5/vport.h                         |   3 +-
 include/linux/skbuff.h                             |  24 ++
 include/linux/virtio_net.h                         |   4 +
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/bluetooth/l2cap.h                      |   5 +
 include/net/inetpeer.h                             |   4 +
 include/net/ip.h                                   |  25 ++
 include/net/ip6_route.h                            |  37 ++
 include/net/libeth/xsk.h                           |   2 +-
 include/net/netfilter/nf_tables.h                  |   3 +-
 include/net/pkt_sched.h                            |   1 +
 include/net/sctp/structs.h                         |   2 +-
 include/net/tcp.h                                  |   5 +
 include/net/xdp_sock_drv.h                         |  22 +-
 include/net/xsk_buff_pool.h                        |   3 +-
 include/uapi/linux/if_xdp.h                        |   1 +
 net/8021q/vlan_dev.c                               |  39 +-
 net/batman-adv/bridge_loop_avoidance.c             |  80 ++--
 net/batman-adv/distributed-arp-table.c             |  66 ++-
 net/batman-adv/main.c                              |   4 +
 net/batman-adv/mesh-interface.c                    |   7 +-
 net/batman-adv/multicast_forw.c                    |   7 +-
 net/batman-adv/tvlv.c                              |   5 +-
 net/batman-adv/types.h                             |   2 +-
 net/bluetooth/eir.c                                |   3 +-
 net/bluetooth/hci_conn.c                           |   3 +-
 net/bluetooth/hci_core.c                           |   2 +-
 net/bluetooth/hci_event.c                          |   7 +-
 net/bluetooth/hci_sync.c                           |  16 +-
 net/bluetooth/iso.c                                |   8 +
 net/bluetooth/l2cap_sock.c                         | 100 +++--
 net/bluetooth/mgmt.c                               |  18 +-
 net/bluetooth/rfcomm/core.c                        |  14 +-
 net/bridge/br_arp_nd_proxy.c                       |  24 +-
 net/bridge/br_multicast.c                          |   4 +-
 net/bridge/br_netlink_tunnel.c                     |   3 +-
 net/core/net_namespace.c                           |  25 +-
 net/core/page_pool.c                               |   7 +
 net/core/skbuff.c                                  |  28 +-
 net/core/xdp.c                                     |   4 +-
 net/ife/ife.c                                      |  14 +-
 net/ipv4/inet_fragment.c                           |   7 +
 net/ipv4/inetpeer.c                                |  38 +-
 net/ipv4/ipip.c                                    |   2 +-
 net/ipv4/netfilter/ipt_ah.c                        |  10 +-
 net/ipv4/netfilter/nf_tproxy_ipv4.c                |   2 +-
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/tcp.c                                     |   3 +-
 net/ipv4/tcp_ao.c                                  |  19 +-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv4/tcp_output.c                              |   8 +-
 net/ipv6/ah6.c                                     |  29 +-
 net/ipv6/exthdrs.c                                 |  26 +-
 net/ipv6/ip6mr.c                                   |   3 +-
 net/ipv6/netfilter/ip6t_ah.c                       |  27 +-
 net/ipv6/netfilter/ip6t_frag.c                     |  41 +-
 net/ipv6/netfilter/ip6t_hbh.c                      |  40 +-
 net/ipv6/netfilter/ip6t_mh.c                       |   3 -
 net/ipv6/netfilter/ip6t_rt.c                       |   6 +-
 net/ipv6/netfilter/nf_tproxy_ipv6.c                |   2 +-
 net/ipv6/route.c                                   |   6 +-
 net/ipv6/seg6_local.c                              |  16 +
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/ipv6/xfrm6_input.c                             |   2 +-
 net/iucv/af_iucv.c                                 |   2 +
 net/l2tp/l2tp_netlink.c                            |  16 +-
 net/mctp/route.c                                   |  19 +-
 net/mptcp/syncookies.c                             |   1 +
 net/netfilter/ipset/ip_set_hash_gen.h              | 174 +++++---
 net/netfilter/ipset/ip_set_hash_netiface.c         |   1 -
 net/netfilter/ipset/ip_set_hash_netportnet.c       |   1 -
 net/netfilter/ipvs/ip_vs_ftp.c                     |  10 +-
 net/netfilter/nf_conncount.c                       |   3 +-
 net/netfilter/nf_conntrack_expect.c                |  11 +-
 net/netfilter/nf_conntrack_netlink.c               |   2 +-
 net/netfilter/nf_tables_api.c                      | 218 +++++-----
 net/netfilter/nfnetlink_queue.c                    |  72 +++-
 net/netfilter/nft_dynset.c                         |  25 +-
 net/netfilter/nft_payload.c                        |  13 +
 net/netfilter/nft_set_pipapo_avx2.c                |  17 +-
 net/netfilter/xt_IDLETIMER.c                       |  68 +--
 net/netfilter/xt_LOG.c                             |   4 +-
 net/netfilter/xt_MASQUERADE.c                      |   4 +-
 net/netfilter/xt_NETMAP.c                          |   6 +-
 net/netfilter/xt_REDIRECT.c                        |   6 +-
 net/netfilter/xt_cgroup.c                          |  12 +-
 net/netfilter/xt_esp.c                             |  10 +-
 net/netfilter/xt_hl.c                              |   4 +-
 net/netfilter/xt_ipcomp.c                          |   8 +-
 net/netfilter/xt_iprange.c                         |  32 +-
 net/netfilter/xt_ipvs.c                            |   1 -
 net/netfilter/xt_multiport.c                       |   4 -
 net/netfilter/xt_sctp.c                            |  19 +-
 net/netfilter/xt_tcpudp.c                          |   8 +-
 net/openvswitch/conntrack.c                        | 120 ++++--
 net/openvswitch/conntrack.h                        |   6 +-
 net/openvswitch/datapath.c                         |  16 +-
 net/openvswitch/datapath.h                         |   8 +-
 net/packet/af_packet.c                             |  96 ++++-
 net/rds/cong.c                                     |   4 +-
 net/sched/act_api.c                                |   5 +-
 net/sched/act_bpf.c                                |  26 ++
 net/sched/act_ct.c                                 |  46 ++
 net/sched/act_ctinfo.c                             |  11 +
 net/sched/act_ife.c                                |  55 ++-
 net/sched/act_pedit.c                              |  24 ++
 net/sched/act_police.c                             |  12 +
 net/sched/act_sample.c                             |   9 +
 net/sched/act_skbmod.c                             |  12 +-
 net/sched/act_tunnel_key.c                         |  80 ++++
 net/sched/cls_api.c                                |   3 +-
 net/sched/cls_basic.c                              |   6 +-
 net/sched/cls_bpf.c                                |   6 +-
 net/sched/cls_cgroup.c                             |   2 +-
 net/sched/cls_flow.c                               |   2 +-
 net/sched/cls_flower.c                             |   4 +-
 net/sched/cls_fw.c                                 |   4 +-
 net/sched/cls_matchall.c                           |   4 +-
 net/sched/cls_route.c                              |   4 +-
 net/sched/cls_u32.c                                |  11 +-
 net/sched/sch_api.c                                |   7 +-
 net/sched/sch_cake.c                               |   1 +
 net/sched/sch_codel.c                              |   2 +-
 net/sched/sch_fifo.c                               |   2 +-
 net/sched/sch_fq.c                                 |  14 +-
 net/sched/sch_fq_codel.c                           |   6 +-
 net/sched/sch_fq_pie.c                             |   3 +-
 net/sched/sch_generic.c                            |   2 +-
 net/sched/sch_gred.c                               |   4 +-
 net/sched/sch_hhf.c                                |   4 +
 net/sched/sch_htb.c                                |   7 +-
 net/sched/sch_plug.c                               |   2 +-
 net/sched/sch_sfq.c                                |   3 +-
 net/sched/sch_teql.c                               |   1 +
 net/sctp/inqueue.c                                 |   7 +-
 net/sctp/stream.c                                  |  48 ++-
 net/smc/smc.h                                      |   6 +-
 net/smc/smc_core.c                                 |  14 +-
 net/smc/smc_inet.c                                 |  16 +
 net/smc/smc_llc.c                                  | 125 ++++--
 net/smc/smc_rx.c                                   |  11 +-
 net/smc/smc_wr.c                                   |   6 +-
 net/tls/tls_device.c                               |   3 +-
 net/vmw_vsock/virtio_transport.c                   |   2 +-
 net/xdp/xsk.c                                      |  30 +-
 net/xdp/xsk_buff_pool.c                            |   7 +-
 net/xfrm/espintcp.c                                |   9 +-
 net/xfrm/xfrm_nat_keepalive.c                      |  53 ++-
 net/xfrm/xfrm_output.c                             |   4 +-
 net/xfrm/xfrm_user.c                               |   2 +-
 tools/include/uapi/linux/if_xdp.h                  |   1 +
 tools/net/ynl/lib/ynl.c                            |   3 +
 tools/testing/selftests/net/big_tcp_tunnels.sh     |  38 +-
 tools/testing/selftests/net/fin_ack_lat.c          |   5 +-
 tools/testing/selftests/net/fin_ack_lat.sh         |   2 +-
 .../net/packetdrill/tcp_advmss_pmtu_ipv4.pkt       |  67 +++
 .../net/packetdrill/tcp_advmss_pmtu_ipv6.pkt       |  67 +++
 .../net/packetdrill/tcp_urg_ptr_retransmit.pkt     |  65 +++
 .../testing/selftests/net/tcp_ao/key-management.c  |  67 ++-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |   6 +-
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |   4 +-
 245 files changed, 2989 insertions(+), 1438 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_urg_ptr_retransmit.pkt
