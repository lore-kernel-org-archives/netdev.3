Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F486367297;
	Tue, 18 Aug 2026 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088573; cv=none; b=XFDR5J8TEqVBl9BxroZm3M4SDi+8nla6O/S5EGdmBC4gF7nMUmI176a7DKT/DrOhSgBgZ2whg+4gRyz0BM6TNAMCiVsB2IFl7Oheo/9K0SXSUvVlhmC2CNhR0fwxxtIo3IAkUEtkCdgvhSxj9iv+v2Pa5TyXxCMt9XjwwgnR6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088573; c=relaxed/simple;
	bh=5RaFm7xk+85FJ42M/lDQpp/sL+1rToYdQ9VP1LMkqwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ir6vP0owlQ+zO/dixTqVaMzNdEB4piW01NwlRES/u0CDg3DYjxopdeHIwx4cyqWTY87TBnuaDZRLM5Y+gA5X1U+LEaWB5LXT9f6wJnIt+uVU7NqwEPUaC751v9aPY/wlxPrr9n6EC34lM9McqNOS/JckR+kGQ2KZAtIgPoz+cyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnypdpib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnypdpib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FEA1F000E9;
	Tue, 18 Aug 2026 21:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787088564;
	bh=E2V740xkuudyA9jF22WZ8Hkx6CRt5blDoUZknmCDP7k=;
	h=From:To:Cc:Subject:Date;
	b=MnypdpiblpVfUifPYqCq+zOjsZNG284Rqw26iySLIMc2QfMC4WceKt40KSPhDYY6L
	 UhxIVENQe7WKj3B2b7sWBPY33mlt5R34uDxdwXHg9z6iYL+/JUW6rfRwP0kaL3g4D2
	 c6oP8BCaypzUS3fnudKV7mnxOyY8to21EGA2Q/LmFfZqdKD6VmP8Sa/Qv/62852jqx
	 2348Holdr/ASDCfTd43+iR0/Oxa5HRiKkuiYdJc5XaREq/2IAVgCc7W74arBiTrK8v
	 w40mhXE7XPjCRLlFP09ODK20CXPGajHIKZELlxbl2p81clNZxl72CHebGDFgq41oUm
	 ncOm4Xlb1HXUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for 7.3
Date: Tue, 18 Aug 2026 14:29:23 -0700
Message-ID: <20260818212923.2725202-1-kuba@kernel.org>
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

One of the "small improvements all over the place" releases for us.
It's hard to draw any direct comparisons because summer vacations
disrupted our patch processing (and presumably - generation) quite
a bit.

Quick and dirty count suggests we (Paolo and I) merged a very similar
number of net (632) and net-next (648) patches. This is not telling
the full story either because 1/3 to 1/2 of the net-next patches also
*seem* like AI-driven low priority fixes, cleanups and clarifications.

We are completely overwhelmed, of course. The glimmer of hope is that
we secured sufficient LLM budget and access (thank you Meta!) to run
reviews with multiple frontier models on each patch. This eliminates
some hallucinations. That said, in terms of review, the LLMs can only
do so much. The sad truth is that our APIs (especially for rare events
like PCIe errors, timeouts etc.) have always been racy, and now LLMs
don't let us ignore that. I expect our direction for the next release
will be to tweak the reviews a little bit more, but start shifting
focus to letting the LLMs take care of the busy work - managing
patchwork, automating common process complaints, editing commit
messages, and maybe applying patches which already got "reviewed-by"
tags from people we trust...

Enough blabber. Returning to this PR - you will see these conflicts:
 - trivial in MAINTAINERS, remove EHEA
 - trivial in include/linux/pci_ids.h, keep both
 - wifi/mt76 - keep the lockdep and the comment, rest it obvious
   https://lore.kernel.org/aoMaGJ1GcPZOoT_i@sirena.org.uk

The following changes since commit 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40:

  Revert "wifi: mt76: Disable napi when removing device" (2026-08-13 09:00:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.3

for you to fetch changes up to 61eb236c41c2a4717015dff18016a75a5eb90052:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-08-18 10:42:41 -0700)

----------------------------------------------------------------
Networking changes for 7.3.

Core & protocols
----------------

 - A few steps lowering rtnl_lock dependence:
   - per-netns netdev unregistration for select SW drivers
     (e.g. veth, ipvlan, tunnels)
   - rtnl_lock-less FIB rule changes (RTM_NEWRULE and RTM_DELRULE)
   - prepare software drivers and TC qdiscs for rtnl_lock-less GET

 - Support BIG TCP (>64kB TSO) in UDP tunnels (vxlan, geneve).

 - Support buffers larger than PAGE_SIZE in devmem zero-copy API.

 - Improve MPTCP handling of extreme memory pressure handling,
   when out-of-order queue had to be pruned.

 - Report the per-group user count via RTM_GETMULTICAST.

 - Expose the route deletion reason in RTM_DELROUTE.

 - Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
   handling of LSM denials when receiving SCM_RIGHTS messages: instead
   of truncating the message at the first blocked fd, keep every fd slot
   and store the LSM errno in the blocked slot.

 - IPv6 Segment Routing - support looking up the post-encap SID
   (address) in a different/specified routing table.

 - Support PRP RedBox (interlink) creation.

 - Support per-nexthop UDP dst port in VXLAN.

 - Continue converting getsockopt callbacks in a number of protocols
   to iov_iter.

Ethernet
--------

 - Marge initial CXL support for AMD/Solarflare NICs (shared branch
   with the CXL tree).

 - New drivers:
   - ADIN1140 10BASE-T1S MACPHY
   - Initial skeleton of Intel iXD and ZTE Dinghai drivers.

 - High-speed NICs:
   - AMD/Pensando:
     - support firmware flashing
   - Cisco (enic):
     - SR-IOV V2 admin channel and MBOX protocol
   - Huawei (hns3):
     - support for ethtool pfc_prevention_tout
   - nVidia/Mellanox:
     - support sharing bandwidth control across interfaces of
       the same device
   - Marvell (octeontx2-pf):
     - link RQ page pools to netdev for Netlink stats
   - Google vNIC:
     - XDP metadata support for DQ RDA
   - Microsoft vNIC:
     - support forcing full-page RX buffers

 - Other NICs:
   - Synopsys IP:
     - eic7700: support for eth1
   - Microchip (lan743x):
     - support for RMII interface
   - Wangxun:
     - support for ethtool -G and -C for VFs
     - add Tx timeout and PCIe error handling
   - Intel (igb/igc):
     - RSS key get/set support
     - support for forcing link speed without auto-negotiation

 - Switches:
   - NXP (dpaa2):
     - support bonding/LAG offload
   - Mediatek:
     - mt7530: EN7528 support
     - initial support for MT7628
   - Micrel (ksz8/9):
     - refactoring work to move towards library model
     - PTP support for KSZ8463
   - nVidia/Mellanox:
     - support rtnl-lock-less ethtool callbacks
   - Realtek:
     - rtl8366rb: use generic RTL83xx code
     - support SGMII and HSGMII for RTL8367S

 - PHYs:
   - Airoha:
     - EcoNet EN7528 PHY support
   - DAPU Telecom
     - DAPU Telecom DAP8211R(I) Gigabit PHY support
   - Realtek:
     - support RTL8261C_CG
     - support RTL8261D

Wireless
--------

 - nl80211: per-link statistics support for multi-link operation

 - mac80211: AQL/airtime-fairness support for multicast

 - Merge Peripheral Authentication Service (PAS) / TEE support
   for ath12k (shared branch with the firmware/qcom tree).

 - New drivers:
   - mm81x for Morse Micro Long-Range S1G devices
   - nxpwifi for NXP devices (mostly forked off from mwifiex)

 - Driver changes:
   - Broadcom (brcmfmac):
     - DPP support, some Cypress part update
   - MediaTek (mt76):
     - mt7928 support
     - mt7925 NAN support
     - mt7996 AP powersave improvements
   - Qualcomm (ath12k):
     - much kernel infrastructure integration work
     - AHB platform MultiPD support
   - Realtek (rt89):
     - LED support
     - RTL8922DE support
     - dual-BT coex for RTL8922D
   - Intel:
     - new FW version support

Bluetooth
---------

 - HCI: add support for Shorter Connection Interval (SCI) feature.

 - af_bluetooth: add minimal context analysis annotations.

 - Driver changes:
   - Intel:
     - add Bluetooth SAR revision 2 support
     - add vendor_reset PCI sysfs for PLDR
   - Mediatek:
     - add USB IDs for MT7902 and MT7922 devices
   - Realtek:
     - add USB IDs for 8761CU and 8852BE devices
   - NXP:
     - add M.2 Bluetooth device support using pwrseq

Misc
----

 - DPLL support for manual/numerical oscillator control (NCO)
   (implement in zl3073x).

 - MCTP support for MCTP over USB v1.1 (DMTF DSP0283).

 - Power-over-Ethernet: support Realtek PSE controllers.

 - Remove the IBM EHEA driver.

 - Remove tulip/xircom_cb driver.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaradhana Sahu (10):
      wifi: ath12k: remove unused QMI definitions
      wifi: ath12k: expand UserPD ID mask to support up to 8 PDs
      wifi: ath12k: correct monitor destination ring size
      wifi: ath12k: add QMI capability negotiation for dynamic memory mode
      wifi: ath12k: update IPQ5332 BDF address offset
      wifi: ath12k: switch to name-based reserved memory lookup
      wifi: ath12k: refactor QMI memory assignment
      wifi: ath12k: allocate HOST_DDR and BDF regions after Q6 RO region
      wifi: ath12k: add AHB platform descriptor support
      wifi: ath12k: Share RootPD state across UserPDs to avoid duplicate operations

Abdifatah Suruur (1):
      ptp: vmclock: prevent read-only mappings from becoming writable

Abdun Nihaal (6):
      bnx2x: fix null pointer dereference in bnx2x_free_mem_bp()
      wifi: rtlwifi: rtl8192du: Fix possible memory leak in rtl92du_init_sw_vars()
      wifi: rtlwifi: pci: fix error path in rtl_pci_probe()
      wifi: rtw88: Fix potential memory leak in rtw_txq_push_skb()
      net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
      wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()

Aditya Garg (3):
      net: mana: Add debug knob to skip TX timeout recovery reset
      net: mana: Route ring-buffer access through offset-based helpers
      net: mana: Fall back to scattered pages for GDMA queues

Ahmad Fatoum (1):
      net: dsa: realtek: use gpiod_set_value_cansleep for reset GPIO

Ahmed Naseef (4):
      dt-bindings: net: dsa: mediatek,mt7530: add econet,en7528-switch
      net: dsa: mt7530: add EN7528 support
      wifi: mt76: mt7603: add 0x7592 EEPROM chip ID
      net: phy: mediatek: add EcoNet EN7528 PHY support

Aishwarya R (1):
      wifi: ath12k: reset REOQ LUT addresses before firmware stop

Alejandro Lucero (7):
      cxl: Support Type2 cxl regs mapping
      cxl: Support dpa without a mailbox
      sfc: add cxl support
      sfc: Map cxl regs
      sfc: Initialize cxl dpa
      sfc: obtain and map cxl range using devm_cxl_probe_mem
      sfc: support pio mapping based on cxl

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for HORACO copper SFP+ module

Aleksandr Nogikh (1):
      usb: atm: cxacru: properly kill rcv_urb on error in cxacru_cm()

Alessio Faina (1):
      selftests/net: Skip srv6_end_dt46_l3vpn_test if iproute2 too old

Alex Elder (2):
      net: stmmac: use dma_addr_t for DMA addresses
      net: stmmac: convert DMA address to lower 32 before assignment

Alexander Wilhelm (1):
      wifi: ath12k: fix scan command endianness on big endian

Ali Ahmet Memis (5):
      Bluetooth: MGMT: reject HCI_CMD_SYNC params_len above 255
      Bluetooth: ISO: do not force BT_LISTEN after a failed BIG sync
      Bluetooth: ISO: zero the sockaddr before returning it in getname
      Bluetooth: MSFT: validate evt_prefix_len against the response length
      Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

Alice Mikityanska (10):
      net: Use helpers to get/set UDP len tree-wide
      net: Enable BIG TCP with partial GSO
      udp: Support BIG TCP GSO packets where they can occur
      udp: Support gro_ipv4_max_size > 65536
      udp: Validate UDP length in udp_gro_receive
      udp: Set length in UDP header to 0 for big GSO packets
      vxlan: Enable BIG TCP packets
      geneve: Enable BIG TCP packets
      selftests: net: Add a test for BIG TCP in UDP tunnels
      selftests: net: Add a missing config option

Allison Henderson (3):
      net/rds: don't use unpin_user_pages_dirty_lock() from atomic context
      net/rds: unpin MR pages with unpin_user_pages_dirty_lock()
      net/rds: clear i_rx_lat_trace in rds_inc_path_init()

Amritha Nambiar (1):
      ixd: add devlink support

Anand Khoje (1):
      net/ionic: avoid OOB TX partner lookup for hwstamp RXQ

Anas Khan (1):
      wifi: p54: update stale wireless wiki URLs

Andrea Mayer (2):
      seg6: add FIB table attribute for post-encap SID route lookup
      selftests: seg6: add test for post-encap SID route lookup

Anirudh Srinivasan (2):
      PCI: Move Spacemit vendor and device IDs to linux/pci_ids.h
      wifi: rtw89: pci: enable 36-bit DMA on spacemit K3

Anton Danilov (2):
      udp: fix encapsulation packet resubmit in multicast deliver
      selftests: net: add FOU multicast encapsulation resubmit test

Anton Protopopov (1):
      virtio_net: Fix resize of the RX ring

Arend van Spriel (13):
      wifi: cfg80211: pre-assign cookie for driver callbacks
      wifi: mac80211: stop using ieee80211_mgmt_tx_cookie()
      wifi: ath6kl: use pre-assigned cookie for remain_on_channel and mgmt_tx
      wifi: wil6210: use pre-assigned cookie for remain_on_channel, mgmt_tx and probe_peer
      wifi: brcmfmac: use pre-assigned cookie for remain_on_channel and mgmt_tx
      wifi: mwifiex: use pre-assigned cookie for remain_on_channel and mgmt_tx
      wifi: wilc1000: use pre-assigned cookie for remain_on_channel and mgmt_tx
      wifi: nxpwifi: use pre-assigned cookie for remain_on_channel and mgmt_tx
      wifi: qtnfmac: use pre-assigned cookie for mgmt_tx
      wifi: rtl8723bs: use pre-assigned cookie for mgmt_tx
      wifi: cfg80211: convert cookie output to input parameter
      wifi: cfg80211: convert tx_control_port cookie to input parameter
      wifi: nl80211: send frame tx status event only for non-zero cookie

Arnd Bergmann (1):
      net: replace linux/gpio.h inclusions

Arseniy Krasnov (1):
      vsock/virtio: rewrite MSG_ZEROCOPY flag handling

Artem Lytkin (1):
      rtnetlink: cap IFLA_VFINFO_LIST at a documented number of VFs

Artem Shimko (3):
      dt-bindings: vendor-prefixes: add Guangdong Dapu Telecom Co., Ltd.
      dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
      net: phy: add DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY driver

Asim Viladi Oglu Manizada (1):
      net: tun: bound receive headroom

Avi Weiss (1):
      et131x: propagate EEPROM readiness errors

Avinash Bhatt (1):
      wifi: iwlwifi: fw: move SAR defines from acpi.h to regulatory.h

Avraham Stern (4):
      wifi: iwlwifi: mld: support aborting an ongoing ftm request
      wifi: iwlwifi: mei: check SAP message length before reading it
      wifi: iwlwifi: mei: skip data read if length is too short
      wifi: iwlwifi: mei: pass correct argument to function

Ayala Beker (1):
      wifi: iwlwifi: mld: drop connection on D3 resume failure

Baochen Qiang (3):
      wifi: ath12k: fix dp_link_peer dangling references on AP vdev rollback
      wifi: ath12k: fix MLO peer delete race
      wifi: ath11k: cap out-of-range rx MCS instead of leaving bogus rate

Bastien Curutchet (Schneider Electric) (18):
      net: dsa: microchip: make ksz_is_port_mac_global_usable() static
      net: dsa: microchip: move ksz88xx stats handling in ksz8.c
      net: dsa: microchip: move ksz_get_gbit() and ksz_get_xmii() to ksz9477.c
      net: dsa: microchip: move KSZ9477 errata handling to ksz9477.c
      net: dsa: microchip: handle KSZ8-specific tc setup in ksz8.c
      net: dsa: microchip: move ksz9477_set_default_prio_queue_mapping() to ksz9477.c
      net: dsa: microchip: rename ksz9477_drive_strength_write()
      net: dsa: microchip: move the drive strength config out of the common section
      net: dsa: microchip: implement ksz8463_setup()
      net: dsa: microchip: split ksz8_config_cpu_port()
      net: dsa: microchip: allow the use of other IRQ operations.
      net: dsa: microchip: add PTP interrupt handling for KSZ8463
      net: dsa: microchip: adapt port offset for KSZ8463's PTP register
      net: dsa: tag_ksz: move the KSZ8795 tag handling below ksz_xmit_timestamp()
      net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations
      net: dsa: microchip: add KSZ8463 tail tag handling
      net: dsa: microchip: explicitly enable detection of L2 PTP frames
      net: dsa: microchip: add two-steps PTP support for KSZ8463

Baul Lee (1):
      vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()

Ben Greear (1):
      wifi: iwlwifi: Clean dangling pointer in tx path

Bence Csokas (1):
      wanxl: Remove pci_map_single_debug()

Bitterblue Smith (2):
      wifi: rtw88: 8822c: Don't process RF path C in query_phy_status_page{0,1}
      wifi: rtw88: 8822b: Don't process RF path C in query_phy_status_page1

Bitterblue Smith (S.E.A. Datentechnik GmbH) (1):
      wifi: rtw88: Enable receiving control frames in monitor mode

Bobby Eshleman (4):
      selftests: drv-net: enable devmem TCP in the test config
      net: devmem: allow rx-page-size > PAGE_SIZE per dmabuf binding
      selftests/net: ncdevmem: add -b option to set rx-page-size on bind
      selftests/net: devmem.py: add check_rx_large_niov

Breno Leitao (35):
      netconsole: do not warn when the best-effort skb allocation fails
      netpoll: do not warn when the best-effort pool refill fails
      net: add sockopt_init_user() for getsockopt conversion
      udp: convert udp_lib_getsockopt to sockopt_t
      ipv4: raw: convert do_raw_getsockopt to sockopt_t
      selftests: net: getsockopt_iter: add raw ICMP_FILTER coverage
      netconsole: clean up released targets dropped before the cleanup worker
      netpoll: export refill_skbs(), refill_skbs_work_handler(), skb_pool_flush()
      netconsole: take over skb pool lifecycle from netpoll
      netconsole: move refill_skbs_work_handler() from netpoll
      netconsole: move refill_skbs() and skb-pool sizing macros from netpoll
      netconsole: move local_port / remote_port from struct netpoll to netconsole_target
      netconsole: move skb_pool_flush() from netpoll
      netconsole: move remote_mac from struct netpoll to netconsole_target
      netconsole: move skb_pool / refill_wq from struct netpoll to netconsole_target
      netpoll: export carrier_timeout via netpoll_get_carrier_timeout()
      netpoll: export the netpoll_setup() helpers for netconsole
      netconsole: take over netpoll_setup() from netpoll
      netconsole: move netpoll_local_ip_unset() as netcons_local_ip_unset()
      netconsole: move netpoll_take_ipv4() as netcons_take_ipv4()
      netconsole: move netpoll_take_ipv6() as netcons_take_ipv6()
      netconsole: move egress_dev() as netcons_egress_dev()
      netconsole: move local_ip/remote_ip/ipv6 to netconsole_target
      netconsole: move netpoll_wait_carrier() as netcons_wait_carrier()
      ipv6: raw: drop unused level argument from do_rawv6_getsockopt
      ipv6: raw: convert do_rawv6_getsockopt to sockopt_t
      ieee802154: convert dgram getsockopt to sockopt_t
      phonet: pep: do not write beyond optlen in getsockopt
      phonet: pep: convert getsockopt to sockopt_t
      tls: convert getsockopt to sockopt_t
      selftests: net: getsockopt_iter: cover rawv6 and tls
      nfc: llcp: avoid userspace overflow on invalid optlen
      nfc: llcp: read llcp_sock->local under the socket lock in getsockopt
      netconsole: publish the userdata payload with RCU
      selftests: netconsole: add a userdata torture test

Brett Creeley (4):
      pds_core: add support for quiet devcmd failures
      pds_core: add support for identity version 2
      pds_core: add PLDM firmware update support via devlink flash
      pds_core: add PLDM component info display

Brian Grech (1):
      selftests/net: fin_ack_lat: fix latency threshold typo

Bryam Vargas (6):
      wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
      wifi: mt76: mt7996: bound the device EEPROM address before the EFUSE copy
      nfc: nci: add data_len bound checks to activation parameter extractors
      nfc: fdp: bound the device-reported read length and fix an skb leak
      net/smc: unregister the connection before draining the rx tasklet
      net/smc: do not dereference an unset send buffer on the SMC-D teardown path

Can Peng (3):
      wifi: brcmfmac: validate msgbuf flowring IDs before use
      wifi: brcmfmac: Set DMA direction for msgbuf packet IDs
      netxen: unregister notifiers if PCI registration fails

Carlos Grillet (1):
      netfilter: replace u_int8_t and u_int16t with u8 and u16

Cen Zhang (2):
      wifi: mac80211_hwsim: clean up radio rhashtable on free
      wifi: mac80211_hwsim: avoid NULL skb in stop queue drain

Chad Monroe (7):
      wifi: mt76: mt7996: fix EAPOL source BSS for non-MLD stations
      wifi: mt76: mt7996: fix non-MLD station num_sta leak
      wifi: mt76: mt7996: select net_setup_tc handler at runtime
      wifi: mt76: fix stuck TX queues after SER with no active interfaces
      wifi: mt76: mt7915: trigger L1 SER on PLE MDP RIOC hang
      wifi: mt76: serialize scan-link teardown with dev->mutex
      wifi: mt76: mt7996: hold dev->mutex in remove_interface teardown

Chandrashekar Devegowda (1):
      Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR

Charlie-cy Wu (3):
      wifi: mt76: mt7921: refactor regd update to fix recursive mutex deadlock
      wifi: mt76: mt7925: add regulatory wiphy self manager support
      wifi: mt76: mt7921: add regulatory wiphy self manager support

Chelsy Ratnawat (1):
      wifi: rtlwifi: rtl8192d: remove dead SMPS rate mask code

Chen Changcheng (2):
      Bluetooth: btintel_pcie: Remove unreachable break after goto
      Bluetooth: btrsi: Move set_bt_context after successful HCI registration

Chen Jung Ku (1):
      wifi: rtw88: 8822c: replace msleep() with fsleep() for DPK delays

Chengfeng Ye (3):
      rds: synchronize info callbacks with module unload
      Bluetooth: hci_event: fix LE list UAF on reset
      Bluetooth: hci_sync: Fix accept list UAF during suspend

Chenguang Zhao (1):
      net: sxgbe: fix null pointer dereference in probe error path

Chia-Yuan Li (1):
      wifi: rtw89: fw: use MAC source for IO offload delay command

Chih-Kang Chang (6):
      wifi: rtw89: disable sniffer mode in RX filter when initialization for Wi-Fi 7 chips
      wifi: rtw89: pci: disable phy error flag related to refclk
      wifi: rtw89: wow: only WiFi 6 chips initialize RF registers in WoWLAN mode
      wifi: rtw89: 8852a: fix RSSI report when average beacon RSSI is not ready
      wifi: rtw89: rfk: update TXIQK H2C command format to v1
      wifi: rtw89: 8922d: bypass TXIQK when scan

Chin-Yen Lee (2):
      wifi: rtw89: wow: use MLD address in WoWLAN ARP replies for MLO stations
      wifi: rtw89: wow: add QoS control field to WoWLAN ARP response for MLO

