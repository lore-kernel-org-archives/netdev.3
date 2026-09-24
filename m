Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B54AE10F;
	Thu, 24 Sep 2026 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274780; cv=none; b=gen/gRUptgGfBPK+hpJkO/NwvMq5E2VVpQGdF3Dc7b1tSTnQulrrBNMoRl2koJsGiRXdiZz8oyw9UP8yUCPgPzQRWfP//Q0niehJGYEfL8tzA7Wzit+dOibV80vQBQL/yOeU923/96w19a6ZiiAbgSvDUxEJrl9oHkKKbTU/Kt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274780; c=relaxed/simple;
	bh=xKdyNazPMrQZbhP8C5SDQhL3Ho2QJPSAceBIGqSuTI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKmyzCDW2XOLRpmyF3VTvBwhdPt3DwhuXq8T7sQ1LWMelRLO0S3p7XbjaHMkOWLCl/SIeIHsoGi9G9xu916lVcEyLI0XgpAjYuriyCKGmRhe8UDj2vuztaDgJSz91q5lLcx5vaX2FrqbhFiMtqBIyc1bQ6SXE3USxipexOMQdQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTl6sSUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTl6sSUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729581F00893;
	Thu, 24 Sep 2026 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274777;
	bh=8xSBBkNePkc9uaPHAghhV1ZNm397RMIXu0GIJWM0hgI=;
	h=From:To:Cc:Subject:Date;
	b=cTl6sSUwlrgvDXntiiJAONv0P4cfelWyP8NgCWfYKAZ5uBduITS6SADQVdC5i3Kex
	 c1QTMp6VYuNyOnIOyrlJnXrFoXbDe/JLXgXgV2i+dNXK40ufBE1qW7zcQmb8H9G727
	 irpXvGH8sWEqxL+mJfwQlN8RafglMhOAo87DuGYM7bFebKdFSBfQGs0reg3NrT5Qfz
	 5CfxIP/ERYDuwBVjlssbnUs0ZJYn78yFkv5BRJl+H5LHmRQfVhu/G6W2u9jK8Cmm41
	 RfylHi34YxpjQGfkXyiHT35Kt0T62rxfVhjhoNLbow2boXXYeJM2xoe47Z8qLJ0ogM
	 9IKfDcA5dogWw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.3-rc5
Date: Thu, 24 Sep 2026 11:32:57 -0700
Message-ID: <20260924183257.2700506-1-kuba@kernel.org>
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

The following changes since commit b5a051f6b840d48f159166ef073d3021989bfb50:

  Merge tag 'net-7.3-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-09-17 10:40:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc5

