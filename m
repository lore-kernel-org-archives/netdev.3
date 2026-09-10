Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB05335B6;
	Thu, 10 Sep 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058993; cv=none; b=H15/Z/C/034eWicg5YWynHeqr3WGZCQRMnTT2cZ0BEKLyD0Y/JCYkFMhcM2gYS/T8FWgcAWzy1kmtRqYKpYEH8k2Q4FUW1Eu+kVcZg5284dgsF5id9U2+Lv3x5C8Et9rStx/oGDkghCoCx69Y7o9OivwLsroDNOEEVSd5RDDurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058993; c=relaxed/simple;
	bh=TWbRHTr8bnJ0vItmaZXiZF4h+NJvuh+2o4Ov6JnIEu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VV1yPsh57uxlG3pGuwqMo7I1CAPevKd6l81AuXdN0kE0dbWc3VayFIxVSuCuC8Rbg2dBcqF6Co0AIXWxTWFn/0PAYHi22Mc1XI3DCZjNk719U0Gf7Eu2Cc1bsF54aTwRdtqFvTCU07A/TkQ2Crwq/+shBvzTIMLMtR/AmiO2yP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXCCleAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXCCleAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBADF1F00893;
	Thu, 10 Sep 2026 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058989;
	bh=R4DSYFENVX7lENkubv0a3SQEae19adBd9+egcTMS/Mg=;
	h=From:To:Cc:Subject:Date;
	b=eXCCleAcjY8IRRxVmjg33FIQmVRtLgcl26AMsvJ6Mh8rveBqPWdGr4N0Pfr04ktej
	 NUpWUGnBhRi3kxcUz7dPJ38/6TSmshyik21PnV1Chbq2UXGHx6zJkRl+LndBEMXGq+
	 QvinzW8HKg3b3MHARy4oiofdrMVAwEWwZTx1lvB3Ogty+diC+eH8sfYeLA9Zx0uNF4
	 11QwxIheu85jw0g1goeg/jljIbe7g541+C17kbk13PeAX8J0ATbqRg4ppcGcSRY/7v
	 Fwl+JNvsJO/h1W3GyaY80GK3PPrkh1mKCprGPPFbUrapSfF1of0UzmAT4jdbajwhwP
	 k+e4AsTFADY9g==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.3-rc3
Date: Thu, 10 Sep 2026 09:49:48 -0700
Message-ID: <20260910164948.2123565-1-kuba@kernel.org>
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

The following changes since commit adf50c47a47f0f0f0b79dd58ffade9919cddebea:

  Merge tag 'net-7.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-09-03 10:18:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc3

for you to fetch changes up to 5096947508b750bd4a65a8e61bd2083a44d61bfd:

  Merge branch 'net-sched-fix-action-batch-failure-cleanup' (2026-09-10 09:06:08 -0700)

----------------------------------------------------------------
Nothing too exciting, usual stream of fixes.
Including fixes from Netfilter, Bluetooth and WPAN.

Current release - new code bugs:

 - Bluetooth: hci_sync: fix not setting CE length properly

 - eth: enic: match mailbox replies to request numbers

Previous releases - regressions:

 - tunnels: drop stale dst when building an ICMP error for PMTUD

 - ipv6: null-check fib6_node before accessing in __ip6_del_rt_siblings()
   (bug in the rtnl_lock -> RCU conversion)

 - eth: bnxt_en: fix crashes on Thor2 due to OOB coalescing buffer accesses

 - eth: bnxt_en: prevent queue stop with deferred completions

Previous releases - always broken:

 - eth: ice: don't dereference pointers from TP_printk()

 - eth: fix OOB writes on ethtool flow rule dump in 3 drivers

 - eth: mlx5: fix FEC configuration with RS_544_514_INTERLEAVED_QUAD

 - dsa: tag_brcm: legacy FCS: request needed tailroom

Misc:

 - net: cap tx_queue_len at S16_MAX to prevent oversized ring alloc

 - ipv6: flowlabel: cap duplicate leases per socket

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aamir Ahmed (1):
      net: hinic: fix mailbox segment buffer overflow

Akiva Goldberger (1):
      net/mlx5: LAG, use local tracker to update active ports