Ching-Te Ku (63):
      wifi: rtw89: coex: force to exit Wi-Fi LPS while Bluetooth profile exist
      wifi: rtw89: coex: offset current BT info to BT0 for dual BT configuration
      wifi: rtw89: coex: Move wifi related counters to wifi info
      wifi: rtw89: coex: Extend bt_slot_req for dual MAC wifi
      wifi: rtw89: coex: Move Bluetooth related counters to BT info
      wifi: rtw89: coex: Refine third party module related coexistence
      wifi: rtw89: coex: Add TX/RX RF parameter format version 9
      wifi: rtw89: coex: Renaming drvinfo_type to drvinfo_ver
      wifi: rtw89: coex: Add Wi-Fi firmware 0.35.94.1 support for RTL8922D
      wifi: rtw89: coex: Add RTL8922D chip string
      wifi: rtw89: coex: Add Init info version 10
      wifi: rtw89: coex: add rtw89_btc_init() entry for initialization once
      wifi: rtw89: coex: Update TDMA descriptor for dual MAC
      wifi: rtw89: coex: Add Bluetooth binding for Bluetooth TX power setting
      wifi: rtw89: coex: Add Bluetooth binding for Bluetooth RX gain setting
      wifi: rtw89: coex: Add WiFi/Bluetooth adapter binding info
      wifi: rtw89: coex: Add TDMA binding for dual MAC
      wifi: rtw89: coex: Update scoreboard related logic for dual Bluetooth
      wifi: rtw89: coex: Add Co-RX logic
      wifi: rtw89: coex: Add Wi-Fi role info version 10
      wifi: rtw89: coex: Rearrange coexistence control structure
      wifi: rtw89: coex: Update driver outsource info to firmware version 6
      wifi: rtw89: ceox: Update antenna & grant signal setting
      wifi: rtw89: coex: Rearrange Bluetooth firmware report entry
      wifi: rtw89: coex: Refine send firmware command function
      wifi: rtw89: coex: Refine _reset_btc_var()
      wifi: rtw89: coex: Correct SET_RFE settings
      wifi: rtw89: coex: Add firmware report control report v11
      wifi: rtw89: coex: update external control length by case
      wifi: rtw89: coex: Update coexistence version to 9.24.0
      wifi: rtw89: coex: Add version 107 TX/RX info for firmware feature
      wifi: rtw89: coex: Add version 9 report control info
      wifi: rtw89: coex: Fix unexpected grant-signal assignee
      wifi: rtw89: coex: Branch out version 105 firmware report map index
      wifi: rtw89: coex: Refine chip initial related structure
      wifi: rtw89: coex: Add driver info H2C command index version 103
      wifi: rtw89: coex: Fix Wi-Fi role info H2C command header issue
      wifi: rtw89: coex: Add firmware 0.29.133.X support for RTL8852B family
      wifi: rtw89: coex: Add TDMA version 4
      wifi: rtw89: coex: Add slots version 2
      wifi: rtw89: coex: Add cycle status report version 105
      wifi: rtw89: coex: Add wifi role info version 101
      wifi: rtw89: coex: Add firmware 0.27.97.X support for RTL8852C
      wifi: rtw89: coex: Add chip initial info version 11 for RTL8922A/D
      wifi: rtw89: coex: Add Wi-Fi MLO info version 2 H2C command
      wifi: rtw89: coex: Add firmware 0.35.111.X support for RTL8922A/D
      wifi: rtw89: coex: Rearrange _ntfy_role_info info
      wifi: rtw89: coex: Separate _ntfy_role_info into two function
      wifi: rtw89: coex: Decrease Wi-Fi special packet protect time
      wifi: rtw89: coex: complete GPIO debug configuration handler
      wifi: rtw89: coex: Refine RF calibration notify flow
      wifi: rtw89: coex: Fix log dump format with proper newline
      wifi: rtw89: coex: Add BTC report version 8 support for BT sub-reports
      wifi: rtw89: coex: Add dual Bluetooth debug info dump
      wifi: rtw89: coex: Fix TDMA v8 handling to unblock BTC report parsing
      wifi: rtw89: coex: Fix H2C command redundant send & version fall through
      wifi: rtw89: coex: Handle Bluetooth LE-Audio related coexistence feature
      wifi: rtw89: coex: Fix Bluetooth link weight not updated on profile change
      wifi: rtw89: coex: Fix BT-info parsing for 5/6 GHz band & dual Bluetooth
      wifi: rtw89: coex: Clear BT link weight when BT is disabled
      wifi: rtw89: coex: Change Wi-Fi link_mode_v0 translating timing
      wifi: rtw89: coex: Port _update_bt_ctrl_lps() for BT profile-based LPS control
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 9.24.1

Christian Marangi (1):
      MAINTAINERS: add myself as QCA8K maintainer

Christoph Zwerschke (2):
      Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU
      Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU

Christophe JAILLET (2):
      wifi: ath12k: Constify struct ath12k_dp_arch_ops
      wifi: ath6kl: Constify struct cfg80211_ops

Chukun Pan (1):
      net: dsa: yt921x: Fix external port detection

Ciprian Regus (13):
      dt-bindings: net: Add ADIN1140
      net: ethernet: oa_tc6: Handle the OA TC6 SPI protected mode
      net: ethernet: oa_tc6: add OA_TC6_BROKEN_PHY quirk flag
      net: ethernet: oa_tc6: Export the C45 access functions
      net: ethernet: oa_tc6: Export standard defined registers
      net: ethernet: oa_tc6: Add the OA_TC6_ prefix to standard registers
      net: ethernet: oa_tc6: Add read_mms/write_mms register access functions
      net: ethernet: oa_tc6: Use the read_mms/write_mms functions for C45
      net: ethernet: oa_tc6: Add new register address defines
      net: phy: add generic helpers for direct C45 MMD access
      net: phy: microchip-t1s: use generic C45 MMD access helpers
      net: phy: Add support for the ADIN1140 PHY
      net: ethernet: adi: Add a driver for the ADIN1140 MACPHY

Claudiu Manoil (1):
      net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC

Colin Ian King (1):
      net: dsa: microchip: make read-only const array ts_reg static

Cosmin Ratiu (30):
      devlink: Update nested instance locking comment
      devlink: Add a helper for getting a nested-in instance
      devlink: Migrate from info->user_ptr to info->ctx
      devlink: Decouple rate storage from associated devlink object
      devlink: Add parent dev to devlink API
      devlink: Allow parent dev for rate-set and rate-new
      devlink: Allow rate node parents from other devlinks
      net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
      net/mlx5: qos: Refactor vport QoS cleanup
      net/mlx5: qos: Model the root node in the scheduling hierarchy
      net/mlx5: qos: Remove qos domains and use shd
      net/mlx5: qos: Support cross-device tx scheduling
      selftests: drv-net: Add test for cross-esw rate scheduling
      net/mlx5: Document devlink rates
      net/mlx5: Add PSP related fields to the mlx5_ifc
      net/mlx5e: psp: Rename the saved psp_dev to 'psd'
      net/mlx5e: psp: Remove PSP steering mutexes
      net/mlx5e: psp: Remove unneeded ref counting for PSP steering
      net/mlx5e: psp: Merge rx_err rule add/delete with ft create/delete
      net/mlx5e: psp: Use helpers for steering object manipulation
      net/mlx5e: psp: Factor out drop rule creation code
      net/mlx5e: psp: Remove unused PSP syndrome copy action
      net/mlx5e: psp: Rename and consolidate steering functions
      net/mlx5e: psp: Adjust rx_check FT size and use a drop_group
      net/mlx5e: psp: Add an RX steering table
      net/mlx5e: psp: Use a single rx_check table
      net/mlx5e: psp: Flatten steering structures
      net/mlx5e: psp: Make PSP steering config dynamic
      net/mlx5e: Return errors from profile->enable
      net/mlx5e: psp: Report PSP dev registration errors

Cunhao Lu (2):
      dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
      can: rockchip: add RK3588 CAN support

Daizhuang Bai (1):
      wifi: ath12k: Set DTIM policy to stick mode for station interface

Dan Carpenter (1):
      wifi: rtw89: debug: fix off by on in rtw89_ppdu_str()

Daniel Golle (6):
      net: pcs: mtk-lynxi: check regmap reads in mtk_pcs_lynxi_get_state()
      net: dsa: mt7530: check bus->read() error in core_rmw()
      net: dsa: mt7530: error out on failed PHY_IAC command writes
      net: dsa: mt7530: check CORE_PLL_GROUP4 access in mt7531_setup()
      net: dsa: mt7530: check command register writes in fdb and vlan cmd
      net: dsa: mt7530: serialize the regmap IRQ chip like every other user

Daniel Zahka (1):
      net: psp: use psp_dev_is_registered() in psp_assoc_free()

Daniele Palmas (2):
      net: wwan: add minimalistic IOCTls support also to QCDM port
      net: wwan: add exclusive open mode capability to AT and QCDM ports

Danielle Ratson (5):
      bridge: Use direct pointer in br_is_nd_neigh_msg()
      ipv6: ndisc: Add ndisc_check_ns_na() validation helper
      bridge: Validate NS/NA messages using ndisc_check_ns_na()
      bridge: Linearize skb once the ND message type is validated
      bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()

Daniil Agalakov (1):
      net: hns: use u32 for register offset in RCB TX coalescing

David Bauer (2):
      wifi: mt76: mt7915: configure noise floor reporting on reset
      wifi: mt76: mt7603: free beacon SKB on error

David Christensen (2):
      ehea: remove the ehea driver
      powerpc: remove ehea driver references

David Heidelberg (1):
      MAINTAINERS: Add Matrix channel to the NFC subsystem

David Laight (1):
      netfilter: avoid strcpy usage

David Lee (1):
      wifi: rtw89: 8852cu: add quirk to disable 2.4 GHz band

Dawei Feng (2):
      wifi: rtw88: pci: fix resource leak on failed NAPI setup
      wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()

Deep Shah (1):
      ptp: reject frequency adjustments that overflow scaled_ppm_to_ppb()

Deepanshu Kartikey (1):
      wifi: mac80211: don't encrypt pre-auth (ETH_P_PREAUTH) frames

Devin Wittmayer (5):
      wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length
      wifi: mt76: mt76x02: report rx FCS errors to mac80211
      wifi: mt76: mt7925: ensure tx headroom in usb_sdio_tx_prepare_skb
      wifi: mt76: mt7925: cancel mlo_pm_work on stop
      wifi: mt76: mt792x: do not advertise active monitor

Dhanavandhana Kannan (1):
      wifi: cfg80211: Avoid UNPROT_BEACON on AP interfaces

Dian-Syuan Yang (2):
      wifi: rtw89: drop packet offload entry on H2C addition failure to avoid scan issue
      wifi: rtw89: refine RX filter configuration for WiFi 7 generation

Dinh Nguyen (1):
      MAINTAINERS: update entry for socfpga dwmac and gmii/sgmii

Dipayaan Roy (2):
      net: mana: refactor mana_get_strings() and mana_get_sset_count() to use switch
      net: mana: force full-page RX buffers via ethtool private flag

Dmitry Antipov (3):
      wifi: mac80211: simplify airtime_flags_write()
      wifi: mt76: mt7915: simplify mt7915_sys_recovery_set()
      Bluetooth: simplify force_no_mitm_write() with kstrtobool_from_user()

Dmitry Gomzyakov (1):
      wifi: mt76: connac: add MT7991A (0x7991) to is_mt7996()

Dmitry Morgun (1):
      wifi: rtw89: check return values in rtw89_ops_start_ap()

Dmitry Torokhov (1):
      nfc: st95hf: switch to using sleeping variants of gpiod API

Doruk Tan Ozturk (7):
      wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
      macvlan: require lower-netns admin for shared port settings
      nfc: digital: clamp SENSF_RES length to the destination buffer
      nfc: llcp: bound SNL TLV parsing to the skb and add length checks
      nfc: llcp: reject PDUs shorter than the LLCP header
      nfc: llcp: bound the connect_sn TLV walk to the skb
      nfc: st21nfca: validate ATR_REQ length against the received frame

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Remove dead CWR handling in GRO header update

Eason Lai (3):
      wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete
      wifi: mt76: mt7921: Add PCIe AER handler support to prevent system crash
      wifi: mt76: mt792x: Fix memory leak in SDIO TX path

Eduard Bostina (1):
      dt-bindings: net: can: Convert TI HECC to DT schema

Emery Hsin (21):
      wifi: mt76: mt792x: consolidate rx interrupt masks into all_complete_mask
      wifi: mt76: connac2: apply new rx all_complete_mask
      wifi: mt76: mt7925: replace shared rx irq masks with per-chip definitions
      wifi: mt76: mt7925: add MT7927 per-chip rx irq definitions
      wifi: mt76: mt792x: add per-chip PCIe register struct
      wifi: mt76: connac2: add per-chip PCIe register definitions
      wifi: mt76: mt7925: add per-chip PCIe register definitions
      wifi: mt76: mt792x: replace shared PCIe MAC macros with per-chip struct
      wifi: mt76: mt792x: rename WFDMA DMASHDL enable bit to follow the convention
      wifi: mt76: mt7925: rename WTBL registers to chip-specific format
      wifi: mt76: mt792x: add tx_done ring to common DMA queue allocation
      wifi: mt76: connac3: update basic rate table starting index
      wifi: mt76: mt7925: fix MMIO dynamic remap window size
      wifi: mt76: mt7925: add MT7928 FWDL support
      wifi: mt76: mt7925: add MT7928 irq_map with chip-specific rx masks
      wifi: mt76: mt7925: add MT7928 DMA configuration
      wifi: mt76: mt7925: add MT7928 TXD/TXS/TX_DONE support
      wifi: mt76: mt7925: add MMIO register remapping table for MT7928
      wifi: mt76: mt7925: align scan IE and EFUSE TLV lengths to 4 bytes for MT7928
      wifi: mt76: mt7925: add MT7928 per-chip PCIe register definitions
      wifi: mt76: mt7925: add MT7928 PCIe support

Emil Tsalapatis (1):
      net/tcp: Prevent inlining tcp_syn_ack_timeout()

Emmanuel Grumbach (16):
      wifi: iwlwifi: mvm: fix the FCS truncation logic in d3
      wifi: iwlwifi: mld: treat valid BAID without STA as a FW error
      wifi: iwlwifi: mvm: validate monitor notif link_id
      wifi: iwlwifi: mld: validate D3_END notif size
      wifi: iwlwifi: pcie: validate txq_id in txq_enable
      wifi: iwlwifi: mvm: reset the smart fifo state upon FW stop
      wifi: iwlwifi: mvm: cleanup the driver state after device_powered_off
      wifi: iwlwifi: mld: reset the driver state upon firmware recovery
      wifi: iwlwifi: mld: validate WoWLAN notif header
      wifi: iwlwifi: fix counter type in iwl_fwrt_dump_error_logs
      wifi: iwlwifi: mld: fix validation fallback in iwl_mld_notif_is_valid
      wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitiser
      wifi: iwlwifi: guard against division by zero in iwl_dbg_tlv_alloc_fragments
      wifi: iwlwifi: mld: validate wake packet crypto overhead
      wifi: iwlwifi: mld: initialize scan-abort status
      wifi: iwlwifi: mvm: ignore sync frames when sync is disabled

Eric Dumazet (14):
      bonding: no longer rely on RTNL in bond_fill_info()
      macvlan: annotate data-races around vlan->mode and vlan->flags
      macvlan: no longer rely on RTNL in macvlan_fill_info()
      macsec: no longer rely on RTNL in macsec_fill_info()
      amt: no longer rely on RTNL in amt_fill_info()
      tun: no longer rely on RTNL in tun_fill_info()
      geneve: pass geneve_config pointer to helper functions
      geneve: convert config to RCU-protected pointer
      geneve: make geneve_fill_info() RTNL independent
      geneve: fix geneve_config leak on register_netdevice() failure
      gre: fix ERSPAN o_flags race/corruption in xmit and fill_info
      net: prevent torn reads in netdev_tc_txq
      net: add READ_ONCE()/WRITE_ONCE() annotations for dev->num_tc
      net: add READ_ONCE()/WRITE_ONCE() annotations for dev->prio_tc_map

Eric Huang (5):
      wifi: rtw89: 8922d: remove CCK bandwidth compensation
      wifi: rtw89: 8922d: dynamic adjust channel smoothing
      wifi: rtw89: 8922d: fix EMLSR BB switch sequence for MLO mode transition
      wifi: rtw89: phy: fix bandedge primary channel for 2.4GHz 40MHz and 6GHz
      wifi: rtw89: pack I/O during bb_sethw to reduce API execution time

Eric Joyner (1):
      ionic: add missing dma_rmb() after the completion publish check

Ethan Nelson-Moore (2):
      wifi: mt76: mt7925: remove code guarded by nonexistent config option
      wifi: mt76: mt7996: remove code guarded by nonexistent config option

Evgenii Burenchev (1):
      mlxsw: spectrum_acl_erp: Fix const qualifier of delta_clear()

Fabio Estevam (2):
      wifi: mwifiex: Detach sync cmd buffer on interrupted wait
      wifi: mwifiex: Remove WQ_HIGHPRI from main workqueue

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition

Faizal Rahim (4):
      igc: remove unused autoneg_failed field
      igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
      igc: replace goto out with direct returns in igc_config_fc_after_link_up()
      igc: add support for forcing link speed without autonegotiation

Fan Gong (1):
      hinic3: Fix skb linearization mismatch and drop skb when skb_checksum_help() failed

Fan Wu (3):
      wifi: rtl8xxxu: fix use-after-free from rx_urb_wq on stop
      fjes: unregister the netdev before destroying the workqueues
      fjes: cancel force_close_task in fjes_remove()

Fan Ye (2):
      net: thunderbolt: Release the Rx HopID that was handed out on mismatch
      net: thunderbolt: Mark the connection down when bringing it up fails

Fanbo He (1):
      drivers: gs_usb: gs_usb_probe(): fix typo in error message

Felix Fietkau (59):
      wifi: mac80211: factor out part of ieee80211_calc_expected_tx_airtime
      wifi: mac80211: estimate expected throughput if not provided by driver/rc
      wifi: mac80211: add AQL support for multicast packets
      wifi: mac80211: add ieee80211_txq_aql_pending()
      wifi: mt76: mt7996: validate RX band_idx before dereferencing phys[]
      wifi: mt76: mt7996: set MT76_MCU_RESET before waking MCU waiters on full reset
      wifi: mt76: mt7915: clear wcid mask under mutex after RCU pointer clear
      wifi: mt76: mt7915: avoid nss underflow in mt7915_mcu_get_sta_nss
      wifi: mt76: mt7996: don't report a zero TX bitrate
      wifi: mt76: mt7915: write RX header translation bit to the correct register
      wifi: mt76: fix 4th chain ACK RSSI bitmask in sta_poll
      wifi: mt76: mt7996: fix TX DMA mapping leak for AddBA req frames
      wifi: mt76: fix stranded frames in mt76_txq_schedule_pending
      wifi: mt76: allow TX aggregation on the VO queue
      wifi: mt76: fix uninitialised RXDMAD_C descriptor info
      wifi: mt76: fix RXDMAD_C buffer recycling race
      wifi: mt76: mt7915: poll the correct SLP CTRL register for the second adie
      wifi: mt76: fix HE DCM max-RU capability encoding
      wifi: mt76: mt7996: bound TLV walk in mt7996_mcu_get_chip_config
      wifi: mt76: fix out-of-bounds access in mmio copy helpers
      wifi: mt76: mt7915: unwind state on add_interface failure
      wifi: mt76: mt7996: hold dev->mt76.mutex while disabling tx worker in SER
      wifi: mt76: decode the full VHT Rx STBC capability field
      wifi: mt76: fix ER-SU 106-tone RU check in RX rate decode
      wifi: mt76: mt7996: reserve space for the CSA-abort countdown TLV
      wifi: mt76: mt7996: don't leak MLD group index on remap alloc failure
      wifi: mt76: cancel reset and rc work on device unregister
      wifi: mt76: report data NSS for STBC frames in RX rate decode
      wifi: mt76: mt7915: use little-endian for bss_info_ra wire fields
      wifi: mt76: only consume the WO drop bit on WED v2 devices
      wifi: mt76: mt7915: unlink TWT flow if the MCU rejects the agreement
      wifi: mt76: mt7996: skip key upload when adding an offchannel link
      wifi: mt76: mt7996: wake MCU waiters before aborting scan in L1 SER
      wifi: mt76: fix queue reg access when building WED and NPU together
      wifi: mt76: mt7615: fix NULL deref in mt7615_mac_set_rates
      wifi: mt76: mt7996: free vif links after clearing wcid entries on full reset
      wifi: mt76: mt7996: clear stale link state on full reset
      wifi: mt76: set MT76_SCANNING when starting a hw scan
      wifi: mt76: mt7996: fix MIB TX aggregation counter registers for mt7990
      wifi: mt76: mt7915: fix double hif2 init on the non-WED path
      wifi: mt76: mt7915: fix ext PHY use-after-free on register error path
      wifi: mt76: mt7915: release hif2 reference on probe IRQ failure
      wifi: mt76: mt7996: do not attach hif2 WED when the main WED attach failed
      wifi: mt76: mt7996: do not leave state behind after a failed WED attach
      wifi: mt76: mt7915: fix chainmask handling for non-dbdc phys on band 1
      wifi: mt76: mt7915: report RX chain signal for all RX paths
      wifi: mt76: mt7915: update SKU power limits after changing antennas
      wifi: mt76: mt7925: fix infinite loop in UNI event TLV parsing
      wifi: mt76: add PS buffering support for HW-managed TIM drivers
      wifi: mt76: mt7915: handle MCU PS sync events
      wifi: mt76: mt7996: handle UNI PS sync events
      wifi: mt76: set the EOSP bit in the QoS header of the last released frame
      wifi: mt76: mt7603: fix U-APSD service period termination
      wifi: mt76: mt7603: tell mac80211 when the PS queue has run empty
      wifi: mt76: mt7603: restore hardware PS buffering after a service period
      wifi: mt76: mt7603: file buffered frames under the TID reported to mac80211
      wifi: mt76: reject out-of-range link ids in mt76_vif_link()
      wifi: mt76: mt7996: fix out-of-bounds link array access in mt7996_tx()
      wifi: mac80211: skip default WMM setup for AP_VLAN links

Feng Tang (1):
      selftests: net: reuseport_bpf_numa: consider cpuless numa node

Feng Wu (2):
      netfilter: xt_tcpmss: add checkentry for parameter validation
      netfilter: xt_dscp: add checkentry for tos match

Fernando Fernandez Mancera (3):
      ipv4: remove unnecessary reset of position pointer
      ipv6: remove unnecessary reset of position pointer
      netfilter: conncount: normalize tuple and zone on successful ct lookup

Filip Bakreski (1):
      wifi: mt76: mt76u: use a threaded NAPI for the RX path

Florian Bezdeka (1):
      net: stmmac: intel: Add missing pci_free_irq_vectors() calls

Florian Westphal (6):
      netfilter: nf_conntrack_helper: do not hash by tuple
      netfilter: conntrack: get rid of tuple in helper definitions
      netfilter: conntrack: remove obsolete module parameters
      netfilter: nft_ct: support expectation creation for natted flows
      netfilter: xt_tcpmss: extend checkentry to ipv6
      netfilter: nf_nat_sip: rewind offset when NAT shrinks the packet

Gal Pressman (1):
      net/mlx5e: Remove _once from PCI heuristic debug print

Geert Uytterhoeven (2):
      wifi: nxp: NXPWIFI should be invisible and selected by its users
      wifi: morsemicro: MM81X should be invisible and selected by its users

Geliang Tang (2):
      mptcp: remove unused data_ack from struct mptcp_ext
      selftests: mptcp: fix const qualifier warnings in strchr usage

Glenn Judd (1):
      net/mlx5e: do not HW-GRO coalesce small frames

Griffin Kroah-Hartman (3):
      rndis_host: add overflow check in rndis_rx_fixup()
      nfc: mrvl: spi: Unregister dev on allocation fail
      nfc: nxp-nci: Add remove on IRQ error

Guangshuo Li (1):
      Bluetooth: btmtksdio: fix usage_count leak when autosuspend_delay is negative

GuoHan Zhao (1):
      wifi: rtw89: wow: fix unsupported cipher debug messages

Gustavo Evgucci (1):
      Bluetooth: btusb: Add USB ID 13d3:3625 for MediaTek MT7922

Haiyang Zhang (3):
      net: mana: Add Interrupt Moderation support
      net: mana: Add handler for sriov configure
      net: mana: Extend RX CQE coalescing up to 8 packets

Hangbin Liu (1):
      bonding: fix wrong extack attribute in ARP validate netlink error path

Hangtian Zhu (2):
      genirq: export irq_can_set_affinity() for module drivers
      wifi: ath12k: enable threaded NAPI when DP IRQ affinity is unavailable

Hao Chen (1):
      net: hns3: add support to query/set TX pfc_prevention_tout for ethtool with RX prevention disabled

Haoxiang Li (1):
      iwlwifi: dvm: add missing cleaup for on error path

