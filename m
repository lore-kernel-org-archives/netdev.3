Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBF3CB2D5;
	Thu,  8 Oct 2026 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487375; cv=none; b=d384AxzRfGyrYzLQw5ZVb/K5afaMtsHyJ3pFFcjCQahi5lrKgvlXdiHrc/FunDkJGF11QiFCDfbfpZJDWf9bs+YJhewXxjDBXIKGYBeLjUUliwDzFvxejXnih6VdnwE1w+TSqyFafihV9MpQgxpFcwcCBRGbqgmtON92yYt1DLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487375; c=relaxed/simple;
	bh=fIuSRGKUAikRdOYKGw8qem/1TYW3UMyYJRVbAVnasgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eIkAcuq3H2uyZF7TKx36yAPmv9DkOMZ8dulAHg2fneORzaI6ZFiZRcZ9zh3UjxvS5c/jsZ1yD31aRoeBR0Tfb9GYTUSOG6gQNqrg+R26tjZs9lTjY+q1I8hBFpzddszKGQbY+78Fc15+nW6IAnODg+GETBxt6Lzjds9UXV+wemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfiB1hHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfiB1hHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940041F000FF;
	Thu,  8 Oct 2026 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791487373;
	bh=CMTU46wfX55CPEHJu/18xWfK3y6eLr2C4LDeiKiZeQ0=;
	h=From:To:Cc:Subject:Date;
	b=HfiB1hHOomGQyj/8EnOiANamuYKUSCYI4XUu2S0DAwCvnNRFp30BpEVWOyj10vIJz
	 trRLNiTLEn3HjNa1RPiGDYHuoqa13aGTh1NFBEQENkFKRcFHNGc4wmmDZJM7xlRMIR
	 34e8dLzs2XtM+f9NSJbig20gMbpAlOmUoV+b11UTnGnKO+jplauA0b1CgrHeY+uXOM
	 xH4RR9YucNOr/UomaAG47WxQ1IFgSto2O4ImPda5RCIYev7ItWMykFbz8oSAXKFKMC
	 4R32hiYQTmy869UzuzZEH/QCq0apr9Wcf6JiF83Fkke97jO9A25tx8nluVIp+kQGil
	 qpDLTpYlyhYnQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.3-rc7
Date: Thu,  8 Oct 2026 12:22:53 -0700
Message-ID: <20261008192253.574195-1-kuba@kernel.org>
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

Hope LPC is going well & wish I was there.

Pretty sure you won't be impressed by the size of this PR
but this is after we shaved off 50 fixes to net-next and
asked sub-trees to significantly trim their PRs.
Situation is what it is.

The following changes since commit d24e8ac715de2e16a53c144005b1863660a5fbea:

  Merge tag 'net-7.3-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-01 06:41:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc7

for you to fetch changes up to 37f12441f557468a56c1e27790413aa78c82afa2:

  Merge branch 'net-macb-fix-software-fcs-handling-of-shared-and-requeued-skbs' (2026-10-08 11:48:54 -0700)

----------------------------------------------------------------
Including fixes from wireless, wireguard, CAN and Bluetooth.
We have one known regression to wrap up in VLAN handling.

Current release - regressions:

 - Bluetooth: RFCOMM: fix deadlock on rfcomm_mutex

Previous releases - regressions:

 - can: fix regression in handling RPS after migrating metadata to skb_ext

 - eth: iavf: fix regressions in reconfig impacting bonding

 - eth: mana: fix packet forwarding performance regression

 - eth: stmmac: remove buggy VLAN acceleration support

Previous releases - always broken:

 - a few high prio fixes for tun, and af_packet

 - amt: fix a UaF on tunnel teardown

 - eth: bnxt: fix PCIe AER recovery and FLR handling issues

 - eth: macb: don't modify Tx skbs before taking ownership

 - eth: axienet: don't leak Tx skbs on interface stop

 - wifi: nxpwifi: number of LLM-ish fixes

 - wifi: assorted mt76 fixes

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaron Ma (1):
      wifi: mt76: mt7925: restore the legacy BSS after MLO teardown