Aleksei Sviridkin (5):
      net: macb: zero the link settings taprio reads back
      net: macb: reject an unknown link speed in the taprio setup
      net: phylink: initialise link_state before a forced major config
      net: dsa: mt7530: populate lpi_interfaces to fix EEE support
      net: ethernet: mtk_eth_soc: populate lpi_interfaces to fix EEE support

Alexandra Winter (2):
      dibs: Unregister dibs_class after error
      s390/ism: folio_put() after error

Alice Mikityanska (4):
      net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
      net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
      selftests: net: Test UDP length overflow with PMTU discover and big MTU
      net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

Carolina Jubran (4):
      net/mlx5e: Fix ETS zero BW reporting when one TC holds 100%
      net/mlx5e: Fix use-after-free race in sample_restore_put()
      net/mlx5e: Keep HW timestamp stats monotonic across reconfiguration
      net/mlx5e: Move representor vnic reporter to eswitch devlink port

Chengfeng Ye (2):
      netfilter: cttimeout: prevent UAF during module unload
      netfilter: nf_log: unregister loggers before per-net teardown

Chenguang Zhao (1):
      net: 6lowpan: fix mismatched comments

David Carlier (1):
      ieee802154: hwsim: serialize pib updates to fix double-free

Donggeun Yoo (2):
      net: phy: dp83867: handle the active-high LED polarity mode
      net: phy: dp83td510: handle the active-high LED polarity mode

Eelco Chaudron (1):
      openvswitch: fix wrong flag value in get_ipv6_ext_hdrs()

Eric Dumazet (2):
      bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()
      vxlan: initialize _md in vxlan_xmit_one()

Faicker Mo (1):
      net: net_failover: Fix the deadlock in net_failover_slave_name_change()

Fan Wu (1):
      ieee802154: cc2520: fix FIFOP work use-after-free

Florian Westphal (3):
      netfilter: nfnetlink_log: cope with concurrent instance destruction
      netfilter: arp_tables: remove the 32bit compat interface
      netfilter: ip6_tables: set F_PROTO when proto value is nonzero

Fourie Zhang (1):
      net: mpls: clear inner_protocol when the last label is popped

Gang Yan (1):
      selftests: mptcp: fix an UAF in mptcp_connect.c

Greg Marsden (1):
      net/rds: fix tcp stream corruption with large pages

Ibrahim Hashimov (1):
      mac802154: fix use-after-free of sdata via queued RX frames

Ido Schimmel (2):
      tunnels: Drop stale dst when building an ICMP error for PMTUD
      nexthop: Initialize extack in remove_nh_grp_entry()

Ilya Maximets (1):
      netfilter: report NLM_F_DUMP_FILTERED when all is filtered out

Ivan Hu (1):
      Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware

Jacob Keller (1):
      ice: add missing xa_destroy for sched_node_ids

Jakub Kicinski (22):
      Merge branch 'net-bcmasp-fix-tx-ring-accounting-bugs'
      Merge branch 'enic-fix-v2-vf-mailbox-reply-matching-and-carrier-reopen'
      Merge tag 'ieee802154-for-net-2026-09-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan
      net: dsa: bcm_sf2: bound the CFP rule dump by the caller's buffer size
      eth: nfp: bound the ntuple rule dump by the caller's buffer size
      eth: nfp: drop the replaced rule from the list when reprogramming fails
      net: dsa: mv88e6xxx: bound the policy rule dump by the caller's buffer size
      ethtool: document that GRXCLSRLALL rule_cnt is a caller-provided limit
      Merge branch 'eth-fix-bugs-in-ntuple-filter-reporting'
      Merge branch 'net-cap-tx_queue_len-at-s16_max-to-prevent-oversized-ring-allocations'
      Merge branch 'pds_core-fixes-for-the-pci-reset-path'
      Merge branch 'net-mlx5e-rs-fec-variant-fixes'
      Merge branch 'net-sched-clamp-quantum-psched_mtu-in-change-paths'
      Merge branch 'af_unix-minor-fixes-for-msg_oob-and-msg_peek'
      Merge branch 'fix-udp-length-overflow-in-edge-cases'
      eth: ice: don't dereference pointers from TP_printk()
      Merge tag 'nf-26-09-07' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'net-macb-fix-two-probe-path-leaks'
      Merge tag 'for-net-2026-09-08' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'mptcp-misc-fixes-for-v7-3-rc1'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-sched-fix-action-batch-failure-cleanup'