Harini T (2):
      MAINTAINERS: Replace maintainer for Xilinx CAN driver
      dt-bindings: can: xilinx_can: Document phys property

Hariprasad Kelam (1):
      octeontx2-af: npc: Warn on NPC_IPSEC_SPI key overlap

Harshitha Ramamurthy (3):
      gve: don't pass in unused parameter to gve_adminq_free
      gve: refactor initialization with helper functions
      gve: add a few helper functions to set device properties

Heiko Carstens (2):
      s390/ctcm: Add __context_unsafe() attribute to various functions
      drivers/s390/net: Enable CONTEXT_ANALYSIS

Hongyan Xu (1):
      net: phy: nxp-tja11xx: cancel registration work on remove

Howard Hsu (1):
      wifi: mt76: mt7996: reject iTWT setup requests from MLD stations

HyeongJun An (1):
      Bluetooth: virtio_bt: avoid OOB read of build info string

Hyunwoo Kim (1):
      sctp: stop processing a packet once its association is deleted

Håkon Bugge (1):
      net/rds: hold the socket while an rds_mr references it

Ian Bridges (1):
      netfilter: x_tables: replace strlcat() with snprintf()

Ido Schimmel (5):
      bridge: mcast: Fix a false positive lockdep splat
      bridge: mcast: Remove unnecessary argument from br_multicast_alloc_query()
      mlxsw: Convert to async version of ndo_set_rx_mode
      mlxsw: ethtool: Prepare for RTNL-less ethtool operations
      mlxsw: Tell the core to use the netdev instance lock

Ilan Peer (2):
      wifi: mac80211: Route (Re)association req/response to per-STA queue
      wifi: iwlwifi: mld: Do not cleanup FW state when the device is dead

Ilya Maximets (9):
      openvswitch: remove support for legacy tunnel types
      openvswitch: vport: remove infrastructure for vport options
      openvswitch: vport: remove infrastructure for separate modules
      net: geneve: remove unused geneve_dev_create_fb
      net: gre: remove unused gretap_fb_dev_create
      net: vxlan: remove unused vxlan_dev_create
      net: openvswitch: unexport ovs_vport_alloc/free
      net: ip_tunnel: remove unused non-strict __ip_tunnel_change_mtu
      net: openvswitch: fix flow mask use-after-free on flow deletion

Ioana Ciornei (13):
      dpaa2-switch: remove unnecessary dev_mc_add/dev_mc_del calls
      dpaa2-switch: avoid holding rtnl_lock in dpaa2_switch_event_work()
      dpaa2-switch: extend the FDB management to cover bond scenarios
      dpaa2-switch: create a separate dpaa2_switch_port_fdb_event() function
      dpaa2-switch: check early if an FDB entry should be added
      dpaa2-switch: add dpaa2_switch_port_to_bridge_port() helper
      dpaa2-switch: consolidate unicast and multicast management
      dpaa2-switch: add LAG configuration API
      dpaa2-switch: add support for LAG offload
      dpaa2-switch: offload FDBs added on an upper bond device
      dpaa2-switch: offload port objects on an upper bond device
      dpaa2-switch: trap all link local reserved addresses to the CPU
      dpaa2-switch: add support for imprecise source port

Ismael Luceno (1):
      ipvs: Move defense_work and est_reload_work to system_dfl_long_wq

Iva Kasprzaková (1):
      Bluetooth: fix BT dependency for submodules

Ivan Vecera (10):
      dpll: add STATE_CONNECTED_OVERRIDE pin capability
      dpll: add DPLL_PIN_TYPE_INT_NCO pin type
      dpll: zl3073x: use per-operation poll timeouts
      dpll: zl3073x: add per-DPLL serialization lock
      dpll: zl3073x: add NCO virtual input pin
      dpll: zl3073x: update all DPLL channels on ref_sync_set
      dpll: use pin owner's dpll ref for pin-level attribute setting
      dpll: zl3073x: scale poll interval proportionally to timeout
      dpll: zl3073x: add channel ToD, phase step and TIE operations
      dpll: zl3073x: add PTP clock support

JB Tsai (1):
      wifi: mt76: mt7925: Fix unregister deadlock

Jack Ma (3):
      net: nexthop: add NHA_DST_PORT for fdb nexthops
      vxlan: honor per-nexthop fdb destination port
      selftests: net: add coverage for fdb nexthop dst_port

Jakub Kicinski (96):
      Merge branch 'net-do-not-warn-on-best-effort-skb-allocation-failures'
      selftests: drv-net: toeplitz: cap the Rx queue count
      tools: ynl: pyynl: re-export the library API from the package root
      tools: ynl: pyynl: pull the --family resolution logic into the lib
      Merge branch 'net-mlx5e-psp-cleanups-and-improvements'
      Merge branch 'net-fix-stale-tx-skb-pointers-on-dma-map-failure'
      Merge branch 'align-ipv4-teardown-with-ipv6-and-fix-driver-regressions'
      Merge branch 'net-libwx-improve-vf-ethtool-support'
      Merge branch 'seg6-add-fib-table-attribute-for-post-encap-sid-route-lookup'
      Merge branch 'net-dsa-realtek-rtl8365mb-add-sgmii-hsgmii-support-for-rtl8367s'
      Merge branch 'extend-packet-socket-selftests'
      Merge branch 'net-dsa-mt7530-add-econet-en7528-built-in-switch-support'
      Merge branch 'net-mdio-rearrange-kconfig-menus'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-2026-07-26' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-enetc-cleanups-and-improvements'
      Merge branch 'net-hsr-prp-redbox-prp-san-support'
      Merge tag 'nf-next-26-07-24' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'docs-netdev-a-couple-of-updates'
      net_shaper: remove incorrect comment about group leaves
      net_shaper: clarify the kernel API / comments
      net_shaper: add some notes on re-parenting
      Merge branch 'net_shaper-clarify-kernel-api-docs'
      Merge branch 'add-packet_ignore_outgoing-selftest-for-packet-sockets'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-nexthop-per-nexthop-udp-dst-port-for-fdb-vxlan-nexthops'
      Merge branch 'net-mctp-usb-add-support-for-mctp-over-usb-v1-1'
      Merge branch 'net-dsa-microchip-add-ptp-support-for-ksz8463'
      Merge branch 'add-support-for-rtl8261c-d'
      Merge branch 'net-stmmac-fix-phy-attach-when-custom-pcs-is-in-use'
      Merge branch 'net-convert-rawv6-ieee802154-phonet-and-tls-getsockopt-to-sockopt_t'
      Merge branch 'net-stmmac-only-use-mac-loopback-for-selftests'
      Merge branch 'net-stmmac-cleanup-rx-coalescing-computation-when-using-riwt'
      Merge branch 'net-mana-add-ethtool-private-flag-for-full-page-rx-buffers'
      Merge branch 'net-rds-bug-fix-ports'
      Merge branch 'bnge-add-more-functionality'
      Merge tag 'nf-next-26-07-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      selftests: drv-net: hw: reset HDS mode after netkit devmem tests
      Merge branch 'pfcp-support-per-netns-device-unregistration'
      Merge branch 'pds_core-add-pldm-firmware-update-and-host-backed-memory-support'
      selftests: drv-net: print device info at the start
      Merge branch 'add-zte-dinghai-ethernet-pf-driver'
      Merge branch 'dpll-zl3073x-add-microchip-zl30643-support'
      Merge branch 'net-mlx5-allocate-doorbells-from-dma-pools'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-next-2026-08-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'for-net-next-2026-08-07' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'bridge-validate-and-clean-up-ipv6-neighbour-suppression'
      Merge branch 'net-dsa-mt7530-fix-remaining-swallowed-mdio-access-errors'
      Merge branch 'selftests-net-shaper-expand-shaper-api-coverage'
      Merge branch 'tun-tap-vhost-net-apply-qdisc-backpressure-on-full-ptr_ring-to-reduce-tx-drops'
      Merge branch 'net-wangxun-timeout-and-error'
      tools/ynl: add ovs_packet uapi header in Makefile.deps
      Merge branch 'net-devmem-allow-rx-buf-size-page_size-per-binding'
      Merge branch 'add-dapu-telecom-dap8211r-i-gigabit-ethernet-phy-driver'
      netdev: check for nla_put_u32() failures
      selftests: netdevsim: fix SIGPIPE flake in ethtool-coalesce
      selftests: drv-net: pace ethtool_std_stats packet generation
      selftests: drv-net: let ethtool stats settle before reading
      Merge branch 'drivers-s390-net-enable-context_analysis'
      selftests: bonding: disable DAD for IPv6 addresses
      Merge branch 'update-null-pointer-handling-in-generated-code'
      MAINTAINERS: make Tung an official TIPC maintainer
      Merge branch 'devlink-add-generic-device-max_sfs-parameter'
      Merge branch 'net-selftests-adjustments-to-ipv6_flowlabel_mgr'
      selftests: drv-net: hide the devlink port_split test
      Merge branch 'mptcp-out-of-order-queue-pruning'
      Merge tag 'batadv-next-pullrequest-20260805' of https://git.open-mesh.org/batadv
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-phy-dp83640-fix-shared-clock-lifetime-and-probe-error-cleanup'
      Merge branch 'net-smc-close-the-smc-d-teardown-window-around-the-ghost-send-buffer'
      ethtool: tsconfig: reject zero-valued tx_type and rx_filter bitsets
      Merge tag 'nf-next-26-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-prevent-lockless-data-races-in-net_device-tc-structures'
      eth: bnxt: decrease indent in bnxt_init_int_mode()
      eth: bnxt: preserve IRQ affinity across IRQ reallocation
      Merge branch 'eth-bnxt-preserve-irq-affinity-across-irq-reallocation'
      Merge branch 'net-thunderbolt-two-fixes-for-the-failed-bring-up-path'
      Merge branch 'net-stmmac-dma-address-handling-fixes'
      Merge tag 'nfc-7.1-rc8' of https://codeberg.org/linux-nfc/linux
      Merge branch 'ionic-fix-completion-descriptor-access'
      Merge branch 'net-sfp-quirk-support-for-xgs-pon-ont-sticks-with-unclean-eeproms'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-ravb-fix-ptp-clock-lifetime'
      Merge branch 'net-macb-implement-context-swapping'
      Merge branch 'mptcp-misc-features-for-v7-3'
      Merge branch 'enic-sr-iov-v2-admin-channel-and-mbox-protocol'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-af_unix-useful-handling-of-lsm-denials-on-scm_rights'
      Merge branch 'gve-adminq-mode-related-refactors'
      Merge branch 'net-mlx5-hws-misc-enhancements'
      Merge branch 'dpll-zl3073x-add-ptp-clock-support'
      Merge tag 'nfc-net-next-20260817' of https://codeberg.org/linux-nfc/linux
      Merge tag 'linux-can-next-for-7.3-20260818' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jared.Huang (2):
      wifi: mt76: mt7925: update clc before setting sar power table
      wifi: mt76: mt7925: fix msg len mismatch between driver and firmware

Jason Huang (2):
      wifi: brcmfmac: add DPP support
      wifi: brcmfmac: fix P2P action frame handling without device vif

Javen Xu (5):
      net: phy: c45: add genphy_c45_pma_soft_reset()
      net: phy: c45: add setup and read master/slave helpers
      net: phy: realtek: add support for RTL8261C_CG
      net: phy: realtek: load firmware for RTL8261C_CG
      net: phy: realtek: add support for RTL8261D

Jeff Chen (3):
      mmc: core: add NXP IW61x base ID and block size quirk
      wifi: nxp: add nxpwifi driver for IW61x
      wifi: nxpwifi: fix multiple static analysis errors and warnings

Jeff Hsu (1):
      wifi: mt76: mt7925: skip DMA re-init selectively

Jeff Johnson (15):
      Merge qcom PAS TZ service series (20260702115835.167602-2-sumit.garg@kernel.org)
      wifi: ath12k: Fix ath12k_wifi7_mac_op_tx() style issues
      wifi: ath6kl: avoid buffer overreads in WMI event handlers
      wifi: ath12k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath11k: Correctly copy the hint BSSID in WMI scan request
      wifi: ath12k: Avoid buffer overread in ath12k_wmi_op_rx()
      wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv_op_rx()
      wifi: ath12k: fix overreads in ath12k_wmi_process_csa_switch_count_event()
      wifi: ath11k: fix overreads in ath11k_wmi_process_csa_switch_count_event()
      wifi: ath12k: validate TLV length in process_tpc_stats()
      wifi: ath12k: move firmware_mode enum to qmi.h
      wifi: ath12k: rename firmware_mode enum members to use QMI namespace
      wifi: ath12k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()
      wifi: ath11k: fix leak in ath11k_service_ready_ext_event()

Jeremy Kerr (12):
      net: mctp: usb: Include version indicator in max packet size defines
      net: mctp: usb: Use packet-length max for maximum packet-size check
      net: mctp: usblib: Move RX transfer processing to a new mctp-usblib
      net: mctp: usb: Improve IN endpoint status handling
      net: mctp: usblib: Move TX transfer processing to mctp-usblib
      net: mctp: usblib: Add support for multi-packet transmit
      net: mctp: usb: Accommodate DSP0283 v1.1 header format
      net: mctp: usblib: Implement receive-side packet spanning
      net: mctp: usblib: Implement transmit-side packet spanning
      net: mctp: usblib: Add initial kunit tests
      net: mctp: usb: enable v1.1 packet spanning
      net: mctp: usb: Allow multiple urbs in flight

Jiajia Liu (1):
      wifi: cfg80211: reg: add a newline in DFS debug message

Jian Shen (2):
      net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
      net: hns3: use txqueue parameter directly in ndo_tx_timeout

Jiangshan Yi (1):
      selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info()

Jiawen Wu (7):
      net: libwx: disable TX VLAN offload for packets with >2 VLAN tags
      net: ngbe: correct misleading interrupt comment
      net: ngbe: implement libwx reset ops
      net: wangxun: add Tx timeout process
      net: wangxun: add reinit parameter to wx->do_reset callback
      net: wangxun: implement soft quiesce for PCIe error recovery
      net: wangxun: add pcie error handler

Jiaxing Hu (1):
      net: phy: motorcomm: enable the reference clock for YT8521

Jiayuan Chen (2):
      netfilter: ebtables: bound num_counters like nentries in do_replace()
      bpf, xdp: move offload check into dev_xdp_install()

Jijie Shao (2):
      net: hns3: add missing const qualifier to hclge_log_error() reg parameter
      net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race

Jinhui Guo (1):
      net: usb: cdc_ether: add quirk for AMI BMC stale link events

Jiri Pirko (1):
      MAINTAINERS: add Ivan Vecera as DPLL reviewer

Jiri Slaby (SUSE) (1):
      ppp/ppp_{async,synctty}: drop unused {a,}syncppp::bytes_{sent,rcvd}

Jisheng Zhang (1):
      net: stmmac: remove ptpaddr/mmcaddr/estaddr "safe" initialization

Joe Damato (8):
      selftests/net: Test PACKET_STATISTICS
      selftests/net: Test PACKET_STATISTICS drops
      selftests/net: Test PACKET_AUXDATA
      selftests/net: psock: Generalize psock bind
      selftests/net: psock: Generalize stats check
      selftests/net: psock_snd: unify on recvmsg()
      selftests/net: psock_snd: Verify sll_pkttype
      selftests/net: test PACKET_IGNORE_OUTGOING

Joel Granados (3):
      net: enforce net sysctl registration
      net: Const qualify ctl_tables that kmemdup unconditionally
      net: Const qualify network templated ctl_tables Arrays

Johan Alvarado (3):
      net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
      net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S
      net: stmmac: raise TX completion interrupt at the end of an xmit burst

Johan Hovold (1):
      net: mvneta: bm: fix device reference leak on failed lookup

Johannes Berg (25):
      wifi: radiotap: add definitions for the new UHR TLVs
      wifi: nl80211: clarify NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA content
      wifi: cfg80211: remove WIPHY_FLAG_DISABLE_WEXT
      wifi: iwlwifi: mvm: remove iwl_mvm_recalc_tcm()
      wifi: iwlwifi: claim UHR DBE capability for UHR devices
      wifi: iwlwifi: mvm/mld: fix PPE threshold debug print loop
      Merge tag 'mm81x-driver-08-07-2026' of https://github.com/MorseMicro/linux
      wifi: mac80211: always send regulatory connectivity element
      wifi: use UHR operation field presence bits
      wifi: cfg80211: improve multi-BSSID profile continuation parser
      wifi: cfg80211: clarify and tighten key checks
      wifi: mac80211: fix monitor min_def bandwidth
      wifi: mac80211: refactor multi-link assoc response parsing
      wifi: mac80211: parse enhanced critical updates field
      Merge tag 'nxpwifi-2026-07-15' of https://github.com/jeffchen71/nxpwifi
      Merge tag 'ath-next-20260722' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-next-2026-07-23' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Revert "wifi: mac80211: don't encrypt pre-auth (ETH_P_PREAUTH) frames"
      wifi: mac80211: fix RCU dereference in throughput estimate
      wifi: mac80211: fix RCU usage in peer probing
      Merge tag 'mm81x-next-2026-07-31' of https://github.com/MorseMicroLabs/linux-wireless
      Merge tag 'mt76-next-2026-08-01' of https://github.com/nbd168/wireless
      Merge tag 'rtw-next-2026-08-02' of https://github.com/pkshih/rtw
      wifi: mac80211: disconnect on CSA to channel 0
      Merge tag 'ath-next-20260803' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Johnson Tsai (2):
      wifi: rtw89: add LED support to reflect the wireless association status
      wifi: rtw89: add multicolor LED support for RTL8852CU valve board

Jonas Jelonek (4):
      dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
      net: pse-pd: add Realtek PSE MCU core
      net: pse-pd: realtek-pse-mcu: add I2C transport
      net: pse-pd: realtek-pse-mcu: add UART transport

Jori Koolstra (4):
      net: af_unix: enable custom setsockopt for all socket types
      net: scm: move scm_detach_fds() from common path to scm_recv_unix()
      net: af_unix: useful handling of LSM denials on SCM_RIGHTS
      selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS

Joris Vaisvila (4):
      dt-bindings: net: dsa: add MT7628 ESW
      net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet PHYs
      net: dsa: initial MT7628 tagging driver
      net: dsa: initial support for MT7628 embedded switch

Jose Ignacio Tornos Martinez (1):
      wifi: mt76: mt7996: remove beacon_int_min_gcd from ADHOC interface combinations

Joshua Washington (2):
      gve: use xdp_build_skb methods for XDP_PASS case
      gve: add XDP metadata support for DQ RDA

Julia Lawall (2):
      qlcnic: drop unneeded semicolon
      netlink: drop unneeded semicolon

Junseo Lim (1):
      net: kcm: Hold RCU read lock while running BPF parser

Junyang Han (2):
      dinghai: add ZTE network driver support
      dinghai: add hardware register access and PCI capability scanning

Kai Kuang (1):
      net: dsa: drop explicit NULL comparisons

Kalpan Jani (1):
      mptcp: honour configured min/max RTO in retransmit paths

Karl Mehltretter (4):
      r8169: give RTL_GIGA_MAC_VER_EXTENDED a distinct value
      octeontx2-af: initialize lmac_bmap in rvu_mcs_set_lmac_bmap()
      net_shaper: fix kernel-doc list indentation
      8139cp: fix Rx and Tx not being disabled in cp_suspend

Kenneth Kasilag (1):
      wifi: mt76: mt7996: expose per-band MAC addresses to cfg80211

Kiran K (3):
      Bluetooth: btintel_pcie: split coredump worker into per-trigger works
      Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS
      Bluetooth: btintel: Add Bluetooth SAR revision 2 support

Kiran Kumar K (2):
      octeontx2-af: reserve 4 PKINDs for skip-size custom use
      octeontx2-af: Add RSS hashing support based on RoCEv2 header

Kohei Enju (4):
      igc: prepare for RSS key get/set support
      igc: expose RSS key via ethtool get_rxfh
      igc: allow configuring RSS key via ethtool set_rxfh
      igb: set skb hash type from RSS_TYPE

Krishan Singh (1):
      net: sfp: fix hwmon_name memory leak on hwmon registration failure

Krzysztof Kozlowski (4):
      net: ethernet: qualcomm: Unconstify function arguments passed by value
      net: ethernet: qualcomm: Constify "queue_map" in ppe_ring_queue_map_set()
      wifi: ath10k: Drop redundant NULL check on devm_clk_get()
      dt-bindings: net: Correct white-space style

Kuniyuki Iwashima (33):
      net: fib_rules: Make fib_rules_ops.delete() return void.
      ipv4: fib_rules: Make the need for fib_unmerge() explicit.
      ipv4: fib: Protect fib_new_table() with spinlock.
      ipv4: fib: Drop RTNL annotation for net->ipv4.fib_table_hash[].
      net: fib_rules: Add fib_rules_ops.lock.
      net: fib_rules: Remove unnecessary EXPORT_SYMBOL.
      net: fib_rules: Drop RTNL assertions.
      net: fib_rules: Use dev_get_by_name_rcu().
      net: fib_rules: Only hold RTNL for the first IPv4 RTM_NEWRULE.
      ipv6: fib_rules: Convert fib6_rules_net_exit_rtnl() to ->exit().
      ipv4: fib: Define fib_table_hash_lock under CONFIG_IP_MULTIPLE_TABLES.
      net: fib_rules: Destroy ops->lock in fib_rules_unregister().
      rtnetlink: Lock sock_net(skb->sk) in rtnl_newlink().
      rtnetlink: Call unregister_netdevice_many() only once in rtnl_link_unregister().
      rtnetlink: Add per-netns rtnl_work.
      net: Wrap default_device_exit_net() with __rtnl_net_lock().
      net: Hold __rtnl_net_lock() in netdev_wait_allrefs_any().
      net: Add per-netns netdev unregistration infra.
      net: Call unregister_netdevice_many() per netns.
      veth: Support per-netns device unregistration.
      bareudp: Protect bareudp_list with mutex.
      bareudp: Support per-netns netdev unregistration.
      ipvlan: Convert ipvl_port.count to refcount_t.
      ipvlan: Synchronise ipvlan_init() and ipvlan_uninit() for the same lower dev.
      ipvlan: Protect ipvl_port.ipvlans with mutex.
      ipvlan: Support per-netns netdev unregistration.
      geneve: Unlink geneve->sock[46].hlist[46].hlist in __geneve_sock_release().
      geneve: Protect geneve_net and geneve_sock with per-netns mutex.
      geneve: Support per-netns netdev unregistration.
      pfcp: Protect pfcp_net.pfcp_dev_list with mutex.
      pfcp: Support per-netns netdev unregistration.
      amt: Don't support cross-netns setup.
      can: vxcan: support per-netns device unregistration.

Kyle Zeng (1):
      vxlan: keep the last remote linked during FDB flush

Lachlan Hodges (5):
      wifi: cfg80211: introduce helper to get S1G primary width
      wifi: ieee80211: introduce generic KHZ_TO_HZ helper
      mmc: sdio: add Morse Micro vendor ids
      wifi: mm81x: add mm81x Wi-Fi HaLow driver
      wifi: cfg80211: include cf1 offset when sending chandef

Larysa Zaremba (6):
      idpf: remove unused code for getting RSS info from device
      idpf: make mbx_task queueing and cancelling more consistent
      idpf: print a debug message and bail in case of non-event ctlq message
      ixd: add basic driver framework for Intel(R) Control Plane Function
      ixd: add reset checks and initialize the mailbox
      ixd: add the core initialization

Laxman Acharya (1):
      Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly

Laxman Acharya Padhya (4):
      wifi: mt76: mt7921: validate CLC firmware records
      wifi: mt76: mt7996: validate default EEPROM firmware size
      Bluetooth: hci_aml: validate firmware segment lengths
      Bluetooth: hci_event: validate LE Set CIG Parameters response

Lei Zhu (1):
      ionic: Change list definition method

Li Qiang (4):
      Bluetooth: bfusb: validate received block boundaries
      Bluetooth: btmrvl: validate event packet lengths
      Bluetooth: hci_bcsp: validate received packet lengths
      Bluetooth: hci_ldisc: reject invalid tty write lengths

Linghui Wu (2):
      wifi: ath10k: filter non-UTF testmode events
      wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdump

Linmao Li (11):
      wifi: nxpwifi: reject zero-length extension elements in beacon IEs
      wifi: mm81x: prevent timers from outliving teardown
      wifi: nxpwifi: detach sync command buffer on interrupted wait
      wifi: nxpwifi: bound uAP association event IEs to the event buffer
      Bluetooth: hci_conn: fix the SCO setup context lifetime
      Bluetooth: hci_sync: free the advertising instance on the failure and cancel paths
      Bluetooth: MGMT: free the mesh send cancel command when it is cancelled
      Bluetooth: MGMT: free the HCI command when it is cancelled
      nfc: digital: Do not dump a NULL response in command completion
      nfc: nci: free destination parameters when closing a connection
      nfc: trf7970a: Use NULL when no response is expected