Aldo Ariel Panzardo (1):
      Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()

Bryan Fraschetti (1):
      ice: Restore Ordered MMIO Writes for Tx Doorbells

Chengfeng Ye (6):
      tipc: hold a reference to nodes found by link name
      Bluetooth: hci_sock: Serialize dead-device detachment
      Bluetooth: hci_sync: Fix command skb lifetime during scan setup
      Bluetooth: ISO: Reject concurrent BIS listener setup
      Bluetooth: ISO: Serialize concurrent connect calls
      net/smc: protect clcsock lifetime in smc_getname

Cristian Papa (1):
      wifi: mt76: mt7603: initialize global station WCID

Daehyeon Ko (9):
      tcp: reject net_iov in zerocopy receive mapping hints
      ip6_gre: remove obsolete ERSPAN PMTU update
      vsock/virtio: account only unread bytes in read_skb()
      ipv4: stop PMTU walk when nexthop group shrinks
      ipv4: stop exception dump when nexthop group shrinks
      ipv4: stop route notification sizing when nexthop group shrinks
      cipso: adjust cached option offsets when removing CIPSO
      ipv4: do not warn on route notification size race
      ipv6: do not warn on route notification size race

Daniel Machon (1):
      net: sparx5: free the matchall entry on destroy

David Carlier (2):
      wifi: nxpwifi: fix inverted check in Tx BA stream entry deletion
      wifi: nxpwifi: do not delete Rx reorder entries under RCU

David S. Miller (1):
      Merge branch 'dim-overflow' Shashank Mohan Jain says:

Denis V. Lunev (1):
      openvswitch: fix soft lockup in the netlink flow dump

Devin Wittmayer (2):
      wifi: mt76: mt7925: don't put the band auto marker in TGID
      wifi: mt76: mt792x: pick the SAR table layout from the table itself

Eric Dumazet (6):
      ipv4: free inet_opt and ireq_opt after an RCU grace period
      flow_dissector: avoid u16 truncation of skb->len when computing thoff
      net: always dissect GSO packets in __virtio_net_hdr_to_skb()
      selftests: net: tun: add test for VLAN-tagged GSO without NEEDS_CSUM
      bnxt_en: fix DMA mapping length for padded small packets
      flow_dissector: avoid u16 truncation of hlen in bpf_flow_dissect()

Felix Fietkau (4):
      wifi: mt76: mt7996: program a link again if the driver holds it
      wifi: mt76: mt7996: take over connection monitoring
      wifi: mt76: account non-AQL frames per peer rather than per link
      wifi: mt76: use ALTX queue for packets to disassociated stations

Fernando Fernandez Mancera (1):
      net: openvswitch: validate transport header presence in set_ipv6_addr

Frank Li (1):
      net: allwinner: remove dmaengine_desc_free()

François Roux (1):
      wifi: mac80211: don't estimate airtime for unsupported rate widths

Fredrik Nyberg (1):
      net: usb: ax88179_178a: fix rx frame length for non-last packets

Haishuang Yan (3):
      devlink: fix devlink_rel reference leak when notify work is pending
      pfcp: make sure the SEID is linear before reading it
      bareudp: set the inner protocol to the protocol of the packet

Hamza Mahfooz (1):
      net: mana: reserve RX buffer headroom to fix forwarding performance

Hui Peng (1):
      sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute

Iaroslav Voitovych (1):
      Bluetooth: MGMT: Fix status of pending commands flushed on power off

Ilia Gavrilov (1):
      vsock: Fix memory leak in vmci_transport_recv_dgram_cb()