Jamal Hadi Salim (12):
      net: cap tx_queue_len at S16_MAX to prevent oversized ring allocations
      net: reject oversized tx_queue_len at netlink parse time
      selftests: tc-testing: add tx_queue_len cap regression tests
      net/sched: fq: clamp quantum and initial_quantum in change path
      net/sched: fq_pie: clamp quantum in change path
      net/sched: sfq: clamp quantum in change path
      net/sched: hhf: clamp quantum in change and init paths
      net/sched: dualpi2: clamp psched_mtu at all call sites
      net/sched: pie: clamp psched_mtu in pie_drop_early
      net/sched: drr: clamp quantum in change class
      net/sched: ets: clamp quantum in parse and fallback paths
      selftests: tc-testing: update ETS test 41f5 for clamped quanta

Jan Havran (Advantech Czech) (1):
      net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value

Jason Winter (1):
      net: usb: cx82310_eth: drop URB after 0xffff reboot sentinel to prevent partial_data heap overflow

Jiajia Liu (2):
      Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
      Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset

Joas Antonio dos Santos (1):
      netfilter: nf_conntrack_sip: fix OOB read in sip_skip_whitespace()

Joe Damato (7):
      bnxt_en: Prevent queue stop with deferred completions
      bnxt_en: Only restore LRO if the device supports TPA
      bnxt_en: Don't free the live ring's TPA state on queue restart failure
      bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
      bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
      bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
      bnxt_en: Bound SW TPA IDs to prevent crashes

Johan Hovold (1):
      net: hso: fix TIOCMIWAIT race

Joshua Hay (1):
      idpf: account for VLAN header when parsing RSC packet header

Justin Chen (2):
      net: bcmasp: clear txcb->last before writing each descriptor
      net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times

Kalpan Jani (1):
      mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

Karl Mehltretter (1):
      MAINTAINERS: Update the so_txtime selftest path in SOCKET TIMESTAMPING

Kiran K (2):
      Bluetooth: btintel_pcie: validate packet_len before skb_put_data
      Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one

Krystian Kaniewski (1):
      Bluetooth: hci_sysfs: Fix NULL pointer dereference in device_del()

Kuniyuki Iwashima (4):
      af_unix: Update last skb marker in manage_oob().
      af_unix: Return immediately when manage_oob() returns NULL for 0-length buffer.
      selftest: af_unix: Add zero-buffer test for msg_oob.c
      net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().

Kyle Zeng (2):
      ipvs: reject invalid states in connection template sync records
      ipvs: fix reversed sequence option serialization

Lama Kayal (1):
      net/mlx5: E-Switch, prevent mc_list repopulation during vport disable

Li Youhong (1):
      net: sun4i-emac: fix missing of_node_put() for phy_node

Linus Walleij (5):
      net: ethernet: cortina: Fix budget accounting
      net: ethernet: cortina: Finish RX updates before NAPI completion
      net: ethernet: cortina: Count dropped frames as NAPI work
      net: ethernet: cortina: Count RX drops once per frame
      net: ethernet: cortina: Count RX descriptors for freeq refill

Long Li (2):
      net: mana: Clear RDMA teardown and suspend state in mana_rdma_probe()
      net: mana: restore the XDP program pointer when pre-allocation fails

Lorenzo Bianconi (3):
      mailmap: add entries for Lorenzo Bianconi
      net: stmmac: initialize ptp_lock at probe time
      net: stmmac: fix TX descriptor availability check for TSO traffic

Luiz Augusto von Dentz (2):
      Bluetooth: btusb: Fix UAF of btusb_data by rx_work
      Bluetooth: hci_sync: Fix not setting CE length properly

MD Danish Anwar (1):
      net: hsr: enable promiscuous mode on interlink port with fwd offload

Marek Vasut (1):
      net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down

Matthieu Baerts (NGI0) (7):
      mptcp: subflow: no need to copy thmac during ulp_clone
      mptcp: syncookies: remember the request backup flag
      mptcp: options: handle MPC data + csum reqd + no csum
      mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
      selftests: mptcp: lib: dump nstat for the right test
      selftests: mptcp: lib: get counters for the right test
      mptcp: options: fix uninit-value in mptcp_write_data_fin

Myeonghun Pak (2):
      idpf: disable DIM work before freeing q_vectors
      idpf: disable PTM on probe failure and on remove