Linus Walleij (6):
      net: dsa: realtek: rtl83xx: Make learning optional in join/leave
      net: dsa: realtek: rtl8366rb: Switch to generic port_bridge* handlers
      net: dsa: realtek: rtl8366rb: Use DSA port iterators
      net: dsa: realtek: rtl8366rb: Disable STP learning on all ports in setup
      net: dsa: realtek: rtl8366rb: Switch to generic learning enablement
      net: dsa: realtek: rtl8366rb: Fix up port isolation

Lorenzo Bianconi (9):
      net: airoha: add preliminary support to configure tx hw QoS queue during flowtable offloading
      net: ipip: use tunnel parameters for fill_forward_path route lookup
      net: ip6_tunnel: use tunnel parameters for fill_forward_path route lookup
      net: airoha: rename airoha_priv_flags to airoha_dev_flags
      net: airoha: fix ETS QoS stats counter underflow and cross-channel corruption
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload
      ipip: reject unsupported configurations in fill_forward_path
      net: airoha: fix ARRAY_SIZE() division by zero on UP builds
      net: pass net_device_path_ctx to dev_fill_forward_path()

Louis Kotze (2):
      wifi: cfg80211: say why the auth/assoc BSS lookup failed
      wifi: cfg80211: tests: check BSS lookup failure reasons

Luiz Augusto von Dentz (3):
      Bluetooth: Add support for Shorter Connection Interval (SCI) feature
      Bluetooth: Add MGMT Shorter Connection Interval setting
      Bluetooth: Add MGMT Load Connection Subrate command

Luxiao Xu (1):
      ipv6: fix use-after-free in ip6_finish_output2()

Maciej Fijalkowski (1):
      selftests/xsk: Preserve UMEM view in BIDIRECTIONAL test

Mahanta Jambigi (1):
      net/smc: hash socket only after full initialisation in smc_sk_init()

Manikanta Pubbisetty (1):
      wifi: ath10k: trigger hardware recovery upon rx failures

Manish Dharanenthiran (1):
      wifi: ath12k: advertise ieee_link_id in vdev start MLO params

Manuel Ebner (1):
      dt-bindings: net: microchip: fix entry

Maoyi Xie (1):
      l2tp: send netlink notifications in the tunnel's net namespace

Marc Kleine-Budde (2):
      Merge patch series "dt-bindings: can: rockchip: add rk3588 CAN-FD compatible"
      Merge patch series "dt-bindings: can: xilinx_can: Document phys and update maintainer"

Marcelo Mendes Spessoto Junior (6):
      selftests: net: test IPV6_FL_A_RENEW
      selftests: net: test IPV6_FL_F_REMOTE
      selftests: net: create own netns in ipv6_flowlabel_mgr
      selftests: net: test IPV6_FL_F_REFLECT
      selftests: net: adopt harness for flow label mgr
      selftests: net: separate ipv6_flowlabel_mgr test

Marek Szyprowski (1):
      Bluetooth: btmrvl: fix event packet length validation

Mariano Baragiola (1):
      wifi: wilc1000: validate monitor transmit frame headers

Markus Schneider-Pargmann (The Capable Hub) (1):
      can: m_can: pci: Remove driver_data

Martino Dell'Ambrogio (2):
      net: sfp: allow prefix matching in quirk lookup
      net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI

Masi Osmani (3):
      wifi: carl9170: mac80211: document spatial multiplexing power save handler
      wifi: carl9170: rx: track PHY errors via debugfs
      wifi: carl9170: cmd: downgrade transient register I/O errors to wiphy_dbg

Matthew Leach (1):
      wifi: ath12k: fix survey indexing across bands

Matthieu Baerts (NGI0) (4):
      mptcp: pm: userspace: make remove_addr_entry static
      selftests: mptcp: connect: test name in pcap file
      selftests: mptcp: simult_flow: test name in pcap file
      selftests: mptcp: pcap: drop most of the payload

Maxime Chevallier (11):
      net: phylink: Drop references to the .validate() method in comments
      net: phy: at803x: Use a helper to check for phy reset existence
      net: phy: drop duplicated header include in mdio-device
      net: stmmac: Simplify ioctl handling
      net: mdio: Kconfig: Group mdio controller drivers in a submenu
      net: mdio: Kconfig: Group mdio multiplexers in a submenu
      net: phy: micrel: Add loopback support for ksz9131
      net: stmmac: Don't use PHY loopback for selftests
      net: stmmac: Don't rely on the PHY for flow-control testing
      net: stmmac: ethtool: Comment the magic numbers in RIWT computation
      net: stmmac: ethtool: Address off-by-one when reading the coal rx-usecs

Maximilian Immanuel Brandtner (1):
      tls: fix RX desync on overlapping skbs

Mengyuan Lou (2):
      net: libwx: add support for set_ringparam in wx_ethtool_ops_vf
      net: libwx: add support for set_coalesce in wx_ethtool_ops_vf

Miaoqing Pan (7):
      wifi: ath12k: fix TLV32 length mask
      wifi: ath12k: refactor HAL TLV32/64 decode helpers
      wifi: ath12k: add HAL ops for monitor TLV header decode and alignment
      wifi: ath12k: add dp_mon support 32-bit TLV headers
      wifi: ath12k: tighten RX monitor TLV bounds check
      wifi: ath12k: fix ML-STA authentication timeout on QCC2072
      wifi: ath11k: add purwa-iot-evk and qcs6490-rb3gen2 to usecase firmware table

Michael Chan (1):
      bnxt_en: Add missing NETIF_F_TSO_ECN feature flag

Michael Guralnik (1):
      net/mlx5: rsc_dump and hv_vhca return NULL on create error

Michael-CY Lee (2):
      wifi: mt76: fix non-AQL packet accounting for MLO stations
      wifi: mt76: assign link_id when sending probe request during scan

Mihail Dimoski (1):
      wifi: rtw88: disable ASPM and deep PS on ASUS TUF Gaming A15 FA506II

Mike Rapoport (Microsoft) (8):
      wifi: b43, b43legacy: debugfs: use kzalloc() to allocate formatting buffers
      wifi: libertas: debugfs: use kzalloc() to allocate formatting buffers
      wifi: mwifiex: debugfs: use kzalloc() to allocate formatting buffers
      wifi: wlcore: allocate aggregation and firmware log buffers with kzalloc()
      bnx2x: use kzalloc() to allocate mac filtering list
      ice: use kzalloc() to allocate staging buffer for reading from GNSS
      sfc/siena: use kmalloc() to allocate logging buffer
      sfc: use kmalloc() to allocate logging buffer

Mikhail Lukianchikov (1):
      dt-bindings: net: microchip,lan78xx: convert to DT schema

Minghao Zhang (1):
      netfilter: conntrack: tcp: use UNACK timeout for non-closing RST packets

Minhong He (8):
      ipv4: nexthop: handle errors in nexthop_init()
      net: failover: check register_netdevice_notifier() error in failover_init()
      net: lapbether: check register_netdevice_notifier() error in lapbeth_init_driver()
      net: team: check register_netdevice_notifier() error in team_module_init()
      net: macvlan: check register_netdevice_notifier() error in macvlan_init_module()
      net: vrf: check register_netdevice_notifier() error in vrf_init_module()
      net: bonding: check register_netdevice_notifier() error in bonding_init()
      batman-adv: handle errors in batadv_init()

Minxi Hou (3):
      selftests/net/openvswitch: add output truncation test
      selftests/net/openvswitch: add ICMPv6 echo type match test
      selftests/net/openvswitch: add SCTP flow key support and test

Miri Korenblit (6):
      wifi: iwlwifi: add a compile time check for too long hcmds
      wifi: iwlwifi: support TTL platform device ID
      wifi: iwlwifi: mld: cancel wiphy work before freeing wiphy
      wifi: iwlwifi: mld: add PNVM_INIT_COMPLETE_NTFY to the hcmd names
      wifi: iwlwifi: mld: move BIOS reading code to where it belongs
      wifi: iwlwifi: bump core version for BZ/SC/DR

Mohsin Bashir (15):
      selftests: drv-net: Test queue stall upon reconfig
      selftests: net: shaper: Drop redundant command timeouts
      selftests: net: shaper: Prepare helpers for group tests
      selftests: net: shaper: Decouple basic_groups from netdev rate limiting
      selftests: net: shaper: Add basic_groups_with_rate test
      selftests: net: shaper: Add node scope .set rate update test
      selftests: net: shaper: Add .group rate update test
      selftests: net: shaper: Add nested depth limit discovery test
      selftests: net: shaper: Add child node deletion reparent test
      selftests: net: shaper: Add queue migration between nodes test
      selftests: net: shaper: Add reparenting rejection test
      selftests: net: shaper: Cover scalar attributes
      selftests: net: shaper: Reject invalid set requests
      selftests: net: shaper: Cover mixed-parent grouping
      selftests: net: shaper: Cover recursive node cleanup

Moshe Shemesh (2):
      devlink: print controller prefix for non-zero controller
      net/mlx5: Set satellite PF devlink ports as non-external

Muhammad Bilal (1):
      nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers

Muhammad Saheed (1):
      Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot

Myeonghun Pak (1):
      ptp: fc3: register PTP clock after initialization

Nagamani PV (1):
      s390/ctcm: Convert fsm.h to proper kernel-doc format

Nguyen Dinh Phi (3):
      vsock: don't check the listener's sk_err in vsock_accept()
      vsock: remove the now-unused rejected flag
      vsock: use sock_error() to consume sk_err after a failed connect

Nguyen Quang Le Kien (1):
      usb: atm: cxacru: fix use-after-free in cxacru_poll_status

Nicolas Escande (1):
      wifi: ath12k: avoid setting 320MHz support on non 6GHz band

Nikhil P. Rao (2):
      pds_core: add host backed memory support for firmware
      pds_core: add debugfs support for host backed memory

Niklas Söderlund (1):
      net: dsa: microchip: Fix log typo in error path

Nikolay Aleksandrov (3):
      devlink: add generic device max_sfs parameter
      net/mlx5: implement max_sfs parameter
      net: bridge: vlan: fix inverted default vlan notification

Nimrod Oren (5):
      selftests: drv-net: allow switching env IP version
      selftests: drv-net: xdp: run with both IP versions
      net/mlx5: initialize doorbell dma pools
      net/mlx5: allocate doorbells from dma pools
      net/mlx5: add debugfs stats for doorbell dma pools

Nirmoy Das (1):
      selftests: net: make busywait timeout clock portable

Nora Schiffer (5):
      batman-adv: create hardif only for netdevs that are part of a mesh
      batman-adv: remove global hardif list
      batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
      batman-adv: move hardif generation counter into batadv_priv
      batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()

P Praneesh (5):
      wifi: cfg80211: Drop unused link stats handling in nl80211_send_station()
      wifi: cfg80211: Add helper to pack station-level STA_INFO
      wifi: cfg80211: Refactor nl80211_dump_station() to prepare for per-link stats
      wifi: cfg80211: Fragment per-link station stats in nl80211_dump_station()
      wifi: cfg80211: support MAC address filtering in station dump for link stats

Pablo Neira Ayuso (20):
      netfilter: flowtable: tear down flow entries with stale dst from GC
      netfilter: conntrack_helper: pass master conntrack to helper functions
      netfilter: nf_conntrack_expect: store event cache in expectation
      netfilter: flowtable: consolidate net_device field in nft_forward_info struct
      netfilter: flowtable: consolidate flowtable device check
      net: dsa: stop at the user device in .fill_forward_path
      net: do not advance stack index from dev_fwd_path()
      net: pass dst via net_device_path in dev_fill_forward_path()
      netfilter: flowtable: release tunnel route on error when building forward path
      netfilter: nf_tables: call skb_valid_dst() before skb_dst()
      netfilter: add DEBUG_NET_WARN_ON_ONCE to skb_set_nfct()
      net: netfilter: add ether_type to net_device_path_ctx and use it
      netfilter: flowtable: rename tun.l3_proto to tun.inner_proto
      netfilter: flowtable: rename ctx.tun.proto to ctx.tun.inner_proto
      netfilter: flowtable: store ethertype in flowtable context
      netfilter: flowtable: move ipv4 and ipv6 xmit path to function
      netfilter: flowtable: detach layer 2 encapsulation parser from lookup
      netfilter: nft_ct: move custom expectation support to helper
      netfilter: conntrack: always lower timeout for non-closing RST packets
      netfilter: nf_conntrack_expect: bail out on insert dead expectations

Pablo Vallespín Aranguren (1):
      net: tulip: remove xircom_cb driver

Pagadala Yesu Anjaneyulu (8):
      wifi: iwlwifi: ignore raw-DSM TLV for LARI cmd version 13 and above
      wifi: iwlwifi: regulatory: add LARI_CONFIG_CHANGE command v14 support
      wifi: iwlwifi: mld: honor FW puncturing capability in MCC response
      wifi: iwlwifi: mvm: add LARI_CONFIG_EXTENSION command
      wifi: iwlwifi: mld: support update_mcc notification v2
      wifi: iwlwifi: mld: add debug log after AP type command
      wifi: mac80211: notify driver before destroying assoc link
      wifi: iwlwifi: regulatory: add LARI v15 DSM support bitmap

Panagiotis Petrakopoulos (1):
      wifi: rtw89: use str_enable_disable() helper

Paolo Abeni (62):
      Merge branch 'dpaa2-switch-add-support-for-lag-offload'
      Merge branch 'net-fib_rules-rtnl-less-rtm_newrule-and-rtm_delrule'
      Merge tag 'batadv-next-pullrequest-20260630' of https://git.open-mesh.org/batadv
      Merge branch 'net-remove-the-orphaned-ibm-ehea-driver'
      Merge branch 'net-dsa-realtek-rtl8366rb-use-generic-rtl83xx-code'
      Merge branch 'net-convert-udp-getsockopt-to-sockopt_t'
      Merge branch 'octeontx2-af-npc-parser-and-rss-improvements'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-report-multicast-group-user-count'
      Merge branch 'tools-ynl-pyynl-pull-the-family-resolution-logic-into-the-lib'
      Merge branch 'macvlan-rtnl-less-macvlan_fill_info'
      Merge tag 'nf-next-26-07-02' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'dpll-add-nco-pin-type-and-zl3073x-support'
      Merge branch 'net-misc-follow-up-on-rtnl-less-fib_rules-series'
      Merge branch 'devlink-and-mlx5-support-cross-function-rate-scheduling'
      Merge tag 'sfc-net-pullrequest-20260630' of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
      Merge branch 'net-hold-instance-lock-around-netdev_down-and-netdev_going_down'
      Merge branch 'drivers-net-ethernet-replace-__get_free_pages-with-kmalloc'
      Merge branch 'net-dsa-microchip-move-non-common-function-out-of-ksz_common-c'
      Merge branch 'devlink-extend-phys_port_name-controller-prefix-to-non-external-ports'
      Merge branch 'selftests-drv-net-run-xdp-tests-with-both-ip-versions'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-support-per-netns-device-unregistration'
      Merge branch 'netconsole-stop-charging-netpoll-users-for-netconsole-only-data'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-stmmac-eic7700-add-eth1-variant-support-and-update-delay-bindings'
      Merge branch 'geneve-make-geneve_fill_info-rtnl-less'
      Merge branch 'net-add-adin1140-support'
      Merge branch 'udp-fix-fou-gue-over-multicast'
      Merge branch 'ipv4-update-rt_flush_dev-and-two-dst-dev-readers'
      Merge branch 'bridge-mcast-fix-a-false-positive-lockdep-splat'
      Merge branch 'mlxsw-make-the-driver-ops-locked'
      Merge branch 'big-tcp-for-udp-tunnels'
      docs: netdev: clarify handling of idle patches
      docs: netdev: clarify expected interactions with LLMs
      Merge branch 'xdp-metadata-support-for-dq-rda'
      Merge branch 'net-lan743x-add-rmii-support-for-pci11x1x'
      Merge branch 'improve-wwan-qcdm-compatibility-with-user-space-tools'
      Merge branch 'airoha-add-the-capability-to-configure-gdm3-gdm4-as-wan-lan-on-demand'
      Merge branch 'netpoll-finish-untangling-netconsole-from-netpoll'
      Merge branch 'net-remove-conditional-returns-with-no-effect'
      Merge branch 'geneve-support-per-netns-device-unregistration'
      Merge branch 'openvswitch-remove-support-for-legacy-tunnel-ports'
      Merge branch 'dpll-use-pin-owner-s-dpll-ref-for-pin-level-set-callbacks'
      Merge branch 'net-hns3-some-cleanups-for-hns3-driver'
      mptcp: move the retrans loop to a separate helper
      mptcp: move the stale logic out of retrans scheduler
      mptcp: let the retrans scheduler do its job
      mptcp: explicitly drop over memory limits
      mptcp: enforce hard limit on backlog flushing
      mptcp: avoid code duplication in __mptcp_move_skb()
      mptcp: implemented OoO queue pruning
      Merge branch 'ipv6-report-why-a-route-was-deleted-in-rtm_delroute'
      Merge branch 'net-rds-bug-fix-ports-part-2'
      Merge branch 'net-sysctl-const-qualify-sysctl-ctl_table-arrays'
      Merge branch 'net-mana-avoid-dma-queue-allocation-failure-under-memory-fragmentation'
      Merge branch 'netconsole-replace-target_list_lock-by-rcu-on-userdata-hot-path'
      Merge branch 'net-fix-ip6gre-header-length-before-capping-tunnel-headroom'
      Merge branch 'vsock-fix-stale-sk_err-handling-after-a-failed-connect'
      Merge branch 'net-pse-pd-add-realtek-pse-mcu-support'
      Merge branch 'net-dsa-mt7628-embedded-switch-initial-support'

Paritosh Potukuchi (1):
      net : bonding : Remove TODO comment about retrying setting the MAC

Pauli Virtanen (7):
      Bluetooth: af_bluetooth: Add minimal context analysis annotations
      Bluetooth: hci_core: Add minimal context analysis annotations
      Bluetooth: L2CAP: Add minimal context analysis annotations
      Bluetooth: RFCOMM: Add minimal context analysis annotations
      Bluetooth: enable context analysis
      Bluetooth: L2CAP: use proto_lock for l2cap_data to fix l2cap_disconn_ind
      Bluetooth: add annotations for l2cap_data locking context

Paulo Alcantara (1):
      net: dns_resolver: allow shorter names in dns_query()

Pavan Kumar Linga (4):
      libeth: allow to create fill queues without NAPI
      idpf: remove 'vport_params_reqd' field
      idpf: refactor idpf to use libie_pci APIs
      idpf: refactor idpf to use libie control queues

Pavankumar Nandeshwar (2):
      wifi: ath12k: Use different RX release ring sizes as per memory profiles
      wifi: ath12k: skip MLO multicast links during crash recovery in Tx path

Pavel Pisa (1):
      docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CAN FD

Pavel Zverev (1):
      Bluetooth: btusb: Add support for 1357:c123 Realtek 8852BE device

Pawel Zalewski (The Capable Hub) (2):
      Bluetooth: use a named initializer for acpi_device_id
      Bluetooth: hci_intel: drop unused assignment of acpi_device_id::driver_data

Pengfei Zhang (1):
      ipv4: fib: fix route re-dump in inet_dump_fib() on multi-batch dump

Pengpeng Hou (6):
      wifi: rtw89: fix HE extended capability length check
      wifi: iwlwifi: validate PNVM SKU TLV length
      wifi: iwlwifi: validate UEFI reduced-power SKU TLV length
      wifi: ath11k: validate regulatory capability phy_id
      Bluetooth: hci_nokia: validate firmware packet bounds
      nfc: microread: validate target discovery payload lengths

Peter Chiu (4):
      wifi: mt76: mt7996: fix MLD ID in MAC TXD and HIF TXP
      wifi: mt76: mt7996: add mcu command to set bssid mapping address
      wifi: mt76: mt7996: leave PS when a 4-address connection is established
      wifi: mt76: fix queue assignment for disassoc packets

Petr Oros (2):
      ice: clear the default forwarding VSI rule when releasing a VSI
      dpll: fix NULL deref in dpll_device_ops() during teardown race

Petr Vorel (2):
      selftests: drv-net: Fix csum path in doc
      selftests: drv-net: Fix TSO test doc

Phani R Burra (3):
      libie: add PCI device initialization helpers to libie
      libie: add control queue support
      libie: add bookkeeping support for control queue messages

Phil Elwell (1):
      wifi: brcmfmac: 43430 and 43455 are CYW parts

Phil Sutter (1):
      netfilter: nfnetlink_hook: Dump nat type chains

Ping-Ke Shih (24):
      wifi: rtw89: fw: add first set of firmware features by version for RTL8922D
      wifi: rtw89: fw: support scan offload v2 for WiFi 7 chips
      wifi: rtl8xxxu: 8723bu: remove reference of non-existing firmware rtl8723bu_bt.bin
      wifi: rtw89: mac: finish active TX immediately without waiting for DMAC
      wifi: rtw89: mac: pass chip version to firmware
      wifi: rtw89: fw: lower debug level for UDM1 debug register
      wifi: rtw89: 8922d: set TX compensation by format v2
      wifi: rtw89: efuse: no need to export rtw89_efuse_read_ecv_be()
      wifi: rtw89: efuse: read thermal calibration value for RTL8922D
      wifi: rtw89: 8922d: read default digital voltage calibration values
      wifi: rtw89: add thermal protect by digital voltage reduction
      wifi: rtw89: 8922d: set ANA CLK enter to 500KHz
      wifi: rtw89: 8922d: update scaling factor for RX path
      wifi: rtw89: phy: add NCTL check for WiFi 7 chips
      wifi: rtw89: unify access struct of TX power track tables
      wifi: rtw89: set needed firmware elements for early chips transition
      wifi: rtw89: mac: abstract register definition of firmware boot debug
      wifi: rtw89: 8922d: add TX time limit for 2GHz band
      wifi: rtw89: fw: do bb_preinit before downloading firmware
      wifi: rtw89: wow: extend timeout unit to avoid SER false alarm
      wifi: rtw89: pci: set PCIe maximum TS1 for RTL8922DE
      wifi: rtw89: 8922d: reduce IO in power-on function
      wifi: rtw89: phy: set CFR to manual mode for some 2GHz channels
      wifi: rtw89: 8922d: enable Makefile and Kconfig for RTL8922DE

Po-Hao Huang (2):
      wifi: rtw89: fix scan offload version check logic
      wifi: rtw89: change scan offload format to V3 for WiFi 7 IC

Prabu Thayalan (1):
      ionic: fix completion descriptor access with 2x desc size

Prashant Rahul (1):
      wifi: mt76: mt7921: fix memory leak when skb_linearize fails in mcu rx event

Praveen Rajendran (2):
      net: qed: Fix spelling typo in qed_dcbx.c comment
      wifi: iwlwifi: fw: Fix spelling typo in error-dump.h

Priyansha Tiwari (4):
      wifi: nl80211/cfg80211: rename probe_client to probe_peer
      wifi: cfg80211/nl80211: add STA-mode peer probing
      wifi: mac80211: implement STA-mode peer probing
      wifi: mac80211_hwsim: report TX status link_id

Przemyslaw Korba (1):
      ice: fall back to SBQ when LL PHY timer interface times out

Qi Zhang (1):
      net: pktgen: use a consistent flow count

Qing Luo (2):
      sctp: auth: discard auth_chunk when skb_clone fails
      sctp: auth: propagate HMAC calculation errors to callers

Qing Ming (1):
      mpls: reload header after pskb_may_pull()

Qingfang Deng (6):
      ppp: convert chan_sem to a mutex
      ppp: use netdev_from_priv()
      pppoe: remove redundant xmit wrapper
      ppp: annotate lockless queue empty check
      pptp: drop packets received before connect
      pppox: drain queued packets on channel handoff

Qingshuang Fu (1):
      selftests: netfilter: conntrack_dump_flush: remove unused variables and fix typo

Raj Kumar Bhagat (2):
      wifi: ath12k: Fix inconsistencies in struct qmi_elem_info initializers
      wifi: ath12k: use %u for unsigned variables in QMI debug logs

Randy Dunlap (1):
      rfkill: repair malformed kernel-doc and add some descriptions

Ratheesh Kannoth (1):
      octeontx2-pf: link RQ page pools to netdev for Netlink stats