Jakub Kicinski (21):
      Merge branch 'ibmveth-fix-open-fail-unwind-after-lan-registration'
      Merge branch 'amt-send-the-relay-s-general-query-directly-from-the-receive-path'
      bonding: fix the program leak when XDP is replaced
      Merge branch 'intel-wired-lan-driver-updates-2026-09-28-idpf-ice-iavf'
      net: make dev_xdp_sb_prog_count() see programs attached through a link
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-stmmac-fix-double-vlan-802-1ad-tag-handling'
      Merge branch 'gve-various-xdp-fixes'
      Revert "net: stmmac: propagate PTP addend and system time programming errors"
      Merge branch 'net-always-dissect-gso-packets-in-__virtio_net_hdr_to_skb'
      Merge branch 'ipv4-handle-nexthop-group-shrink-races'
      Merge branch 'net-team-fix-transmit-skb-ownership'
      Merge tag 'for-net-2026-10-05' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'linux-can-fixes-for-7.3-20261001' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'wireless-2026-10-07' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'bnxt_en-pcie-flr-aer-fixes'
      Merge branch 'veth-fix-peer-netdev_xdp_act_ndo_xmit-after-gro-is-toggled-while-down'
      Merge branch 'mlxsw-fix-port-range-register-leak'
      Merge branch 'ipv4-ipv6-do-not-warn-on-route-notification-size-races'
      Merge branch 'wireguard-fixes-for-7-3-rc7'
      Merge branch 'net-macb-fix-software-fcs-handling-of-shared-and-requeued-skbs'

Jamal Hadi Salim (1):
      net/sched: em_text: reject unterminated algo before autoload

Jason A. Donenfeld (1):
      wireguard: noise: reject response consumption after intermediate initiation

Ji-Ze Hong (Peter Hong) (1):
      usb: f81604: fix struct f81604_int_data size mismatch

Johannes Berg (4):
      Merge tag 'mt76-fixes-2026-10-05' of https://github.com/nbd168/wireless
      Merge tag 'nxpwifi-fixes-20261006-v2' of https://github.com/nxp-upstream/nxpwifi-next
      Merge tag 'ath-current-20261006' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Revert "wifi: libertas: reject short monitor TX frames"

Jose Ignacio Tornos Martinez (3):
      i40e: skip unnecessary VF reset when setting trust
      iavf: send MAC change request synchronously
      ice: skip unnecessary VF reset when setting trust

Josef Bacik (3):
      net: skbuff: don't leave stale bytes in skb_copy_and_csum_bits()
      xen/netfront: drop RX packets with a short Ethernet header
      xen/netfront: don't leak the skb when xennet_fill_frags() fails

Joshua Washington (3):
      gve: fix XSK buffer leak when rings are stopped
      gve: fix XSK buffer leak on error descriptor
      gve: fix napi_disable deadlock when attempting to disable XSK pools

Junjie Cao (1):
      wifi: mt76: mt792x: treat 0xff ACPI SAR entries as no limit

Justin Chen (1):
      net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET

Leto Liu (刘涛) (1):
      net: airoha: Add retry mechanism to airoha_qdma_set_trtcm_param()

Li RongQing (1):
      net/mlx5e: Order ICOSQ cc update after CQ doorbell

Linmao Li (7):
      wifi: nxpwifi: protect sta_list against concurrent add and delete
      wifi: nxpwifi: delete the station entry on the uAP deauth event
      wifi: nxpwifi: wait for the wakeup timer before the adapter is freed
      wifi: nxpwifi: free the aggregation buffer when the RA list disappears
      wifi: nxpwifi: zero the channel statistics array
      wifi: nxpwifi: fix the authentication frame length handling
      wifi: nxpwifi: handle authentication frame allocation failures

Lorenzo Bianconi (1):
      net: stmmac: propagate PTP addend and system time programming errors

Lu Huang (1):
      wifi: mt76: mt7996: fix uninitialized buf read in mt7996_variant_fem_init()