Nagamani PV (1):
      s390/qeth: allow bridgeport queries despite OS_MISMATCH

Naman Gulati (1):
      ipv6: null-check fib6_node before accessing in __ip6_del_rt_siblings()

Nicolai Buchwitz (2):
      net: macb: destroy the phylink instance on the probe error path
      net: macb: put the "mdio" child node reference on success

Nikhil P. Rao (3):
      ionic: use netif_txq_maybe_stop() in ionic_tx()
      pds_core: fix cmd_regs access racing BAR unmap on reset
      pds_core: don't release PCI regions for VFs on reset

Nikolay Aleksandrov (1):
      net: bridge: mcast: properly convert mglist to rcu

Norbert Szetei (1):
      net: openvswitch: fix use-after-free of the flow table mask array

Paolo Abeni (10):
      Merge branch 'fix-a-variety-of-tpa-bugs'
      Merge branch 'net-macb-fix-the-link-speed-the-taprio-setup-reads'
      Merge branch 'net-ethernet-cortina-fix-rx-budget-accounting'
      mptcp: do not reschedule the RTX timer for fallback sockets
      mptcp: prevent race between disconnect() and rtx
      mptcp: remove unneeded READ_ONCE() annotation
      mptcp: being below memory limit is a likely() condition
      mptcp: avoid pruning for OoW data
      Merge branch 'net-sched-cls_route-fix-bucket-retention-and-handle-recomputation'
      Merge branch 'net-restore-eee-on-mediatek-switches-and-soc-macs'

Pavel Begunkov (1):
      tcp: reject non zerocopy devmem tx

Qing Luo (1):
      mptcp: pm: userspace: fix address ID overflow

Qingfang Deng (1):
      ppp_synctty: ensure a writeable skb header

Ratheesh Kannoth (2):
      octeontx2-pf: reset HTB scheduler topology before freeing queues
      octeontx2-af: fix PF/CGX debugfs PCI bus lookup

Rong Zhang (2):
      Bluetooth: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
      Bluetooth: btrtl: Don't leak return code when parsing firmware format v2

Runyu Xiao (1):
      net: macb: initialize PTP state before registering clock

Sahil Chandna (1):
      net: mana: Reserve extra CQ slot for the fence completion CQE

Satish Kharat (2):
      enic: preserve V2 VF carrier across netdev reopen
      enic: match mailbox replies to request numbers

Sebastian Sjoholm (1):
      net: usb: qmi_wwan: add Quectel RG660QB

Seungwon Bae (1):
      vxlan: reject dynamic fdb entries that reference a nexthop id

Shahar Shitrit (3):
      net/mlx5e: Fix missing FEC mode mapping for RS_544_514_INTERLEAVED_QUAD
      net/mlx5e: Fix setting RS FEC after remapping
      net/mlx5e: Fix reporting support for all RS FEC variants

Taylor Bates (1):
      mlxsw: spectrum_ptp: Fix napi_gro_receive() call from GC workqueue context

Victor Nogueira (4):
      net/sched: cls_route: free emptied bucket on filter move
      net/sched: cls_route: Reject handle aliasing
      net/sched: cls_route: Fix in-place replace
      selftests/tc-testing: Add cls_route bucket move and change tests

Vineeth Karumanchi (1):
      net: macb: fix NULL pointer dereference on unbind with fixed-link

Viswajith Murali (1):
      octeontx2-af: mcs: Clear stale X2P calibration state before calibration

Vladislav Karmanov (1):
      net: phy: mediatek-ge: disable EEE on the MT7530 PHY

Vlatko Kosturjak (1):
      ppp_async: drop the errored frame instead of resetting its headroom

Weiming Shi (2):
      net/sched: defer qdisc freeing after failed creation
      net: dsa: tag_brcm: legacy FCS: request needed tailroom

XingWang Xiang (2):
      genetlink: pin family module during policy dump
      net: mctp: i3c: serialize probe with bus removal

Xu Rao (1):
      Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing hci_dev

Xuanqiang Luo (2):
      net/sched: act_api: release all action references on NEWACTION failure
      selftests: tc-testing: test action batch failure cleanup

Yael Chemla (1):
      net/mlx5: E-Switch: fix use-after-free in mlx5_eswitch_termtbl_put