for you to fetch changes up to fc6d80eb504458d6416b75a94188b268c95c6533:

  tcp: prevent collapsing skbs across boundary in rtx queue (2026-09-24 11:03:42 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth, NFC and Netfilter.

Every week in this release is record-setting for number of posted
patches. It doesn't seem like we're creating any regressions with
all these fixes, 3 Fixes tags here point to 7.2 commits but none
are true regression fixes. We're trying to keep the count down,
nonetheless.

Previous releases - regressions:

 - net: don't require the hwtstamp NDOs when a PHY provides timestamping

 - ipv6: fix dst leak for uncached routes

 - vrf: stop corrupting skb->csum when capturing CHECKSUM_COMPLETE
   packets

Previous releases - always broken:

 - packet: use ubuf_info completion for TX_RING packets

 - arp: terminate device name before lookup

 - ipv6: do not let ipv6_find_hdr() return an offset past the packet end

 - udp: remove a disconnected socket from the 4-tuple hash table

 - sctp: discard the rest of the packet on a stale-cookie error

 - eth: mlx5: Bridge, fix remaining switchdev ownership gaps on merged
   eswitch

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aamir Ahmed (2):
      net: usb: catc: bound the RX packet length in catc_rx_done()
      nfc: llcp: drop truncated I/RR/RNR PDUs in nfc_llcp_recv_hdlc()

Abhishek Ojha (1):
      net: phy: micrel: Advance register data pointer in write loop

Aldo Ariel Panzardo (9):
      Bluetooth: hci_conn: fix CIS hold ownership on reuse
      Bluetooth: ISO: release unused CIS holds after channel attach
      Bluetooth: hci_sock: reject out-of-range OCF values
      Bluetooth: hci_sock: validate event length before filtering
      Bluetooth: ISO: balance the parent hold in hci_bind_bis()
      Bluetooth: L2CAP: validate frame length before control and FCS access
      Bluetooth: mgmt: fix race in read_unconf_index_list()
      vsock: ignore empty child namespace mode writes
      nfc: llcp: Fix list corruption / refcount desync in nfc_llcp_recv_dm()

Aleksei Sviridkin (3):
      net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621
      net: dsa: mt7530: leave the MDIO IRQ mappings to regmap-irq
      net: phylink: record the PHY only once bringup cannot fail

Alexander Duyck (5):
      net: ethtool: keep rtnl_lock for the ioctl self test
      eth: fbnic: use the Rx queue napi pointer to find the napi vector
      eth: fbnic: reset num_napi when the napi vectors are freed
      eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox
      eth: fbnic: Handle FW mailbox completions flagged with an error

Alexander Sverdlin (1):
      net: phy: intel-xway: workaround 100BASE-TX Link-Up issue

Allison Henderson (1):
      net/rds: size a connection's path set by the transport it ends up with

Andrea Parri (1):
      net/mlx5e: fix swapped IPv6 IPsec policy masks

Andy Moreton (1):
      sfc: add X4D PF support

Aohan Mei (2):
      netfilter: nf_tables: skip expired catchall elements on insert and delete
      sctp: discard the rest of the packet on a stale-cookie error

Bernard Ladenthin (1):
      net/sched: fix potential stack infoleak in em_text_dump()

Bernardo Soares (2):
      net/mlx5: Bridge, don't fail switchdev events of sibling eswitch ports
      net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports

Björn Töpel (3):
      eth: fbnic: Fix payload page pool error cleanup
      eth: fbnic: Handle maximum standalone channels
      eth: fbnic: Avoid rounding zero ring sizes

Chaithanya Lagisetty (1):
      selftests: nci: Fix uninitialized family ID on missing attribute

Chris Gellermann (2):
      selftests/nci: Fix out-of-bounds store on thread join
      nfc: virtual_ncidev: Add missing ioctl compat handler

Christian Lamparter (1):
      net: emac: move setting of netops to fix crash

Christiano Amora (1):
      Bluetooth: SMP: reject Security Request over BR/EDR

Coia Prant (2):
      net: pcs: xpcs: fix clock reference leak on xpcs_init_clks failure
      net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails

Cong Nguyen (1):
      nfc: llcp: fix sdreq TLV list leak on parse/alloc/send failure

Dairui Zhang (1):
      af_packet: fix integer overflow in prb_calc_retire_blk_tmo()

David Dai (1):
      bonding: crypto offload enabled, non-offload slave failover, rekey failed

Deepanshu Kartikey (1):
      nfc: pn533: fix OOB read in pn533_acr122_is_rx_frame_valid()

Dongliang Qin (1):
      rds: ib: Clear the sg list when mapping an MR fails

Doruk Tan Ozturk (1):
      nfc: port100: reject frames whose declared length exceeds the received data

Eddie Phillips (1):
      gve: fix TX drop when GSO MSS is too small for hw

Eric Dumazet (8):
      tipc: reject invalid and unexpected GRP_ACK_MSG to prevent bc_ackers underflow
      net: flush skb_defer_nodes in dev_cpu_dead()
      gve: DQO: fix header length used by gve_can_send_tso() for UDP GSO
      gve: DQO: reject TSO packets with an out of range MSS
      llc: fix skb UAF and leaks on llc_mac_hdr_init() failure
      bridge: check llc_mac_hdr_init() return value in br_send_bpdu()
      net/sched: sch_teql: fix shadowed err in __teql_resolve()
      vlan: ensure sufficient headroom in vlan_dev_hard_header()

Fang Xieyan (1):
      net/sched: act_ife: validate metadata length before decoding

Florian Fainelli (5):
      net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems
      net: bcmgenet: initialize u64 stats seq counter for all queues
      net: bcmgenet: do not skip WoL power up on GENET V1
      net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
      net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

Florian Westphal (1):
      netfilter: nfnetlink_queue: hold nfnl mutex in event notifier

Fourie Zhang (1):
      net: bridge: mdb: restart port group walk after deletion

Gajdos Tamás (3):
      net: atl1c: fix soft lockup on out-of-range tpd_cons read
      net: atl1e: fix soft lockup on out-of-range hw_next_to_clean read
      net: atl1: fix soft lockup on out-of-range cmb_tpd_next_to_clean read

Gilberto Conde (1):
      net: usb: qmi_wwan: add Quectel EG120K-EA

Ginger Li (1):
      tipc: Fix a data race on mon->peer_cnt in mon_timeout()

Guangshuo Li (2):
      net: ena: fix PHC cleanup on probe failure
      net: ena: fix MMIO read buffer leak on probe failure

Haseeb Malik (1):
      macsec: initialize SecY before registering the netdevice

Heyang Tan (1):
      octeontx2-af: use seq_file for rsrc_alloc debugfs

Hui Peng (6):
      Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
      Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
      Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
      ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
      fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
      mctp: route: iterate socket tag list in mctp_lookup_prealloc_tag()

Ido Schimmel (1):
      vrf: Stop corrupting skb->csum when capturing CHECKSUM_COMPLETE packets

Ilya Maximets (6):
      net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
      net: openvswitch: conntrack: remove 'add_helper' dead code
      net: openvswitch: conntrack: fix helper UAF due to extensions realloc
      net/sched: act_ct: avoid modifying shared unconfirmed ct entry
      net/sched: act_ct: remove 'add_helper' dead code
      net/sched: act_ct: fix helper UAF due to extensions realloc

Ivan Delalande (1):
      tg3: use random MAC address when tg3_get_device_address fails

Ivan Vecera (1):
      dpll: use exact lookup for reference sync pin id

Jakub Kicinski (18):
      Merge branch 'net-mlx5-sd-lag-and-devcom-stability-fixes'
      Merge branch 'eth-fbnic-a-collection-of-fixes'
      Merge tag 'nf-26-09-18' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-net-2026-09-21' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      genetlink: report the real command id for dump-only ops in policy dumps
      selftests: net: nl_nlctrl: check the op ids in the policy map
      Merge branch 'net-mlx5-bridge-fix-remaining-switchdev-ownership-gaps-on-merged-eswitch'
      Merge branch 'packet-fix-packet_tx_ring-data-corruption-on-skb_orphan'
      Merge branch 'net-stmmac-more-selftest-related-fixes'
      veth: manage XDP program pointers during channel resize
      Merge branch 'net-bcmgenet-collection-of-bug-fixes'
      Merge tag 'nfc-7.3-rc5' of https://codeberg.org/linux-nfc/linux
      Merge branch 'net-dsa-mt7530-fix-two-crashes-on-driver-unbind'
      Merge tag 'ovpn-net-20260921' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'ovs-net-sched-fixes-for-uaf-after-conntrack-extension-realloc'
      Merge branch 'net-ena-fix-resource-cleanup-on-probe-failure'
      Merge branch 'gve-dqo-fix-handling-of-out-of-range-tso-mss'
      Merge branch 'vlan-ensure-sufficient-headroom-in-vlan_dev_hard_header'

Jamal Hadi Salim (4):
      net/sched: cls_u32: fix manual hash table handle IDR aliasing
      selftests/tc-testing: add u32 manual table handle IDR tests
      net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget
      selftests: tc-testing: add a lateral-drift hfsc classify-walk test

Jiawen Wu (1):
      net: libwx: fix races in Tx timestamp handling

Jonas Jelonek (1):
      net: mdio: realtek-rtl9300: fix RTL931x C22 extended page selection

Julian Anastasov (1):
      ipvs: revalidate ihl before icmp_send

Jérémy Jean (2):
      netfilter: flowtable: publish HW_DEAD after worker is done
      net: gue: reject invalid REMCSUM offsets

Karl Mehltretter (1):
      netfilter: nft_synproxy: use the family-aware checksum helper

Kuniyuki Iwashima (3):
      ip6_gre: Call ip6erspan_tunnel_unlink_md() in ip6erspan_changelink().
      ipv6: Prevent rt6_insert_exception() for dying fib6_info.
      ipv6: Fix dst leak for uncached routes.

Kyle Hendry (1):
      net: pcs: rzn1-miic: Fix config array initialization

Lee Jones (2):
      Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
      nfc: llcp: Fix race condition in accept_queue lifecycle

Lei Zhu (1):
      selftests: nci: Correct pthread_create return value check

Linkui Xiao (1):
      ipv4: fib: fix data-race and stale genid check around nh->nh_saddr

Lorenzo Bianconi (2):
      net: ethernet: mtk_eth_soc: unregister net_devices in case of probe failure
      net: stmmac: clear stale buf->page after recycling on skb build failure

Luxiao Xu (2):
      netfilter: ip6t_rt: fix zero-address non-strict match out-of-bounds read
      nfc: fix use-after-free in nfc_get_local_general_bytes

Maxime Chevallier (7):
      net: stmmac: selftests: Support running selftests on DSA conduits
      net: stmmac: selftests: Validate EEE based on the actual LPI timer value
      net: stmmac: selftests: Check the dev->features for S-TAG offload testing
      net: stmmac: selftests: Capture all packets for vlan checks
      net: stmmac: dwmac4: Use the correct bufzise when the len is exactly 8K
      net: stmmac: size the RX buffers from the frame length, not the MTU
      net: stmmac: selftests: Account for alignment shift on dwmac1000 for Jumbo test

Mina Almasry (1):
      net: devmem: document that bind-tx is unprivileged by design

Ming Wang (1):
      net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP whitelist

Muhammad Bilal (1):
      net: spacemit: clear TX descriptor on fragment mapping failure

Myeonghun Pak (4):
      tg3: clean up PHYLIB resources on probe failure
      nfc: trf7970a: power down on startup RX gain failure
      net: airoha: npu: cancel wdt_work after releasing the WDT IRQ
      bna: prevent IOC timer rearm during teardown

Naman Gulati (1):
      netfilter: ctnetlink: fix suspicious RCU usage in expect_iter_name

Nguyen Ngoc Thang (1):
      net/sched: act_ct: don't WARN on benign flow_offload_alloc() failure

Nicolai Buchwitz (3):
      net: don't require the hwtstamp NDOs when a PHY provides timestamping
      MAINTAINERS: add Nicolai Buchwitz as GENET maintainer
      net: bcmgenet: stop Tx NAPI before disabling the queues

Nicolo Giuliani (1):
      net: dsa: mv88e6xxx: 88E6191X and 88E6193X have no PTP

Norbert Szetei (2):
      ipv6: do not let ipv6_find_hdr() return an offset past the packet end
      net: xps: reject an out of range traffic class

Paolo Abeni (2):
      Merge branch 'udp-two-fixes-for-the-4-tuple-hash-table'
      Merge branch 'net-atl1c-atl1e-atl1-fix-soft-lockup-on-out-of-range-tx-consumer-index'

Pengpeng Hou (4):
      net: usb: sr9700: include receive overhead in the length check
      nfc: nfcmrvl: validate helper command length before pull
      nfc: st21nfca: validate received frame size
      nfc: st21nfca: validate ISO15693 inventory length

Quentin Armitage (1):
      net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset

Ralf Lici (12):
      net/mlx5e: advertise MACsec offload only when supported
      ovpn: preserve IPv6 scope id for netlink peer endpoints
      ovpn: skip UDP source validation for unspecified addresses
      ovpn: track UDP socket route key for peer dst cache
      ovpn: validate peer state before caching UDP dst
      ovpn: replace bind when learning local endpoint
      ovpn: replace bind when clearing stale local source
      ovpn: always unhash old VPN addresses before rehashing
      ovpn: reject duplicate peer VPN addresses
      ovpn: reject multipeer peers without VPN addresses
      ovpn: reject invalid peer VPN addresses
      selftests: ovpn: validate peer VPN addresses

Ratheesh Kannoth (1):
      octeontx2-af: Fix memory scaling limitation in SR-IOV mode

Ravindra (1):
      Bluetooth: btintel_pcie: validate device-supplied DMA indices

Sang-Hoon Choi (1):
      nfp: hold IPsec RX state under the XArray lock

Sanghyun Park (1):
      vxlan: use one headroom snapshot for neighbour replies

Shardul Bankar (2):
      udp: relocate a connected socket in the 4-tuple hash table on re-connect
      udp: remove a disconnected socket from the 4-tuple hash table

Shay Drory (3):
      net/mlx5: devcom, Base component size on linked devices
      net/mlx5: SD, unload reps on shared FDB create error path
      net/mlx5: LAG, reload IB reps of LAG master before the rest

Shihuang Liu (1):
      net: skbuff: fix pull-bound underflow in skb_checksum_setup_ipv6()

Sidraya Jayagond (1):
      net/smc: fix UAF on lgr list traversal in smcr_port_err()

Théo Lebrun (1):
      net: macb: fix dma_alloc_coherent() leak on macb_alloc() error paths

Victor Nogueira (1):
      net/sched: act_gate: budget the per-entry list in get_fill_size

Wei Wang (1):
      mailmap: add entry for Wei Wang

Weiming Shi (2):
      netfilter: ip6t_rpfilter: reject routes without inet6_dev
      net/sched: reject IDR error pointers when deleting actions

Wentao Liang (4):
      fsl/fman: Fix clk reference leak in read_dts_node()
      net: hisilicon: hns_dsaf_mac: fix mdio device leak in hns_mac_register_phy()
      net: usb: lan78xx: Fix URB reference leak in lan78xx_submit_deferred_urbs()
      net/mlx5: Fix rev_entry reference leak in mlx5_tc_ct_shared_counter_get()

Willem de Bruijn (3):
      virtio_net: copy zerocopy frags in start_xmit without NAPI
      packet: use ubuf_info completion for TX_RING packets
      tcp: prevent collapsing skbs across boundary in rtx queue

Xiang Mei (1):
      vlan: require the MAC header to be present in __vlan_insert_inner_tag()

Xin Long (1):
      sctp: hold asoc or transport before mod_timer() in timer handlers

Xuanqiang Luo (1):
      ip_gre: Reject enabling collect metadata through changelink

Yilin Zhang (1):
      tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()

Yiqi Sun (1):
      sctp: avoid livelock while updating retransmit path

Yuqi Xu (1):
      net: ipconfig: bound DHCP option construction

Yuya Kusakabe (2):
      selftests: net: fix CONFIG_SYSCTL sort order in configs
      net: ipv6: keep room for the mac header in dst_dev_overhead()

Zhang Yunfei (1):
      net: txgbe: fix FDIR filter restore for VF rules

Zijie Huang (1):
      net: arp: terminate device name before lookup

Zijun Hu (1):
      Bluetooth: btnxpuart: Fix skb leak in nxp_process_fw_dump()

Zixuan Chai (1):
      llc: reserve device headroom for allocated frames

bui duc phuc (1):
      net: ethernet: ti: netcp: fix pm_runtime usage counter leak on error

Ömer Mete Kaya (3):
      nfc: llcp: fix -ENOMEM on connect with zero-length service name
      nfc: llcp: fix WKS SAP hijacking via prefix match in nfc_llcp_wks_sap()
      nfc: llcp: fix slab-out-of-bounds reads when logging service names

 .mailmap                                           |   1 +
 Documentation/netlink/specs/netdev.yaml            |   2 +
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/btintel_pcie.c                   |  16 ++
 drivers/bluetooth/btnxpuart.c                      |   8 +-
 drivers/dpll/dpll_netlink.c                        |   3 +-
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/dsa/mt7530-mdio.c                      |  18 +-
 drivers/net/dsa/mt7530.c                           |   3 -
 drivers/net/dsa/mv88e6xxx/chip.c                   |  68 +++++++-
 drivers/net/ethernet/airoha/airoha_npu.c           |  18 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   2 +
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   3 +
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   3 +
 drivers/net/ethernet/atheros/atlx/atl1.c           |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   3 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  34 ++--
 drivers/net/ethernet/broadcom/tg3.c                |  15 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |  24 ++-
 drivers/net/ethernet/cadence/macb_main.c           |  14 +-
 drivers/net/ethernet/freescale/fman/fman.c         |   1 +
 drivers/net/ethernet/google/gve/gve_desc_dqo.h     |   5 +
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  40 ++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |   3 +
 drivers/net/ethernet/ibm/emac/core.c               |  16 +-
 drivers/net/ethernet/marvell/octeontx2/af/common.h |  45 ++++-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    | 104 ++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   6 +-
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |  45 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |   3 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   1 -
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |  15 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.h   |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  44 +++--
 .../ethernet/mellanox/mlx5/core/lag/shared_fdb.c   |   1 +
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   5 +
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |  16 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |  47 ++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |  18 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  30 +++-
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c  |   3 +-
 drivers/net/ethernet/sfc/efx.c                     |   4 +
 drivers/net/ethernet/spacemit/k1_emac.c            |   3 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   5 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  21 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c | 153 ++++++++++++----
 drivers/net/ethernet/ti/netcp_core.c               |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |  47 +++--
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c        | 144 ++++++++++-----
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   2 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c    |  13 +-
 drivers/net/macsec.c                               |  84 ++++-----
 drivers/net/mdio/mdio-realtek-rtl9300.c            |   6 +
 drivers/net/ovpn/netlink.c                         | 108 ++++++++++--
 drivers/net/ovpn/peer.c                            | 121 ++++++++++---
 drivers/net/ovpn/peer.h                            |  25 ++-
 drivers/net/ovpn/udp.c                             | 193 +++++++++++++++++----
 drivers/net/pcs/pcs-rzn1-miic.c                    |   3 +-
 drivers/net/pcs/pcs-xpcs.c                         |   4 +-
 drivers/net/phy/intel-xway.c                       |  29 +++-
 drivers/net/phy/micrel.c                           |   1 +
 drivers/net/phy/phylink.c                          |  20 ++-
 drivers/net/usb/catc.c                             |  15 +-
 drivers/net/usb/cdc_mbim.c                         |   5 +
 drivers/net/usb/lan78xx.c                          |   2 +
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/sr9700.c                           |   3 +-
 drivers/net/veth.c                                 |   2 +
 drivers/net/virtio_net.c                           |   9 +
 drivers/net/vrf.c                                  |   2 -
 drivers/net/vxlan/vxlan_core.c                     |   6 +-
 drivers/nfc/microread/microread.c                  |   6 +-
 drivers/nfc/nfcmrvl/fw_dnld.c                      |  11 +-
 drivers/nfc/pn533/pn533.c                          |  14 +-
 drivers/nfc/pn533/pn533.h                          |   4 +-
 drivers/nfc/pn533/usb.c                            |   4 +-
 drivers/nfc/pn544/pn544.c                          |   7 +-
 drivers/nfc/port100.c                              |   7 +
 drivers/nfc/st21nfca/core.c                        |  12 +-
 drivers/nfc/st21nfca/i2c.c                         |  29 ++--
 drivers/nfc/trf7970a.c                             |   4 +-
 drivers/nfc/virtual_ncidev.c                       |   3 +-
 include/linux/ethtool.h                            |   2 +
 include/linux/if_vlan.h                            |   3 +
 include/linux/skbuff.h                             |  19 +-
 include/net/dst.h                                  |   3 +-
 include/net/gue.h                                  |  19 +-
 include/net/ip6_route.h                            |   4 +-
 include/net/netfilter/nf_conntrack.h               |   5 +
 include/net/nfc/hci.h                              |   2 +-
 include/net/nfc/nfc.h                              |   3 +-
 include/net/tcp.h                                  |   4 +-
 net/8021q/vlan_dev.c                               |   5 +
 net/bluetooth/bnep/core.c                          |  17 +-
 net/bluetooth/bnep/netdev.c                        |   8 +-
 net/bluetooth/hci_conn.c                           |  14 +-
 net/bluetooth/hci_sock.c                           |  20 ++-
 net/bluetooth/iso.c                                |   7 +
 net/bluetooth/l2cap_core.c                         |  10 +-
 net/bluetooth/mgmt.c                               |  27 +--
 net/bluetooth/rfcomm/core.c                        |   3 +-
 net/bluetooth/rfcomm/sock.c                        |   6 +-
 net/bluetooth/smp.c                                |  17 ++
 net/bridge/br_mdb.c                                |   2 +
 net/bridge/br_stp_bpdu.c                           |   5 +-
 net/core/dev.c                                     |  49 ++++--
 net/core/dev.h                                     |   2 +
 net/core/dev_ioctl.c                               |  25 +--
 net/core/netdev-genl.c                             |   6 +
 net/core/skbuff.c                                  |  21 ++-
 net/ethtool/common.h                               |   2 +
 net/ipv4/arp.c                                     |   1 +
 net/ipv4/devinet.c                                 |   7 +-
 net/ipv4/fib_semantics.c                           |  13 +-
 net/ipv4/fou_core.c                                |   4 +
 net/ipv4/ip_gre.c                                  |  12 ++
 net/ipv4/ipconfig.c                                |  45 +++--
 net/ipv4/tcp_output.c                              |   3 +
 net/ipv4/udp.c                                     |  44 ++++-
 net/ipv6/exthdrs_core.c                            |   3 +
 net/ipv6/ip6_fib.c                                 |   2 +-
 net/ipv6/ip6_gre.c                                 |   2 +-
 net/ipv6/netfilter/ip6t_rpfilter.c                 |   2 +-
 net/ipv6/netfilter/ip6t_rt.c                       |  11 +-
 net/ipv6/route.c                                   |  12 +-
 net/ipv6/seg6.c                                    |   4 +-
 net/llc/llc_c_ac.c                                 |   2 +-
 net/llc/llc_s_ac.c                                 |   4 +
 net/llc/llc_sap.c                                  |   8 +-
 net/mctp/route.c                                   |   2 +-
 net/netfilter/ipvs/ip_vs_core.c                    |   6 +
 net/netfilter/nf_conntrack_netlink.c               |   3 +-
 net/netfilter/nf_flow_table_offload.c              |   7 +-
 net/netfilter/nf_tables_api.c                      |  10 +-
 net/netfilter/nfnetlink_queue.c                    |   8 +-
 net/netfilter/nft_synproxy.c                       |   3 +-
 net/netlink/genetlink.c                            |   8 +-
 net/nfc/core.c                                     |  15 +-
 net/nfc/digital_dep.c                              |   8 +-
 net/nfc/llcp.h                                     |   1 +
 net/nfc/llcp_commands.c                            |   2 +-
 net/nfc/llcp_core.c                                | 173 ++++++++++++------
 net/nfc/llcp_sock.c                                |  67 +++++--
 net/nfc/nci/core.c                                 |  10 +-
 net/nfc/netlink.c                                  |   7 +-
 net/nfc/nfc.h                                      |   3 +-
 net/openvswitch/conntrack.c                        |  37 ++--
 net/packet/af_packet.c                             | 104 ++++++-----
 net/rds/connection.c                               |   6 +
 net/rds/ib_frmr.c                                  |  11 +-
 net/sched/act_api.c                                |   2 +-
 net/sched/act_ct.c                                 |  44 +++--
 net/sched/act_gate.c                               |  30 +++-
 net/sched/act_ife.c                                |  17 +-
 net/sched/act_meta_mark.c                          |   6 +-
 net/sched/act_meta_skbprio.c                       |   6 +-
 net/sched/act_meta_skbtcindex.c                    |   6 +-
 net/sched/cls_u32.c                                |  12 +-
 net/sched/em_text.c                                |   2 +-
 net/sched/sch_hfsc.c                               |  22 +++
 net/sched/sch_teql.c                               |   7 +-
 net/sctp/associola.c                               |  15 +-
 net/sctp/input.c                                   |   7 +-
 net/sctp/sm_sideeffect.c                           |  37 ++--
 net/sctp/sm_statefuns.c                            |   2 +
 net/smc/smc_core.c                                 |   2 +
 net/smc/smc_ib.c                                   |  10 +-
 net/tipc/group.c                                   |   4 +-
 net/tipc/monitor.c                                 |   3 +-
 net/vmw_vsock/af_vsock.c                           |   3 +
 tools/testing/selftests/nci/nci_dev.c              |  45 +++--
 tools/testing/selftests/net/config                 |   2 +-
 tools/testing/selftests/net/nl_nlctrl.py           | 116 +++++++++++--
 tools/testing/selftests/net/ovpn/common.sh         |  13 ++
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |  54 ++++--
 tools/testing/selftests/net/ovpn/test.sh           |  75 +++++++-
 tools/testing/selftests/net/packetdrill/config     |   2 +-
 .../selftests/tc-testing/tc-tests/filters/u32.json |  48 +++++
 .../selftests/tc-testing/tc-tests/qdiscs/hfsc.json |  34 ++++
 188 files changed, 2569 insertions(+), 889 deletions(-)