Maxim Skokov (1):
      Bluetooth: RFCOMM: free the skb when the DLC has no owner

Michael Chan (2):
      bnxt_en: Add bnxt_clear_bars() helper
      bnxt_en: Fix driver init in kdump kernel

Michael S. Tsirkin (1):
      ipv4: validate checksum_start before completing checksum

Michele Dionisio (1):
      wifi: brcmfmac: fix P2P device removal race in brcmf_detach()

Mikhail Gavrilov (1):
      Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex

Mingming Cao (2):
      ibmveth: h_free logical LAN on open-fail after register
      ibmveth: fix TX LTB and filter unwind on open-fail

Nicolai Buchwitz (2):
      net: macb: check TX ring before modifying skb
      net: macb: copy shared skbs before appending the FCS

Nicolas Cavallari (1):
      wifi: mt76: mt7915: disable rx napi when removing device

Oliver Hartkopp (1):
      can: fix unique skb identifier regression under RPS

Omar Ramadan (2):
      amt: send the relay's General Query directly from the receive path
      selftests: net: amt: check that the relay's queries bypass the amt device

Or Har-Toov (2):
      net/mlx5: Lag, split aggregate speed into oper and max helpers
      Revert "net/mlx5: E-Switch, preserve max tx speed on vport state modification"

Ovidiu Panait (5):
      net: stmmac: Remove VLAN perfect matching dead code
      net: stmmac: Stop toggling the EDVLP bit
      net: stmmac: Rename double VLAN references to svlan
      net: stmmac: Do not advertise S-VLAN stripping when it is disabled
      net: stmmac: Disable S-Tag processing on dwmac4

Palla Raghunath (1):
      Bluetooth: RFCOMM: Fix NULL tty_dev dereference in rfcomm_dev_shutdown

Pavan Chebbi (1):
      bnxt_en: Re-write the BARs following any type of PCIe errors

Petr Machata (2):
      mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()
      selftests: mlxsw: Test port range occupancy on template create

Quchaosheng (1):
      net/packet: guard the ll header push in packet_rcv_spkt()

Quentin Freimanis (1):
      net: sparx5: start the TOD counters on non-PTP lan969x variants

Ramses de Norre (1):
      wireguard: queueing: preserve tstamp_type when encapsulating packet

Ravindra (1):
      Bluetooth: btintel_pcie: fix TX descriptor bounds check

Runyu Xiao (1):
      Bluetooth: btintel_pcie: use managed IRQ teardown

Sabrina Dubroca (1):
      strparser: make sure __strp_recv isn't running before tearing down the parser

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: Add shared HW reset for clean start

Sang-Hoon Choi (1):
      cxgb4/ch_ktls: disable softirqs around tid_list erases

Sebastien Royen (1):
      net: dsa: microchip: fix KSZ8765 fiber detection

Shashank Mohan Jain (2):
      lib/dim: fix 32-bit overflow in dim_calc_stats() rates
      lib/dim: add KUnit test for dim_calc_stats()

Suraj Gupta (1):
      net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop

Tao Gong (1):
      wifi: mt76: mt7996: fix struct mt7996_mcu_wed_rro_ba_delete_event layout

Tianyi Gao (2):
      veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO is toggled while down
      selftests: net: veth: test peer ndo-xmit after GRO toggle while down

Tony Nguyen (1):
      e1000e: add system to disable K1 list

Tristan Madani (1):
      ice: fix metadata_dst refcount handling on representor teardown

Vadim Fedorenko (1):
      ptp: ocp: fix PCIe delay estimation calculation

Victor Nogueira (2):
      net/sched: cls_route: reject change with no routing attribute
      selftests: tc-testing: add cls_route no-routing-attribute change tests

Weiming Shi (2):
      net: team: stop reusing skb after queue override
      net: team: free skb when broadcast has no txable port

Willem de Bruijn (1):
      net/packet: call packet_parse_headers after virtio_net_hdr_to_skb