Reshma Immaculate Rajkumar (1):
      wifi: ath12k: fix encrypted EAPOL TX in encap offload mode

Rex Lu (2):
      wifi: mt76: fix RX data queuing of RRO 3.0
      wifi: mt76: check txfree done event on the WED hw path

Robert Malz (1):
      ice: acquire NVM lock around each flash read

Robert Marko (1):
      net: sparx5: configure TAS port link speed

Ronan Marchal (1):
      net: niu: fix potential buffer overflow/truncation in irq names

Rongguang Wei (1):
      tap: fix incorrect variable used for USO check in set_offload()

Rosen Penev (4):
      net: gianfar: dispose irq mappings on probe failure and device removal
      net: dsa: qca8k: fall back to ethernet-ports node name for LEDs
      wifi: nxpwifi: embed rx_reorder_ptr
      nfc: pn533: fix memcpy overflow warning

Runyu Xiao (5):
      wifi: rtlwifi: rtl8192du: check QoS TID before indexing tids
      gtp: annotate PDP lookups under RTNL
      net: rmnet: annotate endpoint lookup under RTNL
      wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex
      net: ibm: emac: mal: fix NAPI locking

Ruoyu Wang (3):
      net: dsa: mv88e6xxx: Fix PCS link check on CMODE read error
      bonding: initialize err for empty target lists
      net: openvswitch: fix nf_connlabels leak in ovs_ct_init

Russell King (Oracle) (1):
      net: phylink: allow PHYs to be attached in 802.3z inband mode

Ryan Leung (1):
      wifi: mt76: mt7915: add thermal zone device registration

Samuel Page (2):
      nfc: nci: fix out-of-bounds write in nci_target_auto_activated()
      nfc: nci: fix uninit-value in the RF discover/activated NTF handlers

Sandeep Sondagar (1):
      net: phylink: treat PSGMII as an inband capable interface

Sang-Heon Jeon (7):
      wifi: rtlwifi: rtl8821ae: remove conditional return with no effect in _rtl8821ae_llt_write()
      wifi: rtw89: remove conditional return with no effect in sys_init_*()
      dpll: zl3073x: remove conditional return with no effect
      net: ethernet: remove conditional return with no effect
      net: remove conditional return with no effect
      net: intel: remove conditional return with no effect
      wifi: ath6kl: return 0 explicitly in ath6kl_init_upload()

Satha Rao (1):
      octeontx2-af: add new mbox to support sync cycle on rx path

Satheesh Paul (1):
      octeontx2-af: Add mailbox to read default MCAM entry

Satheesh Paul A (1):
      octeontx2-af: add support for custom L2 header

Satish Kharat (11):
      enic: verify firmware supports V2 SR-IOV at probe time
      enic: add admin channel open and close for SR-IOV
      enic: add admin RQ buffer management
      enic: add admin CQ service with MSI-X interrupt and workqueue polling
      enic: define MBOX message types and header structures
      enic: add MBOX core send and receive for admin channel
      enic: add MBOX PF handlers for VF register and capability
      enic: add MBOX VF handlers for capability, register and link state
      enic: wire V2 SR-IOV enable with admin channel and MBOX
      enic: add V2 VF probe with admin channel and PF registration
      enic: re-establish V2 VF admin channel and PF registration after reset

Sean Nyekjaer (1):
      can: tcan4x5x: put tcan into sleep when removing driver

Sean Wang (19):
      wifi: mt76: mt792x: advertise mgmt frame registration
      wifi: mt76: mt7925: guard BSS capability lookups
      wifi: mt76: connac: add NAN connection type
      wifi: mt76: mt7925: add NAN MCU helpers
      wifi: mt76: mt7925: add NAN MCU handling
      wifi: mt76: add init_wiphy callback
      wifi: mt76: mt7925: wire up NAN operations
      wifi: mt76: mt792x: build iface combinations dynamically
      wifi: mt76: mt792x: advertise NAN data support
      wifi: mt76: mt7925: stop init retries on hung bus
      wifi: mt76: mt7925: skip reset work on hung bus
      wifi: mt76: mt792x: stop USB register access after bus hang
      wifi: mt76: mt792x: drain USB UDMA before WFSYS reset
      wifi: mt76: mt792x: enable USB UDMA TX timeout
      wifi: mt76: mt792x: quiesce USB paths on disconnect
      wifi: mt76: mt7927: set band index for sniffer mode
      wifi: mt76: mt7927: use real monitor vifs for dual-band monitors
      wifi: mt76: mt7925: support new WoW pattern TLV
      Bluetooth: btusb: Add new VID/PID 0x0489/0xe156 for MT7902

Shahar Tzarfati (2):
      wifi: iwlwifi: mld: fix read in wake packet notification handler
      wifi: mac80211: ibss: read deauth reason_code after frame length check

Shaikh Kamaluddin (1):
      netlink: specs: nl80211: fix TOOD -> TODO

Sharath Srinivasan (2):
      net/rds: fix rds_message leak in the rds_send_xmit() drop path
      net/rds: reinitialize to_be_dropped on rds_send_xmit() restart

Shardul Bankar (2):
      mptcp: add per-event MIB counters for MPTCP_RST_EMPTCP resets
      selftests: mptcp: check per-event MPTCP_RST_EMPTCP counters

Shay Drory (3):
      net/mlx5: Drop redundant esw_cap, reuse e_switch_cap
      devlink: Expose external flag for PCI SF ports
      net/mlx5: SD, prefer sd_group_size from vport context

Shayne Chen (2):
      wifi: mt76: fix handling channel context with different bands in mt76_switch_vif_chanctx()
      wifi: mt76: mt7996: fix capability of EHT-MCS 15 in MRU

Sherry Sun (1):
      Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq

Shijith Thotton (1):
      octeontx2-af: return VWQE timer delay in NIX HW info

Siddaraju DH (1):
      ethtool: link 10000baseCR to SFF-8431, Appendix-E SFP+ DA

Simon Horman (1):
      Revert "gtp: annotate PDP lookups under RTNL"

Simon Schippers (5):
      tun/tap: add IFF_BACKPRESSURE flag
      tun/tap: add ptr_ring consume helper with netdev queue wakeup
      vhost-net: wake queue of tun/tap after ptr_ring consume
      ptr_ring: move free-space check into separate helper
      tun/tap & vhost-net: stop tail-drop when IFF_BACKPRESSURE is set

Siwei Zhang (1):
      Bluetooth: hci_sync: Remove unused hci_cmd_sync_dequeue_once()

Slawomir Stepien (2):
      wifi: zd1211rw: reject secondary interfaces to prevent conflicts
      netdevsim: drop the ability to change max_vfs via debugfs

Sreeramya Soratkal (3):
      wifi: ath12k: Use runtime device count in dp stats display
      wifi: ath12k: Add timestamp to dp stats display
      wifi: ath12k: Show per-radio center freq in dp stats

Srinivas Achary (1):
      wifi: cfg80211: change mesh_setup::ie_len to size_t

Stanislav Fomichev (6):
      net: hold instance lock around NETDEV_DOWN/GOING_DOWN
      net: dsa: hold instance lock on close-on-shutdown paths
      net: mtk_eth_soc: hold instance lock around DMA-device-swap close
      net: rtnetlink: take instance lock inside rtnl_configure_link
      net: require instance lock for NETDEV_DOWN/GOING_DOWN notifiers
      net: document NETDEV_UNREGISTER unlocked rationale

Stanislaw Gruszka (1):
      wifi: rtl818x: initialize eeprom_93cx6 struct to zero

StanleyYP Wang (4):
      wifi: mt76: mt7996: add missing rdd_idx check when enabling background radar
      wifi: mt76: mt7996: fix reg addr remap when addr is 0
      wifi: mt76: mt7996: remove repeater muar config
      wifi: mt76: mt7996: add scan dwell time hw cap

Stefan Hansson (1):
      wifi: rsi: Fix types to appease CFI

Subasri S (3):
      netfilter: remove redundant null check before kvfree()
      ipvs: use type-safe allocation helpers in ip_vs_rht_alloc
      usb: atm: ueagle-atm: fix array-index-out-of-bounds in uea_bind()

Sumit Garg (5):
      firmware: qcom: Add a generic PAS service
      firmware: qcom_scm: Migrate to generic PAS service
      firmware: qcom: Add a PAS TEE service
      MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
      wifi: ath12k: Switch to generic PAS TZ APIs

Suraj Gupta (1):
      net: xilinx: axienet: Treat xlnx,rxmem as a required property

Sushant Butta (2):
      wifi: ath12k: Skip setting RX_FLAG_8023 for Ethernet-II (DIX) frames in monitor mode
      wifi: ath12k: Skip peer link info update in rx_status for monitor MSDUs

Sven Eckelmann (19):
      batman-adv: make hard_iface->mesh_iface immutable
      batman-adv: drop NULL check for immutable hardif->mesh_iface
      Revert "batman-adv: v: stop OGMv2 on disabled interface"
      batman-adv: iv: drop migration check for batadv_hard_iface
      batman-adv: tvlv: extract tvlv header iterator
      batman-adv: tp_meter: simplify unordered ack calculation
      batman-adv: tp_meter: combine adjacent/overlapping unacked entries
      batman-adv: tp_meter: keep unacked list for receivers
      batman-adv: tp_meter: adjust name of receiver lock
      batman-adv: tp_meter: delay allocation of unacked entry
      batman-adv: dat: drop non-4addr backwards compatibility
      batman-adv: tvlv: handle negative tvlv processing return codes
      batman-adv: add missing kernel-doc comments
      batman-adv: fix kernel-doc for functions holding skb ownership
      batman-adv: annotate functions which may reallocate the skbuff
      batman-adv: split multiple declarations per line
      batman-adv: switch var declarations to reverse x-mas tree order
      batman-adv: correct NET_RX_* NET_XMIT_* confusion
      batman-adv: remove negative returns for batadv_send_skb_unicast

T.J. Mercier (1):
      selftests: drv-net: ncdevmem: Open /dev/udmabuf O_RDONLY

Takashi Kozu (3):
      igb: prepare for RSS key get/set support
      igb: expose RSS key via ethtool get_rxfh
      igb: allow configuring RSS key via ethtool set_rxfh

Tamizh Chelvam Raja (2):
      wifi: ath12k: Advertise multicast Ethernet encapsulation offload support
      wifi: ath12k: Set IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param

Tao Cui (1):
      mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow

Tariq Toukan (1):
      net/mlx5e: Fix indentation in mlx5e_free_mpwqe_rq_drop_page()

Tejas Birajdar (1):
      tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path

Tetsuo Handa (1):
      net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()

Thaison Phan (2):
      tools: ynl: check for null ptr on dump free
      tools: ynl: check alloc fails in generated getter code

Thangaraj Samynathan (2):
      net: lan743x: add RMII strap status detection for PCI11x1x
      net: lan743x: add support for RMII interface

Thiraviyam Mariyappan (2):
      wifi: ath12k: Reduce RX SRNG interrupt timer threshold to 200us
      wifi: ath12k: Set congestion control max MSDU count

Thorsten Blum (2):
      net: chelsio: cxgb4: Use str_plural() in mem_intr_handler()
      keys, dns: Drop unused NUL terminator from upayload->data

Théo Lebrun (7):
      net: macb: drop "consistent" from alloc/free function names
      net: macb: unify device pointer naming convention
      net: macb: unify variable naming convention in at91ether functions
      net: macb: unify queue index variable naming convention and types
      net: macb: enforce reverse christmas tree (RCT) convention
      net: macb: allocate tieoff descriptor once across device lifetime
      net: macb: refuse set_ringparam on EMAC

Tibor Harcsa (1):
      Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table

Uwe Kleine-König (The Capable Hub) (13):
      net: phy: Drop #inclusion of <linux/mod_devicetable.h> from <linux/mdio.h>
      nfc: Drop __maybe_unused from acpi_device_id tables
      nfc: Drop unused assignment of acpi_device_id driver data
      nfc: Initialize acpi_device_id arrays using member names
      nfc: Unify style of acpi_device_id arrays
      nfc: pn544: Drop empty line between i2c_device_id array and MODULE_DEVICE_TABLE()
      nfc: Initialize mei_cl_device_idarrays using member names
      nfc: Drop __maybe_unused from of_device_id tables
      nfc: Unify style of of_device_id arrays
      nfc: Drop unused assignment of spi_device_id driver data
      nfc: Initialize spi_device_idarrays using member names
      nfc: Unify style of spi_device_id arrays
      nfc: Unify style of usb_device_id arrays

Vadim Fedorenko (1):
      bnxt_en: enable PTM function

Victor Nogueira (2):
      selftests/tc-testing: Add tests that force multiq and taprio to enqueue to child's gso_skb
      net/sched: cls_api: fix teardown of an adopted proto on insert-race loss

Victor Raj (1):
      virtchnl: move virtchnl and virtchnl2 headers to 'include/linux/net/intel'

Vikas Gupta (3):
      bnge: refactor rx mode helpers to accept explicit address lists
      bnge: add ndo_set_rx_mode_async support
      bnge: send hwrm for interface down/up transitions

Vincent Jardin (2):
      dt-bindings: dpll: zl3073x: ZL30643 is compatible
      dpll: zl3073x: recognize the ZL30643 chip ID (0x0E3B)

Vineeth Karumanchi (1):
      net: macb: remove unused ENST Q0/Q1 time register defines

Vitaliy Sochnev (1):
      net: airoha: npu: load the firmware without the sysfs fallback

Vladimir Oltean (3):
      net: dsa: microchip: split ksz8_change_mtu()
      net: dsa: microchip: split port_max_mtu() implementation
      net: dsa: b53: fix error propagation from b53_fdb_dump()

Wei Fang (14):
      net: enetc: extract common helpers for MAC promiscuous mode setting
      net: enetc: extract common helpers for MAC hash filter configuration
      net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
      net: enetc: improve MAFT entry management with bitmap tracking
      net: enetc: use PCI device name for debugfs directory
      net: enetc: simplify enetc4_set_port_speed()
      net: enetc: remove invalid code from enetc4_pl_mac_link_up()
      net: enetc: open-code enetc4_set_default_si_vlan_promisc()
      net: enetc: refactor SI VLAN promiscuous mode configuration
      net: enetc: move enetc_set_si_vlan_promisc() to enetc_pf_common.c
      net: enetc: remove redundant num_vsi field from enetc_port_caps
      net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
      net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
      ptp: netc: skip PEROUT disable if channel is not enabled

Wei Wang (1):
      psp: use unrcu_pointer() for the cmpxchg() on netdev psp_dev

Wei Zhang (1):
      wifi: ath12k: fix rx_mpdu_start layout for QCC2072

Weimin Xiong (1):
      net/rds: use krealloc_array() for iovector growth

Wentao Guan (2):
      wifi: rtw89: fw: correct preload field of w2 in rtw89_fw_h2c_default_cmac_tbl_be()
      wifi: mt76: mt7925: cancel pending mlo_pm_work

Willem de Bruijn (3):
      selftests: drv-net: so_txtime: only send test traffic to sch_etf
      idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc
      selftests: drv-net: so_txtime: fix qdisc replace with handle

William Hansen-Baird (4):
      wifi: rtlwifi: rtl8723be: Remove unnecessary irq save/restore in hw_init()
      wifi: rtlwifi: fix disabling of ASPM for RTL8723BE with AER flooding
      wifi: rtlwifi: convert pci if-statement to ID table
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 17aa:b736

William Kucharski (1):
      net/rds: initialize i_conn_path in rds_inc_init()

Wolfram Sang (1):
      net: ethernet: qualcomm: remove unneeded 'fast_io' parameter in regmap_config

Xiang Mei (1):
      vxlan: vnifilter: enforce exact length of GROUP/GROUP6 attributes

Xiang Mei (Microsoft) (1):
      macvlan: require init-userns CAP_NET_ADMIN to raise bc_queue_len

Xiang-Bin Shi (1):
      atm: remove unused exported helpers

Xin Xie (5):
      net: hsr: add PRP interlink (RedBox) datapath and duplicate discard
      net: hsr: emit RedBox-MAC TLV in PRP RedBox supervision frames
      net: hsr: allow PRP RedBox (interlink) creation
      selftests: net: hsr: add PRP RedBox test
      net: hsr: free learned nodes on device setup failure

Xu Rao (4):
      net: sgi: ioc3-eth: unregister netdev before freeing DMA rings
      net: sgi: ioc3-eth: fix split TX DMA mapping lengths
      nfc: pn533: purge fragmented skbs during cleanup
      net: usb: lg-vl600: fix Ethernet header on fragmented RX packets

Xuanqiang Luo (11):
      ipv4: use rcu_assign_pointer() in rt_flush_dev()
      ipv4: snapshot dst.dev in ip_rt_send_redirect() and ip_rt_get_source()
      bna: fix use-after-free on DMA mapping failure
      hinic3: fix use-after-free on DMA mapping failure
      net: hibmcge: fix double-free of tx skb on DMA mapping failure
      net: phy: add PHY package locking helpers
      net: phy: dp83640: embed pin configuration in clock
      net: phy: dp83640: clear state after PTP registration failure
      net: phy: dp83640: fix per-bus clock lifetime
      net: ravb: avoid dereferencing an invalid PTP clock
      net: ravb: serialize PTP clock teardown

Yael Chemla (1):
      net/mlx5: E-Switch, defer fwd2vport egress ACL allocation

Yanan He (1):
      net: phy: motorcomm: Enable optional clock for YT8531

Yevgeny Kliteynik (5):
      net/mlx5: HWS, Print more details for bad completion
      net/mlx5: HWS, Log syndrome on STC modify failure
      net/mlx5: HWS, Set the num of queues only when alloc succeeded
      net/mlx5: HWS, Remove redundant MLX5_SET in RTC creation
      net/mlx5: HWS, Remove redundant FW command when reading caps

Yingying Tang (1):
      wifi: ath12k: change MAC buffer ring size to 4096

Yinhao Hu (1):
      nfc: pn533: hold a reference to the request skb during send_frame

Yong Wang (1):
      ipv4: reject undersized MTUs in ip_do_fragment()

Yousef Alhouseen (1):
      net: usb: rtl8150: handle link status read failures

Yuhang.chen (1):
      wifi: rtw89: pci: add .shutdown callback to stop rfkill polling on reboot

Yun Lu (1):
      net: skbuff: optimization of net_zcopy_get() call in pskb_carve helpers

Yun Zhou (2):
      net: mvneta_bm: add suspend/resume support to prevent crash after resume
      nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing

Yuyang Huang (16):
      net: ipv4: report multicast group user count
      net: ipv6: report multicast group user count
      selftests: net: check multicast group user count
      net: prestera: ignore duplicate RIF destruction events
      wifi: mac80211: use ifa_dev from event argument
      net: ipv4: clear dev->ip_ptr before destroying inetdev
      ipv6: add ip6_del_rt_reason()
      ipv6: propagate the route deletion reason to fib6_del_route()
      ipv6: record the reason for kernel-initiated route deletions
      ipv6: add a deletion reason argument to rt6_fill_node()
      ipv6: expose the route deletion reason in RTM_DELROUTE
      ipv6: add inet6_rt_del_notify()
      netlink: specs: rt-route: add route notifications
      netlink: specs: rt-route: split out the request attribute list
      netlink: specs: rt-route: add the route deletion reason
      selftests: net: verify RTA_DEL_REASON on route deletion

Zhao Dongdong (1):
      Bluetooth: btnxpuart: Fix use-after-free in probe error path

Zhao Li (7):
      wifi: mac80211_hwsim: authenticate PMSR report senders
      wifi: mac80211_hwsim: clear PMSR request state on abort
      wifi: mac80211: fix per-STA profile length in cross-link CSA parsing
      wifi: mac80211: send TWT teardown to peer after setup TX failure
      wifi: nl80211: clean up color-change beacon data on errors
      wifi: mac80211: skip unused probe response countdown offsets
      wifi: cfg80211: stop PMSR before P2P and NAN teardown

ZhaoJinming (1):
      wifi: ath11k: fix resource leak on error in ext IRQ setup

Zhenghang Xiao (1):
      nfc: nci: fix double completion race in nci_data_exchange_complete

Zhi Li (4):
      dt-bindings: ethernet: eswin: relax internal delay model to range-based constraints
      dt-bindings: ethernet: eswin: add EIC7700 eth1 RX clock inversion variant
      net: stmmac: eic7700: make RGMII delay properties optional
      net: stmmac: eic7700: add support for eth1 clock inversion variant

Zhi-Jun You (2):
      wifi: mt76: wed: fix kernel panic on non-DBDC MT7986
      wifi: mt76: mt7915: fix net_fill_forward_path for non-DBDC mt7986

Zhiling Zou (4):
      ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
      ip6_gre: fix hardware header length for NBMA tunnels
      net: cap advertised IP tunnel headroom
      ip: orphan prefetched skbs before multicast forwarding

Zhixing Chen (1):
      r8169: keep LED device name valid after setup

Zihan Xi (1):
      xsk: account ring allocations to memcg

Zijun Hu (31):
      Bluetooth: btqca: Fix qca_set_bdaddr() waiting for wrong HCI event
      Bluetooth: btusb: Fix BD_ADDR byte order in btusb_set_bdaddr_wcn6855()
      Bluetooth: btusb: Record matched usb_device_id into btusb_data
      Bluetooth: btusb: QCA: Fix populating devcoredump fields on unenabled devices
      Bluetooth: btusb: QCA: move qca_dump out of struct btusb_data
      Bluetooth: hci_sync: Introduce __hci_reset_sync() for device drivers
      Bluetooth: btqca: Simplify qca_send_reset() by using __hci_reset_sync()
      Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()
      Bluetooth: hci_sync: Simplify hci_reset_sync()
      Bluetooth: hci_event: Log error for HCI reset status error in hci_cc_reset()
      Bluetooth: btusb: Reduce a redundant assignment in btusb_probe()
      Bluetooth: btusb: Use & instead of == to test bitflag BTUSB_IGNORE
      Bluetooth: coredump: Do not export hci_devcd_rx() and hci_devcd_timeout()
      Bluetooth: hci_qca: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
      Bluetooth: btusb: QCA: Replace HCI_VENDOR_PKT usages with HCI_EV_VENDOR
      Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
      Bluetooth: coredump: Introduce and apply hci_devcd_state_name()
      Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *
      Bluetooth: btusb: Add a simple static btusb_prepare_reset()
      Bluetooth: hci: Introduce hci_acl_handle() and hci_acl_dlen() helpers
      Bluetooth: hci_core: Simplify hci_recv_frame() by hci_acl_handle()
      Bluetooth: btusb: Simplify btusb_recv_bulk() by hci_acl_dlen()
      Bluetooth: btintel: Simplify btintel_classify_pkt_type() by hci_acl_handle()
      Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT frame by hci_recv_frame()
      Bluetooth: btintel: Fix diagnostics event detection
      Bluetooth: btintel: Remove redundant (hdr->plen > 0) in btintel_recv_event()
      Bluetooth: coredump: Expose header size and end marker to drivers
      Bluetooth: hci_core: Introduce __hci_reset_dev() with a hardware error code
      Bluetooth: btnxpuart: Simplify nxp_set_ind_reset() by __hci_reset_dev()
      Bluetooth: hci_event: Introduce handle_ev_vendor() for HCI_EV_VENDOR
      Bluetooth: hci_event: Use 255 as max event payload length in hci_ev_table[]

Zinc Lim (1):
      selftests: drv-net: rss_ctx: Add retries to test_rss_context_overlap to reduce flakes

Ziran Zhang (1):
      tcp: clarify comment for mdev_us in struct tcp_sock

Zong-Zhe Yang (5):
      wifi: rtw89: fw: fix link ID filling for LPS MLO common info
      wifi: rtw89: introduce helper to get tx shape index
      wifi: rtw89: add tx shape v0 to keep built-in arrays compatible during transitions
      wifi: rtw89: extend tx shape format for regulatory 6 GHz power type
      wifi: rtw89: debug: add diagnosis for RF

Zxyan Zhu (2):
      net: stmmac: dwxgmac2: configure INTM for per-channel interrupt routing
      net: stmmac: Skip PHY attach if custom PCS is in use

bui duc phuc (1):
      can: m_can: Use of_property_present() for wakeup-source

longlong yan (1):
      selftests/net: use MAP_FAILED instead of (void *)-1 in tcp_mmap

oshada imalka (1):
      Bluetooth: hcli_ldisc: Remove reduntant braces