Yilin Zhang (1):
      inet: frags: invalidate queues before flushing them

Zhiling Zou (3):
      ieee802154: 6lowpan: fix NULL dereference in lowpan_newlink
      ipv6: flowlabel: cap duplicate leases per socket
      net: bridge: use option bits for CFM/MRP frame handlers

Zihan Xi (3):
      ipv4: fib: bound automatic table ID allocation
      ipv6: fix fib6 walker UAF on seq stop
      ipmr: account multicast table and route memory

 .mailmap                                           |   3 +
 Documentation/netlink/specs/rt-link.yaml           |   2 +
 MAINTAINERS                                        |   2 +-
 drivers/bluetooth/btintel_pcie.c                   |   6 +-
 drivers/bluetooth/btmtk.c                          |  11 +-
 drivers/bluetooth/btmtk.h                          |   1 +
 drivers/bluetooth/btqcomsmd.c                      |   6 +-
 drivers/bluetooth/btrtl.c                          |   5 +-
 drivers/bluetooth/btusb.c                          | 105 ++++-
 drivers/dibs/dibs_main.c                           |  10 +-
 drivers/net/bonding/bond_alb.c                     |  19 +-
 drivers/net/dsa/bcm_sf2_cfp.c                      |   2 +
 drivers/net/dsa/lantiq/lantiq_gswip.h              |   2 +-
 drivers/net/dsa/mt7530.c                           |  16 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  16 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c        |   2 +
 drivers/net/ethernet/amd/pds_core/fw.c             |  10 +-
 drivers/net/ethernet/amd/pds_core/main.c           |  10 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  99 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c      |  21 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h      |   6 +-
 drivers/net/ethernet/cadence/macb_main.c           |  24 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |   5 +-
 drivers/net/ethernet/cisco/enic/enic.h             |  26 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |  25 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c        | 321 ++++++++------
 drivers/net/ethernet/cisco/enic/enic_mbox.h        |   2 +
 drivers/net/ethernet/cortina/gemini.c              |  77 ++--
 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   9 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |   4 +-
 drivers/net/ethernet/intel/ice/ice_trace.h         |  64 ++-
 drivers/net/ethernet/intel/ice/ice_type.h          |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |   5 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  34 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c    |  10 +
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  10 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |  60 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  18 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c  |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/port.h  |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/tc/sample.c |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  52 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.h   |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  51 +--
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |  37 ++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   1 +
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  19 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |  34 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |   8 +-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  24 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |  19 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  32 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   1 -
 drivers/net/ieee802154/cc2520.c                    |   5 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |  10 +-
 drivers/net/mctp/mctp-i3c.c                        |   9 +-
 drivers/net/net_failover.c                         |   2 +-
 drivers/net/phy/dp83867.c                          |   3 +
 drivers/net/phy/dp83td510.c                        |   3 +
 drivers/net/phy/mediatek/mtk-ge.c                  |  29 ++
 drivers/net/phy/phylink.c                          |   2 +
 drivers/net/ppp/ppp_async.c                        |   7 +-
 drivers/net/ppp/ppp_synctty.c                      |  14 +-
 drivers/net/usb/cx82310_eth.c                      |   1 +
 drivers/net/usb/hso.c                              |   2 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/vxlan/vxlan_core.c                     |  13 +-
 drivers/s390/net/ism_drv.c                         |   4 +-
 drivers/s390/net/qeth_l2.h                         |   3 +-
 drivers/s390/net/qeth_l2_main.c                    |  26 +-
 drivers/s390/net/qeth_l2_sys.c                     |   7 +-
 include/linux/ethtool.h                            |   6 +
 include/linux/netfilter_arp/arp_tables.h           |  19 -
 include/net/cfg802154.h                            |   1 +
 include/net/ip6_route.h                            |   2 +
 include/net/sch_generic.h                          |   2 +-
 net/6lowpan/nhc.h                                  |   3 +-
 net/bluetooth/hci_sync.c                           |  38 +-
 net/bluetooth/hci_sysfs.c                          |  17 +-
 net/bridge/br_cfm.c                                |  11 +-
 net/bridge/br_device.c                             |   1 -
 net/bridge/br_input.c                              |  35 +-
 net/bridge/br_mrp.c                                |  13 +-
 net/bridge/br_multicast.c                          |   9 +-
 net/bridge/br_private.h                            |  26 +-
 net/core/dev.c                                     |   2 +-
 net/core/rtnetlink.c                               |   7 +-
 net/core/skbuff.c                                  |   7 +
 net/dsa/tag_brcm.c                                 |   1 +
 net/hsr/hsr_slave.c                                |  11 +-
 net/ieee802154/6lowpan/core.c                      |   2 +-
 net/ipv4/fib_rules.c                               |   4 +-
 net/ipv4/inet_fragment.c                           |   6 +
 net/ipv4/ip_output.c                               |   1 +
 net/ipv4/ip_tunnel_core.c                          |   6 +
 net/ipv4/ipmr.c                                    |   3 +-
 net/ipv4/ipmr_base.c                               |   2 +-
 net/ipv4/netfilter/arp_tables.c                    | 472 +--------------------
 net/ipv4/nexthop.c                                 |   2 +-
 net/ipv4/tcp.c                                     |   3 +-
 net/ipv6/ip6_fib.c                                 |   4 +-
 net/ipv6/ip6_flowlabel.c                           |  19 +
 net/ipv6/ip6_output.c                              |   2 +
 net/ipv6/ip6mr.c                                   |   2 +-
 net/ipv6/netfilter/ip6_tables.c                    |   5 +
 net/ipv6/route.c                                   |   9 +-
 net/mac802154/ieee802154_i.h                       |   8 +
 net/mac802154/iface.c                              |   6 +
 net/mac802154/main.c                               |   1 +
 net/mac802154/rx.c                                 | 120 +++++-
 net/mac802154/scan.c                               |  10 +-
 net/mptcp/options.c                                |   8 +-
 net/mptcp/pm.c                                     |   2 +-
 net/mptcp/pm_kernel.c                              |   8 +
 net/mptcp/pm_userspace.c                           |  18 +-
 net/mptcp/protocol.c                               |  41 +-
 net/mptcp/protocol.h                               |   1 +
 net/mptcp/subflow.c                                |   1 -
 net/mptcp/syncookies.c                             |   5 +-
 net/netfilter/Kconfig                              |   2 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |  20 +-
 net/netfilter/nf_conntrack_netlink.c               |   2 +
 net/netfilter/nf_conntrack_sip.c                   |   2 +-
 net/netfilter/nf_log_syslog.c                      |   2 +-
 net/netfilter/nfnetlink_cttimeout.c                |   2 +-
 net/netfilter/nfnetlink_log.c                      |  15 +-
 net/netlink/genetlink.c                            |  21 +-
 net/openvswitch/flow.c                             |   4 +-
 net/openvswitch/flow_table.c                       |   4 +-
 net/rds/message.c                                  |   4 +-
 net/sched/act_api.c                                |   9 +-
 net/sched/cls_api.c                                |   2 +-
 net/sched/cls_route.c                              |  76 ++--
 net/sched/sch_api.c                                |   2 +-
 net/sched/sch_drr.c                                |   3 +-
 net/sched/sch_dualpi2.c                            |  10 +-
 net/sched/sch_ets.c                                |  12 +-
 net/sched/sch_fq.c                                 |  14 +-
 net/sched/sch_fq_pie.c                             |   3 +-
 net/sched/sch_generic.c                            |  24 +-
 net/sched/sch_hhf.c                                |   8 +-
 net/sched/sch_pie.c                                |   2 +-
 net/sched/sch_sfq.c                                |   7 +-
 net/unix/af_unix.c                                 |  12 +-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/af_unix/msg_oob.c      |  67 +++
 tools/testing/selftests/net/cork_fragsize.py       | 187 ++++++++
 tools/testing/selftests/net/fib_nexthops.sh        |  28 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  26 +-
 tools/testing/selftests/net/pmtu.sh                |   2 +-
 .../tc-testing/tc-tests/actions/gact-rollback.json |  78 ++++
 .../tc-testing/tc-tests/filters/route.json         | 210 +++++++++
 .../selftests/tc-testing/tc-tests/qdiscs/ets.json  |   4 +-
 .../tc-testing/tc-tests/qdiscs/pfifo_fast.json     | 204 +++++++++
 165 files changed, 2378 insertions(+), 1232 deletions(-)
 create mode 100755 tools/testing/selftests/net/cork_fragsize.py
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions/gact-rollback.json