Xuanqiang Luo (1):
      ice: fix use-after-free in dynamic port cleanup

Yingying Tang (1):
      Revert "wifi: ath12k: add panic handler"

Yuqi Xu (1):
      tipc: destroy topsrv workqueues before closing connections

Zixuan Chai (1):
      net: bridge: avoid recursive multicast port cleanup

zjamg (1):
      can: dev: init_can_skb(): restore skb header initialization

 Documentation/networking/strparser.rst             |   2 +-
 arch/um/drivers/vector_transports.c                |   1 +
 drivers/bluetooth/btintel_pcie.c                   |  17 +-
 drivers/net/amt.c                                  |  48 ++---
 drivers/net/bareudp.c                              |   3 +-
 drivers/net/bonding/bond_main.c                    |   8 +-
 drivers/net/can/dev/skb.c                          |   4 +
 drivers/net/can/usb/f81604.c                       |   2 +-
 drivers/net/can/vxcan.c                            |   3 +
 drivers/net/dsa/microchip/ksz_common.h             |   2 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |  32 +++-
 drivers/net/ethernet/airoha/airoha_eth.h           |   2 +
 drivers/net/ethernet/allwinner/sun4i-emac.c        |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 199 +++++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   1 -
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  11 ++
 drivers/net/ethernet/cadence/macb_main.c           |  80 +++++----
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c      |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   8 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  13 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |  22 +--
 drivers/net/ethernet/intel/e1000e/netdev.c         |   7 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  35 ++--
 drivers/net/ethernet/intel/iavf/iavf.h             |  11 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  85 +++++++--
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  99 ++++++++--
 drivers/net/ethernet/intel/ice/devlink/port.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  32 +++-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   6 +-
 .../ethernet/mellanox/mlx5/core/esw/adj_vport.c    |  20 ---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  79 +++++---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  24 ---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   2 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_flower.c  |   9 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  28 +--
 .../ethernet/microchip/sparx5/sparx5_tc_matchall.c |   1 +
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   8 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  63 +++++--
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |  10 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  60 +++----
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |  30 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |  65 ++-----
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |   7 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  53 ++++--
 drivers/net/pfcp.c                                 |   7 +
 drivers/net/team/team_core.c                       |  16 +-
 drivers/net/team/team_mode_broadcast.c             |   2 +
 drivers/net/tun.c                                  |  23 ++-
 drivers/net/usb/ax88179_178a.c                     |   6 +-
 drivers/net/veth.c                                 |   1 +
 drivers/net/virtio_net.c                           |   2 +
 drivers/net/wireguard/noise.c                      |   7 +-
 drivers/net/wireguard/queueing.h                   |   2 +
 drivers/net/wireless/ath/ath12k/core.c             |  33 +---
 drivers/net/wireless/ath/ath12k/core.h             |   3 -
 drivers/net/wireless/ath/ath12k/hif.h              |   9 -
 drivers/net/wireless/ath/ath12k/pci.c              |   8 -
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  27 ++-
 drivers/net/wireless/marvell/libertas/tx.c         |   7 -
 drivers/net/wireless/mediatek/mt76/mt76.h          |   7 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   6 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  12 ++
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   | 134 +++++++++-----
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   3 +
 drivers/net/wireless/mediatek/mt76/tx.c            |  14 +-
 drivers/net/wireless/nxp/nxpwifi/11n.c             |   2 +-
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c        |   1 +
 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c   |  11 +-
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c        |  31 +++-
 drivers/net/wireless/nxp/nxpwifi/init.c            |   2 +-
 drivers/net/wireless/nxp/nxpwifi/main.c            |   4 +-
 drivers/net/wireless/nxp/nxpwifi/uap_event.c       |   1 +
 drivers/net/wireless/nxp/nxpwifi/util.c            |   8 +-
 drivers/net/xen-netfront.c                         |  16 +-
 drivers/ptp/ptp_ocp.c                              |   2 +-
 include/linux/can/core.h                           |   3 +-
 include/linux/can/skb.h                            |   4 +-
 include/linux/virtio_net.h                         |  64 +++----
 include/net/amt.h                                  |   4 -
 include/net/bluetooth/rfcomm.h                     |   1 +
 include/net/can.h                                  |   2 +
 include/net/ip.h                                   |   7 +
 include/net/mana/mana.h                            |  14 +-
 include/net/strparser.h                            |  10 +-
 lib/Kconfig.debug                                  |  15 ++
 lib/dim/Makefile                                   |   2 +
 lib/dim/dim.c                                      |  10 +-
 lib/dim/dim_kunit.c                                | 126 +++++++++++++
 net/bluetooth/hci_core.c                           |   4 +
 net/bluetooth/hci_sock.c                           |   2 +
 net/bluetooth/hci_sync.c                           |  10 +-
 net/bluetooth/iso.c                                |  52 ++++--
 net/bluetooth/mgmt.c                               |   2 +-
 net/bluetooth/rfcomm/core.c                        | 134 ++++++++++----
 net/bluetooth/rfcomm/sock.c                        |   5 +-
 net/bluetooth/rfcomm/tty.c                         |   2 +-
 net/bluetooth/sco.c                                |  87 ++++++---
 net/bridge/br_multicast.c                          |  23 ++-
 net/bridge/netfilter/nf_conntrack_bridge.c         |  10 +-
 net/can/af_can.c                                   |  47 +++--
 net/can/gw.c                                       |   3 +
 net/can/isotp.c                                    |  16 +-
 net/can/raw.c                                      |  10 +-
 net/core/dev.c                                     |  11 +-
 net/core/flow_dissector.c                          |  11 +-
 net/core/skbuff.c                                  |   6 +-
 net/devlink/core.c                                 |  10 +-
 net/ipv4/af_inet.c                                 |   2 +-
 net/ipv4/cipso_ipv4.c                              |   8 +
 net/ipv4/fib_semantics.c                           |   3 +
 net/ipv4/fib_trie.c                                |   2 -
 net/ipv4/ip_output.c                               |  10 +-
 net/ipv4/route.c                                   |   5 +
 net/ipv4/tcp.c                                     |   2 +
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv6/ip6_gre.c                                 |   7 -
 net/ipv6/route.c                                   |   2 -
 net/mac80211/airtime.c                             |  18 ++
 net/netfilter/nfnetlink_queue.c                    |   7 +
 net/netfilter/xt_CHECKSUM.c                        |   6 +-
 net/openvswitch/actions.c                          |   7 +-
 net/openvswitch/datapath.c                         |   8 +
 net/packet/af_packet.c                             |  28 +--
 net/sched/cls_route.c                              |   6 +
 net/sched/em_text.c                                |   3 +
 net/sctp/socket.c                                  |   6 +-
 net/smc/af_smc.c                                   |   7 +-
 net/strparser/strparser.c                          |   6 +-
 net/tipc/node.c                                    |  10 +-
 net/tipc/topsrv.c                                  |  80 +++++++--
 net/vmw_vsock/af_vsock.c                           |   2 +
 net/vmw_vsock/virtio_transport_common.c            |   4 +-
 net/xfrm/xfrm_output.c                             |  16 +-
 .../selftests/drivers/net/mlxsw/port_range_occ.sh  |  26 +++
 tools/testing/selftests/net/amt.sh                 |  29 +++
 tools/testing/selftests/net/tun.c                  | 136 ++++++++++++++
 tools/testing/selftests/net/veth.sh                |  46 +++++
 .../tc-testing/tc-tests/filters/route.json         |  46 +++++
 149 files changed, 2074 insertions(+), 824 deletions(-)
 create mode 100644 lib/dim/dim_kunit.c