shengwei.lu (1):
      wifi: mt76: mt7925: Fix EHT Beamformee SS subfields to meet 802.11be minimum

 .../ABI/testing/sysfs-bus-pci-drivers-btintel_pcie |   15 +
 .../bindings/dpll/microchip,zl30731.yaml           |   19 +-
 .../devicetree/bindings/net/adi,ad3306.yaml        |   71 +
 .../bindings/net/altr,gmii-to-sgmii-2.0.yaml       |    2 +-
 .../bindings/net/altr,socfpga-stmmac.yaml          |    2 +-
 .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  |    4 +-
 .../bindings/net/can/ti,am3517-hecc.yaml           |   64 +
 .../devicetree/bindings/net/can/ti_hecc.txt        |   32 -
 .../devicetree/bindings/net/can/xilinx,can.yaml    |    5 +-
 .../devicetree/bindings/net/dptel,dap8211r.yaml    |   62 +
 .../bindings/net/dsa/mediatek,mt7530.yaml          |    5 +
 .../bindings/net/dsa/mediatek,mt7628-esw.yaml      |   96 +
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |   74 +-
 .../devicetree/bindings/net/fsl,gianfar.yaml       |    2 +-
 .../devicetree/bindings/net/microchip,lan7800.yaml |   89 +
 .../devicetree/bindings/net/microchip,lan78xx.txt  |   53 -
 .../devicetree/bindings/net/microchip,lan95xx.yaml |    2 +-
 .../bindings/net/microchip,lan966x-switch.yaml     |    4 +-
 .../bindings/net/microchip,sparx5-switch.yaml      |    6 +-
 .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml  |  182 +
 .../bindings/net/renesas,rzv2h-gbeth.yaml          |    8 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/driver-api/dpll.rst                  |   18 +-
 Documentation/netlink/specs/devlink.yaml           |   30 +-
 Documentation/netlink/specs/dpll.yaml              |   19 +
 Documentation/netlink/specs/netdev.yaml            |   19 +
 Documentation/netlink/specs/nl80211.yaml           |    4 +-
 Documentation/netlink/specs/rt-addr.yaml           |    4 +
 Documentation/netlink/specs/rt-link.yaml           |    5 +
 Documentation/netlink/specs/rt-route.yaml          |   85 +-
 .../device_drivers/can/ctu/fsm_txt_buffer_user.svg |    4 +-
 .../device_drivers/ethernet/amd/pds_core.rst       |   89 +
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../device_drivers/ethernet/intel/ixd.rst          |   39 +
 .../networking/devlink/devlink-params.rst          |    6 +
 Documentation/networking/devlink/devlink-port.rst  |   11 +
 Documentation/networking/devlink/index.rst         |    9 +-
 Documentation/networking/devlink/ixd.rst           |   30 +
 Documentation/networking/devlink/mlx5.rst          |   40 +-
 .../net_cachelines/netns_ipv4_sysctl.rst           |    1 +
 Documentation/networking/netdevices.rst            |    7 +
 Documentation/networking/oa-tc6-framework.rst      |    3 +-
 Documentation/networking/tuntap.rst                |   32 +
 Documentation/process/maintainer-netdev.rst        |   20 +
 MAINTAINERS                                        |   85 +-
 arch/alpha/include/uapi/asm/socket.h               |    2 +
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/include/uapi/asm/socket.h                |    2 +
 arch/parisc/include/uapi/asm/socket.h              |    2 +
 arch/powerpc/configs/ppc64_defconfig               |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/powerpc/mm/mem.c                              |    6 -
 arch/sparc/include/uapi/asm/socket.h               |    2 +
 drivers/bluetooth/Makefile                         |    2 +
 drivers/bluetooth/bfusb.c                          |   37 +-
 drivers/bluetooth/btintel.c                        |  200 +-
 drivers/bluetooth/btintel.h                        |   18 +
 drivers/bluetooth/btintel_pcie.c                   |  299 +-
 drivers/bluetooth/btintel_pcie.h                   |   12 +-
 drivers/bluetooth/btmrvl_main.c                    |   20 +
 drivers/bluetooth/btmrvl_sdio.c                    |    2 +-
 drivers/bluetooth/btmtksdio.c                      |    3 +
 drivers/bluetooth/btnxpuart.c                      |   52 +-
 drivers/bluetooth/btqca.c                          |   25 +-
 drivers/bluetooth/btrsi.c                          |    3 +-
 drivers/bluetooth/btusb.c                          |  137 +-
 drivers/bluetooth/hci_aml.c                        |   18 +-
 drivers/bluetooth/hci_bcm.c                        |  336 +-
 drivers/bluetooth/hci_bcsp.c                       |    5 +-
 drivers/bluetooth/hci_h5.c                         |    6 +-
 drivers/bluetooth/hci_intel.c                      |    4 +-
 drivers/bluetooth/hci_ldisc.c                      |   10 +-
 drivers/bluetooth/hci_nokia.c                      |   20 +
 drivers/bluetooth/hci_qca.c                        |   16 +-
 drivers/bluetooth/virtio_bt.c                      |    8 +-
 drivers/cxl/core/core.h                            |    2 +
 drivers/cxl/core/mbox.c                            |   51 +-
 drivers/cxl/core/memdev.c                          |   67 +
 drivers/cxl/core/pci.c                             |    1 +
 drivers/cxl/core/port.c                            |    1 +
 drivers/cxl/core/regs.c                            |    1 +
 drivers/cxl/cxlpci.h                               |   12 -
 drivers/cxl/pci.c                                  |    1 +
 drivers/dpll/dpll_core.c                           |   30 +-
 drivers/dpll/dpll_netlink.c                        |  250 +-
 drivers/dpll/dpll_nl.c                             |    2 +-
 drivers/dpll/zl3073x/Kconfig                       |    6 +-
 drivers/dpll/zl3073x/chan.c                        |  449 +-
 drivers/dpll/zl3073x/chan.h                        |   80 +
 drivers/dpll/zl3073x/core.c                        |   62 +-
 drivers/dpll/zl3073x/core.h                        |   35 +-
 drivers/dpll/zl3073x/dpll.c                        |  984 ++-
 drivers/dpll/zl3073x/dpll.h                        |    9 +
 drivers/dpll/zl3073x/out.c                         |    8 +-
 drivers/dpll/zl3073x/regs.h                        |   63 +
 drivers/firmware/qcom/Kconfig                      |   22 +-
 drivers/firmware/qcom/Makefile                     |    2 +
 drivers/firmware/qcom/qcom_pas.c                   |  298 +
 drivers/firmware/qcom/qcom_pas.h                   |   50 +
 drivers/firmware/qcom/qcom_pas_tee.c               |  479 ++
 drivers/firmware/qcom/qcom_scm.c                   |  335 +-
 drivers/infiniband/core/lag.c                      |    2 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |    4 +-
 drivers/mmc/core/quirks.h                          |    3 +
 drivers/net/amt.c                                  |   52 +-
 drivers/net/bareudp.c                              |   45 +-
 drivers/net/bonding/bond_3ad.c                     |   24 +-
 drivers/net/bonding/bond_main.c                    |   10 +-
 drivers/net/bonding/bond_netlink.c                 |  113 +-
 drivers/net/bonding/bond_options.c                 |    8 +-
 drivers/net/can/m_can/m_can.c                      |    2 +-
 drivers/net/can/m_can/m_can_pci.c                  |    6 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   31 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   17 +
 drivers/net/can/rockchip/rockchip_canfd-rx.c       |    5 +-
 drivers/net/can/rockchip/rockchip_canfd.h          |   14 +-
 drivers/net/can/usb/gs_usb.c                       |    2 +-
 drivers/net/can/vxcan.c                            |   26 +-
 drivers/net/dsa/Kconfig                            |   10 +
 drivers/net/dsa/Makefile                           |    1 +
 drivers/net/dsa/b53/b53_common.c                   |    2 +-
 drivers/net/dsa/b53/b53_priv.h                     |    3 +-
 drivers/net/dsa/microchip/ksz8.c                   |  742 +-
 drivers/net/dsa/microchip/ksz8_reg.h               |    1 +
 drivers/net/dsa/microchip/ksz9477.c                |  164 +-
 drivers/net/dsa/microchip/ksz9477.h                |    4 +-
 drivers/net/dsa/microchip/ksz_common.c             |  611 +-
 drivers/net/dsa/microchip/ksz_common.h             |   91 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |  277 +-
 drivers/net/dsa/microchip/ksz_ptp.h                |   16 +
 drivers/net/dsa/microchip/ksz_ptp_reg.h            |   10 +
 drivers/net/dsa/microchip/lan937x_main.c           |    6 +-
 drivers/net/dsa/mt7530-mmio.c                      |    1 +
 drivers/net/dsa/mt7530.c                           |  144 +-
 drivers/net/dsa/mt7530.h                           |    1 +
 drivers/net/dsa/mt7628.c                           |  652 ++
 drivers/net/dsa/mv88e6xxx/pcs-6352.c               |    5 +-
 drivers/net/dsa/qca/qca8k-leds.c                   |    3 +
 drivers/net/dsa/realtek/rtl8365mb_main.c           |  619 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |  267 +-
 drivers/net/dsa/realtek/rtl83xx.c                  |   30 +-
 drivers/net/dsa/yt921x.h                           |    2 +-
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/adi/Kconfig                   |   12 +
 drivers/net/ethernet/adi/Makefile                  |    1 +
 drivers/net/ethernet/adi/adin1140.c                |  791 +++
 drivers/net/ethernet/agere/et131x.c                |    2 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |  265 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |   33 +-
 drivers/net/ethernet/airoha/airoha_npu.c           |   10 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   36 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |    1 +
 drivers/net/ethernet/allwinner/sun4i-emac.c        |    2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    6 +-
 drivers/net/ethernet/amd/Kconfig                   |    1 +
 drivers/net/ethernet/amd/pds_core/core.c           |  173 +
 drivers/net/ethernet/amd/pds_core/core.h           |   54 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |   45 +
 drivers/net/ethernet/amd/pds_core/dev.c            |  144 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |  149 +-
 drivers/net/ethernet/amd/pds_core/fw.c             |  796 ++-
 drivers/net/ethernet/amd/pds_core/main.c           |    7 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |    2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c |    6 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |  132 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h   |    6 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    8 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c     |    6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  138 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   11 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |    2 +-
 drivers/net/ethernet/cadence/macb.h                |   26 +-
 drivers/net/ethernet/cadence/macb_main.c           |  969 +--
 drivers/net/ethernet/cadence/macb_pci.c            |   46 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |   18 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |    3 +-
 drivers/net/ethernet/cisco/enic/Makefile           |    3 +-
 drivers/net/ethernet/cisco/enic/enic.h             |   41 +-
 drivers/net/ethernet/cisco/enic/enic_admin.c       |  667 ++
 drivers/net/ethernet/cisco/enic/enic_admin.h       |   27 +
 drivers/net/ethernet/cisco/enic/enic_main.c        |  431 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c        |  647 ++
 drivers/net/ethernet/cisco/enic/enic_mbox.h        |   95 +
 drivers/net/ethernet/cisco/enic/enic_pp.c          |    5 +
 drivers/net/ethernet/cisco/enic/enic_res.c         |    4 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.h          |    9 +
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h      |   13 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h        |    4 +-
 drivers/net/ethernet/dec/tulip/Kconfig             |   16 +-
 drivers/net/ethernet/dec/tulip/Makefile            |    1 -
 drivers/net/ethernet/dec/tulip/xircom_cb.c         | 1172 ----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   12 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  935 ++-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.h    |   42 +-
 drivers/net/ethernet/freescale/dpaa2/dpsw-cmd.h    |   18 +-
 drivers/net/ethernet/freescale/dpaa2/dpsw.c        |   60 +
 drivers/net/ethernet/freescale/dpaa2/dpsw.h        |   30 +
 drivers/net/ethernet/freescale/enetc/enetc.h       |    4 +-
 .../net/ethernet/freescale/enetc/enetc4_debugfs.c  |   42 +-
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |    6 +-
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |  471 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |   12 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |   94 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |    6 -
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  150 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.h |    5 +
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    4 +-
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |    9 +-
 drivers/net/ethernet/freescale/gianfar.c           |    6 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   89 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |   11 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  111 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   15 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c  |    1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   14 +
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |    3 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   48 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   12 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |    9 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |    3 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  172 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |    7 +
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c     |   14 +-
 drivers/net/ethernet/ibm/Kconfig                   |    9 -
 drivers/net/ethernet/ibm/Makefile                  |    1 -
 drivers/net/ethernet/ibm/ehea/Makefile             |    7 -
 drivers/net/ethernet/ibm/ehea/ehea.h               |  477 --
 drivers/net/ethernet/ibm/ehea/ehea_ethtool.c       |  277 -
 drivers/net/ethernet/ibm/ehea/ehea_hw.h            |  253 -
 drivers/net/ethernet/ibm/ehea/ehea_main.c          | 3581 ----------
 drivers/net/ethernet/ibm/ehea/ehea_phyp.c          |  612 --
 drivers/net/ethernet/ibm/ehea/ehea_phyp.h          |  433 --
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c           |  999 ---
 drivers/net/ethernet/ibm/ehea/ehea_qmr.h           |  390 --
 drivers/net/ethernet/ibm/emac/mal.c                |   13 +-
 drivers/net/ethernet/intel/Kconfig                 |    2 +
 drivers/net/ethernet/intel/Makefile                |    1 +
 drivers/net/ethernet/intel/i40e/i40e.h             |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    8 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    2 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c      |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h   |    3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |    2 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h       |    4 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   32 +-
 drivers/net/ethernet/intel/ice/ice.h               |    2 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |    2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   18 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c          |    5 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |    3 +
 drivers/net/ethernet/intel/ice/ice_nvm.c           |   90 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h           |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |   38 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    2 +-
 drivers/net/ethernet/intel/ice/virt/virtchnl.h     |    2 +-
 drivers/net/ethernet/intel/idpf/Kconfig            |    1 +
 drivers/net/ethernet/intel/idpf/Makefile           |    2 -
 drivers/net/ethernet/intel/idpf/idpf.h             |   99 +-
 drivers/net/ethernet/intel/idpf/idpf_controlq.c    |  621 --
 drivers/net/ethernet/intel/idpf/idpf_controlq.h    |  144 -
 .../net/ethernet/intel/idpf/idpf_controlq_api.h    |  177 -
 .../net/ethernet/intel/idpf/idpf_controlq_setup.c  |  169 -
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |   97 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |   28 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c         |   32 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   69 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |  115 +-
 drivers/net/ethernet/intel/idpf/idpf_mem.h         |   20 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    4 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |   92 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    | 1969 +++---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |  127 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl_ptp.c    |  310 +-
 drivers/net/ethernet/intel/igb/e1000_82575.h       |   21 +
 drivers/net/ethernet/intel/igb/e1000_i210.c        |    6 +-
 drivers/net/ethernet/intel/igb/igb.h               |    3 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   89 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   25 +-
 drivers/net/ethernet/intel/igc/igc.h               |    3 +
 drivers/net/ethernet/intel/igc/igc_base.c          |   33 +-
 drivers/net/ethernet/intel/igc/igc_defines.h       |    9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  279 +-
 drivers/net/ethernet/intel/igc/igc_hw.h            |   10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c           |   35 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   10 +-
 drivers/net/ethernet/intel/igc/igc_phy.c           |   71 +-
 drivers/net/ethernet/intel/igc/igc_phy.h           |    1 +
 drivers/net/ethernet/intel/igc/igc_tsn.c           |    8 +-
 drivers/net/ethernet/intel/ixd/Kconfig             |   14 +
 drivers/net/ethernet/intel/ixd/Makefile            |   13 +
 drivers/net/ethernet/intel/ixd/ixd.h               |   67 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c          |  141 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h          |   34 +
 drivers/net/ethernet/intel/ixd/ixd_dev.c           |   89 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c       |   99 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.h       |   50 +
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h      |   68 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c           |  173 +
 drivers/net/ethernet/intel/ixd/ixd_main.c          |  144 +
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c      |  190 +
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h      |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    7 +-
 drivers/net/ethernet/intel/libeth/rx.c             |   12 +-
 drivers/net/ethernet/intel/libie/Kconfig           |   14 +
 drivers/net/ethernet/intel/libie/Makefile          |    8 +
 drivers/net/ethernet/intel/libie/controlq.c        | 1295 ++++
 drivers/net/ethernet/intel/libie/pci.c             |  229 +
 drivers/net/ethernet/marvell/mvneta.c              |   18 +
 drivers/net/ethernet/marvell/mvneta_bm.c           |   87 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    9 +-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |    2 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   52 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   80 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    7 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c |    1 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |    2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |    2 +-
 .../ethernet/marvell/prestera/prestera_router.c    |    6 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |    5 +
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c    |  139 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |    1 +
 .../ethernet/mellanox/mlx5/core/diag/rsc_dump.c    |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |    7 +-
 .../net/ethernet/mellanox/mlx5/core/en/health.c    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |    4 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h         |   19 +-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 1057 ++-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.h |   18 +-
 .../mellanox/mlx5/core/en_accel/psp_rxtx.c         |   13 +-
 .../mellanox/mlx5/core/en_accel/psp_rxtx.h         |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   29 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   15 +-
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |    2 +-
 .../mellanox/mlx5/core/esw/acl/egress_ofld.c       |  105 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |  605 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h  |    3 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   27 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   18 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   12 +-
 .../net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c  |   22 +-
 .../net/ethernet/mellanox/mlx5/core/lib/hv_vhca.h  |    5 +-
 .../net/ethernet/mellanox/mlx5/core/lib/nv_param.c |  125 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |   75 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   11 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    2 +
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c |   21 +-
 .../mellanox/mlx5/core/steering/hws/send.c         |   67 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |    6 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    8 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c |    2 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.h    |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |    2 +
 drivers/net/ethernet/microchip/lan743x_main.c      |   35 +-
 drivers/net/ethernet/microchip/lan743x_main.h      |    6 +
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |    2 +-
 .../microchip/sparx5/lan969x/lan969x_regs.c        |    3 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |   12 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |    4 +
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |   49 +
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |    1 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |    3 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |    3 +
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |    9 +-
 drivers/net/ethernet/microsoft/Kconfig             |    1 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  272 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |    2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  353 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |  383 +-
 drivers/net/ethernet/oa_tc6.c                      |  263 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   17 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    4 +
 .../net/ethernet/pensando/ionic/ionic_rx_filter.c  |    7 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   38 +-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c |    7 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   13 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c         |    2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c  |    6 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |    2 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c            |    1 -
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c     |    7 +-
 drivers/net/ethernet/qualcomm/ppe/ppe_config.h     |    2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    3 +-
 drivers/net/ethernet/realtek/8139cp.c              |    2 +-
 drivers/net/ethernet/realtek/r8169.h               |    2 +-
 drivers/net/ethernet/realtek/r8169_leds.c          |   11 +-
 drivers/net/ethernet/renesas/ravb.h                |    3 +
 drivers/net/ethernet/renesas/ravb_main.c           |    9 +-
 drivers/net/ethernet/renesas/ravb_ptp.c            |   44 +-
 drivers/net/ethernet/renesas/rtsn.c                |    7 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c    |    3 +-
 drivers/net/ethernet/sfc/Kconfig                   |    9 +
 drivers/net/ethernet/sfc/Makefile                  |    1 +
 drivers/net/ethernet/sfc/ef10.c                    |   41 +-
 drivers/net/ethernet/sfc/efx.c                     |   18 +-
 drivers/net/ethernet/sfc/efx_cxl.c                 |  105 +
 drivers/net/ethernet/sfc/efx_cxl.h                 |   32 +
 drivers/net/ethernet/sfc/falcon/net_driver.h       |    2 +-
 drivers/net/ethernet/sfc/falcon/selftest.c         |    4 +-
 drivers/net/ethernet/sfc/falcon/tx.c               |   16 +-
 drivers/net/ethernet/sfc/mcdi.c                    |    7 +-
 drivers/net/ethernet/sfc/net_driver.h              |   10 +
 drivers/net/ethernet/sfc/nic.h                     |    3 +
 drivers/net/ethernet/sfc/selftest.c                |    4 +-
 drivers/net/ethernet/sfc/siena/mcdi.c              |    7 +-
 drivers/net/ethernet/sfc/siena/selftest.c          |    4 +-
 drivers/net/ethernet/sfc/siena/tx.c                |   12 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c        |    2 +-
 drivers/net/ethernet/sgi/ioc3-eth.c                |    9 +-
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c   |    9 +-
 .../net/ethernet/stmicro/stmmac/dwmac-eic7700.c    |  117 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |    2 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   10 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   12 -
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |   15 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    7 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |   14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   25 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |  121 +-
 drivers/net/ethernet/sun/niu.c                     |    6 +-
 drivers/net/ethernet/sun/niu.h                     |    2 +-
 drivers/net/ethernet/ti/cpsw_priv.c                |    2 +-
 drivers/net/ethernet/wangxun/libwx/Makefile        |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c        |  332 +
 drivers/net/ethernet/wangxun/libwx/wx_err.h        |   18 +
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |   70 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   92 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h        |    5 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c        |   27 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h        |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   24 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h         |    1 -
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c  |    4 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.h  |    2 +
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c     |   13 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |    1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   84 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |    1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   64 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |    2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    5 +-
 drivers/net/ethernet/zte/Kconfig                   |   20 +
 drivers/net/ethernet/zte/Makefile                  |    6 +
 drivers/net/ethernet/zte/dinghai/Kconfig           |   34 +
 drivers/net/ethernet/zte/dinghai/Makefile          |    7 +
 drivers/net/ethernet/zte/dinghai/dh_queue.h        |   56 +
 drivers/net/ethernet/zte/dinghai/en_pf.c           |  449 ++
 drivers/net/ethernet/zte/dinghai/en_pf.h           |   75 +
 drivers/net/fjes/fjes_main.c                       |    9 +-
 drivers/net/geneve.c                               |  549 +-
 drivers/net/ipvlan/ipvlan.h                        |   12 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  147 +-
 drivers/net/ipvlan/ipvtap.c                        |   25 +-
 drivers/net/macsec.c                               |   78 +-
 drivers/net/macvlan.c                              |  138 +-
 drivers/net/mctp/Kconfig                           |   16 +
 drivers/net/mctp/Makefile                          |    1 +
 drivers/net/mctp/mctp-usb.c                        |  360 +-
 drivers/net/mctp/mctp-usblib-test.c                |  412 ++
 drivers/net/mctp/mctp-usblib.c                     |  625 ++
 drivers/net/mdio/Kconfig                           |    9 +-
 drivers/net/netconsole.c                           |  594 +-
 drivers/net/netdevsim/bus.c                        |    3 -
 drivers/net/netdevsim/dev.c                        |   81 +-
 drivers/net/netdevsim/netdevsim.h                  |    3 +-
 drivers/net/netdevsim/psample.c                    |    2 +-
 drivers/net/netdevsim/psp.c                        |    8 +-
 drivers/net/pcs/pcs-mtk-lynxi.c                    |    7 +-
 drivers/net/pfcp.c                                 |   32 +-
 drivers/net/phy/Kconfig                            |   15 +
 drivers/net/phy/Makefile                           |    2 +
 drivers/net/phy/adin1140-phy.c                     |   72 +
 drivers/net/phy/dap8211r.c                         |  220 +
 drivers/net/phy/dp83640.c                          |  131 +-
 drivers/net/phy/mdio_device.c                      |    1 -
 drivers/net/phy/mediatek/Kconfig                   |   19 +-
 drivers/net/phy/mediatek/Makefile                  |    1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c              |   52 +
 drivers/net/phy/mediatek/mtk-ge-soc.c              |   35 +
 drivers/net/phy/micrel.c                           |   60 +
 drivers/net/phy/microchip_t1.c                     |    6 +-
 drivers/net/phy/microchip_t1s.c                    |   32 +-
 drivers/net/phy/motorcomm.c                        |   13 +
 drivers/net/phy/nxp-tja11xx.c                      |    9 +
 drivers/net/phy/phy-c45.c                          |  125 +
 drivers/net/phy/phy_device.c                       |   25 +
 drivers/net/phy/phy_package.c                      |   23 +
 drivers/net/phy/phylib.h                           |    2 +
 drivers/net/phy/phylink.c                          |   26 +-
 drivers/net/phy/qcom/at803x.c                      |    2 +-
 drivers/net/phy/realtek/realtek_main.c             |  411 ++
 drivers/net/phy/sfp.c                              |   45 +-
 drivers/net/phy/sfp.h                              |    1 +
 drivers/net/ppp/ppp_async.c                        |    2 -
 drivers/net/ppp/ppp_generic.c                      |  153 +-
 drivers/net/ppp/ppp_synctty.c                      |    2 -
 drivers/net/ppp/pppoe.c                            |   20 +-
 drivers/net/ppp/pppox.c                            |   17 +
 drivers/net/ppp/pptp.c                             |    8 +-
 drivers/net/pse-pd/Kconfig                         |   28 +
 drivers/net/pse-pd/Makefile                        |    3 +
 drivers/net/pse-pd/realtek-pse-mcu-core.c          |  998 +++
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c           |  148 +
 drivers/net/pse-pd/realtek-pse-mcu-uart.c          |  164 +
 drivers/net/pse-pd/realtek-pse-mcu.h               |   94 +
 drivers/net/pse-pd/tps23881.c                      |    6 +-
 drivers/net/tap.c                                  |    5 +-
 drivers/net/team/team_core.c                       |    4 +-
 drivers/net/thunderbolt/main.c                     |   12 +
 drivers/net/tun.c                                  |  263 +-
 drivers/net/tun_vnet.h                             |    8 +-
 drivers/net/usb/cdc_ether.c                        |   16 +
 drivers/net/usb/lg-vl600.c                         |    2 +-
 drivers/net/usb/qmi_wwan.c                         |    1 +
 drivers/net/usb/rndis_host.c                       |    6 +-
 drivers/net/usb/rtl8150.c                          |    4 +-
 drivers/net/veth.c                                 |   34 +-
 drivers/net/virtio_net.c                           |   14 +
 drivers/net/vrf.c                                  |    4 +-
 drivers/net/vxlan/vxlan_core.c                     |   55 +-
 drivers/net/vxlan/vxlan_mdb.c                      |    9 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |    6 +-
 drivers/net/wan/lapbether.c                        |    8 +-
 drivers/net/wan/wanxl.c                            |   17 -
 drivers/net/wireguard/receive.c                    |    2 +-
 drivers/net/wireless/Kconfig                       |    2 +
 drivers/net/wireless/Makefile                      |    2 +
 drivers/net/wireless/ath/ath10k/ahb.c              |   12 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    6 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |    9 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |   14 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   79 +-
 drivers/net/wireless/ath/ath11k/core.c             |    4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   32 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   46 +-
 drivers/net/wireless/ath/ath12k/Kconfig            |    2 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |  244 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |   36 +-
 drivers/net/wireless/ath/ath12k/core.c             |   41 +-
 drivers/net/wireless/ath/ath12k/core.h             |   24 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |   14 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   16 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    8 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   70 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    4 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   46 +
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    2 +
 drivers/net/wireless/ath/ath12k/hal.c              |   42 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   15 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  104 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   15 +-
 drivers/net/wireless/ath/ath12k/peer.c             |  132 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   14 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  437 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   48 +-
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |   90 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp.c         |    2 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |   66 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |   64 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |    4 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |   13 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx_desc.h    |   34 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |   13 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |   76 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  197 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   26 +
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   29 +-
 drivers/net/wireless/ath/ath6kl/core.h             |    5 +-
 drivers/net/wireless/ath/ath6kl/init.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/main.c             |    1 +
 drivers/net/wireless/ath/ath6kl/txrx.c             |    1 +
 drivers/net/wireless/ath/ath6kl/wmi.c              |   19 +-
 drivers/net/wireless/ath/ath6kl/wmi.h              |    1 +
 drivers/net/wireless/ath/carl9170/carl9170.h       |    1 +
 drivers/net/wireless/ath/carl9170/cmd.c            |    4 +-
 drivers/net/wireless/ath/carl9170/debug.c          |    2 +
 drivers/net/wireless/ath/carl9170/main.c           |    8 +-
 drivers/net/wireless/ath/carl9170/rx.c             |    4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   20 +-
 drivers/net/wireless/ath/wil6210/debugfs.c         |    2 +-
 drivers/net/wireless/ath/wil6210/p2p.c             |    6 +-
 drivers/net/wireless/ath/wil6210/wil6210.h         |    4 +-
 drivers/net/wireless/broadcom/b43/debugfs.c        |   12 +-
 drivers/net/wireless/broadcom/b43legacy/debugfs.c  |   12 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    6 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  161 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    2 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |    8 +-
 .../wireless/broadcom/brcm80211/brcmfmac/msgbuf.c  |   47 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |   68 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    3 +-
 .../broadcom/brcm80211/include/brcmu_wifi.h        |    2 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |    4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |    5 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   51 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |    6 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   28 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   33 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   22 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c      |   28 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |    9 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  136 +-
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |   21 +
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.h |    1 +
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   19 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h  |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |   26 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |    7 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |    2 -
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |    5 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |   90 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |    3 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   36 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h |    4 +
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   54 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    1 +
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c   |    2 +
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |   11 +-
 drivers/net/wireless/intersil/p54/Kconfig          |    6 +-
 drivers/net/wireless/intersil/p54/fwio.c           |    4 +-
 drivers/net/wireless/intersil/p54/p54usb.c         |    2 +-
 drivers/net/wireless/marvell/libertas/debugfs.c    |   39 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   26 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   62 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |   12 +
 drivers/net/wireless/mediatek/mt76/channel.c       |   98 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   48 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |  112 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   20 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |   12 +-
 drivers/net/wireless/mediatek/mt76/mmio.c          |   18 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   11 +
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c |    1 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |   73 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   89 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h |    4 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    5 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |    5 +-
 .../net/wireless/mediatek/mt76/mt7615/usb_sdio.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |   16 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   42 +
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |    8 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  267 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   47 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |    5 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   41 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   25 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   43 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   20 +
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7915/testmode.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   35 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |  112 +-
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c   |  219 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regd.h   |   57 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   37 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  241 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mac.h    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  279 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  267 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   43 +
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |    9 +
 drivers/net/wireless/mediatek/mt76/mt7925/nan.c    | 1098 +++
 drivers/net/wireless/mediatek/mt76/mt7925/nan.h    |  421 ++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |  305 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |    8 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c   |  250 +-
 drivers/net/wireless/mediatek/mt76/mt7925/regd.h   |   57 +
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |   67 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |    8 +
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   85 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |  146 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |  124 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |   25 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |  138 +-
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c |    6 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   96 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   75 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  205 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   42 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   93 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   24 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |   26 +-
 drivers/net/wireless/mediatek/mt76/sdio.c          |   11 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |  102 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |   75 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |    7 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   19 +-
 drivers/net/wireless/microchip/wilc1000/mon.c      |   30 +-
 drivers/net/wireless/morsemicro/Kconfig            |   15 +
 drivers/net/wireless/morsemicro/Makefile           |    2 +
 drivers/net/wireless/morsemicro/mm81x/Kconfig      |   26 +
 drivers/net/wireless/morsemicro/mm81x/Makefile     |   21 +
 drivers/net/wireless/morsemicro/mm81x/bus.h        |   99 +
 drivers/net/wireless/morsemicro/mm81x/command.c    |  563 ++
 drivers/net/wireless/morsemicro/mm81x/command.h    |   85 +
 .../net/wireless/morsemicro/mm81x/command_defs.h   | 1658 +++++
 drivers/net/wireless/morsemicro/mm81x/core.c       |  138 +
 drivers/net/wireless/morsemicro/mm81x/core.h       |  456 ++
 drivers/net/wireless/morsemicro/mm81x/fw.c         |  752 +++
 drivers/net/wireless/morsemicro/mm81x/fw.h         |  143 +
 drivers/net/wireless/morsemicro/mm81x/hif.h        |  117 +
 drivers/net/wireless/morsemicro/mm81x/hw.c         |  367 +
 drivers/net/wireless/morsemicro/mm81x/hw.h         |  159 +
 drivers/net/wireless/morsemicro/mm81x/mac.c        | 2443 +++++++
 drivers/net/wireless/morsemicro/mm81x/mac.h        |   63 +
 drivers/net/wireless/morsemicro/mm81x/mmrc.c       | 1354 ++++
 drivers/net/wireless/morsemicro/mm81x/mmrc.h       |  193 +
 drivers/net/wireless/morsemicro/mm81x/ps.c         |  120 +
 drivers/net/wireless/morsemicro/mm81x/ps.h         |   22 +
 drivers/net/wireless/morsemicro/mm81x/rate_code.h  |  177 +
 drivers/net/wireless/morsemicro/mm81x/rc.c         |  494 ++
 drivers/net/wireless/morsemicro/mm81x/rc.h         |   51 +
 drivers/net/wireless/morsemicro/mm81x/sdio.c       |  613 ++
 drivers/net/wireless/morsemicro/mm81x/skbq.c       | 1064 +++
 drivers/net/wireless/morsemicro/mm81x/skbq.h       |  218 +
 drivers/net/wireless/morsemicro/mm81x/usb.c        |  943 +++
 drivers/net/wireless/morsemicro/mm81x/yaps.c       |  704 ++
 drivers/net/wireless/morsemicro/mm81x/yaps.h       |   77 +
 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c    |  702 ++
 drivers/net/wireless/morsemicro/mm81x/yaps_hw.h    |   52 +
 drivers/net/wireless/nxp/Kconfig                   |   17 +
 drivers/net/wireless/nxp/Makefile                  |    3 +
 drivers/net/wireless/nxp/nxpwifi/11ac.c            |  280 +
 drivers/net/wireless/nxp/nxpwifi/11ac.h            |   33 +
 drivers/net/wireless/nxp/nxpwifi/11ax.c            |  597 ++
 drivers/net/wireless/nxp/nxpwifi/11ax.h            |   73 +
 drivers/net/wireless/nxp/nxpwifi/11h.c             |  339 +
 drivers/net/wireless/nxp/nxpwifi/11n.c             |  838 +++
 drivers/net/wireless/nxp/nxpwifi/11n.h             |  158 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c        |  251 +
 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h        |   21 +
 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c   |  815 +++
 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h   |   71 +
 drivers/net/wireless/nxp/nxpwifi/Kconfig           |   23 +
 drivers/net/wireless/nxp/nxpwifi/Makefile          |   39 +
 drivers/net/wireless/nxp/nxpwifi/cfg.h             | 1019 +++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c        | 3935 +++++++++++
 drivers/net/wireless/nxp/nxpwifi/cfg80211.h        |   18 +
 drivers/net/wireless/nxp/nxpwifi/cfp.c             |  478 ++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.c          | 1310 ++++
 drivers/net/wireless/nxp/nxpwifi/cmdevt.h          |  122 +
 drivers/net/wireless/nxp/nxpwifi/debugfs.c         | 1094 +++
 drivers/net/wireless/nxp/nxpwifi/ethtool.c         |   58 +
 drivers/net/wireless/nxp/nxpwifi/fw.h              | 2475 +++++++
 drivers/net/wireless/nxp/nxpwifi/ie.c              |  480 ++
 drivers/net/wireless/nxp/nxpwifi/init.c            |  607 ++
 drivers/net/wireless/nxp/nxpwifi/join.c            |  787 +++
 drivers/net/wireless/nxp/nxpwifi/main.c            | 1673 +++++
 drivers/net/wireless/nxp/nxpwifi/main.h            | 1436 ++++
 drivers/net/wireless/nxp/nxpwifi/scan.c            | 2698 ++++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.c            | 2328 +++++++
 drivers/net/wireless/nxp/nxpwifi/sdio.h            |  340 +
 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c         | 1177 ++++
 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c         | 3393 ++++++++++
 drivers/net/wireless/nxp/nxpwifi/sta_event.c       |  862 +++
 drivers/net/wireless/nxp/nxpwifi/sta_rx.c          |  242 +
 drivers/net/wireless/nxp/nxpwifi/sta_tx.c          |  190 +
 drivers/net/wireless/nxp/nxpwifi/txrx.c            |  352 +
 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c         | 1256 ++++
 drivers/net/wireless/nxp/nxpwifi/uap_event.c       |  506 ++
 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c        |  478 ++
 drivers/net/wireless/nxp/nxpwifi/util.c            | 1380 ++++
 drivers/net/wireless/nxp/nxpwifi/util.h            |  155 +
 drivers/net/wireless/nxp/nxpwifi/wmm.c             | 1318 ++++
 drivers/net/wireless/nxp/nxpwifi/wmm.h             |   77 +
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    4 +-
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c      |   11 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   20 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   49 +-
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.c  |   21 +-
 .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    |   12 +-
 .../net/wireless/realtek/rtlwifi/rtl8192du/trx.c   |    3 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    6 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |    7 +-
 drivers/net/wireless/realtek/rtw88/bf.c            |    6 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    8 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    1 +
 drivers/net/wireless/realtek/rtw88/pci.c           |   14 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   15 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    1 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |   29 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    9 +
 drivers/net/wireless/realtek/rtw89/coex.c          | 7136 ++++++++++++--------
 drivers/net/wireless/realtek/rtw89/coex.h          |  155 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  131 +-
 drivers/net/wireless/realtek/rtw89/core.h          | 1397 +++-
 drivers/net/wireless/realtek/rtw89/debug.c         |  124 +-
 drivers/net/wireless/realtek/rtw89/debug.h         |    1 +
 drivers/net/wireless/realtek/rtw89/efuse.h         |    7 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |  117 +-
 drivers/net/wireless/realtek/rtw89/fw.c            | 1522 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  366 +-
 drivers/net/wireless/realtek/rtw89/led.c           |  139 +
 drivers/net/wireless/realtek/rtw89/led.h           |   37 +
 drivers/net/wireless/realtek/rtw89/led_mc.c        |   81 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   71 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   52 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   38 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   87 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   17 +
 drivers/net/wireless/realtek/rtw89/pci.h           |    6 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   11 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   95 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   28 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   53 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  100 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  146 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |   22 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |   23 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.h    |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   91 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |   36 +-
 .../net/wireless/realtek/rtw89/rtw8852a_table.c    |   27 +-
 .../net/wireless/realtek/rtw89/rtw8852a_table.h    |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   80 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   36 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    |   31 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.h    |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   80 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   87 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  101 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    |   39 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.h    |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |   57 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  142 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8922au.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c      |  521 +-
 drivers/net/wireless/realtek/rtw89/rtw8922de.c     |    3 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   27 +-
 drivers/net/wireless/rsi/rsi_91x_coex.c            |    3 +-
 drivers/net/wireless/rsi/rsi_91x_main.c            |    7 +-
 drivers/net/wireless/rsi/rsi_91x_sdio_ops.c        |    3 +-
 drivers/net/wireless/rsi/rsi_91x_usb_ops.c         |    7 +-
 drivers/net/wireless/rsi/rsi_common.h              |    2 +-
 drivers/net/wireless/rsi/rsi_sdio.h                |    2 +-
 drivers/net/wireless/rsi/rsi_usb.h                 |    2 +-
 drivers/net/wireless/ti/wlcore/main.c              |   14 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |   69 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |    8 +
 drivers/net/wwan/wwan_core.c                       |   27 +-
 drivers/nfc/fdp/i2c.c                              |   31 +-
 drivers/nfc/microread/mei.c                        |   10 +-
 drivers/nfc/microread/microread.c                  |   31 +-
 drivers/nfc/nfcmrvl/i2c.c                          |    6 +-
 drivers/nfc/nfcmrvl/spi.c                          |   12 +-
 drivers/nfc/nfcmrvl/usb.c                          |    1 -
 drivers/nfc/nxp-nci/i2c.c                          |   14 +-
 drivers/nfc/pn533/i2c.c                            |   10 +-
 drivers/nfc/pn533/pn533.c                          |   32 +-
 drivers/nfc/pn533/uart.c                           |    4 +-
 drivers/nfc/pn544/i2c.c                            |   14 +-
 drivers/nfc/pn544/mei.c                            |   10 +-
 drivers/nfc/port100.c                              |    4 +-
 drivers/nfc/s3fwrn5/i2c.c                          |    6 +-
 drivers/nfc/s3fwrn5/uart.c                         |    4 +-
 drivers/nfc/st-nci/i2c.c                           |   18 +-
 drivers/nfc/st-nci/spi.c                           |   18 +-
 drivers/nfc/st21nfca/dep.c                         |    3 +
 drivers/nfc/st21nfca/i2c.c                         |   14 +-
 drivers/nfc/st95hf/core.c                          |   14 +-
 drivers/nfc/trf7970a.c                             |   14 +-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c      |    3 -
 drivers/ptp/Kconfig                                |    1 +
 drivers/ptp/ptp_clock.c                            |   14 +-
 drivers/ptp/ptp_fc3.c                              |   18 +-
 drivers/ptp/ptp_netc.c                             |    3 +
 drivers/ptp/ptp_vmclock.c                          |    6 +
 drivers/s390/net/Makefile                          |    2 +
 drivers/s390/net/ctcm_fsms.c                       |   20 +-
 drivers/s390/net/ctcm_mpc.c                        |    6 +-
 drivers/s390/net/fsm.h                             |  152 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    7 +-
 drivers/usb/atm/cxacru.c                           |   10 +-
 drivers/usb/atm/ueagle-atm.c                       |    3 +-
 drivers/vhost/net.c                                |   21 +-
 include/cxl/cxl.h                                  |    2 +
 include/cxl/pci.h                                  |   22 +
 include/linux/atmdev.h                             |    3 -
 include/linux/firmware/qcom/qcom_pas.h             |   43 +
 include/linux/fsl/ntmp.h                           |    2 +
 include/linux/ieee80211-eht.h                      |   92 +
 include/linux/ieee80211-uhr.h                      |   44 +-
 include/linux/ieee80211.h                          |   12 +
 include/linux/if_tun.h                             |    4 +
 include/linux/mdio.h                               |    6 +-
 include/linux/mlx5/device.h                        |    1 +
 include/linux/mlx5/driver.h                        |    8 +-
 include/linux/mlx5/mlx5_ifc.h                      |   38 +-
 include/linux/mlx5/vport.h                         |    3 +-
 include/linux/mmc/sdio_ids.h                       |    4 +
 include/linux/net.h                                |   23 +
 include/linux/net/intel/libie/controlq.h           |  436 ++
 include/linux/net/intel/libie/pci.h                |   56 +
 include/linux/{avf => net/intel}/virtchnl.h        |    0
 .../idpf => include/linux/net/intel}/virtchnl2.h   |    0
 .../linux/net/intel}/virtchnl2_lan_desc.h          |    0
 include/linux/netdevice.h                          |   52 +-
 include/linux/netfilter.h                          |    7 +
 include/linux/netfilter/nf_conntrack_amanda.h      |    1 +
 include/linux/netfilter/nf_conntrack_ftp.h         |    1 +
 include/linux/netfilter/nf_conntrack_h323.h        |    2 -
 include/linux/netfilter/nf_conntrack_irc.h         |    1 +
 include/linux/netfilter/nf_conntrack_pptp.h        |    2 -
 include/linux/netfilter/nf_conntrack_sane.h        |    2 -
 include/linux/netfilter/nf_conntrack_tftp.h        |    3 +-
 include/linux/netpoll.h                            |   23 +-
 include/linux/oa_tc6.h                             |   73 +-
 include/linux/pci_ids.h                            |    4 +
 include/linux/pds/pds_core_if.h                    |  469 ++
 include/linux/phy.h                                |    9 +
 include/linux/phylink.h                            |    1 +
 include/linux/ptr_ring.h                           |   26 +-
 include/linux/rfkill.h                             |    9 +-
 include/linux/rtnetlink.h                          |    8 +
 include/linux/skbuff.h                             |    1 +
 include/linux/sonet.h                              |   20 -
 include/linux/tcp.h                                |    2 +-
 include/linux/udp.h                                |   27 +
 include/linux/usb/mctp-usb.h                       |   88 +-
 include/net/af_unix.h                              |    1 +
 include/net/af_vsock.h                             |    5 +-
 include/net/bluetooth/coredump.h                   |   14 +
 include/net/bluetooth/hci.h                        |   64 +
 include/net/bluetooth/hci_core.h                   |   33 +-
 include/net/bluetooth/hci_sync.h                   |    5 +-
 include/net/bluetooth/mgmt.h                       |   29 +
 include/net/bond_3ad.h                             |    4 +-
 include/net/bonding.h                              |    8 +-
 include/net/cfg80211.h                             |   61 +-
 include/net/devlink.h                              |   19 +-
 include/net/dsa.h                                  |    4 +
 include/net/fib_rules.h                            |    4 +-
 include/net/geneve.h                               |    5 -
 include/net/gre.h                                  |    2 -
 include/net/ieee80211_radiotap.h                   |  190 +
 include/net/ip6_fib.h                              |    5 +-
 include/net/ip6_route.h                            |    2 +
 include/net/ip_fib.h                               |    3 +-
 include/net/ip_tunnels.h                           |   12 +-
 include/net/ip_vs.h                                |    4 +-
 include/net/libeth/rx.h                            |    4 +-
 include/net/mac80211.h                             |   27 +-
 include/net/mana/gdma.h                            |   45 +-
 include/net/mana/mana.h                            |  109 +-
 include/net/mptcp.h                                |    4 -
 include/net/ndisc.h                                |    2 +
 include/net/net_namespace.h                        |    8 +-
 include/net/net_shaper.h                           |   52 +-
 include/net/netfilter/nf_conntrack_expect.h        |    3 +
 include/net/netfilter/nf_conntrack_helper.h        |   11 +-
 include/net/netfilter/nf_flow_table.h              |   10 +-
 include/net/netns/ipv4.h                           |    1 +
 include/net/nexthop.h                              |    6 +-
 include/net/scm.h                                  |   13 +-
 include/net/sctp/auth.h                            |    6 +-
 include/net/udp.h                                  |    2 +-
 include/net/vxlan.h                                |    8 +-
 include/trace/events/icmp.h                        |    2 +-
 include/trace/events/mptcp.h                       |    6 +-
 include/uapi/asm-generic/socket.h                  |    2 +
 include/uapi/linux/batadv_packet.h                 |   16 +-
 include/uapi/linux/devlink.h                       |    2 +
 include/uapi/linux/dpll.h                          |    8 +
 include/uapi/linux/ethtool.h                       |    6 +
 include/uapi/linux/if_addr.h                       |    1 +
 include/uapi/linux/if_tun.h                        |    4 +
 include/uapi/linux/mdio.h                          |    5 +
 include/uapi/linux/netdev.h                        |    1 +
 include/uapi/linux/nexthop.h                       |    3 +
 include/uapi/linux/nl80211.h                       |   46 +-
 include/uapi/linux/openvswitch.h                   |   31 +-
 include/uapi/linux/rtnetlink.h                     |   25 +
 include/uapi/linux/seg6_iptunnel.h                 |    1 +
 kernel/irq/manage.c                                |    1 +
 lib/tests/blackhole_dev_kunit.c                    |    2 +-
 net/6lowpan/nhc_udp.c                              |   10 +-
 net/atm/atm_misc.c                                 |   79 -
 net/batman-adv/bat_algo.c                          |   16 +-
 net/batman-adv/bat_iv_ogm.c                        |  331 +-
 net/batman-adv/bat_iv_ogm.h                        |    1 +
 net/batman-adv/bat_v.c                             |  100 +-
 net/batman-adv/bat_v.h                             |    5 +
 net/batman-adv/bat_v_elp.c                         |   28 +-
 net/batman-adv/bat_v_ogm.c                         |   67 +-
 net/batman-adv/bitarray.c                          |    9 +-
 net/batman-adv/bridge_loop_avoidance.c             |  122 +-
 net/batman-adv/distributed-arp-table.c             |  239 +-
 net/batman-adv/fragmentation.c                     |   35 +-
 net/batman-adv/gateway_client.c                    |   48 +-
 net/batman-adv/gateway_common.c                    |    6 +-
 net/batman-adv/hard-interface.c                    |  259 +-
 net/batman-adv/hard-interface.h                    |   10 +-
 net/batman-adv/hash.c                              |    5 +-
 net/batman-adv/hash.h                              |   42 +-
 net/batman-adv/log.h                               |   16 +-
 net/batman-adv/main.c                              |  113 +-
 net/batman-adv/main.h                              |    3 -
 net/batman-adv/mesh-interface.c                    |  126 +-
 net/batman-adv/multicast.c                         |   43 +-
 net/batman-adv/multicast_forw.c                    |   26 +-
 net/batman-adv/netlink.c                           |   26 +-
 net/batman-adv/netlink.h                           |    2 +-
 net/batman-adv/originator.c                        |   68 +-
 net/batman-adv/routing.c                           |  123 +-
 net/batman-adv/send.c                              |   13 +-
 net/batman-adv/tp_meter.c                          |  256 +-
 net/batman-adv/translation-table.c                 |  385 +-
 net/batman-adv/tvlv.c                              |  130 +-
 net/batman-adv/types.h                             |   32 +-
 net/bluetooth/6lowpan.c                            |    2 +
 net/bluetooth/Kconfig                              |    2 +-
 net/bluetooth/Makefile                             |    2 +
 net/bluetooth/af_bluetooth.c                       |    7 +-
 net/bluetooth/bnep/Kconfig                         |    2 +-
 net/bluetooth/bnep/Makefile                        |    2 +
 net/bluetooth/coredump.c                           |   54 +-
 net/bluetooth/hci_conn.c                           |   20 +-
 net/bluetooth/hci_core.c                           |   12 +-
 net/bluetooth/hci_debugfs.c                        |   12 +-
 net/bluetooth/hci_event.c                          |  122 +-
 net/bluetooth/hci_sync.c                           |  267 +-
 net/bluetooth/hidp/Kconfig                         |    2 +-
 net/bluetooth/hidp/Makefile                        |    2 +
 net/bluetooth/iso.c                                |   32 +-
 net/bluetooth/l2cap_core.c                         |   32 +-
 net/bluetooth/l2cap_sock.c                         |    1 +
 net/bluetooth/mgmt.c                               |  169 +-
 net/bluetooth/msft.c                               |    5 +
 net/bluetooth/rfcomm/Kconfig                       |    2 +-
 net/bluetooth/rfcomm/Makefile                      |    2 +
 net/bluetooth/rfcomm/core.c                        |   24 +-
 net/bluetooth/rfcomm/sock.c                        |    1 +
 net/bluetooth/smp.c                                |    7 +-
 net/bluetooth/smp.h                                |    6 +-
 net/bridge/br_arp_nd_proxy.c                       |   55 +-
 net/bridge/br_device.c                             |    4 +-
 net/bridge/br_input.c                              |    4 +-
 net/bridge/br_multicast.c                          |  105 +-
 net/bridge/br_private.h                            |    6 +-
 net/bridge/br_vlan.c                               |    4 +-
 net/bridge/netfilter/ebtables.c                    |   12 +-
 net/compat.c                                       |    4 +-
 net/core/dev.c                                     |  341 +-
 net/core/devmem.c                                  |   37 +-
 net/core/devmem.h                                  |   13 +-
 net/core/failover.c                                |    4 +-
 net/core/fib_rules.c                               |   83 +-
 net/core/lock_debug.c                              |    4 +-
 net/core/net-sysfs.c                               |    2 +-
 net/core/net_namespace.c                           |    4 +
 net/core/netdev-genl-gen.c                         |   11 +-
 net/core/netdev-genl-gen.h                         |    1 +
 net/core/netdev-genl.c                             |   30 +-
 net/core/netpoll.c                                 |  259 +-
 net/core/page_pool.c                               |   64 +-
 net/core/pktgen.c                                  |   29 +-
 net/core/rtnetlink.c                               |   96 +-
 net/core/scm.c                                     |   40 +-
 net/core/selftests.c                               |    4 +-
 net/core/skbuff.c                                  |   16 +-
 net/core/sysctl_net_core.c                         |   38 +-
 net/core/tso.c                                     |    3 +-
 net/devlink/core.c                                 |   20 +-
 net/devlink/dev.c                                  |   16 +-
 net/devlink/devl_internal.h                        |   20 +
 net/devlink/dpipe.c                                |   14 +-
 net/devlink/health.c                               |   12 +-
 net/devlink/linecard.c                             |    4 +-
 net/devlink/netlink.c                              |   82 +-
 net/devlink/netlink_gen.c                          |   24 +-
 net/devlink/netlink_gen.h                          |    8 +
 net/devlink/param.c                                |    9 +-
 net/devlink/port.c                                 |   26 +-
 net/devlink/rate.c                                 |  329 +-
 net/devlink/region.c                               |    6 +-
 net/devlink/resource.c                             |   14 +-
 net/devlink/sb.c                                   |   22 +-
 net/devlink/trap.c                                 |   12 +-
 net/dns_resolver/dns_key.c                         |    3 +-
 net/dns_resolver/dns_query.c                       |    2 +-
 net/dsa/Kconfig                                    |    6 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/dsa.c                                      |   22 +-
 net/dsa/tag_ksz.c                                  |  237 +-
 net/dsa/tag_mt7628.c                               |   93 +
 net/dsa/user.c                                     |   24 +-
 net/ethtool/tsconfig.c                             |   12 +-
 net/hsr/hsr_device.c                               |   46 +-
 net/hsr/hsr_forward.c                              |   46 +-
 net/hsr/hsr_framereg.c                             |   27 +-
 net/hsr/hsr_framereg.h                             |    2 +
 net/hsr/hsr_main.h                                 |    2 +-
 net/hsr/hsr_netlink.c                              |    8 +-
 net/ieee802154/socket.c                            |   38 +-
 net/ipv4/devinet.c                                 |   10 +-
 net/ipv4/esp4.c                                    |    2 +-
 net/ipv4/fib_frontend.c                            |   69 +-
 net/ipv4/fib_rules.c                               |   20 +-
 net/ipv4/fib_trie.c                                |    3 +-
 net/ipv4/fou_core.c                                |    2 +-
 net/ipv4/igmp.c                                    |    2 +
 net/ipv4/ip_gre.c                                  |   89 +-
 net/ipv4/ip_output.c                               |    4 +
 net/ipv4/ip_tunnel.c                               |   19 +-
 net/ipv4/ipconfig.c                                |    6 +-
 net/ipv4/ipip.c                                    |   18 +-
 net/ipv4/ipmr.c                                    |    3 +
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c        |    6 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |    6 +-
 net/ipv4/nexthop.c                                 |   34 +-
 net/ipv4/raw.c                                     |   41 +-
 net/ipv4/route.c                                   |   35 +-
 net/ipv4/sysctl_net_ipv4.c                         |   54 +-
 net/ipv4/tcp_minisocks.c                           |    4 +-
 net/ipv4/tcp_output.c                              |    8 +-
 net/ipv4/tcp_timer.c                               |    2 +-
 net/ipv4/udp.c                                     |   52 +-
 net/ipv4/udp_offload.c                             |   49 +-
 net/ipv4/udp_tunnel_core.c                         |    2 +-
 net/ipv4/xfrm4_policy.c                            |   22 +-
 net/ipv6/Makefile                                  |    2 +-
 net/ipv6/addrconf.c                                |   28 +-
 net/ipv6/esp6.c                                    |    5 +-
 net/ipv6/fib6_rules.c                              |   17 +-
 net/ipv6/fou6.c                                    |    2 +-
 net/ipv6/icmp.c                                    |    2 +-
 net/ipv6/ip6_fib.c                                 |   14 +-
 net/ipv6/ip6_gre.c                                 |   19 +-
 net/ipv6/ip6_input.c                               |    1 +
 net/ipv6/ip6_output.c                              |    2 +
 net/ipv6/ip6_tunnel.c                              |   57 +-
 net/ipv6/ip6_udp_tunnel.c                          |    2 +-
 net/ipv6/mcast.c                                   |    1 +
 net/ipv6/ndisc.c                                   |    5 +-
 net/ipv6/ndisc_snoop.c                             |  190 +
 net/ipv6/netfilter/nf_reject_ipv6.c                |    8 +-
 net/ipv6/raw.c                                     |   29 +-
 net/ipv6/route.c                                   |   77 +-
 net/ipv6/seg6_iptunnel.c                           |  132 +-
 net/ipv6/sit.c                                     |    2 +-
 net/ipv6/sysctl_net_ipv6.c                         |    2 +-
 net/ipv6/udp.c                                     |   32 +-
 net/ipv6/udp_offload.c                             |    2 +-
 net/ipv6/xfrm6_policy.c                            |   22 +-
 net/kcm/kcmsock.c                                  |    3 +
 net/l2tp/l2tp_core.c                               |    2 +-
 net/l2tp/l2tp_netlink.c                            |    7 +-
 net/mac80211/airtime.c                             |   87 +-
 net/mac80211/cfg.c                                 |  141 +-
 net/mac80211/chan.c                                |    6 +-
 net/mac80211/debugfs.c                             |   32 +-
 net/mac80211/ibss.c                                |    4 +-
 net/mac80211/ieee80211_i.h                         |   26 +-
 net/mac80211/link.c                                |    3 +-
 net/mac80211/main.c                                |    5 +-
 net/mac80211/mlme.c                                |  182 +-
 net/mac80211/offchannel.c                          |   27 +-
 net/mac80211/parse.c                               |    4 +-
 net/mac80211/s1g.c                                 |    2 +-
 net/mac80211/spectmgmt.c                           |   11 +-
 net/mac80211/sta_info.c                            |   66 +-
 net/mac80211/sta_info.h                            |    3 +-
 net/mac80211/status.c                              |   10 +-
 net/mac80211/tdls.c                                |    2 +-
 net/mac80211/tx.c                                  |  111 +-
 net/mac80211/util.c                                |   24 +-
 net/mpls/af_mpls.c                                 |    2 +
 net/mptcp/mib.c                                    |   10 +
 net/mptcp/mib.h                                    |   10 +
 net/mptcp/options.c                                |   32 +-
 net/mptcp/pm.c                                     |   44 +-
 net/mptcp/pm_userspace.c                           |    7 +-
 net/mptcp/protocol.c                               |  313 +-
 net/mptcp/protocol.h                               |   16 +-
 net/mptcp/subflow.c                                |   10 +
 net/netfilter/ipvs/ip_vs_core.c                    |    9 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |    6 +-
 net/netfilter/ipvs/ip_vs_est.c                     |    2 +-
 net/netfilter/ipvs/ip_vs_nfct.c                    |    2 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |    2 +-
 net/netfilter/nf_conncount.c                       |    2 +
 net/netfilter/nf_conntrack_amanda.c                |    8 +-
 net/netfilter/nf_conntrack_broadcast.c             |    8 +-
 net/netfilter/nf_conntrack_core.c                  |    2 +-
 net/netfilter/nf_conntrack_ecache.c                |    7 +-
 net/netfilter/nf_conntrack_expect.c                |   11 +
 net/netfilter/nf_conntrack_ftp.c                   |   34 +-
 net/netfilter/nf_conntrack_h323_main.c             |   12 +-
 net/netfilter/nf_conntrack_helper.c                |   91 +-
 net/netfilter/nf_conntrack_irc.c                   |   29 +-
 net/netfilter/nf_conntrack_netbios_ns.c            |    2 -
 net/netfilter/nf_conntrack_netlink.c               |    5 +
 net/netfilter/nf_conntrack_ovs.c                   |    6 +-
 net/netfilter/nf_conntrack_pptp.c                  |    2 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |    6 +-
 net/netfilter/nf_conntrack_proto_udp.c             |   15 +-
 net/netfilter/nf_conntrack_sane.c                  |   34 +-
 net/netfilter/nf_conntrack_sip.c                   |   45 +-
 net/netfilter/nf_conntrack_snmp.c                  |    4 +-
 net/netfilter/nf_conntrack_standalone.c            |    2 +-
 net/netfilter/nf_conntrack_tftp.c                  |   35 +-
 net/netfilter/nf_flow_table_core.c                 |    2 +
 net/netfilter/nf_flow_table_ip.c                   |  175 +-
 net/netfilter/nf_flow_table_path.c                 |  118 +-
 net/netfilter/nf_hooks_lwtunnel.c                  |    4 +-
 net/netfilter/nf_log_syslog.c                      |    2 +-
 net/netfilter/nf_nat_amanda.c                      |    7 +-
 net/netfilter/nf_nat_core.c                        |    6 -
 net/netfilter/nf_nat_ftp.c                         |    4 +-
 net/netfilter/nf_nat_helper.c                      |    2 +-
 net/netfilter/nf_nat_irc.c                         |    2 +-
 net/netfilter/nf_nat_proto.c                       |    8 +
 net/netfilter/nf_nat_sip.c                         |    5 +
 net/netfilter/nf_nat_tftp.c                        |    5 +-
 net/netfilter/nfnetlink_cthelper.c                 |   21 +-
 net/netfilter/nfnetlink_cttimeout.c                |    2 +-
 net/netfilter/nfnetlink_hook.c                     |   37 +-
 net/netfilter/nft_ct.c                             |  168 +-
 net/netfilter/nft_meta.c                           |    6 +-
 net/netfilter/nft_rt.c                             |    6 +-
 net/netfilter/nft_set_rbtree.c                     |    3 +-
 net/netfilter/nft_xfrm.c                           |    9 +-
 net/netfilter/x_tables.c                           |   30 +-
 net/netfilter/xt_TCPOPTSTRIP.c                     |    8 +-
 net/netfilter/xt_dscp.c                            |   12 +
 net/netfilter/xt_recent.c                          |    2 +-
 net/netfilter/xt_tcpmss.c                          |   14 +
 net/netlink/af_netlink.c                           |    2 +-
 net/nfc/digital_core.c                             |    2 +-
 net/nfc/digital_technology.c                       |    2 +
 net/nfc/llcp_commands.c                            |   18 +-
 net/nfc/llcp_core.c                                |   44 +-
 net/nfc/llcp_sock.c                                |   14 +-
 net/nfc/nci/data.c                                 |   10 +-
 net/nfc/nci/ntf.c                                  |   36 +-
 net/nfc/nci/rsp.c                                  |   42 +-
 net/openvswitch/Kconfig                            |   35 -
 net/openvswitch/Makefile                           |    4 -
 net/openvswitch/conntrack.c                        |   20 +-
 net/openvswitch/datapath.c                         |   75 +-
 net/openvswitch/vport-geneve.c                     |  143 -
 net/openvswitch/vport-gre.c                        |  106 -
 net/openvswitch/vport-netdev.c                     |   29 +-
 net/openvswitch/vport-netdev.h                     |    2 -
 net/openvswitch/vport-vxlan.c                      |  172 -
 net/openvswitch/vport.c                            |   81 +-
 net/openvswitch/vport.h                            |   23 +-
 net/phonet/pep.c                                   |   36 +-
 net/psp/psp_main.c                                 |    2 +-
 net/psp/psp_nl.c                                   |    3 +-
 net/psp/psp_sock.c                                 |    2 +-
 net/rds/ib_rdma.c                                  |    4 +-
 net/rds/info.c                                     |   23 +-
 net/rds/loop.c                                     |    6 +-
 net/rds/message.c                                  |   26 +
 net/rds/rdma.c                                     |   63 +-
 net/rds/rds.h                                      |   15 +-
 net/rds/recv.c                                     |    3 +
 net/rds/send.c                                     |   33 +-
 net/sched/act_csum.c                               |    4 +-
 net/sched/act_ct.c                                 |   10 +-
 net/sched/cls_api.c                                |   18 +-
 net/sched/sch_mqprio.c                             |    4 +-
 net/sched/sch_mqprio_lib.c                         |   10 +-
 net/sched/sch_taprio.c                             |   35 +-
 net/sctp/associola.c                               |    4 +
 net/sctp/auth.c                                    |   10 +-
 net/sctp/endpointola.c                             |    4 +
 net/sctp/output.c                                  |   12 +-
 net/sctp/sm_sideeffect.c                           |    4 +
 net/sctp/sm_statefuns.c                            |    9 +-
 net/sctp/sysctl.c                                  |    2 +-
 net/smc/af_smc.c                                   |    5 +-
 net/smc/smc_core.c                                 |   13 +-
 net/smc/smc_sysctl.c                               |   26 +-
 net/smc/smc_tx.h                                   |    6 +-
 net/sysctl_net.c                                   |   23 +-
 net/tls/tls_main.c                                 |   80 +-
 net/tls/tls_strp.c                                 |   16 +-
 net/unix/af_unix.c                                 |   24 +-
 net/unix/sysctl_net_unix.c                         |   21 +-
 net/vmw_vsock/af_vsock.c                           |   87 +-
 net/vmw_vsock/virtio_transport_common.c            |   49 +-
 net/wireless/core.c                                |    3 +
 net/wireless/core.h                                |    7 +-
 net/wireless/mlme.c                                |    2 +-
 net/wireless/nl80211.c                             |  546 +-
 net/wireless/rdev-ops.h                            |   24 +-
 net/wireless/reg.c                                 |    3 +-
 net/wireless/scan.c                                |   93 +-
 net/wireless/tests/scan.c                          |  121 +-
 net/wireless/trace.h                               |    2 +-
 net/wireless/util.c                                |  107 +-
 net/wireless/wext-compat.c                         |    3 +-
 net/wireless/wext-core.c                           |    6 +-
 net/xdp/xsk_queue.c                                |   12 +-
 net/xfrm/xfrm_nat_keepalive.c                      |    2 +-
 net/xfrm/xfrm_sysctl.c                             |    2 +-
 tools/include/uapi/linux/if_tun.h                  |    4 +
 tools/include/uapi/linux/netdev.h                  |    1 +
 tools/net/ynl/Makefile.deps                        |    1 +
 tools/net/ynl/pyynl/__init__.py                    |    9 +
 tools/net/ynl/pyynl/cli.py                         |   56 +-
 tools/net/ynl/pyynl/lib/__init__.py                |    3 +-
 tools/net/ynl/pyynl/lib/nlspec.py                  |   22 +-
 tools/net/ynl/pyynl/lib/specdir.py                 |   51 +
 tools/net/ynl/pyynl/lib/ynl.py                     |   19 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |   35 +-
 tools/net/ynl/tests/ethtool.py                     |    7 +-
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  |    4 +-
 .../drivers/net/bonding/bond_topo_2d1c.sh          |   10 +-
 tools/testing/selftests/drivers/net/config         |    5 +
 tools/testing/selftests/drivers/net/hw/Makefile    |    6 +-
 tools/testing/selftests/drivers/net/hw/config      |    2 +
 tools/testing/selftests/drivers/net/hw/csum.py     |    2 +-
 .../drivers/net/hw/devlink_rate_cross_esw.py       |  296 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |   11 +-
 .../testing/selftests/drivers/net/hw/devmem_lib.py |  114 +-
 .../selftests/drivers/net/hw/ethtool_rmon.sh       |    2 +
 .../selftests/drivers/net/hw/ethtool_std_stats.sh  |    6 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |   38 +-
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |   10 +-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |   11 +-
 tools/testing/selftests/drivers/net/hw/toeplitz.py |   22 +
 tools/testing/selftests/drivers/net/hw/tso.py      |    2 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |   59 +-
 .../selftests/drivers/net/netconsole/Makefile      |    1 +
 .../drivers/net/netconsole/netcons_userdata.sh     |  229 +
 .../drivers/net/netdevsim/ethtool-coalesce.sh      |   10 +-
 .../testing/selftests/drivers/net/ring_reconfig.py |  255 +-
 tools/testing/selftests/drivers/net/shaper.py      | 1065 ++-
 tools/testing/selftests/drivers/net/so_txtime.py   |   21 +-
 tools/testing/selftests/drivers/net/xdp.py         |   94 +-
 tools/testing/selftests/net/Makefile               |    5 +-
 tools/testing/selftests/net/af_unix/.gitignore     |    2 +
 tools/testing/selftests/net/af_unix/Makefile       |    8 +
 tools/testing/selftests/net/af_unix/config         |    7 +
 .../net/af_unix/scm_rights_denial_lsm.bpf.c        |   36 +
 .../selftests/net/af_unix/scm_rights_denial_lsm.c  |  292 +
 tools/testing/selftests/net/big_tcp_tunnels.sh     |  188 +
 tools/testing/selftests/net/config                 |    6 +-
 tools/testing/selftests/net/fib_nexthops.sh        |   83 +
 tools/testing/selftests/net/fin_ack_lat.c          |    2 +-
 tools/testing/selftests/net/forwarding/lib.sh      |   15 +
 tools/testing/selftests/net/fou_mcast_encap.sh     |  172 +
 tools/testing/selftests/net/getsockopt_iter.c      |  336 +
 tools/testing/selftests/net/hsr/Makefile           |    1 +
 tools/testing/selftests/net/hsr/hsr_prp_redbox.sh  |   99 +
 tools/testing/selftests/net/ipv6_flowlabel.sh      |    3 -
 tools/testing/selftests/net/ipv6_flowlabel_mgr.c   |  576 +-
 tools/testing/selftests/net/lib/py/__init__.py     |    4 +-
 tools/testing/selftests/net/lib/py/ynl.py          |    7 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |    4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |    8 +-
 tools/testing/selftests/net/mptcp/mptcp_diag.c     |    3 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   95 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   11 +-
 .../selftests/net/netfilter/conntrack_dump_flush.c |   31 +-
 tools/testing/selftests/net/openvswitch/config     |    4 +-
 .../selftests/net/openvswitch/openvswitch.sh       |  296 +-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  122 +-
 tools/testing/selftests/net/psock_snd.c            |  237 +-
 tools/testing/selftests/net/psock_snd.sh           |   15 +
 tools/testing/selftests/net/reuseport_bpf_numa.c   |   24 +
 tools/testing/selftests/net/rtnetlink.py           |  286 +-
 .../selftests/net/srv6_encap_lookup_l3vpn_test.sh  | 1027 +++
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh      |   10 +
 tools/testing/selftests/net/tcp_mmap.c             |   10 +-
 tools/testing/selftests/net/test_vxlan_nh.sh       |   40 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          |  164 +
 1445 files changed, 112469 insertions(+), 29146 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie
 create mode 100644 Documentation/devicetree/bindings/net/adi,ad3306.yaml
 create mode 100644 Documentation/devicetree/bindings/net/can/ti,am3517-hecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt
 create mode 100644 Documentation/devicetree/bindings/net/dptel,dap8211r.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan7800.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
 create mode 100644 Documentation/networking/devlink/ixd.rst
 create mode 100644 drivers/firmware/qcom/qcom_pas.c
 create mode 100644 drivers/firmware/qcom/qcom_pas.h
 create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/ethernet/adi/adin1140.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_admin.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_admin.h
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_mbox.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_mbox.h
 delete mode 100644 drivers/net/ethernet/dec/tulip/xircom_cb.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/Makefile
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_ethtool.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_hw.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_main.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_phyp.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_phyp.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_qmr.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_qmr.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
 delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
 create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
 create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_dev.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lib.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
 create mode 100644 drivers/net/ethernet/intel/libie/pci.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h
 create mode 100644 drivers/net/ethernet/zte/Kconfig
 create mode 100644 drivers/net/ethernet/zte/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
 create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/dh_queue.h
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h
 create mode 100644 drivers/net/mctp/mctp-usblib-test.c
 create mode 100644 drivers/net/mctp/mctp-usblib.c
 create mode 100644 drivers/net/phy/adin1140-phy.c
 create mode 100644 drivers/net/phy/dap8211r.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/nan.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/nan.h
 create mode 100644 drivers/net/wireless/morsemicro/Kconfig
 create mode 100644 drivers/net/wireless/morsemicro/Makefile
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/Kconfig
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/Makefile
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/bus.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command_defs.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hif.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mmrc.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mmrc.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rate_code.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/sdio.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/skbq.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/skbq.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/usb.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps.h
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps_hw.h
 create mode 100644 drivers/net/wireless/nxp/Kconfig
 create mode 100644 drivers/net/wireless/nxp/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ac.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11ax.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11h.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_aggr.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/11n_rxreorder.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Kconfig
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/Makefile
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfg80211.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cfp.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/cmdevt.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/debugfs.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ethtool.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/fw.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/ie.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/init.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/join.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/main.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/scan.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sdio.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cfg.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_rx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/sta_tx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_event.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/uap_txrx.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/util.h
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.c
 create mode 100644 drivers/net/wireless/nxp/nxpwifi/wmm.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/led.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/led.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/led_mc.c
 create mode 100644 include/cxl/pci.h
 create mode 100644 include/linux/firmware/qcom/qcom_pas.h
 create mode 100644 include/linux/net/intel/libie/controlq.h
 create mode 100644 include/linux/net/intel/libie/pci.h
 rename include/linux/{avf => net/intel}/virtchnl.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2.h (100%)
 rename {drivers/net/ethernet/intel/idpf => include/linux/net/intel}/virtchnl2_lan_desc.h (100%)
 delete mode 100644 include/linux/sonet.h
 create mode 100644 net/dsa/tag_mt7628.c
 create mode 100644 net/ipv6/ndisc_snoop.c
 delete mode 100644 net/openvswitch/vport-geneve.c
 delete mode 100644 net/openvswitch/vport-gre.c
 delete mode 100644 net/openvswitch/vport-vxlan.c
 create mode 100644 tools/net/ynl/pyynl/lib/specdir.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py
 create mode 100755 tools/testing/selftests/drivers/net/netconsole/netcons_userdata.sh
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.bpf.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_lsm.c
 create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh
 create mode 100755 tools/testing/selftests/net/hsr/hsr_prp_redbox.sh
 create mode 100755 tools/testing/selftests/net/srv6_encap_lookup_l3vpn_test.sh
