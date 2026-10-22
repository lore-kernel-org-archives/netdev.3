Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685391;
	b=1rwOUuc2ThNh6NyDn5IqAzOZNqr0ifMlIrp065svxpJ1KWsEBH2AifMuU2c9+5zJjukG
	 nlwXZUkcX5atgkGSOmKOOmFbLiI/orcQcF6JeOh7LUjU44QFyYMUIAAqSBeEwzV684lQQ
	 UvxhhEl28KEMS3XqZCCXBX+ooa1zsRl2OynHU3uCFVRTP84o4tUQHD0ui0rkVjhAyQUpX
	 q8NYzlTztkYYp+gyKWFKn+j/KtsX/hBly8ZvZlrOveDlbQA24j8YGEUOJfi9vhuIp1kYn
	 R+u6XUShvaa6m6skW2DYhhGcY00R8XRDzpaCCu6Nw/xVh4kF08/qPXmaI4Ng2iqgLFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685391;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=XchiJegYtGVGOB87mqnCu26mxNaIGTNCEUodLW2Hrug=;
	b=ou1gL4w06+Wyb6k+BVRbkgxJO1HNYO4+fOheR/71Apy2FiuOkmkka8NyDuTVL/KYum4g
	 E4Zisvo4b+o1rtXEUjWmj+B19uZ9kjIQb1NFwbOJ1VfmNdmQlHBlZm2VUNGmdVvEcZXe1
	 YUNtMFQqHeWuyRP5TX8Dh1bHTSPv7W0y4q9wIE7a/07zvzl7Y0xRCgfUsD2hVBV8OocdQ
	 ZDJg3OKvmmZ9twhkiNmQnoHbOi4LecC9PHDtj+dv7yUBSAv1k4I3KLZD4Rhaq3rmVbU23
	 rBfdNmrDraKPhls5tNGZ+RHhJfZMMtss6I6pAHse798puCnpk6YsGphZFpZgwneoZSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DSeo6dM0;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DB8606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1DB8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DSeo6dM0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792685388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XchiJegYtGVGOB87mqnCu26mxNaIGTNCEUodLW2Hrug=;
	b=DSeo6dM09vp9MiS/G+NQBhn1TMdwsvD7W4oCQRPykQ+qUP4bvjlFBdSc/kmk4IAP0hD39A
	MwZmz1bR7k18/q0czRdgszoT5FRBmXzAA4H0rUwOE8q5QDqjyGVUMcwB14EAGw8g42v5pX
	/bEDsANf8txJdtWk/4kmMpTxZy26XBI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-Q_M9R18QNOi_R8NvzDmyng-1; Thu,
 22 Oct 2026 12:09:40 -0400
X-MC-Unique: Q_M9R18QNOi_R8NvzDmyng-1
X-Mimecast-MFC-AGG-ID: Q_M9R18QNOi_R8NvzDmyng_1792685379
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 349A31955D59;
	Thu, 22 Oct 2026 16:09:39 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2A3218004D2;
	Thu, 22 Oct 2026 16:09:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for 7.4
Date: Thu, 22 Oct 2026 18:09:28 +0200
Message-ID: <20261022160928.231626-1-pabeni@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Linus!

I'm not aware of any pending conflicts with other trees (and I hope
it's not just the lack of coffee speaking). This PR includes a
significant number of low-priority fixes - especially in the NIC drivers
area - that we deferred from the last few RCs in the previous cycle,
which can't be easily outlined in the synopsis below.

The following changes since commit 045958acaa75205b31578cb22c4345e28dd2e4bf:

  Merge tag 'net-7.3-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-10-15 08:20:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-7.4

for you to fetch changes up to 1a2c35c49cc7c6be860038b8442b52424a8f123c:

  Bluetooth: btusb: disable by default Qualcomm multi-subsystem (2026-10-22 17:45:45 +0200)

----------------------------------------------------------------
Networking changes for 7.4.

Core & protocols
----------------

 - Continue the work on removing rtnl_lock dependencies:
    - per-netns ARP and ND neighbour tables, with the default settings
      now configurable per netns (inheritance from init_net is
      controlled by the new net.core.neigh_inherit_init_net sysctl)
    - RCU-protected configuration and rtnl_lock-less fill_info() for
      hsr, netkit, sit, vlan and vxlan devices
    - per-netns device unregistration for ip tunnel and gre devices
    - use the netdev instance lock instead of rtnl_lock when reading
      speed and duplex via sysfs
    - batch the flushing of uncached routes at device unregistration
      time, relieving rtnl_lock contention on netns dismantle.

 - Add hardware pacing offload support, admin-controlled via a new
   rtnetlink attribute, with sch_fq integration (implemented in idpf).

 - Re-segment BIG TCP GSO packets into GSO packets fitting the
   egress device limits instead of plain MSS-sized segments,
   improving throughput for mixed BIG TCP / non-BIG TCP paths
   by up to 70%.

 - Generate RSS keys that spread flows over all the RX queues; the
   previous random keys could leave some queues unused.

 - Optimize the bridge VLAN forwarding paths: cache the port-VLAN in fdb
   entries and consider only VLAN members when flooding, for ~10% more
   Mpps in the fdb forwarding path.

 - A few TCP/IP performance improvements aimed at efficient cache
   usage and reducing contention.

 - Add the TCP ROCCET congestion control, a CUBIC variant aimed at
   avoiding bufferbloat in cellular networks.

 - Continue the conversion of getsockopt callbacks to sockopt_t.

 - Add an ethtool command to list the front-facing ports of an
   interface, including SFP cages and modules, using the phy_port
   representation.

 - Enable BIG TCP support for bareudp tunnels.

 - Remove the IPV6_ADDRFORM socket option and disallow buggy TCP state
   transitions (listen() + shutdown() + connect() and connect() +
   connect(AF_UNSPEC) + listen()).

 - Remove most BUG_ON()s from core packet processing, replacing them
   with error paths.

Wireless
--------

 - Latency improvements, including lockless station get/dump and beacon
   updates, plus RTNL reduction and locking cleanups.

 - Infrastructure for non-station TX/RX with MLO.

 - NAN (Wi-Fi Aware) Instant Communication support and other NAN
   improvements.

 - Control frame Integrity Protocol (CIP) and protected TWT support.

 - Improvements for AP regulatory checks.

Netfilter
---------

 - Disable br_netfilter in user namespaces and schedule it for removal
   in 2027.

 - Restrict the raw table in nft_compat to the specific family, hook and
   priority.

 - Prepare the flowtable for mixed IPv4-over-IPv6 tunneling (and
   vice versa).

 - Use GFP_KERNEL_ACCOUNT for most netfilter allocations, for better
   integration with memcg.

 - Allow discovering conntrack zone filtering support in ctnetlink
   dumps, and fix nfnetlink_hook handling of large dumps.

Deletions
---------

 - Move the LLC type 2 sockets out of tree. There are no known users and
   the code attracts a never-ending stream of LLM-driven fixes.

Device drivers
--------------

 - New drivers:
    - Meta Platforms NIC (mpnic), the second-generation NIC from Meta
    - initial skeleton of the Nebula-matrix NICs driver (nbl)
    - X-Powers AC200/AC300 Fast Ethernet PHYs

 - Ethernet high-speed NICs:
    - Intel:
       - i40e: XDP metadata support for RX hash and VLAN tag
       - ice: expose the E825 TSPLL state via the DPLL subsystem
    - nVidia/Mellanox:
       - move the data direct infrastructure from IB to core, in
         preparation for netdev support.
       - reduce the memory used per offloaded TC rule
    - Meta (fbnic):
       - support large io_uring zero-copy RX buffers
    - Microsoft vNIC (mana):
       - add BQL support

 - Ethernet NICs consumer, and embedded:
    - Airoha:
       - LRO offload support
    - Cadence (macb):
       - context swapping for ringparam and MTU changes, avoiding
         buffer loss under memory pressure
    - Mucse (rnpgbe):
       - TX/RX and link status support
    - NXP (enetc):
       - SR-IOV improvements and VF support for ENETC v4
    - Qualcomm (ppe):
       - IPQ5424 support
    - Realtek PCI (r8169):
       - phylink support
       - RSS support for RTL8127
    - Renesas (ravb):
       - gPTP support for R-Car Gen4
    - Synopsys (stmmac):
       - XDP multi-buffer support on the TX side
       - tc mqprio hw queue priority offload
       - support for RK3568 SGMII, Allwinner H616 EMAC1, UltraRISC
         DP1000 and Qualcomm sa8255p

 - Ethernet switches:
    - Mediatek (mt7530):
       - fast age and change conduit support
    - Microchip (ksz):
       - support for KSZ8995XA/KS8995XA
    - Microchip (lan966x):
       - PCIe FDMA support, ~20x throughput increase in PCIe endpoint
    - Microchip (sparx5):
       - Time Aware Shaper (taprio) offload
    - Motorcomm (yt921x):
       - LED and SerDes PCS support
    - Realtek (rtl8365mb):
       - EEE support

 - Ethernet PHYs:
    - Broadcom:
       - enable jumbo frames on BCM54xx
    - Realtek:
       - support for RTL8261CE_CG and RTL8261D_VM
       - MDIO support for RTL838x and RTL839x

 - WiFi drivers:
    - Broadcom (brcmfmac):
       - FT/OKC roaming offload
    - Intel (iwlwifi):
       - UHR sniffer support
       - support for newer UEFI/BIOS tables
    - MediaTek (mt76):
       - mt7925 NAN improvements
       - offchannel/scan improvements and MLO fixes
    - Morse Micro (mm81x):
       - monitor mode support
    - Qualcomm (ath12k):
       - IPQ5332 platform infrastructure
    - Realtek (rtw88):
       - RTL8723BS support
       - SDIO TX performance improvements
    - Realtek (rtw89):
       - P2P_DEVICE support
       - BT-coex updates for RTL8922D

 - Bluetooth:
    - move H:4 reassembly into the Bluetooth core
    - add generic support for vendor packets
    - MGMT: add security level changed event

 - Bluetooth drivers:
    - btusb: support Bulk Serialization Mode
    - Intel: support Draco and Titan Lake, allow unsigned firmware
    - Mediatek: MT7928 support
    - Qualcomm: QCC2072 support
    - Broadcom: Synaptics 4384 support

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aamir Ahmed (4):
      macsec: require CAP_NET_ADMIN in the device netns for changelink
      wifi: nxpwifi: validate variable IE lengths in beacon parser
      wifi: mm81x: validate n_channels in disabled channels response
      wifi: mt76: mt7996: validate TLV length in mt7996_mcu_ie_countdown()

Aaradhana Sahu (14):
      mailmap: add entries for Aaradhana Sahu
      wifi: ath12k: Free allocated CE IRQs on request_irq() failure
      wifi: ath12k: Free allocated external IRQs on request_irq() failure
      wifi: ath12k: add support to load shared firmware on multiPD
      wifi: ath12k: move dp_profile_params to dp.h
      wifi: ath12k: convert DP_TX_COMP_RING_SIZE to inline helper
      wifi: ath12k: convert DP_RXDMA_MONITOR_BUF_RING_SIZE to inline helper
      wifi: ath12k: convert DP_RXDMA_MONITOR_DST_RING_SIZE to inline helper
      wifi: ath12k: convert ATH12K_NUM_POOL_TX_DESC to inline helper
      wifi: ath12k: convert ATH12K_RX_DESC_COUNT to inline helper
      wifi: ath12k: convert DP_RX_RELEASE_RING_SIZE to inline helper
      wifi: mac80211: Do not report BSS parameters in AP station info
      wifi: ath12k: Make RXDMA buffer ring size configurable per memory profile
      wifi: ath12k: Fix NAPI resource leaks in AHB external IRQ paths

Aaron Kling (1):
      Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth

Abdifatah Suruur (1):
      net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops

Abdun Nihaal (1):
      wifi: ath11k: Fix possible memory leak in ath11k_dp_srng_setup()

Abdurrahman Karadag (1):
      wifi: rtw88: debugfs: don't vzalloc(0) when rsvd_page is read unconfigured

Abhijit Gangurde (1):
      net: ionic: Fetch qid allocation and SRQ capability from firmware

Adriano Cordova (2):
      netdevsim: take bus device refcount before registering device
      Bluetooth: bnep: linearize skb before sending

Ahmad Fatoum (1):
      net: dsa: realtek: rtl83xx: add support for enabling supplies

Ahmed Naseef (1):
      wifi: mt76: mt7615: read MT7663 temperature from the correct offset

Ajith P V (1):
      Bluetooth: bnep: refactor deprecated strcpy

Ajith Parappalliyalil Venugopal (1):
      tipc: replace deprecated strcpy with strscpy in tipc_bearer_get_name()

Albert Esteve (1):
      wifi: ath10k: clear QMI if failed during init

Aleksandr Loktionov (2):
      ice: increase OICR interrupt moderation rate to 20K interrupts/sec
      ice: use inline helpers instead of memcmp() for IPv6 mask checks in ice_ethtool_fdir

Aleksei Sviridkin (7):
      net: phy: air_en8811h: refuse a firmware blob that is not a multiple of 4
      net: usb: lan78xx: register the PHY interrupt with the MDIO bus
      net: usb: smsc95xx: register the PHY interrupt with the MDIO bus
      net: phy: take the interrupt back from the bus on detach
      net: phy: restore the interrupt when the generic bind cycle fails
      net: phy: refuse a second attach before touching the PHY
      net: phy: put the driver module the attach took

Alessandro Zini (3):
      dt-bindings: net: microchip,lan8650: add reset-gpios property
      net: ethernet: oa_tc6: return ERR_PTR from oa_tc6_init()
      net: ethernet: oa_tc6: add reset-gpios support

Alessio Faina (1):
      selftests/net: skip srv6_end_dt[4/6]_l3vpn_test.sh if vrftable not available

Alex Zhou (1):
      MAINTAINERS: add entry for NXP wireless Bluetooth driver

Alexander Duyck (2):
      fbnic: Rework the BMC state pulled from the capabilities message
      fbnic: Remove BMC routing rules when the BMC channel is disabled

Alexander Sverdlin (1):
      net: dsa: mxl-gsw1xx: force internal PHYs into a known reset state

Alexandra Winter (3):
      dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
      net/iucv: Add lock nesting annotation in iucv_sock_close()
      s390/ism: Zerorize dmb at allocation

Alexandre Cassen (7):
      net/mlx5e: TC, free NIC flow parse attributes after offload
      net/mlx5: HWS, shrink FTE action array to fit
      net/sched: act_api: take tcfa_lock for hardware stats updates
      net/mlx5: HWS, fix reformat pool creation race
      net/mlx5: HWS, fix modify header pool creation race
      net/mlx5: HWS, fix modify header pattern compare on big-endian
      net/mlx5: HWS, fix modify header pool match for copy actions

Alexei Lazar (2):
      net/mlx5e: Rename state_destroy to rx_mode_active in flow steering
      net/dcb: Validate bandwidth for non-ETS traffic classes

Ali Firas (1):
      vxlan: vnifilter: validate the VXLAN_VNIFILTER_ENTRY nest

Alice Mikityanska (1):
      selftests: net: Fix minor issues in cork_fragsize.py

Allan Wang (1):
      wifi: mt76: mt7925: add AXI DMA calibration cache for MT7928

Allen Chien (1):
      wifi: mt76: mt7921: enable thermal protection

Allison Henderson (2):
      net/rds: restrict the rdma_cm ids to IB devices
      net/rds: log the port a listener actually bound

Alok Tiwari (1):
      octeontx2-af: Fix CQ enable state tracking after AQ writes

Aloka Dixit (2):
      Revert "wifi: mac80211: do not use old MBSSID elements"
      wifi: mac80211: remove redundant null check in ieee80211_assign_beacon()

Andrea Parri (2):
      rtnetlink: wait for RCU readers in rtnl_link_unregister()
      rtnetlink: comment the RCU waits in unregister paths

Andreas Wendleder (1):
      wifi: b43: fix use-after-free in b43_bcma_remove()

Andrei Gherzan (2):
      netdevsim: print IPsec salt/key in network byte order
      selftests: rtnetlink: update ipsec_offload expected output

Andrei Otcheretianski (4):
      wifi: cfg80211: add NL80211_CMD_NAN_SET_NON_EVAC_CHANNELS
      wifi: mac80211: implement NAN non-evacuable channels
      wifi: cfg80211: fix NAN local schedule update ordering and allocation
      wifi: mac80211_hwsim: Support NAN deferred schedule completion

Andrei Rusu de Castro (1):
      wifi: mt76: mt7925: keep MLD membership consistent during link add

Andrei-Alexandru Bleortu (1):
      wifi: mac80211: keep the BSS color while a color change is pending

Andrew LaMarche (2):
      wifi: ath12k: support calibration-variant from device tree
      dt-bindings: wireless: ath12k: drop qcom,ath12k-calibration-variant

Andy Chang (2):
      Bluetooth: dt-bindings: net: bluetooth: add BCM4384
      Bluetooth: btbcm: Add Synaptics 4384 chip support

Andy Shevchenko (4):
      eea: Drop temporary buffer by using %*pEhp directly
      eea: Remove unneeded assignment
      eea: Refactor error handling in eea_adminq_config_host_info()
      eea: Use 2-argument strscpy()

Anil Kaushik (4):
      gtp: set a valid genl command in PDP context get and dump replies
      gtp: hold RCU for the device lookup when adding a PDP context
      netlink: specs: add genetlink-legacy spec for GTP
      selftests: net: add a test for the gtp netlink family

Aniruddha Mishra (2):
      wifi: ath12k: add WBM RX error drop statistics
      wifi: ath12k: add WBM SW desc fallback counter

Anirudh Virdi (1):
      net: qede: initialize extack in qede_flow_spec_to_rule()

Anthony Liu (1):
      wifi: mt76: mt7928: makes struct beacon_tlv 4-byte aligned.

Anton Danilov (6):
      vxlan: rename the drop reasons for use by other tunnels
      ip_tunnel: make __iptunnel_pull_header() return a drop reason
      vxlan: report the drop reason of __iptunnel_pull_header()
      vxlan: report a circular route as SKB_DROP_REASON_RECURSION_LIMIT
      ip6_gre: let collect_md ip6gretap send from the unspecified address
      tun: use pskb_may_pull_reason() and remove SKB_DROP_REASON_HDR_TRUNC

Antonio Ojea (2):
      netfilter: nf_queue: limit the hook drop flush to the unregistered hook point
      selftests: netfilter: nft_queue: check the scope of the hook drop flush

Antonio Quartulli (2):
      selftests: ovpn: wait for the TCP server key setup before traffic
      MAINTAINERS: ovpn: add Ralf Lici as reviewer

Aritra Das (1):
      Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE

Arnav Kapoor (1):
      sfc: fix stale kernel-doc member names in net_driver.h

Arnd Bergmann (7):
      net: dsa: motorcomm: avoid unused variable warning
      ieee802154: avoid deprecated .ndo_do_ioctl callback
      net: remove ndo_do_ioctl handler
      net: dsa: motorcomm: fix unused-function warning
      sfc: fix CONFIG_CXL_MEM dependency
      wifi: b43legacy: work around stack frame size warning
      wifi: mt76: mt7996: add NET_AIROHA dependency

Arthur Crepin Leblond (3):
      dt-bindings: net: wiznet,w5100: convert to DT schema
      dt-bindings: net: wiznet,w5100: add link status interrupt
      w5100: detect carrier state using link status bit and optional interrupt

Aryan Sinha (2):
      octeontx2-af: remove duplicate SCTP port flags
      wifi: nxpwifi: use str_on_off() for carrier state

Asbjørn Sloth Tønnesen (12):
      netlink: specs: rt-link: update ipv6 devconf doc
      netlink: specs: rt-link: add accept-ra-min-lft
      netlink: specs: rt-link: add force-forwarding
      netlink: specs: rt-link: re-align IPv4 devconf
      netlink: specs: rt-link: re-align ifla-inet6-stats
      netlink: specs: rt-link: fix ifinfo-flags names
      netlink: specs: devlink: fix resource-scope type
      netlink: specs: ethtool: re-align c33-pse-ext-state
      netlink: specs: ethtool: re-align module-fw-flash-status
      netlink: specs: nl80211: fix naming of enum members
      netlink: specs: tc: fix typo in cls-flags
      netlink: specs: fix incorrect name-prefixes

Ata İlhan Köktürk (1):
      wifi: rtw88: disable ASPM for Lenovo IdeaPad S340-14IWL

Atharva Vartak (1):
      net/smc: hold a reference on net_device returned by pnet_find_base_ndev()

Avraham Stern (1):
      wifi: iwlwifi: mld: config TLC only after attaching station to a link

Ayala Beker (1):
      wifi: iwlwifi: mld: remove NAN keys before removing internal stations

Ayush Yaduvanshi (4):
      ice: dpll: fix kernel-doc parameter descriptions
      idpf: fix kernel-doc parameter descriptions
      sfc: fix kernel-doc description for efx_ptp_timeset
      atlx: fix kernel-doc description for atlx_tx_timeout

Baochen Qiang (12):
      wifi: ath12k: signal regd update completion when reg event is dropped
      wifi: ath12k: use per-radio ab in ath12k_mac_hw_register()
      wifi: ath12k: protect new_alpha2 access with base_lock
      wifi: ath12k: skip setting country code during registration when unchanged
      mailmap: add entries for Baochen Qiang
      wifi: ath12k: use kernel types instead of userspace stdint types
      wifi: ath12k: fix stale skb pointers after aligned TX payload shift
      wifi: ath12k: fix truncated TX buffer DMA address in MSDU ext descriptor
      wifi: ath12k: use per-device max QMI chunk size
      wifi: ath12k: clear chunk paddr and size in ath12k_qmi_free_target_mem_chunk()
      wifi: ath12k: align QMI target memory to 64 KB
      wifi: ath11k: fix unbalanced IRQ enable/disable during suspend/resume

Bartosz Golaszewski (7):
      net: stmmac: dwmac4: don't program the 1us tick counter without a CSR clock
      dt-bindings: net: qcom: document the ethqos device for SCMI-based systems
      net: stmmac: qcom-ethqos: set serdes mode before powerup
      net: stmmac: qcom-ethqos: update phy_mode to the resolved interface in mac_finish()
      net: stmmac: qcom-ethqos: reuse the address of ethqos_emac_driver_data
      net: stmmac: qcom-ethqos: factor out linux-level setup into a separate function
      net: stmmac: qcom-ethqos: add support for sa8255p

Bastien Curutchet (Schneider Electric) (11):
      net: dsa: microchip: fully save the periodic output request
      net: dsa: microchip: add the number of pins to chip infos
      net: dsa: microchip: add the number of periodic signals to chip infos
      net: dsa: microchip: use dynamic mask to check pulse width validity
      net: dsa: microchip: extract PTP callbacks configuration from PTP registration
      net: dsa: microchip: extract ptp_get_pin
      net: dsa: microchip: extract compute_width
      net: dsa: microchip: extract prepare reset
      net: dsa: microchip: extract time update
      net: dsa: microchip: extract time adjustment
      net: dsa: microchip: add periodic output support for the KSZ8463

Benjamin Berg (17):
      wifi: iwlwifi: use link_sta internally to the driver
      wifi: mac80211: change public RX API to use link stations
      wifi: mac80211: refactor RX link_id and station handling
      wifi: mac80211: rework RX packet handling
      wifi: cfg80211: add attribute for TX/RX denoting there is no station
      wifi: mac80211: report to cfg80211 when no STA is known for a frame
      wifi: mac80211: pass station to ieee80211_tx_skb_tid
      wifi: mac80211: pass error station if non-STA transmit was requested
      wifi: mac80211: add key link_id to debugfs
      wifi: cfg80211: add Control Integrity Protocol (CIP) APIs
      wifi: mac80211: add cigtk parameter to ieee80211_gtk_rekey_add
      wifi: mac80211: add helpers to parse/generate CIP Capabilities
      wifi: mac80211: add Control Integrity Protocol handling
      wifi: mac80211_hwsim: claim support for Control Integrity Protocol
      wifi: iwlwifi: document MIC delay resolution
      wifi: iwlwifi: mld: pass phy status explicitly for sniffer
      wifi: iwlwifi: mld: report RX time from channel survey

Benjamin Drung (2):
      wifi: brcmfmac: Add per-board clm_blob firmware binaries
      wifi: brcmfmac: Add clm_blob firmware for brcmfmac43456-sdio

Bert Karwatzki (1):
      mac80211: tx: Use info->flags in ieee80211_tx_h_select_key()

Bhargava Marreddy (4):
      bnge: fix NULL deref in bnge_alloc_core() on failure
      bnge: require NQ vectors beyond aux reservation
      bnge: do not fail open if IRQ affinity hint fails
      bnge: clear bd->netdev on allocation failure

Binbin Deng (4):
      net: mlx5e: Fix use-after-free of the MACsec xarray entry on RX SC deletion
      ncsi: Fix use-after-free in the VLAN id list removal
      octeontx2: Fix use-after-free of qos node in delete path
      tipc: fix use-after-free of broadcast reception link at node release

Birger Koblitz (1):
      ax88179_178a: Fix endianness of pause watermark register

Bitterblue Smith (2):
      wifi: rtw89: usb: Avoid crash with dynamically added device ID
      wifi: rtw89: Override antenna number for RTL8852BE-VS

Björn Töpel (4):
      fbnic: Track BDQ device-page geometry per ring
      net: Revalidate queue config for ringparam changes
      fbnic: Support larger memory-provider RX pages
      selftests: drv-net: Request larger zcrx buffers

Bobby Eshleman (1):
      MAINTAINERS: add Bobby Eshleman as vsock reviewer

Brad Fitzpatrick (2):
      gre: keep the UDP tunnel GSO type when completing GRO
      selftests: net: add a test for GRO of GRE over FOU and GUE

Branislav Klocok (1):
      wifi: rtw88: add quirks to disable PCI ASPM and deep LPS for Dell Vostro 15 3530

Breno Leitao (2):
      net: add sockopt_expand_out()
      ipv4: igmp: convert ip_mc_msfget() to sockopt_t

Brian Norris (1):
      wifi: mwifiex: Reattach interfaces on suspend failure

Bryam Vargas (1):
      net/smc: queue the copied chunk when smc_tx_sendmsg() faults

Bui Viet Dung (8):
      wifi: mac80211: Pin module for hwflags debugfs file operations
      wifi: cfg80211: Pin module for debugfs file operations
      wifi: mac80211_hwsim: Pin module for debugfs file operations
      Bluetooth: 6lowpan: Pin module for 6lowpan_control debugfs file
      Bluetooth: hci_debugfs: Pin module for debugfs file operations
      Bluetooth: hci_vhci: Pin module for debugfs file operations
      Bluetooth: selftest: Pin module for selftest debugfs file operations
      wwan: wwan_hwsim: Pin module for debugfs file operations

Carella Chen (3):
      wifi: nl80211: add fast roam offload extended feature
      wifi: brcmfmac: detect firmware FBT and OKC support
      wifi: brcmfmac: advertise firmware fast roam offload support

Carlo Szelinsky (2):
      net: pse-pd: si3474: fix use-after-free in ancillary client error path
      net: pse-pd: si3474: use dev_err_probe() for controller registration

Carolina Jubran (3):
      net/mlx5: DPLL, fix fractional frequency offset scaling
      net/mlx5e: Fix NULL deref in PTP TX timestamp recovery warn
      net: skbuff: don't copy alloc_cpu in skb header copies

Catherine L (5):
      Bluetooth: btintel_pcie: Route debug traces to WiFi DBGC by default
      Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
      Bluetooth: btintel_pcie: Add CNVi ID for Titan Lake (Scorpius Peak2 C0)
      Bluetooth: btintel_pcie: Add PCI ID for Titan Lake
      Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID

Cen Zhang (10):
      Bluetooth: 6LoWPAN: Use RCU-safe device list removal
      Bluetooth: hci_core: Keep RCU protection through LTK filtering
      Bluetooth: hci_sync: Serialize devcoredump reset during device open
      Bluetooth: ISO: Hold the listener during disconnect notification
      Bluetooth: MGMT: Reject quality report requests during unregister
      Bluetooth: msft: Lock failed probe cleanup against feature readers
      Bluetooth: 6lowpan: Drain RCU readers on registration failure
      Bluetooth: hci_sync: Protect IRK identity reads with RCU
      Bluetooth: L2CAP: Hold the listener while notifying child teardown
      Bluetooth: MSFT: Serialize handle map cleanup with event processing

Chandrashekar Devegowda (4):
      Bluetooth: btintel_pcie: parse FW memory addresses via mailbox TLV
      Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
      Bluetooth: btintel_pcie: add MDBGC multi-buffer DBGC allocation
      Bluetooth: btintel_pcie: unified decoder coredump format

Charlie-cy Wu (1):
      wifi: mt76: connac2: fill TXD spe_idx for connac2 fixed-rate frames

Chelsy Ratnawat (3):
      wifi: rtlwifi: rtl8192cu: Remove logically dead code in rtl92cu_update_hal_rate_mask()
      wifi: rtlwifi: rtl8192cu: Remove logically dead code in rtl92cu_update_hal_rate_table()
      wifi: rtlwifi: remove dead mimo_ps handling from rate update code

Chengfeng Ye (5):
      net: pktgen: return bool from __pktgen_NN_threads()
      net/smc: Serialize link activation with teardown
      net/smc: Hold a socket reference for transmit work
      net-sysfs: release queue trackers before allowing reuse
      l2tp: snapshot sequencing state when building transmit headers

Chia-Yu Chang (2):
      tcp: Replace min_tso_segs() with tso_segs() CC callback
      bpf: make tcp_tso_autosize() available to BPF congestion controls

Chien Wong (2):
      wifi: mac80211: fix encryption tailroom
      wifi: mac80211: reserve MME tailroom for protected beacons

Chih-Kang Chang (4):
      wifi: rtw89: 8851b: avoid using CPUIO feature with old firmware
      wifi: rtw89: wow: check AOAC report C2H event length
      wifi: rtw89: wow: check AOAC report key index
      wifi: rtw89: ps: send H2C command related to MLO info when FWIPS

Chih-Wen Hsiao (1):
      wifi: rtw89: 8922d: disable VCORE for thermal protection by default

Chin-Yen Lee (1):
      wifi: rtw89: pci: disable D3cold on ASUS ExpertBook B3/P3 series

Ching-Te Ku (39):
      wifi: rtw89: coex: cancel RF band return condition at _set_bt_tx_power()
      wifi: rtw89: coex: fix SET_H2C_MACRO not sent for BTC_FEAT_H2C_MACRO chips
      wifi: rtw89: coex: fix out-of-bounds read of report gnt_val
      wifi: rtw89: coex: fix rlink index bound check in _update_wl_info
      wifi: rtw89: coex: support version 8 for gpio_dbg FCX report
      wifi: rtw89: coex: support fcxtdma version 8 in TDMA policy
      wifi: rtw89: coex: add fcxcysta v8 report support
      wifi: rtw89: coex: route BT sub-reports by bt_id for dual-BT support
      wifi: rtw89: coex: split bt_profile into per-device fields in trx H2C
      wifi: rtw89: coex: add fcxtxpwr version dispatch for CXDRVINFO_TXPWR
      wifi: rtw89: coex: set dbcc_en for dual-band-active MLO modes
      wifi: rtw89: coex: evaluate CO-RX Hi-LNA request per band
      wifi: rtw89: coex: detect BT HID activity from scoreboard
      wifi: rtw89: coex: check null-tx fail ratio in nullsta report
      wifi: rtw89: coex: detect BT slot flood via A2DP empty-streak in cysta
      wifi: rtw89: coex: add AFH conflict detection on BT AFH report
      wifi: rtw89: coex: log FCX report version mismatch without dropping
      wifi: rtw89: coex: add fbtc_rpt_ctrl v205 report struct and handling
      wifi: rtw89: coex: Add firmware 0.27.130.1 support for RTL8852C
      wifi: rtw89: coex: fix BT scoreboard update for non-C2H paths
      wifi: rtw89: coex: offload 8852C IO writes via firmware CMD pack region
      wifi: rtw89: coex: batch PTA init with masked IO offload
      wifi: rtw89: coex: fix RF band check in _set_rf_trx_para() and its propagation
      wifi: rtw89: coex: track per-HW-band WL role fields with arrays
      wifi: rtw89: coex: show per-HW-band MLO state in WL status dump
      wifi: rtw89: coex: add outsrc-set-info v7 for BT SPDT state
      wifi: rtw89: coex: compute WL/BT cross-talk interference maps
      wifi: rtw89: coex: add 1SS MIMO-PS decision for dual-BT CIS
      wifi: rtw89: coex: add firmware 0.35.119.3 support for RTL8922A/D
      wifi: rtw89: coex: raise default BT TX power to 10 dBm
      wifi: rtw89: coex: bind the RF band in use while WL is doing RFK
      wifi: rtw89: coex: store BT TX power per device and per RF band
      wifi: rtw89: coex: set the WL/BT antenna map on shared-antenna chips
      wifi: rtw89: coex: use the right switch-type enum on RTL8922D
      wifi: rtw89: phy: Implement API to control BTG to turn on/off BT TX/RX
      wifi: rtw89: coex: turn BT TX/RX on and off through the BTG control
      wifi: rtw89: coex: set rf_combination in _update_wl_mlo_info()
      wifi: rtw89: coex: fix off-by-one in H2C macro buffer full check
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 9.24.2

Chris Lu (7):
      Bluetooth: btmtksdio: Remove redundant firmware filename override
      Bluetooth: btmtksdio: Pass the hardware device id to mt79xx_setup()
      Bluetooth: btmtk: Validate the firmware layout before parsing it
      Bluetooth: btmtk: Improve BT firmware logging
      Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
      Bluetooth: btmtk: Route firmware debug event to the diag channel
      Bluetooth: btmtk: Add MT7928 support

Chris Packham (1):
      i40e: Avoid repeating RX filter warning

Chris Scott (1):
      wifi: mt76: mt7996: refresh the tx BA session timer on NPU devices

Christian Melendez (1):
      Documentation: netvsc: Remove stale "not yet supported" XDP_REDIRECT note

Christophe JAILLET (1):
      Bluetooth: btmrvl: Slightly simplify btmrvl_process_event()

Claudiu Manoil (1):
      net: enetc: add trusted VF support

Coia Prant (7):
      net: stmmac: move XPCS lifetime management to platform drivers
      net: pcs: xpcs: add ANRESTART support for SGMII link recovery
      dt-bindings: net: pcs: add rockchip,rk3568-xpcs support
      net: pcs: xpcs: add Rockchip RK3568 platform glue driver
      dt-bindings: net: rockchip-dwmac: document pcs-handle
      net: stmmac: dwmac-rk: add SGMII support for RK3568
      MAINTAINERS: add entry for Rockchip XPCS driver

Colin Ian King (3):
      wifi: rtw89: coex: Fix spelling mistake "verseion" -> "version"
      wifi: mt76: Fix spelling mistake "dowload" -> "download"
      wifi: mt76: mt7996: Fix spelling mistake "retriving" -> "retrieving"

Cosmin Ratiu (2):
      devlink: Fix accidental rebase error in nested devlink docs
      net/mlx5e: Stop asserting for RTNL when closing channels

Cristian Deluxe (2):
      wifi: rtw88: 8703b: complete the card-disable to card-emulation transition
      wifi: rtw88: 8703b: stop the PCIe DMA write reaching SDIO

Cristian Papa (2):
      wifi: mt76: mt7603: don't drop short frames looped back on PS entry
      wifi: mt76: feed the station RSSI average from the chain signals

Daehyeon Ko (4):
      ipv6: remove ifaddr from hash during ifdown list cleanup
      ipv6: serialize address publication with device teardown
      ipv6: initialize temporary ifaddr before publication
      ipv6: do not restart DAD for a dead ifaddr

Dan Carpenter (5):
      wifi: mm81x: fix type bugs handling sdio_readl/writel()
      net: enetc: document enetc_msg_vsi_send() return values
      wifi: b43: don't pass unterminated string to sscanf()
      wifi: b43legacy: debugfs: NUL terminate string in debugfs
      wifi: carl9170: NUL terminate string in debugfs

Daniel Borkmann (1):
      net: Port skb_segment tests of the test_bpf module to KUnit

Daniel Gabay (2):
      wifi: iwlwifi: mld: add gp2 timestamps to TX commands
      wifi: iwlwifi: mld: test TX gp2 timestamps

Daniel Golle (11):
      net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
      net: dsa: mt7530: move MDIO bus locking into regmap
      net: dsa: mt7530: fold mt7530_mii_write/read into mt7530_write/read
      net: dsa: mt7530: replace mt7530_write with regmap_write
      net: dsa: mt7530: replace mt7530_rmw/set/clear with regmap API
      net: dsa: mt7530: replace mt7530_read with regmap_read
      net: dsa: mt7530: drop the dummy poll machinery
      net: dsa: mt7530: convert to use field accessor macros
      net: dsa: mt7530: implement port_fast_age
      net: dsa: mt7530: implement port_change_conduit op
      net: sfp: add quirk for TP-LINK SM410U

Daniel Machon (21):
      MAINTAINERS: add FDMA library to Sparx5 SoC entry
      net: microchip: fdma: rename contiguous dataptr helpers
      net: microchip: fdma: add PCIe ATU support
      net: microchip: fdma: use little-endian types for descriptor fields
      net: lan966x: add FDMA LLP register write helper
      net: lan966x: export FDMA helpers for reuse
      net: lan966x: use a dedicated device for DMA operations
      net: lan966x: add FDMA ops dispatch for PCIe support
      net: lan966x: clear FDMA interrupt stickies after switch reset
      net: lan966x: add shutdown callback to stop the FDMA on reboot
      net: lan966x: add PCIe FDMA support
      net: lan966x: add PCIe FDMA MTU change support
      net: lan966x: add PCIe FDMA XDP support
      misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space
      misc: lan966x-pci: dts: add fdma interrupt to overlay
      net: sparx5: Add registers used by TAS
      net: sparx5: Move TAS link speed configuration to sparx5_tas.c
      net: sparx5: Add TAS offload support
      net: lan969x: fix DSM calendar for empty taxis
      net: sparx5/lan969x: do not clobber the PSFP cycle timer update period
      net: lan969x: don't disable hardirqs in fdma tx clear

Daniel Zahka (24):
      psp: refactor psp_dev_tx_key_del()
      psp: move code from psp_sock_assoc_set_tx() into helper functions
      psp: allow drivers to omit tx key add/del ops
      netdevsim: psp: drop tx key ops
      eth: fbnic: put back netmem reference when xdp_buff_add_frag() fails
      eth: mpnic: add scaffolding for Meta Platforms NIC
      eth: mpnic: allocate MSI-X vectors
      eth: mpnic: implement Tx queue allocation and cleanup
      eth: mpnic: start and stop the Tx HW queues
      eth: mpnic: add a netdevice and basic Tx handling
      eth: mpnic: implement Rx queue allocation and cleanup
      eth: mpnic: add basic Rx handling
      selftests: drv-net: psp: swap closed for connected sockets in assoc tests
      net: psp: require an established connection for association setup
      net: psp: drop psp assoc clear in sk_clone()
      selftests: drv-net: psp: test that rx-assoc fails on closed and listen socks
      eth: mpnic: use WRITE_ONCE() for BDQ head and tail updates
      eth: mpnic: add a service task
      eth: mpnic: set Rx buffer minimums using page size and mtu
      eth: mpnic: add a NAPI depletion check
      eth: mpnic: count packets, bytes, and drops per ring
      eth: mpnic: report per-queue stats
      eth: mpnic: count Tx queue stops and wakes
      eth: mpnic: count Rx allocation failures

Darren Li (2):
      wifi: brcmfmac: add PMK programming for firmware roaming offload
      wifi: brcmfmac: report port authorization after offloaded roaming

David Carlier (5):
      vsock: report pending receive data to io_uring
      vsock/test: cover receive queue hints
      vsock: move SOL_SOCKET options to vsock_sol_socket_setsockopt()
      vsock: support SO_INQ on stream sockets
      vsock/test: cover SO_INQ

David Howells (9):
      rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic cookie"
      rxrpc: Fix rxperf test rxgk key kvno to be 0
      rxrpc: Fix update of call->tx_pending without holding lock
      rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
      afs: Fix afs to abort the rxrpc call on send error
      rxrpc: Fix aborting in rxperf test server
      rxrpc: Fix sendmsg length
      rxrpc: Fix double IRQ enablement
      rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

David Lee (1):
      sctp: hold shkey across socket migration

David Woodhouse (1):
      tun: Require CAP_NET_ADMIN to attach to an ownerless device

David Yang (30):
      net: dsa: yt921x: Check lock status with lockdep_assert_held_once()
      net: dsa: motorcomm: Move to subdirectory
      net: dsa: motorcomm: Split SMI module
      net: dsa: motorcomm: Add LED support
      dt-bindings: net: dsa: yt921x: Add LEDs definition example
      net: dsa: motorcomm: Handle degenerated blink delays
      net: dsa: motorcomm: Remove YT921X_PORT_MASK_* macros
      net: dsa: motorcomm: Split xMII and SERDES port masks
      net: dsa: motorcomm: Identify port type at runtime
      net: dsa: motorcomm: Fix register bit field names
      net: dsa: motorcomm: Introduce yt921x_speed
      net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
      net: dsa: motorcomm: Split MDIO bus module
      net: dsa: motorcomm: Add SerDes PCS
      net: dsa: motorcomm: Fix register rollback in LED setup
      net: dsa: motorcomm: Hoist type casting helper into chip.h
      net: dsa: motorcomm: Rename MIB stuff
      net: dsa: motorcomm: Split MIB buffers
      net: dsa: motorcomm: Split MIB module
      net: dsa: motorcomm: Use u64_stats_t for MIB stats
      net: dsa: motorcomm: Fix MIB synchronization
      dt-bindings: net: motorcomm: Add YT861x PHY compatible
      net: phy: motorcomm: Add driver entry for internal YT861x PHYs
      net: phy: motorcomm: Add cable test support for internal YT861x PHYs
      net: dsa: motorcomm: Split TC module
      net: dsa: motorcomm: Use NSEC_PER_SEC
      net: dsa: motorcomm: Enable ACL on demand
      net: dsa: motorcomm: Add TC prio support
      net: dsa: motorcomm: Remove the redundant MIB clear
      net: dsa: motorcomm: Extend ACL with UDF

Deepanshu Kartikey (1):
      wifi: mac80211: fix stats/preemption in ieee80211_tx_control_port()

Demos Ra (1):
      netlink: specs: Add a spec for nexthops in rtnetlink

Devin Wittmayer (13):
      wifi: mac80211: fix monitor filter refcount leak
      wifi: mt76: mt7921: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7925: fix lock inversion between dev->mutex and iflist_mtx
      wifi: mt76: mt7921: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7925: check drv_pmctrl return in the PCIe reset path
      wifi: mt76: mt7921: fix the lock inversion in suspend and resume
      wifi: mt76: mt7925: fix the lock inversion in suspend and resume
      wifi: mt76: mt7921: honour FIF_FCSFAIL instead of hardcoding drop_err
      wifi: mt76: take rcu_read_lock in the USB/SDIO tx completion path
      wifi: mt76: mt7925: cancel mlo_pm_work on the USB stop path
      wifi: mt76: move the channel survey when the channel changes
      wifi: mt76: mt792x: defer the MCU shutdown past unregister on USB
      wifi: rtw89: usb: shorten the RX aggregation hold on RTL8922AU over USB 3

Dexuan Cui (1):
      hv_netvsc: Advertise the SR-IOV capability for CoCo VMs

Dian-Syuan Yang (1):
      wifi: rtw89: 8922d: update BA cam format to G7

Dimitri Daskalakis (2):
      selftests: drv-net: remove duplicate functions in hds.py
      net/mlx5e: Update netdev features only after a successful ringparam set

Dmitry Antipov (1):
      tcp_bpf: propagate error code in tcp_bpf_sendmsg()

Dominic White (1):
      wifi: cfg80211: allow zero HE OBSS PD offsets

Dong Yibo (5):
      net: rnpgbe: Add interrupt handling
      net: rnpgbe: Add basic TX packet transmission support
      net: rnpgbe: Add basic RX data path support
      net: rnpgbe: Add receive mode support
      net: rnpgbe: Add link status handling support

Donggeun Yoo (4):
      net: phy: dp83848: check phy_read() return value in config_init()
      net: phy: dp83867: restore LED configuration after a soft reset
      net: phy: qca808x: accept the active-high LED polarity mode
      net: phy: qca808x: keep an explicit active-high LED across the reset

Dragos Tatulea (10):
      RDMA/mlx5: Notify data direct users via a notifier chain on unbind
      RDMA/mlx5: Add mlx5_data_direct_supported() helper
      RDMA/mlx5: Make the data direct VUID query self-contained
      RDMA/mlx5: Give the data direct PCI driver a proper name
      RDMA/mlx5: Move and rename data direct resource functions
      RDMA/mlx5: Add new registration stage for data direct users
      RDMA/mlx5: Extract IB specific lock out of data direct
      RDMA/mlx5: Consolidate data direct state into one object
      RDMA/mlx5: Pull data_direct resource creation in init phase
      mlx5: Move data direct implementation to mlx5_core

Eason Lai (3):
      wifi: mt76: mt792x: fix UAF in SDIO TX path when out of memory
      wifi: mt76: fix memory leak in USB TX path
      wifi: mt76: mt7925: Fix MCU command timeouts during module unload

Edoardo Canepa (1):
      selftests/net: run tun tests in a dedicated network namespace

Eduard Bostina (1):
      dt-bindings: net: wireless: Convert WL1251 to DT schema

Eduard Zateev (1):
      wifi: cfg80211: validate WEXT station BSSID

Emanuele Rocca (1):
      octeontx2: use arch_extension to enable LSE

Emmanuel Grumbach (26):
      wifi: cfg80211: require zero terminator in valid_regdb country table
      wifi: cfg80211: use sysfs_emit_at() in addresses_show
      wifi: iwlwifi: mvm: wait for 6 missed beacons before disconnection
      wifi: iwlwifi: pcie: validate txq_id in txq_disable
      wifi: iwlwifi: mvm: remove SRAM access through debugfs
      wifi: iwlwifi: dbg: validate dram_alloc_id from debug TLV
      wifi: iwlwifi: mld: explicitly include mld.h in hcmd.h
      wifi: iwlwifi: mld: explicitly include ieee80211-p2p.h in mac-cfg.h
      wifi: iwlwifi: mld: support operational statistics notif ver 5
      wifi: iwlwifi: poke the config space in case of command timeout
      wifi: iwlwifi: pcie: remove monitor_data debugfs file
      wifi: iwlwifi: mld: stop filling link fields unused by the firmware
      wifi: iwlwifi: add multi-BSS/EMCCA max BSSID indicator to LINK cmd
      wifi: iwlwifi: pcie: fix TSO page leak in iwl_pcie_prep_tso()
      wifi: iwlwifi: fix ctxt-info-v2 unwind UAF
      wifi: iwlwifi: mvm: remove indirection_tbl debugfs entry
      wifi: iwlwifi: pcie: order RX reads after the write pointer
      wifi: iwlwifi: add support for the new MPDU descriptor
      wifi: iwlwifi: support RX BAID modify command version 3
      wifi: iwlwifi: mld: fake a valid NSS field when needed
      wifi: iwlwifi: mld: remove unused fields from the firmware API
      wifi: iwlwifi: mld: add STA_CONFIG_CMD version 4
      wifi: iwlwifi: mld: add support for WoWLAN CIGTK API
      wifi: iwlwifi: don't mask ucode_ver in iwl_sar_geo_support()
      wifi: iwlwifi: mvm: fix the VHT MCS sent to a v1 firmware
      wifi: iwlwifi: mvm: remove dead sta check in rx_monitor_no_data

Endrik Einberg (1):
      wifi: iwlwifi: mld: include VI packets in low latency detection

Erfan Sharafzadeh (1):
      net: devmem: allow peer-to-peer dma-buf attach for bindings

Eric Dumazet (63):
      net: optimize netif_is_l3_master() and netif_is_l3_slave()
      selftests: icmp_redirect: remove xfail support
      sit: fix UAF in ipip6_tunnel_del_prl()
      sit: charge ip_tunnel_prl_entry allocations to memcg
      ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
      sit: annotate data-races around tunnel->fwmark
      sit: convert 6RD configuration to RCU protection
      sit: implement ipip6_get_iflink()
      sit: dynamically allocate struct ip_tunnel_parm_kern
      sit: convert configuration to RCU protection
      sit: no longer rely on RTNL in ipip6_fill_info()
      sit: do not report an error from ipip6_fill_info()
      tcp: make smp_rmb() conditional in tcp_poll()
      netkit: no longer rely on RTNL in netkit_fill_info()
      net: rmnet: annotate data-races around port->data_format
      net: rmnet: annotate data-races around mux_id
      net: rmnet: no longer rely on RTNL in rmnet_fill_info()
      vlan: annotate data-races in vlan_dev_priv fields
      vlan: no longer rely on RTNL in vlan_fill_info()
      hsr: annotate data-race around hsr->sequence_nr
      hsr: no longer rely on RTNL in hsr_fill_info()
      netlink: remove dev_hold() and dev_put() in __netlink_deliver_tap_skb()
      vsock: remove dev_hold() and dev_put() in __vsock_deliver_tap_skb()
      tcp: remove dead code in tcp_rcv_state_process()
      net: synchronize proc_do_rss_key() with netdev_rss_key_fill()
      net: ethtool: generate RSS keys that spread flows over all queues
      netdevsim: support reporting RSS key, indirection table, and flow hash fields
      selftests: drivers: net: check the host and device RSS keys
      vxlan: update default fdb entries when the lower device changes
      vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump_dev()
      vxlan: vnifilter: signal interrupted RTM_GETTUNNEL dumps
      vxlan: pass vxlan_config pointer to helper functions
      vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
      vxlan: convert configuration to RCU protection
      vxlan: remove default_dst and use vxlan_config and lowerdev
      vxlan: no longer rely on RTNL in vxlan_fill_info()
      ipv4: fix IP ID reuse in ip_select_ident_segs()
      ipv4: reserve one IP ID per segment for UDP GSO packets
      ipv4: use zero IPID for atomic datagrams on connected sockets
      dlm: fix send buffer backpressure handling
      net: add sk_set_nospace() and sk_clear_nospace()
      sunrpc: use sk_set_nospace() and sk_clear_nospace()
      rds: use sk_set_nospace()
      dlm: use sk_set_nospace() and sk_clear_nospace()
      drbd: use sk_set_nospace()
      nvme-tcp: use sk_clear_nospace()
      libceph: use sk_clear_nospace()
      tcp: add tp->tcp_nospace
      selftests/net: add SO_RESERVE_MEM test
      net: remove IPX raw 802.3 detection from eth_type_trans()
      bng_en: pad short frames before sampling nr_frags
      Bluetooth: btmtk: fix skb double free on ISO padding failure
      hinic3: use skb_put_padto()
      ipv4: use RCU protection in inet_netconf_get_devconf()
      tcp: use the echoed source route in cookie_v4_check()
      vlan: restore HW VLAN tag insertion with reorder_hdr off
      tcp: tcp_metrics: use the socket netns, not the dst device netns
      iavf: use skb_put_padto()
      fm10k: use skb_put_padto()
      hinic: use skb_put_padto()
      ipv6: account route exceptions to the netns of their dst
      ip6mr: clear skb->cb[] in reg_vif_xmit()
      net: shrink the payload-only part of skb dataref to one bit

Eric Huang (4):
      wifi: rtw89: 8922d: update BB wrapper RFSI ctrl to v4
      wifi: rtw89: 8922d: add extra data to PS H2C
      wifi: rtw89: phy: correct PHY-1 EDCCA report register access
      wifi: rtw89: phy: write full data for BB gain table type 15

Eric Joyner (1):
      ionic: free port_info when probe fails after the port is set up

Ethan Nelson-Moore (1):
      drivers: net: smsc: Remove unused smc9194.h header

Ethan Tidmore (1):
      wifi: mt76: mt7925: Remove useless condition

Felix Fietkau (47):
      wifi: mac80211_hwsim: reserve headroom for software encryption
      wifi: mac80211: use the AP address as RA for a 4-addr MLO station
      wifi: mt76: mt7996: program a link again if the driver holds it
      wifi: mt76: check the owner of a remain-on-channel request
      wifi: mt76: mt7996: take over connection monitoring
      wifi: mt76: clear offchannel state if a scan has no channel to restore
      wifi: mt76: account non-AQL frames per peer rather than per link
      wifi: mt76: mt7915: check default EEPROM firmware size before copying
      wifi: mt76: mt7996: validate firmware event lengths before parsing
      wifi: mt76: mt7915: unregister thermal cooling device on hwmon failure
      wifi: mt76: mt7915: guard firmware memory dump write on disabled memdump
      wifi: mt76: mt7996: bound RRO session id before indexing addr_elem[]
      wifi: mt76: mt7925: restore the reset state when fw_pmctrl fails
      wifi: mt76: connac: pass the command to mt76_connac_mcu_chip_config()
      wifi: mt76: abort a scan only for a link change on the scanning radio
      wifi: mt76: mt7996: enable the SKU power limit table
      wifi: mt76: mt7996: set sniffer mode on a radio that is already running
      wifi: mt76: mt7996: update the address of an AP link that is added again
      wifi: mt76: mt7996: size the MLD setup TLV by the links it describes
      wifi: mt76: mt7996: find the last MLD link among the links torn down
      wifi: mt76: mt7996: upload only the keys of the link being set up
      wifi: mt76: mt7996: do not walk the vif keys when a link is destroyed
      wifi: mt76: mt7996: report station statistics from the primary link
      wifi: mt76: mt7996: clear all link wcid entries in sta_pre_rcu_remove
      wifi: mt76: mt7996: free the WTBL index if a link allocation fails
      wifi: mt76: mt7996: pick the secondary link from links with driver state
      wifi: mt76: mt7996: make a returning link primary if a station has none
      wifi: mt76: mt7996: do not reuse the deflink of a removed station link
      wifi: mt76: mt7996: keep a returning link when adding station links fails
      wifi: mt76: mt7996: add the station BMC entry as new once per BSSID
      wifi: mt76: mt7996: keep 4-address and decap state per station
      wifi: mt76: mt7996: record the connection state of a station
      wifi: mt76: mt7996: keep the block ack session parameters per station
      wifi: mt76: mt7996: set up the BSS of a late station link before its peer
      wifi: mt76: mt7996: bring up station links added after association
      wifi: mt76: mt7996: set up block ack sessions on station links added later
      wifi: mt76: mt7996: restore a station link that returns after a removal
      wifi: mt76: mt7996: fix PLE free page and AC queue register offsets
      wifi: mt76: mt7996: fix the hw-queues debugfs queue requests
      wifi: mt76: mt7996: refuse scan and ROC until the hardware restart is done
      wifi: mt76: report an aborted scan or ROC to mac80211 during a reset
      wifi: mt76: mt7921: fix of_node reference leaks in regd update
      wifi: mt76: mt792x: compute the assoc RSSI from the chain signals
      wifi: mt76: remove the unused signal field from struct mt76_rx_status
      wifi: mt76: mt7996: take the offchannel link of a frame from its wcid
      wifi: mt76: keep beacons from queueing the scan work during an abort
      wifi: mac80211: use link address as TA for non-MLO 4-addr station on MLD AP

Felix Hoffmann (1):
      wifi: mm81x: validate YAPS receive framing

Fernando Fernandez Mancera (6):
      netfilter: seqadj: do not take ct lock if seqadj is NULL
      netfilter: synproxy: fix reset of ct seqadj when reopening a connection
      netfilter: nft_exthdr: remove redundant op parsing in tcp_set_init
      netfilter: nft_exthdr: avoid 60 bytes stack buffer in TCP option mangling
      net: openvswitch: skip IPv4 later fragments on TCP/UDP set actions
      net: openvswitch: drop IP fragments on SCTP set action

Florian Fainelli (11):
      net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
      net: bcmasp: remove duplicate MDA filter register definitions
      net: systemport: Fix NULL pointer dereference in bcm_sysport_fini_rx_ring()
      net: systemport: Fix Wake-on-LAN RXCHK filter enable loop
      net: systemport: Fix inverted error messages in bcm_sysport_stop()
      net: bcmasp: fix mib counters struct alignment with ethtool stats
      net: bcmasp: unmap previous DMA mappings on TX map failure
      net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
      net: bcmasp: fix OF node reference leak for phy_dn
      net: bcmasp: account for offload header in TX short packet padding
      net: bcmasp: fix network filter lookup and wake filter pair allocation

Florian Westphal (6):
      netfilter: disable br_netfilter in user namespaces
      netfilter: conntrack: fix unlikely UaF in gc worker
      netfilter: nf_tables: switch chain_types array to rcu
      selftests: netfilter: fix return value in zone subtest
      netfilter: nft_compat: restrict raw table targets/matches
      netfilter: nft_payload: restrict checksum offsets to known values

Frank Li (1):
      net: ethernet: micrel: ks8842: use dmaengine_submit() instead of ->tx_submit()

François Roux (1):
      wifi: ath12k: skip hardware rfkill setup on Microsoft Surface devices

Frédéric Danis (1):
      Bluetooth: MGMT: Add management security level changed event

Gabriel Goller (1):
      net: ipv6: seg6: report lwtunnel setup errors via extack

Geert Uytterhoeven (4):
      net: ethernet: ti: davinci_mdio: Drop commas after match table sentinels
      net: macb: Make sure clk_init_data is fully initialized
      net: mdio: mux-meson-g12a: Make sure clk_init_data is fully initialized
      net: phy: air_en8811h: Make sure clk_init_data is fully initialized

Geliang Tang (1):
      tls: drop duplicate check_app_limited in tls_push_sg

George Maraveyas (1):
      Bluetooth: mt7925: trigger reset on WMT timeout

George Melikov (1):
      bnx2x: fix header length calculation for encapsulated TSO

Georgi Valkov (2):
      dt-bindings: net: wireless: add flag marvell,invalid-reg-hint-in-rom
      wifi: mwifiex: add dt flag to avoid conflict with platform reg domain

Ginger Li (1):
      wifi: mac80211: Fix a race when expiring a mesh path

Girish Rudrappa (1):
      wifi: brcmfmac: Set extsae_pwe parameter to Infineon firmware in SAP mode

Gongwei Li (2):
      wifi: rtw89: coex: Fix wrong constant check of GPIO MUX signal
      wifi: rtw89: fw: propagate real error code in rtw89_fw_h2c_add_general_pkt()

Grzegorz Nitka (4):
      ice: monitor TSPLL lock from PTP periodic worker
      ice: add TSPLL DPLL device and TIME_REF pin for E825
      ice: use per-interface clock_id for E825 generic DPLLs
      ice: reduce loglevel to debug for 'Can't delete DSCP' message

Guangshuo Li (3):
      net: fs_enet: fix platform info memory leak on remove
      net: dpaa2: ptp: fix device node reference leak on remove
      net: ionic: free VF resources on remove

Gustavo Luiz Duarte (7):
      netconsole: add an address family to struct inet_addr
      netconsole: use the address family instead of the ipv6 flag
      netconsole: reject enabling a target with no remote IP address
      netconsole: reject a target mixing IPv4 and IPv6 addresses
      netconsole: show empty string for an unset IP address
      netconsole: move struct inet_addr into netconsole.c
      docs: netconsole: document local_ip auto-selection

Haishuang Yan (6):
      pfcp: fix metadata_dst leak in pfcp_encap_recv()
      net: fix NULL dereference in skb realloc fault injection devname filter
      selftests: net: big_tcp_tunnels: Fix the IPv6 route change
      selftests: net: bareudp: Add stream tests with software GSO
      bareudp: Enable BIG TCP packets
      selftests: net: big_tcp_tunnels: Cover bareudp

Hamza Mahfooz (1):
      net: mana: add BQL support

Hangbin Liu (16):
      bonding: convert unbalanced_load to per-cpu state
      bonding: fix u32 overflow in compute_gap()
      selftests/drivers/net: include lib/sh/*.sh
      selftests: netdevsim: add TEST_INCLUDES to Makefile
      selftests: net: update netfilter netlink config
      selftests: net: move log_test to lib file and remove duplicate code
      selftests: fib_tests: use per-test return value in subtests
      net: lwtunnel: change encap fill order
      tools: ynl: convert enum selector to string for sub-message parsing
      netlink: specs: rt-route: add lwtunnel encap sub-message support
      netlink: specs: rt-route: describe lwtunnel IP options
      netlink: specs: rt-route: describe lwt BPF program options
      netlink: specs: rt-route: describe seg6-local attrs
      selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
      selftests: mptcp: convert iptables to nftables for mptcp_join.sh
      selftests: net: exit with test failure status

Hans de Goede (1):
      Bluetooth: hci_sync: Factor common cleanup code into a helper

Hariharan Ramanathan (4):
      wifi: ath12k: rename wbm_status to htt_status in HTT TX completion
      wifi: ath12k: add TCL ring TX buffer allocation failure counter
      wifi: ath12k: add device DP stats reset support via debugfs
      wifi: ath12k: track per-ring RX sent-to-stack count

Hariprasad Kelam (2):
      octeontx2-af: Show DMAC filter drop count
      octeontx2-pf: report port connector type in ethtool link ksettings

Harshitha Ramamurthy (6):
      gve: add struct gve_device_info to hold device properties
      gve: introduce control plane operations structure
      gve: introduce ctrl ops to set vectors and Qs
      gve: introduce gve_adminq_get_device_properties()
      gve: refactor gve_init_priv for reset path
      gve: add ctrl ops for queue operations

Haseeb Malik (3):
      macsec: check the resolved SCI for duplicates
      selftests: net: test MACsec undefined SCI uniqueness
      macsec: check for duplicate SCIs before registering the device

Heiner Kallweit (2):
      net: phy: factor out legacy PHY fixup support and make it always built-in
      libertas: mesh: remove unused and undocumented sysfs attribute groups

Hemanth Selam (24):
      mdio-mux: fix typo "framwork" in comment
      mii: fix typo "asymetric" in comment
      net: cortina: fix typo "trigged" in comment
      net: ipv6: fix typos in comments
      atm: fix typo "protcol" in comment
      net: fix typos in comments
      net: fix repeated word 'to' in comment
      i40e: fix typos in comments
      ice: fix typos in comments
      ixgbevf: fix typo "enble" in comment
      Documentation/eth/intel: fix repeated words in comments
      net: llc: fix repeated word 'all' in comment
      selftests: net: fix repeated word 'use' in comment
      net: broadcom: fix typos in comments
      net: cavium: fix typos in comments
      net: qlogic: fix typos in comments
      net: fddi: fix typos in comments
      net: marvell: fix typos in comments
      net: hisilicon: fix typos in comments
      net: atheros: fix typos in comments
      net: dec: fix typos in comments
      wifi: rtl8xxxu: fix typo "Tranceiver" in comment
      wifi: rtlwifi: fix typos in comments
      netfilter: fix several typos in comments

Henry Hu (1):
      net: phy: microchip_t1: fix NULL pointer dereference in lan887x_phy_init()

Henry Martin (3):
      rds: fix out-of-bounds conn_path walks via handshake exthdrs
      ipconfig: fix use-after-free of device list after ic_close_devs()
      tipc: fix broadcast sender hang on last acker departure

Heyang Tan (2):
      wifi: nxpwifi: bound histogram debugfs output
      wifi: nxpwifi: bound debug info output

Hitalo Souza (1):
      Bluetooth: Add missing newline to bt_dev_{err,warn}_ratelimited()

Hongyan Xu (2):
      net: octeon_mgmt: kill TX tasklet before freeing rings
      net: octeontx2-af: quiesce devlink health work on teardown

Howard Hsu (1):
      wifi: mt76: mt7996: do not add a station link in disconnected state

Hsiao-Yung Chen (1):
      wifi: rtw89: allow two station interfaces in SCC

Huang Xiangping (1):
      wifi: cfg80211: process pending events before connect/disconnect requests

Hui Peng (1):
      net/sched: ematch: check nla_put_nohdr() return value in tcf_em_tree_dump()

Ian Lin (1):
      net: usb: qmi_wwan: add Compal EXC-T1 support

Ibrahim Abdelkader (1):
      Bluetooth: hci_core: Return -ENOMEM when the sent_cmd clone fails

Ido Schimmel (10):
      ipv6: udp: Use ip6_sk_redirect() for tunnel sockets
      ipv6: Report netns cookie in fib6_table_lookup tracepoint
      ipv4: Pass netns to fib_table_lookup()
      ipv4: Report netns cookie in fib_table_lookup tracepoint
      ipv4: Store netns in FIB table
      ipv4: Do not pass netns to fib_table_lookup()
      bridge: mcast: Delete empty MDB entry when port group creation fails
      selftests: forwarding: bridge_mdb_max: Add a test for rejected MDB entries
      ipv6: Hold RCU when emitting route hardware flags notification
      selftests: netdevsim: Add FIB notification tests for nexthop objects

Ilan Peer (15):
      wifi: mac80211: Restrict probe request rates for minimal content
      wifi: mac80211: Gracefully deauthenticate on association timeout
      wifi: cfg80211: nan: add Instant Communication support
      wifi: mac80211: nan: Update NAN configuration copy
      wifi: cfg80211: nan: check Rx registration for NAN beacons
      wifi: cfg80211: do not use NAN beacons to update the BSS table
      wifi: mac80211: nan: allow Rx registration for NAN beacons
      wifi: mac80211: accept NAN beacons only when IC is enabled
      wifi: ieee80211: add NAN service ID list attribute definitions
      wifi: mac80211_hwsim: nan: use ieee80211_is_nan_beacon() helper
      wifi: mac80211_hwsim: nan: prepare for more configurable NAN settings
      wifi: mac80211_hwsim: nan: Handle more of the NAN configuration
      wifi: mac80211_hwsim: add NAN Instant Communication support
      wifi: iwlwifi: mld: Add support for (Re)association req/resp encryption
      wifi: iwlwifi: mld: Add support for scan iteration complete notification v3

Ilya Maximets (2):
      net: openvswitch: don't schedule rebalancing if there are no datapaths
      netfilter: conntrack: make filtering by zone discoverable

Ivan Vecera (7):
      dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
      dpll: zl3073x: reject inexact frequencies for N-divided outputs
      dpll: zl3073x: reject output frequencies with too small divisor
      dpll: zl3073x: make embedded sync follow the output carrier frequency
      dpll: zl3073x: notify sibling pin when shared output config changes
      selftests: tc-testing: use $IP in hfsc test 8c39 setup
      selftests: tc-testing: preload all qdisc modules enabled in config

Ivy Lopez (1):
      net: starfire: fix ioaddr sign-extension causing ioremap() failure

Jacob Keller (1):
      ice: reorder ice_flash_info fields to eliminate padding

Jacobs Wu (2):
      wifi: mt76: mt7925: support deferred NAN schedule update and cluster events
      wifi: mt76: mt7925: fix HT/VHT caps and rates for NAN NDP peers

Jakub Kicinski (228):
      Merge branch 'net-phy-fix-cleanup-after-probe-failure'
      Merge branch 'net-prepare-skb-extensions-for-reuse-across-scrubs'
      Merge branch 'bonding-fix-tlb-load-tracking-overflow-on-high-speed-nics'
      Merge branch 'net-dsa-realtek-enable-rtl8365mb-power-supplies'
      selftests: drv-net: hw: rename gro_hw.py to gro_stats.py
      selftests: drv-net: split gro.py into one test per coalescing mode
      selftests: drv-net: bump the timeout to 15min
      Merge branch 'selftests-drv-net-split-up-gro-py'
      Merge branch 'usb-replace-page-allocator-calls-with-kmalloc'
      Merge branch 'net-mdio-realtek-rtl9300-add-rtl83xx-support'
      Merge branch 'net-dsa-mt7530-modernise-register-access-and-add-two-dsa-ops'
      netdev: correct error code in netdev_nl_queue_fill_lease()
      netdev: don't use dev->flags for IFF_UP
      Merge branch 'net-dsa-motorcomm-add-led-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'r8169-add-support-for-phylink'
      Merge branch 'neighbour-namespacify-arp_tbl-and-nd_tbl'
      Merge tag 'batadv-next-pullrequest-20260831' of https://git.open-mesh.org/batadv
      netdev: avoid skipping objects on race with device disappearance
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'explicit-tso-segment-count'
      Merge branch '8021q-publish-vlan_devices_arrays-entries-with-acquire-release'
      Merge branch 'psp-make-tx-key-ops-optional-for-drivers'
      Merge branch 'remove-comma-after-sentinel-entries-in-match-table'
      Merge branch 'net-bridge-vlan-minor-cleanups-and-annotations'
      Merge branch 'net-disallow-buggy-tcp-transitions-and-ipv6_addrform'
      netlink: specs: fou: add af to the shared attribute list
      netlink: specs: fou: local-v4 and peer-v4 are big endian
      netlink: specs: fou: link the type attribute to the encap-type enum
      Merge branch 'net-remove-obsolete-32-bit-dma-mask-fallbacks'
      Merge branch 'net-phy-motorcomm-enable-analog-frontend-dac-on-yt8531s'
      Merge branch 'selftests-drv-net-allow-cross-compiling-the-hardware-tests'
      selftests: drv-net: warn if LOCAL_V6 has DAD or not kept on link down
      Merge branch 'netdevsim-fix-ipsec-debugfs-byte-order'
      Merge branch 'selftests-net-use-khdr_includes-in-cflags'
      netlink: specs: handshake: type the remaining key serials s32
      netlink: specs: handshake: do not accept the handler-class sentinel
      netlink: specs: dpll: add clock-quality-level to the device-get reply
      netlink: specs: dpll: drop the pin-set attributes nothing implements
      netlink: specs: dpll: pin-get has no dump filter
      MAINTAINERS: dpll: add the netlink spec
      Merge branch 'dpll-fix-lies-in-the-netlink-spec'
      Merge branch 'intel-fix-typos-in-comments'
      Merge branch 'net-dsa-lantiq_gswip-sgmii-2500base-x-and-flow-control-fixes'
      Merge branch 'netconsole-validate-a-target-s-ip-address-configuration'
      net: run netdev work under the ops-compat lock
      Merge branch 'net-fix-typos-and-repeated-words-in-comments'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'batadv-next-pullrequest-20260907' of https://git.open-mesh.org/batadv
      Merge branch 'sit-convert-configuration-to-rcu-and-lockless-fill_info'
      selftests: net: add ctl_file_write() helper
      Merge branch 'net-xilinx-axienet-fix-irq-error-handling'
      netlink: specs: conntrack: timestamp is a nest, not a be64
      netlink: specs: conntrack: fix the get reply attribute lists
      netlink: specs: conntrack: fix SCTP conntrack state names
      netlink: specs: conntrack: fix the nat-attrs attribute IDs
      netlink: specs: conntrack: describe CTA_HELP_INFO
      netlink: specs: conntrack: fix the per-CPU stats reply
      netlink: specs: conntrack: tweak definition of obsolete attrs
      Merge branch 'netlink-specs-conntrack-minor-spec-fixes'
      selftests: net: add ruff linter exclusions
      Merge tag 'nf-next-26-09-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'hardware-pacing-offload'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-phy-add-x-powers-ac200-ac300-ephy-support'
      Merge branch 'selftests-net-make-iou-zcrx-tests-multithreaded'
      netlink: specs: tcp_metrics: fix the attribute length checks
      netlink: specs: tcp_metrics: drop the RTT shift instructions
      selftests: drv-net: devmem: set reuseaddr on the sender's source port
      netlink: policy: report the big endian attributes
      selftests: drv-net: psp: fix linter issues
      psp: don't report the main netdevice's ifindex to associated namespaces
      selftests: drv-net: psp: check the ifindex an associated netns sees
      psp: notify about a disassociation once it has happened
      selftests: drv-net: psp: factor out creating a netkit in the test netns
      selftests: drv-net: psp: check the PSP disassociation notifications
      Merge branch 'psp-correct-notifications-and-device-info-around-device-assoc'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      netlink: specs: netdev: update doc for xsk tx-checksum and zc-max-segs
      Merge branch 'net-phy-qca808x-fix-the-active-high-led-polarity-mode'
      netlink: specs: nlctrl: fix the policy attribute numbering
      netlink: specs: nlctrl: let getfamily take a family id
      devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS
      netlink: specs: devlink: drop the stale port dump reply value
      netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK
      netlink: specs: devlink: complete the port function nest
      devlink: generate the port function policy from the spec
      netlink: specs: devlink: populate multi-attr attrs for region read and line card
      netlink: specs: devlink: describe the netns id in the parent-dev nest
      netlink: specs: devlink: add pad to the subsets carrying padded u64s
      devlink: validate the port index in the rate set request
      Merge branch 'devlink-netlink-spec-fixes'
      Merge branch 'net-rmnet-lockless-rmnet_fill_info'
      Merge branch 'net-a-sockopt_t-quirk-for-the-options-that-write-past-optlen'
      Merge branch 'vlan-lockless-vlan_fill_info'
      Merge branch 'hsr-lockless-hsr_fill_info'
      Merge branch 'net-dsa-microchip-add-support-for-ksz8995xa-ks8995xa'
      Merge branch 'net-mlx5-more-hws-misc-enhancements'
      Merge branch 'ip6_gre-support-per-netns-device-unregistration'
      Merge branch 'nbl-driver-for-nebulamatrix-nics'
      Merge branch 'add-support-for-phy-chip-and-firmware'
      Merge branch 'ptp-ocp-add-tap-cpld-support-for-adva-timecard-x1'
      Merge branch 'net-devmem-remove-gen_pool-from-dma-buf-allocations'
      Merge branch 'net-bridge-vlan-broadcast-fwding-path-optimizations'
      Merge tag 'wireless-next-2026-09-21' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      net: dsa: mv88e6xxx: check the port when reading back a policy rule
      net: dsa: mv88e6xxx: check the port when deleting a policy rule
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'selftests-drv-net-add-vlan-test'
      Merge branch 'net-ethernet-oa_tc6-add-reset-gpios-support'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-ethtool-make-netdev_rss_key_fill-spread-flows-over-all-queues'
      Merge branch 'ravb-add-gptp-support-for-gen4'
      Merge branch 'net-macb-1000base-x-on-internal-pcs'
      Merge branch 'net-dsa-motorcomm-add-serdes-pcs'
      Merge branch 'ch9200-stop-ignoring-the-register-write-errors'
      Merge branch 'net-macb-rework-hardware-timestamp-configuration'
      dpll: do not truncate the requested pin frequency before checking it
      netlink: specs: dpll: declare pad in the nests which carry 64-bit values
      netlink: specs: dpll: drop the reference to DPLL_MODE_DETACHED
      Merge branch 'dpll-fix-llm-nit-picks-from-the-spec-scan'
      Merge branch 'selftests-openvswitch-sctp-flow-key-coverage-ipv6-nat'
      Merge branch 'vxlan-convert-configuration-to-rcu-and-enable-lockless-dumps'
      Merge branch 'net-broadcom-couple-of-minor-changes'
      Merge branch 'net-systemport-collection-of-fixes'
      Merge branch 'net-mlx5-preparations-for-nested-e-switch'
      Merge branch 'vsock-receive-queue-hint-for-io_uring'
      tools: ynl-gen-c: keep the type values of a nest in spec order
      Merge tag 'nf-next-26-09-28' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      net: use two lockdep classes for the netdev instance lock
      selftests: net: add test for netdev instance lock ordering on unregister
      Merge branch 'ionic-shared' of https://github.com/abhijitG-xlnx/linux
      Merge branch 'w5100-restore-gpio-based-link-detection'
      Merge branch 'ipv6-update-nud_failed-neighbors-from-na-messages'
      Merge branch 'net-stmmac-add-allwinner-h616-emac1-support'
      Merge branch 'net-macb-fix-close-races-and-rx-refill-error-handling'
      octeontx2: remove unneeded symbol exports
      Merge branch 'mptcp-misc-improvements-for-v7-4'
      Merge branch 'ice-fix-stats-array-overflow-via-proper-realloc'
      Merge tag 'wireless-next-2026-09-30' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-dsa-microchip-add-periodic-output-support-for-the-ksz8463'
      net: Add netdev_config helpers
      Merge branch 'fbnic-support-larger-rx-pages'
      Merge branch 'net-mana-add-support-for-the-cdx-bus'
      llc: move the type 2 sockets out of tree
      llc: strip the leftovers of the llc2 removal
      net: drop unused LLC-related includes
      net: only give queue leasing devices a separate instance lock class
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'dpaa2-eth-devlink-port-number-from-the-dpmac'
      Merge branch 'net-rds-restrict-the-rdma_cm-ids-to-ib-devices'
      Merge branch 'eth-fbnic-update-bmc-mac-address-handling'
      docs: netdev: additional info requirements for bug fixes
      Merge branch 'net-bridge-vlan-optimize-standard-fdb-fwding-path'
      Merge branch 'net-lan966x-add-support-for-pcie-fdma'
      Merge branch 'ipv4-fix-ip-id-reuse-for-gso-packets'
      Merge branch 'net-psp-require-an-established-connection-for-association-setup'
      Merge branch 'strparser-remove-general-mode'
      Merge branch 'tcp-avoid-struct-socket-cache-line-miss-in-tcp_check_space'
      Merge branch 'gve-adminq-mode-related-refactors'
      Merge branch 'mpnic-add-napi-buffer-depletion-check'
      Merge branch 's390-ctcm-fix-timer-corruption-and-use-after-free'
      Merge branch 'net-ngbe-fix-error-handling-in-resume-and-open-paths'
      Merge tag 'batadv-next-pullrequest-20260930' of https://git.open-mesh.org/batadv
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'ip-batch-flushing-uncached-routes-per-batched-device-unregistration'
      Merge branch 'net-phy-keep-a-phy-interrupt-across-a-generic-bind-cycle'
      Merge branch 'net-dsa-qca8k-fix-mdio-error-handling'
      Merge branch 'net-bridge-fwd-optimization-cleanups'
      Merge branch 'bnge-fix-error-path-and-irq-setup-bugs-in-probe-open'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'neighbour-add-ipv4-ipv6-specific-wrappers-for-neigh_lookup-and-friends'
      Merge branch 'net-stmmac-introduce-xdp-multi-buff-support-for-tx-path'
      Merge tag 'wireless-next-2026-10-07' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'eea-improvements-in-the-driver'
      Merge branch 'vxlan-generalize-and-refine-drop-reasons'
      Merge branch 'net-dsa-motorcomm-mib-fixup'
      Merge branch 'net-mdio-realtek-rtl9300-add-bus-frequency-handling'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: netfilter: nft_queue.sh: only queue icmp echo request/reply
      Merge branch 'net-use-skb_share_check-in-loopback-selftest-hooks'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'wireless-next-2026-10-15' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'for-net-next-2026-10-14' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'netlink-add-lwtunnel-encap-sub-message-support-to-rt-route'
      Merge branch 'sctp-re-point-retained-control-chunks-on-association-migration'
      Merge branch 'net-netmem-document-design-principles-and-intended-direction'
      Merge branch 'net-skbuff-replace-most-bug_on-s-with-error-returns'
      Merge branch 'net-phy-motorcomm-add-cable-test-support-for-internal-yt861x-phys'
      Merge branch 'net-fix-sk_mc_loop-with-request-and-timewait-sockets'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'arm-dts-imx6ul-extend-var-som-6ul-and-add-dart-6ul-support'
      Merge branch 'net-dsa-motorcomm-tc-offload-follow-ups'
      Merge branch 'dpll-zl3073x-fix-output-pin-frequency-esync-and-sibling-notifications'
      Merge branch 'net-freescale-fix-ptp_extts_request2-for-qoriq-1588'
      Merge branch 'mptcp-misc-fixes-for-v7-3-rc8'
      Merge branch 'bareudp-enable-big-tcp-packets'
      Merge branch 'hw-vlan-insertion-restore'
      Merge branch 'gre-merged-gre-over-fou-gue-packets-are-dropped-bug-report-possible-fix'
      Merge branch 'net-phy-fix-a-second-attach-of-an-attached-phy-and-the-module-put-on-detach'
      Merge branch 'ipv4-remove-netns-argument-from-fib_table_lookup'
      Merge branch 'r8169-add-rss-support-for-rtl8127'
      Merge branch 'net-sched-cls_bpf-accept-dev-bound-programs-on-shared-blocks'
      Merge branch 'net-ethernet-qualcomm-ppe-add-support-for-ipq5424-soc'
      Merge tag 'ovpn-net-next-20261012' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'net-rnpgbe-add-tx-rx-and-link-status-support'
      Merge branch 'net-wwan-support-dtr-rts-on-at-ports-via-mhi-ip_ctrl'
      Merge branch 'neighbour-misc-follow-ups-on-per-netns-neigh_table-series'
      Merge branch 'ipv6-fix-address-publication-races-with-addrconf_ifdown'
      Merge branch 'net-sched-reject-oversized-action-dumps-and-cap-unbounded-entry-lists'
      Merge branch 'net-bcmasp-collection-of-fixes'
      Merge branch 'bridge-mcast-fix-mdb-exhaustion-by-rejected-entries'
      Merge tag 'nf-next-26-10-18' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'ipv6-fix-suspicious-rcu-usage-in-route-hardware-flags-notification'
      Merge branch 'net-mctp-usblib-increase-coverage-of-kunit-testing'
      Merge branch 'net-stmmac-track-and-report-the-tx-dma-threshold-per-queue'
      Merge branch 'ibmveth-fix-hangs-use-after-frees-and-netpoll-races'
      Merge branch 'net-pse-pd-si3474-probe-error-path-cleanups'
      Merge tag 'nf-26-10-19' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'net-stmmac-qcom-ethqos-add-support-for-scmi-power-domains'
      Merge branch 'net-pse-pd-plain-i2c-transport-for-realtek-gen1'
      Merge branch 'selftests-drv-net-introduce-flow-control-selftest'
      Merge branch 'net-phy_port-sfp-modules-representation-and-phy_port-listing'
      Merge branch 'net-pcs-add-basic-support-for-rk3568-xpcs'
      Merge branch 'netmem-rename-non-pp-ref-helpers-to-_inc-dec_ref'
      Merge branch 'ionic-fix-port_info-lifetime-bugs'
      Merge branch 'veth-schedule-the-peer-s-napi-after-xdp_tx-when-only-gro-is-enabled'
      Merge branch 'net-sched-sch_cake-fixes-for-accounting-and-reconfiguration'

Jakub Sitnicki (2):
      net: Make skb_ext_put_sp() idempotent
      net: Make skb_ext_put_mctp() idempotent

Jamal Hadi Salim (15):
      net/sched: cls_flower: exact-match ERSPAN key when no mask supplied
      netdevsim: reject cls_bpf programs bound to another device
      net/sched: cls_bpf: accept dev-bound programs on shared blocks
      selftests: net: exercise dev-bound cls_bpf on shared blocks
      net/sched: act_api: reject duplicate actions in a batch
      selftests: tc-testing: add duplicate action delete batch test
      net/sched: act_gate: reject oversized dumps instead of wrapping them
      net/sched: act_api: keep an add that created its actions from failing
      net/sched: act_gate: cap the number of scheduling entries
      net/sched: sch_taprio: cap the number of schedule entries
      net/sched: act_api: report an oversized action dump instead of silently truncating it
      net/sched/sch_cake: serialize reconfiguration with the datapath
      net/sched/sch_cake: reduce parent backlog when clearing a tin
      net/sched/sch_cake: widen buffer_used to u64
      net/sched/sch_cake: drop dead nla_nest_end() error check

James Clark (1):
      net: stmmac: ptp: switch to gettimex64() interface

James Hilliard (9):
      dt-bindings: net: x-powers: add AC200/AC300 EPHY packages
      net: phy: add X-Powers AC200/AC300 EPHY driver
      net: stmmac: sun8i: reset the MAC after PHY initialization
      dt-bindings: net: allwinner: add H616 EMAC1
      net: stmmac: sun8i: add support for Allwinner H616 EMAC1
      net: stmmac: unwind the WoL IRQ after a safety IRQ request failure
      net: stmmac: leave the datapath running for normal-size MTU changes
      xsk: freeze deferred pool teardown without blocking unregister
      net: stmmac: avoid duplicate XSK TX completions

James Lee (7):
      net: mctp: usblib: Add to parameterized kunit tests.
      net: mctp: usblib: Add test for splits inside headers
      net: mctp: usblib: Add tests of invalid headers
      net: mctp: usblib: Complete rx tests
      net: mctp: usblib: Simplify allocation logic in mctp_usblib_test_rx_init
      net: mctp: usblib: Add initial kunit tx tests
      net: mctp: usblib: Add test for failing append

Jan Havran (Advantech Czech) (2):
      net: dsa: mxl-gsw1xx: set SerDes NCO rate before SGMII reset
      net: dsa: lantiq_gswip: handle SPEED_2500 in gswip_port_set_speed()

Jan Hoffmann (1):
      net: sfp: add quirk for XikeStor SKT-2.5G-100M

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Report port_authorized for 4-way HS offload

Jason A. Donenfeld (1):
      wireguard: noise: remove unused variable

Jason Xing (1):
      tcp: preserve timestamps across receive queue collapse

Javen Xu (19):
      r8169: add speed in private struct
      net: phy: phylink: add helper to modify pause
      r8169: add support for phylink
      r8169: add support for RTL8116af
      r8169: add support for RTL8127atf
      r8169: add ltr support for RTL8117 series
      r8169: fix RTL8116af can not enter s0idle and c10
      net: phy: realtek: improve firmware write speed
      r8169: set eee_enable_default base on LPI cap
      net: phy: realtek: add support for RTL8261CE_CG
      net: phy: realtek: add firmware for RTL8261D
      net: phy: realtek: add support for RTL8261D_VM
      r8169: prepare for multi irqs and napi
      r8169: refactor RX path to prepare for multi-queue
      r8169: add support for new interrupt mapping
      r8169: prepare for new interrupt mapping
      r8169: add support and enable rss
      r8169: move struct ethtool_ops
      r8169: add get_channel support for ethtool

Jayaraj Devaraj (1):
      docs: oa-tc6-framework: Fix typo in SYNC bit description

Jeff Chen (8):
      mmc: sdio: add NXP IW610 device ID
      mmc: core: add NXP IW610 base ID and block size quirk
      wifi: nxpwifi: Add support for SDIO-based IW610
      wifi: nxpwifi: Limit channel width based on firmware capability
      wifi: nxpwifi: fix return value check in change_vif_to_sta/ap
      wifi: nxpwifi: fix missing error codes in _nxpwifi_fw_dpc()
      wifi: mwifiex: append hotfix number to firmware version string
      wifi: mwifiex: validate GET_HW_SPEC TLV lengths before parsing

Jeff Johnson (6):
      wifi: ath12k: remove skb->data check in ath12k_wmi_process_tpc_stats()
      wifi: ath9k: use rcu_dereference_bh() for sta->rates in ath_merge_ratetbl()
      MAINTAINERS: Replace wireless.wiki.kernel.org links
      wifi: ath11k: fix reg_info_store leak in ath11k_service_ready_ext_event()
      wifi: cfg80211: fix kernel-doc %field -> @field cross-references
      wifi: ath12k: Remove unused HAL_RX_REO_QUEUE_INFO macros

Jeremy Dean (1):
      Bluetooth: Fix code style error

Jia Wang (5):
      net: stmmac: Add common internal RGMII delay handling
      net: stmmac: sophgo: Use common RGMII delay handling
      net: stmmac: eic7700: Use common RGMII delay handling
      dt-bindings: net: Add UltraRISC DP1000 GMAC
      net: stmmac: Add UltraRISC DP1000 GMAC support

Jiale Yao (13):
      wifi: ath12k: Reserve space for a string terminator
      tun: Drain eBPF RCU callbacks on module exit
      wifi: mt76: mt76x02: validate RX padding before use
      wifi: mt76: mt7615: cancel reset work during unregister
      wifi: mt76: usb: fix source overread in mt76u_copy
      wifi: mt76: mt7615: usb: fix source overread in mt7663u_copy
      wifi: ath12k: validate MAC/PHY capability count before saving
      wifi: ath10k: avoid IDR mutation during TX cleanup
      wifi: ath11k: avoid IDR mutation during pending mgmt TX cleanup
      wifi: ath11k: avoid IDR mutation during vif mgmt TX cleanup
      wifi: ath12k: avoid IDR mutation during pending mgmt TX cleanup
      wifi: ath12k: avoid IDR mutation during vif mgmt TX cleanup
      team: reject CAN, IEEE 802.15.4 and 6LoWPAN devices in team_port_add

Jiangshan Yi (1):
      octeontx2-af: consolidate RVU AFVF device id definitions

Jiawen Wu (1):
      net: libwx: rename wx_pf_flags to wx_flags

Jiayuan Chen (8):
      netdevsim: fix panic when NETIF_F_LOOPBACK is set on a VF port
      udp: fix auto-selected port colliding with an existing SO_REUSEPORT socket
      selftests/net: check auto-selected port with reuse options
      e1000e: fix IRQ leak when request_irq() fails in e1000_request_msix()
      tcp_bic: fix divide by zero on max_increment == 0
      tcp_hybla: fix divide by zero on rtt0 == 0
      tcp_cubic: fix divide by zero and endless loop on bad module params
      veth: clear rx queue hint in veth_xmit

Jijie Shao (2):
      net: hibmcge: fix spelling mistakes in comments and identifiers
      net: hibmcge: set netdev_ops before hbg_init() to fix NULL pointer dereference

Jinjie Ruan (2):
      8021q: Fix data race when publishing vlan net_device pointers
      8021q: publish vlan_devices_arrays entries with acquire/release

Jisheng Zhang (1):
      net: stmmac: Disable unsolicited checksum insertion for AF_XDP TX

Joas Antonio dos Santos (2):
      calipso: hash the cache key, not the option start, in calipso_cache_add()
      calipso: update payload_len when removing the CALIPSO option

Joe Damato (2):
      bnxt_en: Add helper to fill SW USO payload BDs
      bnxt_en: Pad short SW USO segments to BNXT_MIN_PKT_SIZE

Joel Granados (1):
      ipvs: skip committing sync_threshold when proc_dointvec fails

Johannes Berg (132):
      wifi: skip DUO params when looking for NPCA
      wifi: update UHR to Draft_P802.11bn D1.5
      wifi: mac80211: fix unauthorised port check for encap offload
      wifi: mac80211: fix key selection for encap offload frames
      wifi: mac80211: don't send encap offload frames unencrypted
      wifi: mac80211: drop encap offload frames with a tainted key
      wifi: nl80211: don't export nl80211_mlo_reconf_add_done()
      wifi: mac80211: remove ieee80211_sta_ps_transition() return value
      wifi: mac80211: make ieee80211_is_tx_data() internal
      wifi: mac80211: fix IEEE80211_TX_CTL_REQ_TX_STATUS mixup
      wifi: mac80211: tx: simplify control port frame transmission
      wifi: mac80211: remove cookie from __ieee80211_subif_start_xmit()
      wifi: mac80211: unshare the skb before building the header
      wifi: mac80211: report multicast transmission from lookup_ra_sta()
      wifi: mac80211: set flags/ctrl_flags before ieee80211_build_hdr()
      wifi: mac80211: store the ack skb before building the header
      wifi: mac80211_hwsim: fix potential channel crash
      wifi: mac80211_hwsim: overwrite report SKB
      wifi: rtw89: avoid iter_keys_rcu() where not needed
      Merge tag 'ath-next-20260916' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: tests: fix memory leak
      wifi: mac80211: WARN on 40 MHz HT/HE mismatch
      wifi: mac80211: allow advertising 20 MHz-only non-AP STA
      wifi: ieee80211: fix FTM bufferable check
      wifi: radiotap: correct EHT TB U-SIG 1 B20:25
      wifi: nl80211: rename no-ACK bitmap to TID bitmap
      wifi: mac80211: fix multi-link UHR association
      wifi: mac80211: add key flags to debugfs
      wifi: radiotap: add definitions for UHR U-SIG
      wifi: mac80211: mesh: don't send peering close in listen
      wifi: mac80211: fix potential ack-skb leak on error path
      Merge tag 'mm81x-next-2026-09-24' of https://github.com/MorseMicroLabs/linux-wireless
      Merge tag 'ath-next-20260927' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: fix TPE in channel switch wrapper parsing
      wifi: ieee80211: type-check (extended) element functions
      wifi: cfg80211: add protected TWT assoc flag
      wifi: mac80211: fix and clean up protected TWT support
      wifi: mac80211: set SP in reg connectivity with any channel
      Merge tag 'nxpwifi-next-20260929-v3' of https://github.com/nxp-upstream/nxpwifi-next
      wifi: mac80211: fix non-MLD link ID handling
      wifi: mt76: avoid iter_keys_rcu() where not needed
      wifi: ath6kl: don't take RTNL in del_virtual_intf
      wifi: mac80211: clear fragment cache entry 'is_protected'
      wifi: mac80211: mesh: use hlist_add_head_rcu()
      wifi: mac80211: kill wake_txqs_tasklet on unregistration
      wifi: nl80211: reject zero RNR/MBSSID elements
      wifi: mac80211: init radiotap iter after length checks
      wifi: mac80211: limit injected HT/VHT MCSes
      wifi: mac80211: mesh: fix path table generation counters
      wifi: mac80211: fix mbssid/rnr allocation in beacon data
      wifi: mac80211: don't read runt headers in injection
      wifi: mac80211: fix TDLS setup frame length check
      Merge tag 'mt76-next-2026-10-07' of https://github.com/nbd168/wireless
      wifi: cfg80211: reg: protect regdb pointer with RCU
      wifi: cfg80211: track netdev running state under wiphy mutex
      wifi: nl80211: allow device lookup under RCU
      wifi: nl80211: avoid rtnl for commands that don't want it
      wifi: nl80211: don't take rtnl for most dumps
      wifi: cfg80211: reg: update channels under wiphy mutex
      wifi: cfg80211: reg: set intersected regd under wiphy mutex
      wifi: cfg80211: update channel DFS data under wiphy mutex
      wifi: mac80211_hwsim: call cfg80211 event with wiphy mutex
      wifi: cfg80211: document wiphy mutex for radar/CAC events
      wifi: cfg80211: add a mutex for regulatory/device list
      wifi: cfg80211: allow walking wiphy list under cfg80211_mutex
      wifi: ath: use freq_reg_info() under RCU
      wifi: brcmsmac: use freq_reg_info() under RCU
      wifi: rtlwifi: use freq_reg_info() under RCU
      wifi: nl80211: read WMM reg rule under RCU
      wifi: ath11k: read wiphy regd under RCU
      wifi: ath12k: read wiphy regd under RCU
      wifi: cfg80211: regulatory: stop using RTNL
      Merge tag 'rtw-next-2026-10-08' of https://github.com/pkshih/rtw
      Merge tag 'mm81x-next-2026-10-09' of https://github.com/MorseMicroLabs/linux-wireless
      wifi: nl80211: add NL80211_CMD_UPDATE_BEACON
      wifi: mac80211: protect AP template pointers with a spinlock
      wifi: mac80211: refactor beacon allocation
      wifi: mac80211: implement lockless beacon updates
      wifi: mac80211_hwsim: support lockless beacon updates
      wifi: nl80211: prepare for unlocked wdev-only ops
      wifi: nl80211: allow mgmt frame TX without wiphy mutex
      wifi: cfg80211: make cookie counter atomic
      wifi: mac80211: refactor mgmt frames TX
      wifi: mac80211: implement mgmt_tx_unlocked()
      wifi: mac80211: don't require wiphy mutex for probe_peer
      wifi: nl80211: probe peers without wiphy mutex
      wifi: mac80211: don't require wiphy mutex for control port TX
      wifi: nl80211: transmit control port frames without wiphy mutex
      wifi: cfg80211: support unlocked station get/dump
      wifi: mac80211: refactor station statistics
      wifi: mac80211: implement unlocked STA statistics
      wifi: nl80211: fix BSS reference leak
      wifi: nl80211: avoid RTNL in nl80211_get_reg_do()
      wifi: cfg80211: drop RTNL from disconnect_work
      wifi: nl80211: don't hold RTNL for SET_SAR_SPECS
      wifi: cfg80211: switch wiphy netns under cfg80211_mutex
      wifi: nl80211: avoid RTNL for wiphy/interface netlink dumps
      wifi: cfg80211: protect wiphy names with cfg80211_mutex
      wifi: mac80211_hwsim: get wiphy_name() after registration
      wifi: cfg80211: check wiphy name in wiphy_register()
      wifi: mac80211: don't hold RTNL for rate control algo
      wifi: mac80211: fix interface registration error path order
      Merge tag 'ath-next-20261012' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: iwlwifi: mld: separate HT/VHT/HE/EHT LDPC/STBC capabilities
      wifi: iwlwifi: advertise 2xLDPC RX support for UHR
      wifi: iwlwifi: mld: fix some UHR ELR bits
      wifi: iwlwifi: mld: correct EHT U-SIG-1 B20:25 report
      wifi: iwlwifi: mld: add UHR sniffer support
      wifi: iwlwifi: mld: report UHR LTF symbols for non-TB PPDUs
      wifi: iwlwifi: mld: fix some radiotap field reports
      wifi: iwlwifi: mld: report UHR per-user NSS
      wifi: iwlwifi: mld: report beamforming in UHR sniffer
      wifi: iwlwifi: correctly report TB sounding PPDUs in sniffer
      wifi: iwlwifi: mld: remove UHR TB U-SIG2 B2 validate bit
      wifi: iwlwifi: mld: detect UHR sounding packets
      wifi: iwlwifi: mld: report the guard interval for UHR
      wifi: iwlwifi: mld: set RX_FLAG_FAILED_PLCP_CRC for bad U-SIG CRC
      wifi: iwlwifi: advertise UHR Co-BF support
      wifi: iwlwifi: dbg: validate the index before accessing an array
      wifi: iwlwifi: fw: api: fix D3 sequence counter docs
      wifi: iwlwifi: pcie: correctly read WFPM_OTP_CFG1_ADDR
      wifi: iwlwifi: mld: avoid const in iwl_mld_chan_load_update_iter()
      wifi: iwlwifi: mld: fix const in iwl_mld_mu_mimo_iface_iterator
      wifi: iwlwifi: mvm: fix beacon flags compiler warning
      wifi: iwlwifi: mvm: uninline iwl_mvm_ftm_start versions
      wifi: iwlwifi: support SCD_QUEUE_CONFIG_CMD version 4
      Merge tag 'nxpwifi-next-20261014' of https://github.com/nxp-upstream/nxpwifi-next
      Merge tag 'iwlwifi-next-2026-10-14' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      wifi: mac80211: tests: fix stack variable bug
      wifi: cfg80211: track SSID regardless of country data
      wifi: cfg80211: reject WEP/TKIP with multi-link
      wifi: cfg80211: fix potential requested_regd leak

John Crispin (3):
      wifi: mt76: mt7996: disable the RX NAPIs before the DMA cleanup
      wifi: mt76: scan all radios of a request at the same time
      wifi: mt76: mt7996: scan all bands with one request

Johnson Tsai (1):
      wifi: rtw89: pack I/O during RF nctl init to reduce execution time

Josef Bacik (9):
      net: skbuff: don't BUG() on bad arguments to pskb_expand_head()
      net: skbuff: don't BUG() on a bad frag_list layout in skb_segment()
      net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers
      net: skbuff: don't BUG() on leftover length in skb_checksum() and friends
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()
      net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()
      net: skbuff: remove the BUG_ON()s from skb_shift()
      net: axienet: don't advance the TX ring head before the descriptor is ready

Joshua Washington (6):
      gve: simplify reset logic
      gve: add gve_ctrl_ops for gve initialization/teardown sequences
      gve: split up notify block allocation and setup paths
      gve: introduce new methods to handle IRQ doorbells
      gve: setup and teardown management interrupts
      gve: add link status/speed ctrl ops

Juanlu Herrero (6):
      selftests: net: fix get_refill_ring_size() to use its local variable
      selftests: net: remove unused variable in process_recvzc()
      selftests: net: refactor server state into struct thread_ctx
      selftests: net: add multithread client support to iou-zcrx
      selftests: net: add multithread server support to iou-zcrx
      selftests: net: add rss_multiqueue test variant to iou-zcrx

Julian Anastasov (2):
      ipvs: fix buffer overflow when sending sync messages
      ipvs: fix more races around the overload flag

Julien Blanc (1):
      net: phy: dp83td510: Add config phase

Julius Bairaktaris (4):
      wifi: ath11k: implement CE interrupt enable/disable for AHB
      wifi: ath11k: disable interrupts during firmware crash recovery
      wifi: mac80211: fix swapped fq_overlimit/fq_overmemory in aqm debugfs
      wifi: mac80211: don't reset the TXQ scheduling round number

Jun Yang (1):
      sctp: re-point retained control chunks on association migration

Junjie Cao (2):
      net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
      Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728

Justin Chen (1):
      net: bcmasp: fix lost TX wakeup race with lockless queue API

Juuso Rinta (1):
      octeontx2: use dev_err_probe() for deferred probe

Jérémy Jean (3):
      macsec: prevent AES-GCM nonce reuse after packet number wrap
      mpls: unregister sysctls before network device teardown
      netfilter: nf_conntrack: avoid truncating IPv6 nexthdr offset

Jérôme Pouiller (4):
      wifi: wfx: fix possible device hang during init
      dt-bindings: net: wireless: wfx: discourage OOB IRQ with SDIO
      wifi: wfx: fix use-after-free of the cooling work on device removal
      wifi: wfx: fix error code on unsupported firmware

Kaifeng Wang (2):
      net: devmem: use page_pool_put_netmem_bulk
      net: devmem: check uid and netns in net_devmem_get_binding()

Kamil Bienkiewicz (1):
      wifi: ath12k: advertise AP_VLAN interface mode for IPQ5332

Kang Yang (7):
      wifi: ath12k: preserve PPDU state across monitor status buffers
      wifi: ath12k: fix skb leak on paddr mismatch in wifi7 mon RX pop
      wifi: ath12k: free pending MSDUs on duplicate mon link descriptor
      wifi: ath12k: fix stale tail_msdu pointer returned from mpdu_pop
      wifi: ath12k: place dp_mon_mpdu on stack in mon dst reap loop
      wifi: ath12k: fix skb leak on monitor PPDU ID wraparound
      wifi: ath12k: avoid double DMA unmap of held monitor RX buffers

Karl Mehltretter (14):
      docs: phonet: Fix the struct sockaddr_pn name in the example
      net: smc91x: Remove stale documentation reference
      net: ipa: Drop the monitor_rx endpoint_id ABI entry
      docs: mctp: Fix the struct net_device name
      docs: mctp: Fix the struct mctp_sk_key name
      docs: networking: page_pool: Use page_pool_put_netmem_bulk() in the kernel-doc directive
      wifi: mac80211: Fix the return value in mesh_path_add() kernel-doc
      page_pool: Fix page_pool_alloc_va() reference in kernel-doc
      net: phy: Fix device_set_wakeup_enable() reference in kernel-doc
      net: microchip: vcap: Stop selecting DEBUG_FS for KUnit tests
      ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
      wifi: nxpwifi: return timeout error from nxpwifi_sdio_poll_card_status()
      net: phy: realtek: restore RTL8211F RGMII delays on resume
      net: cpsw: fix netdev cleanup on probe failure

Kees Cook (2):
      octeontx2-af: Allocate ikpu2 with ARRAY_SIZE()
      netdev: Hide the netdev_priv() origin from GCC in netdev_from_priv()

Kevin Dewald (1):
      Bluetooth: hci_event: Fix LE link drop on remote features command status

Kim Wooseok (6):
      wifi: rtl8xxxu: free RX skb when URB submission fails
      wifi: rtl8xxxu: unwind incomplete receive startup
      wifi: rtl8xxxu: preserve RX requests across recoverable transfer errors
      net: macb: Preserve timestamp settings on rejected requests
      net: macb: Enable RX timestamping for specific PTPv1 filters
      net: macb: Clear SRTSM outside PTPv2 receive filters

Kiran K (5):
      Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt
      Bluetooth: btintel_pcie: cap device debug regions at 1 MB
      Bluetooth: btusb: Preserve event and ACL packet ordering
      Bluetooth: btintel: Zero version data before parsing TLVs
      Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware

Kohei Enju (3):
      i40e: prepare for XDP metadata ops support
      i40e: add support for bpf_xdp_metadata_rx_hash()
      i40e: add support for bpf_xdp_metadata_rx_vlan_tag()

Konstantin Meshkov (1):
      net: phy: marvell: add LED support for 88E1116R PHY

Konstantin Nazarov (1):
      Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks

Kris Pan (1):
      net: iterate online nodes in skb_defer_free_flush()

Krzysztof Kozlowski (2):
      dt-bindings: net: fsl,fman-dtsec: Drop redundant pcs-handle-names dependency
      dt-bindings: net: Use consistent indentation in the example

Kuba Pawlak (1):
      selftests: net: Skip so_incoming_cpu on single-CPU systems

Kuniyuki Iwashima (53):
      selftest: net: Deflake Periodic GC test in test_neigh.sh.
      neighbour: Remove __neigh_for_each_release().
      neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
      neighbour: Remove unnecessary EXPORT_SYMBOL().
      neighbour: Remove __rcu from neigh_tables[].
      neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
      neighbour: Remove neigh_tables[].
      ipv4: Replace &arp_tbl with arp_table(net).
      ipv6: Replace &nd_tbl with nd_table(net).
      neighbour: Clean up neigh_table_init() and neigh_table_clear().
      neighbour: Convert neigh_table.entries to refcount_t.
      neighbour: Namespacify neigh_tables.
      neighbour: Don't store net in struct pneigh_entry.
      neighbour: Remove unnecessary net_eq().
      selftest: net: Specify netns for ip ntable in test_neigh.sh.
      tcp: Do not allow buggy transitions between ehash and lhash2.
      ipv6: Remove IPV6_ADDRFORM.
      ipmr: Call ->dellink() to remove DVMRP tunnel device.
      ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
      ip_tunnel: Don't pass rtnl_link_ops to ip_tunnel_delete_net().
      ip_tunnel: Centralise ip_tunnel_del() to ip_tunnel_dellink().
      ip_tunnel: Unify error paths in ip_tunnel_newlink() and ip_tunnel_changelink().
      ip_tunnel: Protect ip_tunnel_net.tunnels[] with mutex.
      ip_tunnel: Support per-netns device unregistration.
      tcp: Set unhashed_state in inet_twsk_hashdance_schedule().
      ip6_gre: Initialise ign->tunnels_wc[0] before register_netdev().
      ip6_gre: Convert ip6gre_net.tunnels[][] to hlist.
      ip6_gre: Clear ign->fb_tunnel_dev in ip6gre_exit_rtnl_net().
      ip6_gre: Unlink ip6gre_tunnel_unlink() from ->dellink().
      ip6_gre: Protect ip6gre_net.tunnels[][] with mutex.
      ip6_gre: Support per-netns device unregistration.
      ipv6: Remove FIB6_EXCEPTION_BUCKET_FLUSHED.
      ref_tracker: Don't use __GFP_NOFAIL for PF_MEMALLOC thread.
      net: Order blackhole_netdev_init(), inet_init(), and inet6_init().
      ipv4: Inline inet_blackhole_dev_init() to devinet_init().
      net: Rename dev_isalive() to netif_is_alive().
      xfrm: Check netif_is_alive() in xfrm_bundle_create() and xfrm_create_dummy_bundle().
      ipv4: Batch rt_flush_dev() in netdev_run_todo().
      ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().
      ipv4: Rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().
      ipv6: Rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().
      ipv4: Add wrappers for neigh_lookup() and neigh_create().
      ipv6: Add wrappers for neigh_lookup() and (__)?neigh_create().
      mlxsw: spectrum: Resolve neigh_table right before neigh_lookup().
      ipv6: Use ipv6_neigh_lookup() and friends.
      ipv4: Use ipv4_neigh_lookup() and friends.
      neighbour: Remove __neigh_lookup() and __neigh_lookup_errno().
      neighbour: Check n->parms->tbl under tbl->lock in ___neigh_create().
      Documentation: networking: switchdev: Replace arp_tbl with arp_table(net).
      selftests: netfilter: Set gc_thresh[123] for gw netns in nft_nat_zones.sh.
      neighbour: Schedule neigh_managed_work only when needed.
      neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
      neighbour: Floor neigh_periodic_work() interval at 1s.

Kyle Hendry (2):
      net: pcs: rzn1-miic: Update port numbering for RZ/T2H
      net: pcs: rzn1-miic: Validate dtb configuration values

Kyle Pepper (1):
      Bluetooth: hci_sync: scan unfiltered for host-resolved RPAs

Kyle Zeng (1):
      netfilter: nf_reject: initialize IPCB at inet ingress

Lachlan Hodges (17):
      wifi: mm81x: move beacon work and init below the tx op
      wifi: mm81x: release buffered broadcast frames after DTIM
      wifi: mm81x: do not drop PS filtered frames in AP mode
      wifi: mm81x: implement .tx_frames_pending() mac op
      wifi: mm81x: factor out tx width selection
      wifi: mm81x: tx EAPOLs at primary width
      wifi: mm81x: clamp tx width to stas max supported width
      wifi: mm81x: tx multicast frames from AP at primary width
      wifi: mac80211: don't seed an S1G sta's last_rate
      wifi: cfg80211: remove duplicate s1g_cap kerneldoc
      wifi: radiotap: add S1G TLVs and channel frequency
      wifi: mac80211: report 900MHz channel for S1G band radiotap header
      wifi: mm81x: provide the station to mac80211 on rx
      wifi: mm81x: add monitor mode support
      wifi: mm81x: copy new sband for each module
      wifi: mac80211: handle shorter S1G TIM when parsing elements
      wifi: mac80211: set conn mode prior to parsing elements in beacon

Lawrence Lee (2):
      ipv6: update NUD_FAILED neighbors from NA messages
      selftests: net: test untracked NA recovery of FAILED neighbors

Laxman Acharya Padhya (1):
      wifi: rtw89: cap firmware section_num before parsing

Li RongQing (2):
      net/mlx5: Use dma_wmb() for completion queue doorbell updates
      veth: decide peer queue count from the peer's own attributes

Linkai Gong (1):
      wifi: ath12k: clear dangling channel pointers on error paths

Linkui Xiao (3):
      ipmr, ip6mr: annotate data-races in vif_seq_show()
      netfilter: osf: remove unreachable break in nf_osf_ttl()
      net: stmmac: do not keep the new TSO MSS cached on mapping failures

Linlin Yang (1):
      wifi: mt76: mt7996: fix PCI device reference leak in mt7996_pci_init_hif2()

Linmao Li (2):
      wifi: mm81x: free the firmware scratch buffer on parse failures
      wifi: mm81x: do not discard a failed firmware segment write

Linus Walleij (5):
      net: ethernet: cortina: Bound RX descriptor processing
      dt-bindings: net: dsa: microchip: Add KSZ8995XA
      net: dsa: tag_ks8995: Add the KS8995 tag handling
      net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA
      net: dsa: ks8995: Delete surplus driver

Liu Chao (2):
      netfilter: nf_conntrack_netlink: fix inverted IPv6 tuple filter
      net: wwan: iosm: validate msg_head before indexing msg_ring

Loic Poulain (1):
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells

Longjun Tang (1):
      virtio_net: add rx-alloc-fail counter

Lorenzo Bianconi (17):
      net: stmmac: drop the queue-0 pinning for GSO frames
      net: airoha: add LRO offload support
      net: stmmac: propagate PTP init failures in __stmmac_open() and stmmac_resume()
      net: mvneta: rely on napi_build_skb() in mvneta_swbm_build_skb()
      net: stmmac: fix TX coalesce race and div-by-zero in XDP/legacy path
      net: stmmac: add XDP multi-buff support for TX side
      net: stmmac: set real_num_tx_queues to max(offset + count)
      net: stmmac: align real_num_tx_queues to mqprio configuration
      net: stmmac: add tc mqprio hw queue priority offload
      netfilter: flowtable: set inner protocol when popping tunnel header
      netfilter: flowtable: populate tunnel tuple regardless of inner protocol
      netfilter: flowtable: add encap_proto to flow_offload_tunnel
      netfilter: flowtable: unify tunnel push for IPv4 and IPv6
      netfilter: flowtable: reset transport header after nf_flow_encap_pop()
      net: stmmac: fix XDP TX DMA address for compound RX pages
      net: stmmac: disable TX checksum offload for jumbo frames on bugged cores
      net: stmmac: fix mqprio and cbs combination

Luiz Angelo Daros de Luca (2):
      net: dsa: realtek: rtl8365mb: define masks using BIT() and GENMASK()
      net: dsa: realtek: use <module>-y in Makefile

Luiz Augusto von Dentz (8):
      Bluetooth: Move H:4 reassembly into the Bluetooth core
      Bluetooth: btusb: Add support for Bulk Serialization Mode
      Bluetooth: MGMT: Fix advertising instances with Global Advertising
      Bluetooth: HCI: Fix tracking of instances sharing handle 0x00
      Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
      Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
      Bluetooth: MGMT: Allow connection rate request as peripheral
      Bluetooth: Fix the LE Read Connection Interval response layout

Luka Gejak (15):
      wifi: rtw88: add the RTL8723B chip type and SDIO helper
      wifi: rtw88: rx: mark zero length packets on RTL8723BS
      wifi: rtw88: tx: extend the TX report purge timeout to RTL8723BS
      wifi: rtw88: sdio: zero the padding added to a TX transfer
      wifi: rtw88: sdio: track free TX pages and OQT credits for RTL8723BS
      wifi: rtw88: sdio: set up RX aggregation and interrupts for RTL8723BS
      wifi: rtw88: sdio: add TX back-pressure and retry on page starvation
      wifi: rtw88: move the 88xxa CCK power detect setter to phy.c
      wifi: rtw88: 8723b: add the RTL8723B register definitions
      wifi: rtw88: 8723b: add the RTL8723B BB, RF and AGC tables
      wifi: rtw88: move the shared 8723x definitions to rtw8723x.h
      wifi: rtw88: 8723b: add the RTL8723B chip driver
      wifi: rtw88: 8723bs: add the RTL8723BS SDIO bind
      wifi: rtw88: 8723bs: enable building the RTL8723BS driver
      staging: rtl8723bs: remove the obsolete driver

Luo Jie (11):
      dt-bindings: net: qcom,ipq9574-ppe: Split EDMA reset into sys and apb
      net: ethernet: qualcomm: ppe: Fix multicast queue config table access
      dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5424 PPE support
      docs: networking: Document IPQ5424 as a supported SoC
      net: ethernet: qualcomm: ppe: Add platform support for IPQ5424
      net: ethernet: qualcomm: ppe: Add IPQ5424 BM buffer configuration
      net: ethernet: qualcomm: ppe: Add IPQ5424 QM configuration
      net: ethernet: qualcomm: ppe: Add IPQ5424 scheduler resource configuration
      net: ethernet: qualcomm: ppe: Add IPQ5424 scheduler configuration
      net: ethernet: qualcomm: ppe: Add IPQ5424 service code configuration
      net: ethernet: qualcomm: ppe: Add IPQ5424 counter debugfs support

Magnus Lindholm (1):
      tg3: normalize inherited BCM5718 register byte order

Mahesh Saran (1):
      wifi: mt76: mt7921: clear WM2 from MT7902 RX all_complete_mask

Manish Awasthi (5):
      net: mana: Use the HWC destination queues reported by the hardware
      net: mana: Introduce gdma_bus_ops for bus-specific operations
      net: mana: Move PCI transport code into gdma_pci.c
      net: mana: Build the PCI transport as a separate module
      net: mana: Add support for CDX device ID 0x00C2

Manish Dharanenthiran (3):
      mailmap: add entries for Manish Dharanenthiran
      wifi: nl80211: add support to configure 6 GHz non-HT duplicate transmission
      wifi: mac80211: Guard FILS discovery and unsolicited broadcast probe response

Manuel Ebner (3):
      docs: networking: radiotap: Fix bracket
      docs: ethtool: Fix bracket
      Documentation: net: dsa: Fix bracket

Manuel Stocker (1):
      net: phy: realtek: support unaligned RTL8224 PHY packages

Maoyi Xie (1):
      wifi: mac80211_hwsim: send config events to the radio's net namespace

Marcin Szycik (2):
      ice: remove unused ICE_FD_FLUSH_REQ from PF state
      ice: use ice_fill_eth_hdr() in ice_fill_sw_rule()

Marco Baffo (2):
      ovpn: remove redundant peer NULL checks in crypto post functions
      selftests: ovpn: enable TCP_NODELAY on TCP sockets

Marco Crivellari (1):
      Octeontx2-af: Add WQ_PERCPU to alloc_workqueue users

Marek Behún (1):
      net: sfp: ignore LOS also on Hisense GPON modules

Marek Vasut (3):
      enetc: Increase eMDIO MDC rate to 2.5 MHz
      Revert "enetc: Increase eMDIO MDC rate to 2.5 MHz"
      net/fsl: xgmac_mdio: Add missing newlines to error prints

Mariano Baragiola (1):
      wifi: mac80211: avoid trimming injected FCS twice

Mark Anthony Agarro (5):
      wifi: mt76: mt76x02: validate TX-status rate index before mac80211 handoff
      wifi: mt76: mt7925: honour mac80211's FIF_FCSFAIL instead of hardcoding drop_err
      wifi: mt76: mt7615: do not tear down BSS/STA state for monitor vifs
      wifi: mt76: mt7921: keep the join ROC until the station is authorized
      wifi: mt76: mt7925: keep the join ROC until the station is authorized

Markus Elfring (1):
      ppp_synctty: Use common error handling code in ppp_sync_txmunge()

Markus Stockhausen (17):
      dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
      net: mdio: realtek-rtl9300: Add polling documentation
      net: mdio: realtek-rtl9300: deny C45 over C22 access
      net: phy: add phy_detach_internal() helper
      net: mdio: realtek-rtl9300: suppress sysfs bind/unbind attributes
      net: mdio: realtek-rtl9300: Configure hardware polling during probing
      net: mdio: realtek-rtl9300: Add page tracking
      net: mdio: realtek-rtl9300: Increase MDIO timeout
      net: mdio: realtek-rtl9300: Open up C22 and C45 space in parallel
      net: mdio: realtek-rtl9300: Add support for RTL838x
      net: mdio: realtek-rtl9300: Add support for RTL839x
      net: mdio: realtek-rtl9300: reword Kconfig and module description
      dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family
      dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency
      net: mdio: realtek-rtl9300: convert "fwnode" left-overs to "of"
      net: mdio: realtek-rtl9300: reject duplicate MDIO bus IDs
      net: mdio: realtek-rtl9300: support non-default clock frequencies

Martin Jabůrek (1):
      selftests: net: add IPv4 and IPv6 address order check

Matthieu Baerts (NGI0) (5):
      selftests: netfilter: use KHDR_INCLUDES in CFLAGS
      selftests: forwarding: use KHDR_INCLUDES in CFLAGS
      mptcp: remove thmac from subflow ctx
      mptcp: options: mpc: avoid printing uninit data
      mptcp: options: dss: avoid printing uninit csum

Matvey Valigura (1):
      usb: atm: use request_firmware_direct() for firmware probing

Maxim Skokov (1):
      wifi: rtw89: fix typos in comments, debug messages and struct field

Maxime Chevallier (16):
      net: stmmac: Remove ARP offload code
      net: stmmac: dwmac4: Read the UC filter size from hardware capabilities
      net: stmmac: dwmac4: Use the full perfect filter ability for UC filter
      net: phy: motorcomm: Split yt8521_config_init() page management
      net: phy: motorcomm: Add a dedicated .config_init for YT8531S
      net: phy: motorcomm: Enable analog frontend on YT8531S
      net: phy: phy_link_topology: Add a helper for opportunistic alloc
      net: phy: phy_link_topology: Track ports in phy_link_topology
      net: phylink: Register a phy_port for MAC-driven SFP cages
      net: phy: Create SFP phy_port before registering upstream
      net: phy: Represent PHY-less SFP modules with phy_port
      net: phy: phy_port: Store information about a port's upstream
      net: phy: phy_link_topology: Add a helper to retrieve ports
      netlink: specs: Add ethernet port listing with ethtool
      net: ethtool: Introduce ethtool command to list ports
      Documentation: networking: Update the phy_port infrastructure description

Maxime Chevallier (Netdev Foundation) (6):
      tools: ynl: Allow cross-compiling ynl and associated tools
      selftests: drv-net: Use cross-compilation environment for the io_uring check
      tools: ynl: Fix out-of-tree build for ynltool
      selftests: drv-net: Introduce a selftest for ethtool flow control
      selftests: drv-net: pause: Validate the pause autonegotiation with a partner
      selftests: drv-net: pause: Validate pause autoneg interactions with link autoneg

Mehmet Fide (5):
      wifi: rtw88: usb: route bmc frames via the high queue only for DTIM delivery
      wifi: rtw88: usb: do not log transfers lost to a mode switch
      wifi: rtw88: usb: bound what the driver feeds the after-DTIM queue
      wifi: rtw88: usb: only let the frames a dozing station needs use the after-DTIM queue
      wifi: rtw88: widen the ATIM window while an AP interface is up

Miaoqing Pan (4):
      wifi: ath11k: fix sporadic WLAN initialization failures
      wifi: ath11k: fix NULL dereference in ahb remove when QMI init incomplete
      wifi: ath11k: unregister PM notifier on QMI init failure path
      wifi: ath12k: remove unused ath12k_dp_rx_h_find_link_peer()

Michael Chan (1):
      MAINTAINERS: Update Michael Chan's email for tg3

Miguel Garcia (1):
      devlink: use direct firmware requests for flash updates

Mike Rapoport (Microsoft) (2):
      USB: cxacru: replace __get_free_page() with kmalloc()
      USB: speedtch: replace __get_free_page() with kmalloc()

Mikhail Lobanov (1):
      wifi: ath11k: modify null check logic in ath11k_ce_rx_post_pipe()

Mina Almasry (10):
      net: netmem: document netmem and memory provider design in comments
      docs: netmem: document netmem and memory provider design principles
      netmem: rename __get/__put_netmem() to get/put_net_iov()
      net: skbuff: add napi_pp_get_page() and use it in tcp_recvmsg_dmabuf()
      net: skbuff: replace skb_page_unref() and __skb_frag_unref() with skb_netmem_unref()
      net: skbuff: replace __skb_frag_ref() with symmetric skb_netmem_ref()
      net: skbuff: use skb_frag_ref() in skb_try_coalesce()
      net: kunit: test netmem, page_pool, and skb frag refcounting
      netmem: rename get/put_net_iov() to net_iov_inc/dec_ref()
      netmem: rename get/put_netmem() to netmem_inc/dec_ref()

Mingming Cao (9):
      ibmveth: fix netpoll races with RX replenish
      ibmveth: do not close twice after a failed reopen
      ibmveth: disable the reset work before unregister in remove
      ibmveth: step past bad RX correlators instead of spinning or oopsing
      ibmveth: release the pool kobjects when probe fails
      ibmveth: return the error when set_channels cannot add TX queues
      ibmveth: wait for in-flight transmits in ibmveth_close()
      ibmveth: wait for the RX poll to return before freeing the RX queue
      ibmveth: check headers in the RX large send and checksum helpers

Minxi Hou (2):
      selftests/net/openvswitch: add SCTP flow key test over IPv6
      selftests/net/openvswitch: add SCTP flow key test across conntrack NAT

Miri Korenblit (30):
      wifi: nl80211: allow a NAN peer schedule with 2 channels in the same slot
      wifi: iwlwifi: mld: don't use bss_conf in NAN
      wifi: iwlwifi: Don't allocate a DRAM buffer with an invalid ID
      wifi: iwlwifi: mld: log error when missing a recovery buffer
      wifi: iwlwifi: mld: avoid leaking error recovery buffer
      wifi: iwlwifi: support net detect match info version 3
      wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 108
      wifi: iwlwifi: mvm: validate mpdu len before relying on it
      wifi: iwlwifi: support for another device ID
      wifi: iwlwifi: pcie: drop gen1_2 prefix from several functions
      wifi: iwlwifi: Revert "wifi: iwlwifi: gen1_2: move gen specific code to a function"
      wifi: iwlwifi: Revert "wifi: iwlwifi: pcie: move generation specific files to a folder"
      wifi: iwlwifi: pcie: remove iwl_dbgfs_fh_reg_read
      wifi: iwlwifi: open code iwl_trans_sync_nmi_with_addr()
      wifi: iwlwifi: move iwl_force_nmi() to where it belongs
      wifi: iwlwifi: drop the orphaned nic_access annotations
      wifi: iwlwifi: add _no_grab postfix to some functions
      wifi: iwlwifi: move pcie-only functions to pcie
      wifi: iwlwifi: avoid unnecessary indirection
      wifi: iwlwifi: rename iwl_trans_read_prph
      wifi: iwlwifi: collapse iwl_read_prph_no_grab() into the transport API
      wifi: iwlwifi: pcie: rename pcie-internal functions
      wifi: iwlwifi: rename io helpers to iwl_trans_ prefix
      wifi: iwlwifi: move iwl-io functions to iwl-trans
      wifi: iwlwifi: call generic trans API and not pcie one
      wifi: iwlwifi: trans: bring virtualization back
      wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 109
      wifi: iwlwifi: move context info APIs to a separate file
      wifi: iwlwifi: mld: don't enable RSS if there is one queue.
      wifi: iwlwifi: trans: remove the unused write8 operation

Mohsin Bashir (2):
      eth: fbnic: Make Rx completion coalescing configurable
      eth: mpnic: add register init for the device

Muhammad Bilal (1):
      wifi: mm81x: check bytes_remaining before reading delimiter

Muhammad Falak R Wani (1):
      net: mana: remove unreachable dead code in mana_bpf()

Myeonghun Pak (5):
      net: 8390: pcnet_cs: release PCMCIA window on setup_shmem_window() error
      net/qla3xxx: disable the PCI device on remove
      net: txgbe: free the fixed-rate clock on cleanup
      wifi: mt76: mt7615: restore DBDC state after ext PHY failure
      net: hix5hd2: serialize timeout recovery with interface teardown

Nagamani PV (2):
      s390/ctcm: Fix timer corruption in fsm_addtimer()
      s390/ctcm: Fix use-after-free in channel_remove()

Naman Gulati (1):
      net: gro_cells: prevent enabling threaded NAPI on gro_cells

Narcisa Vasile (3):
      selftests: drv-net: add BIG TCP test cases
      selftests: net: gro: fix OOB access when under-coalescing
      selftests: drv-net: add BIG TCP coverage to TSO test

Nathan Chancellor (1):
      wifi: brcmsmac: Adjust txpwrindex value in nphy_ipa_rxcal_gaintbl_2GHz

Nathan Gao (1):
      selftests/net: packetdrill: check rcv_ssthresh vs scaling_ratio changes

Nathan Whitehorn (2):
      net: macb: Poll for link state changes when using the internal PCS.
      net: macb: add support for 1000BASE-X autonegotiation to PCS

Naveen Mamindlapalli (1):
      octeontx2-pf: Add NIXLF error and poison interrupt handlers

Nazim Amirul (1):
      dt-bindings: net: snps,dwmac: allow stmmaceth-ocp reset name

Nerijus Bendžiūnas (1):
      wifi: ath9k: refuse spectral scan control while the hardware is disabled

Nguyen Ngoc Thang (1):
      net/rds: ib: don't enable IRQs in rds_ib_conn_free()

Nick Venenga (2):
      wifi: rtw89: 8922au: Add support for TP-Link TBE400U
      wifi: rtw89: 8922au: add ASUS BE93

Nicolai Buchwitz (10):
      net: phy: broadcom: enable jumbo frames on BCM54xx
      net: ethtool: reject an out of range hwtstamp provider index
      net: bcmgenet: complete Tx NAPI after one reclaim pass
      net: move the netdev_ops checks into a helper
      net: reject ops-locked drivers without ndo_set_rx_mode_async
      net: reject a netdev that implements only one hwtstamp NDO
      net: selftests: use skb_share_check() in the loopback receive hook
      net: stmmac: selftests: use skb_share_check() in the loopback receive hook
      net/mlx5e: use skb_share_check() in the loopback selftest hook
      net: rename skb_unshare() to skb_unclone_full()

Nicolas Escande (1):
      wifi: ath11k: fix locking problem in ath11k_dp_rx_tid_del_func()

Nikhil P. Rao (1):
      ionic: fix port_info use-after-free on firmware recovery

Niklas Söderlund (10):
      net: ethernet: ravb: Remove gPTP control from WoL setup and restore
      net: ethernet: ravb: Move programming of gPTP timer interval
      net: ethernet: ravb: Simplify gPTP start and stop
      net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
      net: ethernet: ravb: Propagate error from ptp_clock_register()
      net: ethernet: ravb: Replace gPTP flags with callbacks
      net: ethernet: ravb: Add callback for gPTP probe
      net: ethernet: ravb: Add callback for gPTP clock index
      dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
      net: ethernet: ravb: Add gPTP support for Gen4

Nikolaj Klitlund Børty (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)

Nikolay Aleksandrov (36):
      net: bridge: vlan: drop legacy memory barriers
      net: bridge: vlan: annotate lockless pvid use
      net: bridge: mst: use br_get_pvid helper
      net: bridge: vlan: annotate lockless vlan flags use
      net: bridge: vlan: annotate lockless use of private flags
      net: bridge: vlan: annotate lockless use of num_vlans
      net: bridge: vlan: annotate lockless use of msti
      net: bridge: vlan: add missing tinfo.tunnel_id annotations
      net: bridge: use br_vlan_get_state to get vlan state
      net: bridge: factor out common flood completion handling
      net: bridge: factor out port flooding
      net: bridge: vlan: cache the pvid vlan entry directly
      net: bridge: vlan: introduce a list of port-VLANs in the master VLAN
      net: bridge: consider only port-VLAN members when flooding
      net: bridge: vlan: use an RCU array for large flood sets
      net: bridge: introduce a forwarding destination structure
      net: bridge: avoid egress VLAN lookups when flooding
      net: bridge: avoid VLAN lookups for flood neighbour suppression
      net: bridge: introduce a bridge destination type
      net: bridge: use net_bridge_dst for fdb destinations
      net: bridge: add VLAN support to bridge destinations
      net: bridge: vlan: return VLAN entries from ingress helpers
      net: bridge: fdb: pass VLAN entries to learning updates
      net: bridge: fdb: consolidate port-VLAN cleanup
      net: bridge: vlan: split unpublishing from deletion
      net: bridge: vlan: quiesce readers before freeing port VLANs
      net: bridge: fdb: factor out existing entry updates
      net: bridge: fdb: cache port VLANs in learned entries
      net: bridge: fdb: cache VLAN destinations in configured entries
      net: bridge: fdb: avoid VLAN lookups in unicast forwarding
      net: bridge: rename dst to fwd in br_flood_vlan
      net: bridge: fdb: update the comment for br_fdb_cleanup_by_dst
      net: bridge: vlan: share VLAN validation in br_should_learn
      net: bridge: vlan: inline pvid pointer updates
      net: bridge: fdb: factor out configured entry destination updates
      net: bridge: fdb: use the entry key in __fdb_update

Oleg Zadorozhnyi (1):
      dt-bindings: dpll: allow hex unit addresses on output pins

Oleksij Rempel (6):
      dt-bindings: net: dsa: realtek: add RTL8365MB power supplies
      net: dsa: realtek: rtl83xx: use dev_err_cast_probe() for reset GPIO
      net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access
      net: dsa: realtek: rtl8365mb: extract PHY OCP address halves with FIELD_GET
      net: dsa: realtek: rtl8365mb: add EEE support
      net: phy: realtek: add MDI-X support for RTL8365MB-VC

Omar Ramadan (2):
      amt: pull the AMT header behind the transport header in amt_parse_type()
      amt: mark relay data as a UDP tunnel packet before sending it

Or Har-Toov (2):
      net/mlx5: Add cap_tx_speed and effective_tx_speed support to IFC
      net/mlx5: Remove max_external_SFs device resource

Oskari Lemmela (1):
      dt-bindings: net: realtek: add RTL8224 package binding

Ovidiu Panait (5):
      selftests: drv-net: Move _set_ethtool_feat() into lib
      selftests: drv-net: Check the features set by set_ethtool_feat()
      selftests: drv-net: Add VLAN test
      net: stmmac: Track the TX DMA threshold per queue
      net: stmmac: Report the TX DMA threshold per queue

Pablo Neira Ayuso (8):
      netfilter: x_tables: use GFP_KERNEL_ACCOUNT in match/target
      netfilter: nfnetlink: use GFP_KERNEL_ACCOUNT
      netfilter: nf_tables: use GFP_KERNEL_ACCOUNT
      netfilter: synproxy: use GFP_KERNEL_ACCOUNT
      netfilter: sysctl: use GFP_KERNEL_ACCOUNT
      netfilter: nat: use GFP_KERNEL_ACCOUNT
      netfilter: conncount: use GFP_KERNEL_ACCOUNT
      netfilter: nft_set_rbtree: narrow down range completion to anonymous sets

Pagadala Yesu Anjaneyulu (13):
      wifi: nl80211: defer AP beacon regulatory check to start_ap
      wifi: nl80211: reject color-change requests that change 6 GHz power type
      wifi: iwlwifi: fw: add Google-ASUS TAS approved DMI match
      wifi: iwlwifi: mvm: validate NVM read response length
      wifi: iwlwifi: fw: reject empty UEFI DSM query bitmap
      wifi: iwlwifi: fw: fix dbg dest TLV size check by version
      wifi: iwlwifi: mvm: debugfs: validate TAS response and loop bounds
      wifi: iwlwifi: mvm: fix LARI_CONFIG_EXTENSION version check
      wifi: iwlwifi: add standalone WRSS/EWSS BIOS table loading
      wifi: iwlwifi: send standalone SAR to firmware
      wifi: iwlwifi: uefi: Fix SAR enable check to use mode parameter correctly
      wifi: iwlwifi: fw: harden UEFI reduced-power TLV parsing
      wifi: iwlwifi: fw: add Samsung to TAS and PPAG allow lists

Paolo Abeni (40):
      Merge branch 'netlink-specs-rt-link-ipv6-devconf-updates'
      Merge branch 'net-stmmac-dwmac4-auto-discover-uc-filter-size'
      Merge branch 'net-make-sure-clk_init_data-is-fully-initialized'
      Merge branch 'netlink-specs-fou-spec-tweaks'
      Merge branch 'net-sysfs-use-ops-lock-for-speed-and-duplex'
      Merge branch 'net-stmmac-add-common-rgmii-delay-handling-and-dp1000-support'
      Merge branch 'net-enetc-sr-iov-improvements-and-enetc-v4-vf-support'
      Merge branch 'ip_tunnel-support-per-netns-device-unregistration'
      Merge branch 'net-sched-complete-action-notification-accounting'
      Merge branch 'net-dsa-realtek-eee-support-for-rtl8365mb-vc'
      Merge branch 'net-dsa-mv88e6xxx-ethtool-n-tuple-follow-ups'
      Merge branch 'eth-mpnic-initial-support-for-meta-platforms-nic'
      Merge branch 'netlink-specs-enum-alignment-fixes'
      Merge branch 'net-consolidate-devmem-net_iov-freelist-and-dma-handling'
      Merge branch 'net-move-the-type-2-sockets-out-of-tree'
      Merge branch 'tcp-annotate-lockless-access-to-sk-sk_err'
      Merge branch 'net-axienet-allow-instantiation-without-a-device-tree'
      Merge branch 'net-stmmac-introduce-hw-queue-priority-offload'
      Merge branch 'report-netns-cookie-in-fib-lookup-tracepoints'
      Merge branch 'tcp-fix-a-few-divide-by-zero-in-congestion-control-modules'
      Merge branch 'net-re-segment-oversized-tcp-gso-skbs'
      Merge branch 'net-sparx5-add-tas-offload'
      Merge branch 'rxrpc-miscellaneous-fixes'
      Merge branch 'net-mlx5-less-memory-per-offloaded-tc-rule'
      Merge branch 'bnxt_en-fix-sw-uso-padding'
      mptcp: fix subflow bitfield misuse
      Merge branch 'stmmac-some-xdp-fixes-in-xdp_tx-path'
      Merge branch 'net-macb-implement-context-swapping'
      Merge branch 'mptcp-misc-improvements-for-v7-4'
      Merge branch 'net-unify-symmetric-netmem-and-page_pool-refcounting'
      Merge branch 'net-mlx5-hws-fix-pool-creation-races'
      Merge branch 'net-pcs-rzn1-miic-validate-dtb-configuration-values'
      Merge branch 'support-unaligned-rtl8224-phy-packages'
      Merge branch 'eth-mpnic-add-basic-netdev-statistics'
      Merge branch 'rtnetlink-dump-link-layer-multicast-addresses'
      Merge branch 'gtp-ynl-spec-for-the-gtp-netlink-family-two-fixes-and-a-selftest'
      Merge branch 'vsock-so_inq-for-stream-sockets'
      Merge branch 'net-mlx5-hws-fix-modify-header-pattern-compare'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Bluetooth: btusb: disable by default Qualcomm multi-subsystem

Pardeep Kaur (2):
      wifi: ath12k: fix out-of-bounds access on TX stats arrays
      wifi: ath12k: fix 1-based ring index in REO Rx Received debugfs output

Patryk Biel (1):
      net: pcs: lynx: enable autonegotiation for 10g-qxgmii and usxgmii

Pauli Virtanen (22):
      Bluetooth: hci_core: add lockdep check to hci_conn lookups
      Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
      Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock
      Bluetooth: enable context analysis for headers
      Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
      Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
      Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
      Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
      Bluetooth: L2CAP: remove unused l2cap_chan_close()
      Bluetooth: 6lowpan: avoid concurrent peer_del() in bt_6lowpan_disconnect
      Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer
      Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
      Bluetooth: L2CAP: add annotations for l2cap_chan list locking
      Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
      Bluetooth: L2CAP: make concurrent l2cap_set_timer() refcounting safe
      Bluetooth: L2CAP: remove conditional locking from l2cap_connect()
      Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred_rsp_defer
      Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
      Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
      Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
      Bluetooth: hci_sync: fix mesh adv timeout units
      Bluetooth: make hdev->adv_instance_timeout a boolean

Pavankumar Nandeshwar (1):
      wifi: ath12k: Increase RXDMA buffer ring size for default memory profile

Peng Fan (6):
      net: use assign_bit() where applicable
      wifi: mac80211: use assign_bit() where applicable
      net: protocol: use assign_bit() where applicable
      batman-adv: use assign_bit() where applicable
      net: dsa: use regmap_assign_bits() for conditional set/clear
      Bluetooth: use assign_bit() where applicable

Pengfei Zhang (2):
      net: stmmac: fix RX coalesce frames counter
      net: stmmac: xgmac: do not treat TBU as a TX event

Pengpeng Hou (9):
      net: fbnic: validate mailbox TLV extents
      wifi: libertas_tf: validate firmware block extents
      wifi: libertas: validate firmware block extents
      net: alacritech: publish the PCI module aliases
      net: xscale: publish the IXP46x PTP OF module alias
      net: hip04: use 16-bit byte order for HI13X1 TX fields
      net: dsa: mv88e6060: publish the OF module alias
      wifi: brcmfmac: bound NVRAM comment parsing
      wifi: mt76: mt7615: validate MCU response lengths

Peter Hunt (2):
      net: wwan: core: propagate modem control signals to port drivers
      net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

Phil Sutter (3):
      netfilter: conntrack: Untangle insert_failed counter from others
      netfilter: conntrack: Untangle drop and invalid counters
      netfilter: nfnetlink: Fix for interrupted hook dumps

Ping-Ke Shih (18):
      wifi: rtw89: 8922d: set BB wrapper settings according to operating channel
      wifi: rtw89: 8922d: move conditionally disabled TX shape to common flow
      wifi: rtw89: 8922d: update BB wrapper RFSI ctrl to v5
      wifi: rtw89: 8922d: send RFE type to firmware
      wifi: rtw89: 8922d: bypass RX IQK when scan
      wifi: rtw89: 8922d: correct selection of CCK rate circuit
      wifi: rtw89: consider sta maximum AMSDU subframes number to decide TX work waiting
      wifi: rtw89: mac: change beamformee CSI direct forward to CMAC_TXDMA
      wifi: rtw89: fw: extend ch_info format of hw_scan to v2
      wifi: rtw89: 8851b: rfk: set DCK start and delay time
      wifi: rtw89: 8852b: update default value for ANA SWR
      wifi: rtw89: correct dependency of the multicolor LED
      wifi: rtw89: fw: duplicate recognized firmware elements
      wifi: rtw89: fw: release firmware after recognizing firmware elements
      wifi: rtw89: fw: duplicate firmware suit data by vmalloc to reduce memory fragment
      wifi: rtw88: TX report with long timeout for non-PCIE devices
      wifi: rtw89: remove discouraged imply from Kconfig LED
      wifi: rtw89: 8922d: update supported firmware format to 1

Piotr Kubik (1):
      netfilter: ctnetlink: fix inverted IPv6 address match in dump filter

Po-Hao Huang (4):
      wifi: rtw89: add p2p device declaration
      wifi: rtw89: mlo: update link id to FW upon connection
      Revert "wifi: rtw89: fix unable to receive probe responses under MLO connection"
      wifi: rtw89: modify active scan rule for 6GHz band

Prasenjit Mukherjee (1):
      selftests: net: fix race condition in icmp.sh causing CKI sporadic failures

Przemek Kitszel (7):
      ice: simplify ice_vc_dis_qs_msg() a little
      ice: skip stats handling for channel VSIs on rebuild
      ice: extract __ice_vsi_free_stats()
      ice: extract ice_vsi_new_stat_arrays()
      ice: extract ice_vsi_get_num_qs()
      ice: rebuild ring stats arrays instead of reallocating them in place
      ice: size ring stats arrays from the final queue count

Przemyslaw Korba (1):
      ice: add rx timestamp tracepoint for debugging

Pu Lehui (1):
      e1000e: Fix out-of-bounds MMIO access by validating BAR0 size

Qingfang Deng (4):
      ppp_synctty: remove redundant skb null check in ppp_sync_txmunge()
      net/sched: act_ct: set net pointer before publishing flowtable
      netfilter: flowtable: check namespace before iterating flows
      pppoe: delete session hash entries by pointer match

Qingshuang Fu (1):
      selftests: net: fou_mcast_encap: load the fou module

Quanye Yang (5):
      mptcp: split FASTCLOSE key from rcvr_key
      mptcp: shrink struct mptcp_options_received
      tcp: annotate lockless access to sk->sk_err
      mptcp: annotate lockless access to sk->sk_err
      mptcp: reset msk state on early connect failure

Quentin Strydom (1):
      Bluetooth: btusb: add ASUS 0b05:1868 to QCA Rome quirks

Radek Podgorny (1):
      Bluetooth: forget a peer's RPA once it advertises its identity address

Rahul Kumar Rai (1):
      wifi: rtw88: disable ASPM and deep PS on ASUS TUF Gaming A15 FA506IH

Raj Ojha (1):
      wifi: mac80211: acquire wiphy lock for unlisted sdata teardown

Ralf Lici (1):
      ovpn: remove unused work field from struct ovpn_socket

Rameshkumar Sundaram (2):
      mailmap: add entries for Rameshkumar Sundaram
      wifi: ath12k: fix DMA unwind for ext MSDU descriptor retry

Rand Deeb (1):
      sfc: fix NULL pointer dereference in efx_tc_flower_replace_foreign()

Randy Dunlap (3):
      docs: ABI: OCP TimeCard: use literal blocks for commands
      net: natsemi: xtsonic: make probe function static
      net: dccp: uapi: clean up kernel-doc comments

Ratheesh Kannoth (1):
      octeontx2: collapse consecutive blank lines in source files

Ravindra (3):
      Bluetooth: btintel: read ROM debug registers on FW download failure
      Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
      Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write

Ricardo B. Marlière (SUSE) (1):
      selftests/net: Fix flaky bind_wildcard due to ephemeral port race

Richard Nunley (1):
      Bluetooth: btusb: Add Realtek RTL8821CE device 13d3:3558

Rishikesh Jethwani (1):
      tls: device: protect async RX resync state during device-down

Rob Herring (Arm) (5):
      dt-bindings: net: Document Marvell PHY "marvell,reg-init"
      dt-bindings: net: Convert hisilicon,hns-nic to DT schema
      dt-bindings: net: Convert hisilicon,hns-mdio to DT schema
      dt-bindings: net: Convert HiSilicon hns-dsaf to DT schema
      dt-bindings: net: ethernet-controller: Allow "ethernet-N" node names

Rokas Juras (1):
      rndis_host: enable RX aggregation for OnePlus Nord CE 2

Rory Little (1):
      wifi: cfg80211: validate monitor channel set against radio usage

Rosen Penev (12):
      wifi: mwifiex: Use flexible array for RX reorder table
      wifi: b43legacy: Use flexible array for DMA metadata
      net: ll_temac: Return actual error from of_get_mac_address()
      wifi: rt2x00: Use device-managed register buffers
      wifi: ath9k: delete channel-context timers on deinit
      net: ag71xx: Use default NAPI weight
      net: ibm: emac: size RX buffers for the MTU
      net: emac: mal: replace devm_request_irq with request_irq to fix probe error race
      net: bgmac: enable interrupts only after NAPI is ready
      net: ag71xx: align the IP header behind DSA tags
      net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
      net: bgmac: rate limit RX error messages

Rouven Czerwinski (1):
      net: phy: mxl-gpy: add 2.5G for MXL86211C

Ruide Cao (3):
      wifi: mac80211: start next ROC after purging an interface
      mptcp: hold MP_JOIN msk ref when cloning reqsk
      mptcp: fix MP_CAPABLE token migration when cloning reqsk

Ruizhe Zhou (14):
      net: atlantic: Remove obsolete 32-bit DMA mask fallback
      net: alx: Remove obsolete 32-bit DMA mask fallback
      net: systemport: Remove obsolete 32-bit DMA mask fallback
      bnxt_en: Remove obsolete 32-bit DMA mask fallback
      enic: Remove obsolete 32-bit DMA mask fallback
      net: hns3: Remove obsolete 32-bit DMA mask fallback
      fm10k: Remove obsolete 32-bit DMA mask fallback
      net/mlx4: Remove obsolete 32-bit DMA mask fallback
      net/mlx5: Remove obsolete 32-bit DMA mask fallback
      mlxsw: pci: Remove obsolete 32-bit DMA mask fallback
      eth: fbnic: Remove obsolete 32-bit DMA mask fallback
      net: pch_gbe: Remove obsolete 32-bit DMA mask fallback
      net: renesas: rswitch: Remove obsolete 32-bit DMA mask fallback
      net: niu: Remove obsolete 32-bit DMA mask fallback

Ryan Leung (5):
      wifi: mt76: mt7915: publish wcid before MCU add commands
      wifi: mt76: fix unlocked wcid check in mt76_tx_status_skb_add()
      wifi: mt76: fix wcid teardown ordering in mt76_reset_device()
      wifi: mt76: mt7915: fix thermal zone use-after-free
      wifi: mt76: fix wcid->pktid corruption in mt76_wcid_cleanup()

Ryohei Hashimoto (1):
      wifi: brcmfmac: log the firmware status when a connect fails

Sabrina Dubroca (5):
      net: strparser: remove unused abort_parser/lock/unlock callbacks
      net: strparser: remove strp->sk NULL checks
      net: strparser: remove strp_process()
      net: strparser: removed the aborted bit and aborts counter
      docs: networking: strparser: remove general mode

Sagar Taunk (1):
      rust: net: netlink: Migrate to zerocopy's IntoBytes

Sagi Maimon (9):
      ptp: ocp: unregister devlink before detach on probe error
      ptp: ocp: fix dpll cleanup on probe error
      ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
      ptp: ocp: add TAP CPLD flashing via devlink
      net: axienet: use device_property and fwnode APIs for probe-time config
      net: axienet: add a MODULE_ALIAS for platform instantiation
      net: axienet: do not report TX completions as NAPI work
      net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
      net: axienet: release every RX buffer in axienet_dma_bd_release()

Sai Teja Aluvala (3):
      Bluetooth: btintel_pcie: Add support for Intel Draco
      Bluetooth: btintel_pcie: Add support for Intel Draco
      Bluetooth: Add support for Intel DRACO

Samuel Alhovuori (1):
      Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)

Samuele Yang (1):
      wifi: mm81x: start beaconing on beacon enable not interface add

Sander Vanheule (2):
      dt-bindings: net: pse-pd: realtek,pse: add gen1 I2C transport
      net: pse-pd: realtek-pse-mcu: add gen1 I2C transport

Sang-Heon Jeon (1):
      octeon_ep: remove redundant memset in octep_setup_pfvf_mbox()

Sang-Hoon Choi (4):
      hinic3: handle auxiliary device ID allocation failure
      mlxsw: spectrum_router: destroy FIB hash table on bind failure
      nfp: flower: remove merge entry when conntrack offload fails
      sfc: handle rhashtable walk errors in mport lookup

Sasha Levin (1):
      r8169: clear TX LPI on RTL8168h at link up after phylink conversion

Sebastian Andrzej Siewior (1):
      net: Replace %pK output with 0

Sebastian Reichel (1):
      wifi: brcmfmac: Improve D3 substate entering timeout handling

Seongjun Hong (1):
      net/mlx5: allocate DMA pool structs on the pool's NUMA node

Sergey Lebedev (1):
      Bluetooth: btintel_pcie: verify and serialize D-state transitions

Sergey Shtylyov (3):
      r8152: simplify loops in generic_ocp_{read,write}()
      ch9200: return error on failed register writes in ch9200_bind()
      ch9200: do return USB errors from control_write()

Seung Min Shin (1):
      sctp: hold transport reference across connect wait

Shahar Tzarfati (7):
      wifi: iwlwifi: fw: fix integer overflow in INI dump size calc
      wifi: iwlwifi: validate TLV length before reading fields
      wifi: iwlwifi: uefi: add UEFI GUID Lock Indicator (GLUI) definitions
      wifi: iwlwifi: uefi: add a way to probe connectivity UEFI variables
      wifi: iwlwifi: regulatory: use GLUI as root-of-trust for connectivity variables
      wifi: iwlwifi: mvm: validate BAID from FW
      wifi: iwlwifi: disable HE ER mode

Shaojie Sun (1):
      netfilter: conntrack: fix nf_conntrack_expect_max default value in documentation

Shay Drory (14):
      net/mlx5e: Assign a random MAC to any netdev with a zero MAC address
      net/mlx5: E-switch, do not leave an unpaired devcom registered
      net/mlx5: LAG, allocate v2p_map dynamically
      net/mlx5: LAG, allocate port-indexed scratch buffers dynamically
      net/mlx5: LAG, drop per-port scratch array in drop-rule setup
      net/mlx5: LAG, size debugfs buffers by port count
      net/mlx5e: TC, anchor peer-flow reverse index on the duplicated flow
      net/mlx5e: TC, track peer flows in a vhca_id xarray
      net/mlx5: E-switch, derive manager vport from device capability
      net/mlx5: LAG, don't print port mapping to debugfs in MPESW mode
      net/mlx5: LAG, drop stale esw_shared_ingress_acl gate from shared FDB
      net/mlx5: E-switch, correct stale VF/PF wording in esw-allowed comments
      net/mlx5: E-switch, disable host functions for a non PF e-switch manager
      net/mlx5: IFC, Add capability bits for virtual LAG

Shuai Zhang (1):
      Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping

Shuangfeng He (1):
      netfilter: flowtable: use the vlan id, not the full tci, in the tuple key

Shubham Antil (1):
      RDS/IB: validate receive fragment completions

Siddharth Vadapalli (33):
      can: bxcan: Remove comma after sentinel-entry in match-table
      can: c_can: Remove comma after sentinel-entry in match-table
      can: flexcan: Remove comma after sentinel-entry in match-table
      can: ifi_canfd: Remove comma after sentinel-entry in match-table
      can: m_can: Remove comma after sentinel-entry in match-table
      can: sja1000: f81601: Remove comma after sentinel-entry in match-table
      can: sja1000_platform: Remove comma after sentinel-entry in match-table
      net: dsa: b53: mdio: Remove comma after sentinel-entry in match-table
      net: dsa: b53: srab: Remove comma after sentinel-entry in match-table
      net: dsa: bcm_sf2: Remove comma after sentinel-entry in match-table
      net: dsa: hellcreek: Remove comma after sentinel-entry in match-table
      net: dsa: lan9303: i2c: Remove comma after sentinel-entry in match-table
      net: dsa: lan9303: mdio: Remove comma after sentinel-entry in match-table
      net: dsa: mxl-gsw1xx: Remove comma after sentinel-entry in match-table
      net: dsa: mt7530: mdio: Remove comma after sentinel-entry in match-table
      net: dsa: mt7530: mmio: Remove comma after sentinel-entry in match-table
      net: dsa: mv88e6060: Remove comma after sentinel-entry in match-table
      net: dsa: mv88e6xxx: Remove comma after sentinel-entry in match-table
      net: dsa: qca8k: Remove comma after sentinel-entry in match-table
      net: dsa: realtek: rtl8365mb: Remove comma after sentinel-entry in match-table
      net: dsa: realtek: rtl8366rb: Remove comma after sentinel-entry in match-table
      net: dsa: rzn1_a5psw: Remove comma after sentinel-entry in match-table
      net: dsa: sja1105: Remove comma after sentinel-entry in match-table
      net: bcmasp: Remove comma after sentinel-entry in match-table
      net: spacemit: k1_emac: Remove comma after sentinel-entry in match-table
      net: ti: am65-cpsw-nuss: Remove comma after sentinel-entry in match-table
      net: ethernet: ti: cpsw: Remove comma after sentinel-entry in match-table
      net: ethernet: ti: cpsw_new: Remove comma after sentinel-entry in match-table
      net: mdio: bcm-iproc: Remove comma after sentinel-entry in match-table
      net: mdio: bcm-unimac: Remove comma after sentinel-entry in match-table
      net: pcs: xpcs-plat: Remove comma after sentinel-entry in match-table
      net: phy: nxp-c45-tja11xx: Remove comma after sentinel-entry in match-table
      net: wan: slic_ds26522: Remove comma after sentinel-entry in match-table

Siwei Zhang (6):
      Bluetooth: L2CAP: Reject mode changes on connected channels
      Bluetooth: L2CAP: Reject signalling responses in invalid states
      Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests
      Bluetooth: L2CAP: Use default TxWindow for zero socket option
      Bluetooth: L2CAP: Only accept connection responses to outstanding requests
      Bluetooth: L2CAP: Remove dead configuration state code

Slavin Liu (1):
      wifi: mt76: mt7996: guard station-only MLO TX handling

Sorah Fukumori (1):
      net: gro: don't chain linear parts larger than gso_size into frag_list

Sriram R (1):
      mailmap: add entries for Sriram R

Stanislav Fomichev (7):
      net: devmem: replace gen_pool with freelist
      net: devmem: embed net_iov_area in binding
      net: devmem: batch net_iov allocations into the page_pool cache
      net: netmem: move to index based freelist
      net: devmem: use memory provider helpers for net_iovs
      net: devmem: decode DMA addresses for TX
      net: devmem: remove net_iov_area base_virtual

Stanislaw Gruszka (4):
      wifi: mac80211: queue frames while off-channel
      wifi: iwlegacy: set debug level using debugfs
      wifi: iwlegacy: 4965: remove custom sysfs files
      wifi: iwlegacy: 3945: remove custom sysfs files

Stefano Munari (1):
      net: usb: lan78xx: reject invalid EEPROM write requests

Stefano Radaelli (2):
      net: phy: micrel: Check RMII clock select property presence
      dt-bindings: net: micrel: Fix RMII clock select property type

Stella Liu (13):
      wifi: mt76: mt7925: fix NAN NDP STA record role index
      wifi: mt76: mt7925: fix NAN start failure
      wifi: mt76: mt7925: fix NAN committed CRB timeline layout
      wifi: mt76: mt7925: report only 2.4 GHz NAN supported band
      wifi: mt76: mt7925: drop unused NAN 2.4/5 GHz support config
      wifi: mt76: mt7925: drop deferred NAN local schedule update handling
      wifi: mt76: mt7925: use OFDM-only PHY mode for NAN STA records
      wifi: mt76: mt7925: share TLV setup for NAN enable command
      wifi: mt76: mt7925: replace NAN DW end event with DW start
      wifi: mt76: mt7925: fill all DW intervals in NAN avail_map
      wifi: mt76: mt7925: clear CRB before deactivating NAN peer record
      wifi: mt76: mt7925: add ULW event handling and peer ULW update
      wifi: mt76: mt7925: configure NAN PHY setting on enable

Steve Grubb (1):
      net: preserve socketpair output on setup failure

Subbaraya Sundeep (1):
      octeontx2-af: nix: Log TX scheduler queue validation failures

Sung Byeongchan (1):
      netfilter: xt_dccp: handle reserved options as single-byte

Sunny Tiwari (1):
      net/rds: replace tasklets with workqueue

Sven Eckelmann (38):
      batman-adv: dat: fix printing of unknown 4addr subtype
      batman-adv: drop direction in _batadv_is_ap_isolated kernel-doc
      batman-adv: bat_v: fix bonding candidate selection
      batman-adv: clarify cut-off in batadv_v_neigh_is_sob kernel-doc
      batman-adv: use more descriptive var names for is_similar_or_better
      batman-adv: ensure u16 aligned mac address arrays on stack
      batman-adv: ensure u16 aligned mac address in structs
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: extract code handling a roam on add
      batman-adv: tt: simplify NEW flag transition code
      batman-adv: tt: drop unnecessary cleanup goto in helpers
      batman-adv: tt: use protected flag modifications
      batman-adv: tt: transition NEW local entries only under lock
      batman-adv: tt: don't uncount never committed clients on pending purge
      batman-adv: tt: look up wifi state of incoming interface in helper
      batman-adv: tt: extract allocation of new local entries
      batman-adv: tt: replace forward gotos in batadv_tt_local_add()
      batman-adv: tt: extract refresh of existing local entries
      batman-adv: tt: decrement count for committed client on local_remove
      batman-adv: tt: extract update of dynamic client flags
      batman-adv: tt: extract allocation of new global entries
      batman-adv: tt: extract merging of flags into existing global entries
      batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
      batman-adv: tt: extract removal of the superseded local entry
      batman-adv: tt: extract marking of a removed local entry
      batman-adv: tt: extract immediate purge of a local entry
      batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()
      batman-adv: tt: clarify kernel doc for batadv_tt_local_set_pending_event()
      batman-adv: bat_iv: fix ogm_neigh_is_sob parameters references
      batman-adv: bla: avoid double free after failed backbone_hash alloc
      batman-adv: correct batadv_hash_remove kdoc return type
      batman-adv: tt: clarify kernel-doc for batadv_tt_global_purge_local
      batman-adv: tt: clarify responsibility for roam flag during removal
      batman-adv: tt: soften kernel-doc for batadv_tt_local_remove_now()
      batman-adv: tt: only queue local del event after successful unlink
      batman-adv: tt: queue local DEL event under bucket lock
      batman-adv: tt: queue local DEL event before marking entry as pending
      batman-adv: tt: reject VLAN/TT entries before reaching size limit

Tapio Reijonen (1):
      net: dsa: microchip: enable the SGMII port of the KSZ9897S

Taylor Bates (1):
      netlink: specs: fix duplicate if/then keys in netlink-raw schema

Theodor Arsenij Larionov Trichkine (1):
      net: use the full socket in sk_mc_loop()

Thierry Reding (1):
      dt-bindings: net: nvidia,tegra234-mgbe: Add missing properties

Thomas Fourier (4):
      net: ethernet: i825xx: Fix dma_alloc_coherent() size
      net: alacritech: fix dma_free_coherent() in error path
      drivers: net: xgene: Fix dma_unmap_single() size
      net: ethernet: mtk_wed: Fix dma_unmap_single() size

Thomas Huth (1):
      Bluetooth: SMP: Zeroize raw key data on the stack in smp_e()

Thorsten Blum (1):
      net: dsa: realtek: Remove unused buffer from struct realtek_priv

Théo Lebrun (14):
      net: macb: never give hardware a NULL RX buffer
      net: macb: propagate RX ring refill errors
      net: macb: quiesce IRQs and drain BH on interface close
      net: macb: init workqueues before register_netdev()
      net: macb: move printk() calls out of bp->lock critical section
      net: macb: close race between NAPI polls & ndo_stop
      net: macb: introduce macb_context struct for buffer management
      net: macb: avoid macb_init_rx_buffer_size() modifying state
      net: macb: make `struct macb` subset reachable from macb_context struct
      net: macb: change caps helpers signatures
      net: macb: change function signatures to take contexts
      net: macb: introduce macb_context_alloc() helper
      net: macb: use context swapping in .set_ringparam()
      net: macb: use context swapping in .ndo_change_mtu()

Tianchu Chen (3):
      wifi: mwifiex: bound SDIO fw dump count by memory table size
      wifi: cw1200: fix link_id_db OOB access via device-controlled link ID
      wifi: libertas: fix RX OOB access from device-controlled pkt_ptr

Tianyi Gao (3):
      selftests: net: veth: test own ndo-xmit after peer GRO toggle while down
      veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled
      selftests: net: veth: test XDP_TX to a peer with GRO enabled

Til Kaiser (1):
      mlxsw: Initialize register query payloads

Tim Fuechsel (1):
      tcp: Add TCP ROCCET congestion control module.

Timur Stukan (1):
      bonding: 3ad: remove unused TX state

Tony Nguyen (1):
      ice: rename shared Flow Director functions and structs

Travis Howard (1):
      tg3: Add Datto SIRIS 5 1U Server to restart AER quirk table

Tristan Madani (2):
      net: reduce XMIT_RECURSION_LIMIT under KASAN
      wifi: rtw89: fix IE length passed to cfg80211_find_ie() in WoW AKM

Tzung-Bi Shih (1):
      Bluetooth: btmtksdio: Fix spurious ownership error logs

Umang Pokhriyal (1):
      tap: report IFF_DETACH_QUEUE in TUNGETIFF

Vaibhav Nagare (1):
      bnxt_en: don't leave an XDP program installed when the open fails

Vasanthakumar Thiagarajan (1):
      mailmap: update email address for Vasanthakumar Thiagarajan

Victor Nogueira (5):
      net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
      net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size
      net/sched: add get_fill_size() to the five actions that lack one
      net/sched: act_api: budget TCA_ROOT_EXT_WARN_MSG in notify skbs
      selftests: tc-testing: keep IPv6 autoconf out of exact-counter checks

Vikas Gupta (2):
      bnge: update HSI
      bnge: skip dev_addr when building the VNIC unicast list

Vincent Jardin (6):
      net: pcs: lynx: add support for 25GBASE-R
      dpaa2-eth: use the DPMAC id as the devlink physical port number
      dpaa2-eth: mark DPNIs without a DPMAC as virtual devlink ports
      dpaa2-ptp: fix support for PTP_EXTTS_REQUEST2 ioctl
      net: enetc: fix support for PTP_EXTTS_REQUEST2 ioctl
      ptp: qoriq: fix support for PTP_EXTTS_REQUEST2 ioctl

Vineeth Karumanchi (1):
      net: macb: configure ENST registers for all queues

Vinícius Ramon Fontanela (1):
      wifi: brcmfmac: allow ISO3166 fallback for BCM4350

Vitaliy Sochnev (1):
      net: airoha: grow the small RX rings

Vitor Soares (1):
      wifi: ath12k: advertise interface MAC address pool

Vladimir V. Kondratyev (1):
      Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

Wang Zhan (9):
      net: sysfs: factor out link settings read
      net: sysfs: use ops lock for speed and duplex
      openvswitch: raise internal port TSO limit
      net: core: use the packet's L3 protocol for the GSO size limit
      net: core: factor out the GSO device limit check
      net: gso: support re-segmentation of TCP GSO skbs
      net: gso: clear the GSO state of the last output segment
      net: core: re-segment oversized TCP GSO skbs
      net: net_test: add tests for TCP re-segmentation

Wei Fang (14):
      net: enetc: move msg_task and msg_int_name to struct enetc_si
      net: enetc: add link status message support to PF driver
      net: enetc: add link speed message support to PF driver
      net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
      net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
      net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
      net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
      net: enetc: add MAC address filtering support for VFs of ENETC v4
      net: enetc: simplify and rename PSIIER enable/disable helpers
      net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
      net: enetc: add VF support for i.MX94 and i.MX95
      net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
      net: enetc: add PSI-to-VSI link status notification support for VF
      net: enetc: add ndo_get_vf_config() support

Weimin Xiong (1):
      ice: parser: use kcalloc for table allocation

Weiming Shi (1):
      virtio_net: atomically disable rx mode work

Weiting Lee (1):
      net: phy: air_en8811h: select LED GPIO pins based on AN8811HB package variant

Wentao Liang (3):
      net: stmmac: dwmac-sun8i: Fix EPHY clock leak in get_ephy_nodes()
      net: dsa: vitesse-vsc73xx: Fix SPI device reference leak in vsc73xx_spi_probe()
      wifi: mt76: Fix of_node reference leak in mt76_get_rate_power_limits()

Willem de Bruijn (11):
      selftests: net: csum: filter packets by source address and port
      net: rtnetlink: add pacing_offload attribute to net_device
      net_sched: sch_fq: check device pacing offload
      net_sched: sch_fq: clear past skb->tstamp if offloading pacing
      idpf: support pacing offload
      selftests: drv-net: refactor so_txtime errqueue handling
      selftests: drv-net: in so_txtime tell apart sw from hw pacing
      selftests: drv-net: extend so_txtime with hw offload
      net: downgrade BUG_ON EIOCBQUEUED in sock_sendmsg_nosec
      net/packet: ignore timestamp bits when testing tx frame status
      virtio-net: fix frag overflow in big packets receive

Xinsheng Zhu (4):
      net: usb: ax88172a: improve MAC address read error handling
      net: usb: asix: remove redundant PHY address short-read check
      net: usb: r8153_ecm: reject short register reads
      net: usb: sierra_net: reject short firmware attribute reads

Xuanqiang Luo (8):
      net: phy: split phy_probe() error paths
      net: phy: unregister SFP upstream before port cleanup
      net: phy: set PHY_READY after LED setup
      net: phy: call driver remove when core initialization fails
      net: phy: propagate errors from default port setup
      net: phy: avoid double-free after LED trigger registration failure
      ipv6: make IPV6_FREEBIND and IPV6_TRANSPARENT setsockopt lockless
      net: gro_cells: add drop reasons to gro_cells_receive()

Xuhua Zhang (3):
      Bluetooth: hci_bcsp: Use the shared CRC-CCITT byte helper
      Bluetooth: hci_h5: Avoid clearing the escape bit for ordinary bytes
      Bluetooth: hci_ll: Sleep while waiting for the controller to power up

Yevgeny Kliteynik (6):
      net/mlx5: HWS, Return meaningful error code in hws_send_wqe_fw
      net/mlx5: HWS, Fix error message in mlx5hws_cmd_generate_wqe
      net/mlx5: HWS, Replace kzalloc with kzalloc_obj
      net/mlx5: HWS, Add timeout mechanism to draining send queues
      net/mlx5: HWS, Handle timeout draining the send queue for FW STEs
      net/mlx5: HWS, Remove unneeded WRITE_ONCE in post send

Yi Cong (2):
      wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth backup fields
      wifi: mt76: mt792x: fix negative errno truncation in offload capability

Yibo Tan (1):
      ptp: idt82p33: Stop PTP work producers before teardown

Yingjie Wang (1):
      net: unix: reject negative max_dgram_qlen values

Yongzhao Chen (5):
      net: dsa: qca8k: propagate MDIO errors
      net: dsa: qca8k: do not clear MASTER_EN after a failed page select
      net: dsa: qca8k: fail mgmt Ethernet MDIO access on busy wait errors
      net: phy: qcom: at803x: Apply IPQ5018 analog settings at probe
      net: phy: qca83xx: read resolved QCA8337 link status

YuChia-Kan (1):
      wifi: rtw88: use firmware MAC address as fallback

Yuhang Zheng (1):
      net/sched: cls_flower: avoid stale mask references after delete

Yun Zhou (1):
      net: erspan: set lltx to avoid sch_direct_xmit deadlock

Yunpeng Tian (1):
      tipc: bound the device MTU accepted for L2 bearers

Yury Norov (4):
      ice: simplify ice_pf_state_is_nominal()
      ice: drop pf == NULL check in ice_pf_state_is_nominal()
      wifi: mm81x: switch to use fns()
      wifi: mm81x: use hweight16() to calculate bit index

Yuya Kusakabe (2):
      seg6: reallocate the skb head on L2 encapsulation only when needed
      seg6: fix HMAC validation when an extension header precedes the SRH

Yuyang Huang (6):
      netlink: specs: rt-addr: fix the type of target-netnsid
      net: change netdev_hw_addr_list count through helpers
      net: add a generation counter for dev->mc changes
      net: add AF_PACKET multicast dumps
      netlink: specs: rt-addr: document AF_PACKET multicast dumps
      selftests: net: test AF_PACKET multicast dumps

Zack Gomez (1):
      netpoll: bound the deferred transmit queue

Zhang Yunfei (2):
      net: ngbe: propagate resume errors to the PM core
      net: ngbe: clear DRV_LOAD bit when ngbe_open() fails

Zhao Li (1):
      wifi: mt76: mt7996: unlink TWT flow if the MCU rejects the agreement

ZhaoJinming (4):
      net: stmmac: stop DMA before freeing descriptors on open
      Bluetooth: virtio_bt: Fix use-after-free and memory leak in probe error paths
      Bluetooth: btmtksdio: fix deadlock in close and reset paths
      Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()

Zhiling Zou (1):
      wifi: mac80211: serialize debugfs netdev rename with recreate

Zijun Hu (7):
      Bluetooth: hci_event: Use 254 as max LE Meta subevent payload length in hci_le_ev_table[]
      Bluetooth: hci_event: Use 252 as max CC event payload length in hci_cc_table[]
      Bluetooth: btusb: Add recv_intr() hook to btusb_data
      Bluetooth: Add generic support for vendor packets
      Bluetooth: btusb: Build the driver from multiple source files
      Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
      Bluetooth: btnxpuart: Simplify nxp_recv_acl_pkt() by hci_acl_handle()

Zixuan Chai (2):
      ipv6: defrag: orphan skb before queuing
      devlink: fix reload error on netns teardown

Ziyou Xu (1):
      net: phy: air_en8811h: restore AN8811HB LED GPIO after MCU restart

Zong-Zhe Yang (17):
      wifi: rtw89: chan: introduce helper and refine active list iteration
      wifi: rtw89: regd: check only active vifs when recalculating 6 GHz power type
      wifi: rtw89: skip tracking things when entity is paused
      wifi: rtw89: fix ctrl_sco_cck for Wi-Fi 7
      wifi: rtw89: 8852a: prevent potential OOB in ctrl_sco_cck
      wifi: rtw89: fw: cmd_ofld_flush always reset counter
      wifi: rtw89: explicitly declare TX queue flags by DECLARE_BITMAP()
      wifi: rtw89: use one single BA CAM entry per MLD instead of per link
      wifi: rtw89: led: check if board variant assigns led desc
      wifi: rtw89: support variants of FW elements
      wifi: rtw89: 8852cu: take board ID 1 for FW elements 28de/2432
      wifi: rtw89: add instance of IO ops for (un)pack and [um]delay
      wifi: rtw89: ser: reset map of associated links when L2 SER
      wifi: rtw89: pci: fix typo of "deliver"
      wifi: rtw89: rx: refine skb/desc naming to improve readability
      wifi: rtw89: rx: no need to cancel 6 GHz probe per vif
      wifi: rtw89: regd: add NZ/BR/AR for individual TX power settings

bui duc phuc (8):
      net: marvell: mvmdio: Handle errors from optional IRQ lookup
      net: mvpp2: simplify IRQ validity check
      net: davicom: Propagate wakeup IRQ errors
      net: xilinx: axienet: Propagate errors from optional IRQ lookup
      net: xilinx: axienet: Handle optional IRQ return value correctly
      net: xilinx: axienet: Fix IRQ error handling
      net: fec: Propagate PTP initialization errors
      net: fec: Handle optional IRQ lookup errors correctly

ck.chang (1):
      wifi: mt76: mt7925: fix reset panic caused by the WM2 rx irq mask

illusion wang (2):
      net/nebula-matrix: add minimum nbl build framework
      net/nebula-matrix: add core driver architecture and HW layer initialization

Ömer Mete Kaya (1):
      usbnet: fix smp_processor_id() use in preemptible context

イムティヤズ (1):
      wifi: rtw88: fix out-of-bounds CAM write when key table is full

 .mailmap                                           |   14 +-
 .../ABI/testing/sysfs-devices-platform-soc-ipa     |   14 -
 Documentation/ABI/testing/sysfs-timecard           |   37 +-
 Documentation/admin-guide/sysctl/net.rst           |   14 +
 .../devicetree/bindings/dpll/dpll-device.yaml      |    2 +-
 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |    3 +
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |   13 +
 .../bindings/net/altr,socfpga-stmmac.yaml          |    5 +-
 .../bindings/net/amlogic,meson-dwmac.yaml          |    3 +
 .../bindings/net/bluetooth/brcm,bluetooth.yaml     |    1 +
 .../devicetree/bindings/net/brcm,asp-v2.0.yaml     |    2 +-
 .../bindings/net/cortina,gemini-ethernet.yaml      |   52 +-
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |    1 +
 .../bindings/net/dsa/motorcomm,yt921x.yaml         |   23 +
 .../devicetree/bindings/net/dsa/realtek.yaml       |   33 +
 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml       |    4 +-
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |    3 +
 .../bindings/net/ethernet-controller.yaml          |    2 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   16 +
 .../devicetree/bindings/net/fsl,fman-dtsec.yaml    |    4 -
 .../bindings/net/hisilicon,hns-dsaf-v1.yaml        |  170 +
 .../bindings/net/hisilicon,hns-mdio.yaml           |   61 +
 .../devicetree/bindings/net/hisilicon,hns-nic.yaml |  108 +
 .../devicetree/bindings/net/hisilicon-hns-dsaf.txt |   90 -
 .../devicetree/bindings/net/hisilicon-hns-mdio.txt |   27 -
 .../devicetree/bindings/net/hisilicon-hns-nic.txt  |   76 -
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |    9 +-
 .../bindings/net/loongson,ls1b-gmac.yaml           |    3 +
 .../bindings/net/loongson,ls1c-emac.yaml           |    3 +
 .../devicetree/bindings/net/mdio-gpio.yaml         |   16 +-
 Documentation/devicetree/bindings/net/micrel.yaml  |   27 +-
 .../devicetree/bindings/net/microchip,lan8650.yaml |    5 +
 .../devicetree/bindings/net/motorcomm,yt8xxx.yaml  |    1 +
 .../bindings/net/mscc,vsc7514-switch.yaml          |    8 +-
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml         |    3 +
 .../bindings/net/nvidia,tegra234-mgbe.yaml         |    8 +-
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |    3 +
 .../devicetree/bindings/net/nxp,lpc1850-dwmac.yaml |    3 +
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     |    3 +
 .../bindings/net/pcs/rockchip,rk3568-xpcs.yaml     |   69 +
 .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml  |    7 +
 .../devicetree/bindings/net/qcom,ethqos.yaml       |    3 +
 .../devicetree/bindings/net/qcom,ipa.yaml          |   10 +-
 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml  |  102 +-
 .../bindings/net/qcom,sa8255p-ethqos.yaml          |  107 +
 .../bindings/net/realtek,rtl8224-package.yaml      |  332 ++
 .../devicetree/bindings/net/realtek,rtl82xx.yaml   |    6 +-
 .../bindings/net/realtek,rtl9301-mdio.yaml         |   76 +-
 .../devicetree/bindings/net/renesas,etheravb.yaml  |   11 +
 .../devicetree/bindings/net/renesas,rzn1-gmac.yaml |    3 +
 .../bindings/net/renesas,rzv2h-gbeth.yaml          |    3 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |   30 +
 .../devicetree/bindings/net/snps,dwmac-common.yaml |   66 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |   64 +-
 .../bindings/net/socionext,uniphier-ave4.yaml      |   36 +-
 .../bindings/net/sophgo,cv1800b-dwmac.yaml         |    3 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml          |    3 +
 .../devicetree/bindings/net/spacemit,k3-dwmac.yaml |    3 +
 .../bindings/net/starfive,jh7110-dwmac.yaml        |    3 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |    3 +
 .../devicetree/bindings/net/tesla,fsd-ethqos.yaml  |    3 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml |    3 +
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |   78 +-
 .../bindings/net/toshiba,visconti-dwmac.yaml       |    3 +
 .../bindings/net/ultrarisc,dp1000-gmac.yaml        |   74 +
 .../bindings/net/wireless/marvell,sd8787.yaml      |    6 +
 .../bindings/net/wireless/mediatek,mt76.yaml       |   32 +-
 .../bindings/net/wireless/qcom,ath10k.yaml         |   18 +-
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |    7 -
 .../bindings/net/wireless/silabs,wfx.yaml          |    3 +
 .../devicetree/bindings/net/wireless/ti,wl1251.txt |   64 -
 .../bindings/net/wireless/ti,wl1251.yaml           |   85 +
 .../devicetree/bindings/net/wiznet,w5100.yaml      |   88 +
 .../devicetree/bindings/net/wiznet,w5x00.txt       |   50 -
 .../bindings/net/x-powers,acx00-ephy-package.yaml  |  170 +
 Documentation/netlink/netlink-raw.yaml             |   31 +-
 Documentation/netlink/specs/conntrack.yaml         |   60 +-
 Documentation/netlink/specs/devlink.yaml           |  171 +-
 Documentation/netlink/specs/dpll.yaml              |   22 +-
 Documentation/netlink/specs/ethtool.yaml           |   59 +-
 Documentation/netlink/specs/fou.yaml               |    4 +
 Documentation/netlink/specs/gtp.yaml               |  196 +
 Documentation/netlink/specs/handshake.yaml         |    9 +-
 Documentation/netlink/specs/netdev.yaml            |    5 +-
 Documentation/netlink/specs/nl80211.yaml           |    4 +-
 Documentation/netlink/specs/nlctrl.yaml            |   20 +-
 Documentation/netlink/specs/psp.yaml               |    2 +
 Documentation/netlink/specs/rt-addr.yaml           |   21 +-
 Documentation/netlink/specs/rt-link.yaml           |   44 +-
 Documentation/netlink/specs/rt-neigh.yaml          |    2 +-
 Documentation/netlink/specs/rt-nexthop.yaml        |  761 +++
 Documentation/netlink/specs/rt-route.yaml          |  430 +-
 Documentation/netlink/specs/tc.yaml                |    2 +-
 Documentation/netlink/specs/tcp_metrics.yaml       |   18 +-
 Documentation/networking/bridge.rst                |    5 +-
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../device_drivers/ethernet/intel/i40e.rst         |    2 +-
 .../device_drivers/ethernet/intel/iavf.rst         |    2 +-
 .../device_drivers/ethernet/microsoft/netvsc.rst   |    2 -
 .../device_drivers/ethernet/nebula-matrix/nbl.rst  |   28 +
 .../device_drivers/ethernet/qualcomm/ppe/ppe.rst   |    8 +
 .../device_drivers/ethernet/stmicro/stmmac.rst     |    1 -
 .../networking/devlink/devlink-resource.rst        |    4 -
 Documentation/networking/devlink/index.rst         |    5 +-
 Documentation/networking/devlink/ptp_ocp.rst       |   75 +
 Documentation/networking/dsa/dsa.rst               |    2 +-
 Documentation/networking/ethtool-netlink.rst       |   38 +-
 Documentation/networking/ip-sysctl.rst             |   33 +-
 Documentation/networking/mctp.rst                  |    4 +-
 .../networking/net_cachelines/net_device.rst       |    1 +
 .../networking/net_cachelines/tcp_sock.rst         |    1 +
 Documentation/networking/netconsole.rst            |    5 +
 Documentation/networking/netdevices.rst            |   21 +-
 Documentation/networking/netmem.rst                |   53 +
 Documentation/networking/nf_conntrack-sysctl.rst   |    2 +-
 Documentation/networking/oa-tc6-framework.rst      |    2 +-
 Documentation/networking/page_pool.rst             |    2 +-
 Documentation/networking/phonet.rst                |    2 +-
 Documentation/networking/phy-port.rst              |   26 +-
 Documentation/networking/phy.rst                   |   17 +-
 Documentation/networking/proc_net_tcp.rst          |   20 +-
 Documentation/networking/psp.rst                   |    8 +
 Documentation/networking/radiotap-headers.rst      |    2 +-
 Documentation/networking/rxrpc.rst                 |   21 +-
 Documentation/networking/scaling.rst               |    9 +
 Documentation/networking/strparser.rst             |  120 +-
 Documentation/networking/switchdev.rst             |   11 +-
 Documentation/process/maintainer-netdev.rst        |   32 +
 MAINTAINERS                                        |   90 +-
 arch/loongarch/configs/loongson32_defconfig        |    1 -
 arch/loongarch/configs/loongson64_defconfig        |    1 -
 arch/mips/configs/gpr_defconfig                    |    1 -
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/configs/rb532_defconfig                  |    1 -
 arch/parisc/configs/generic-32bit_defconfig        |    1 -
 drivers/block/drbd/drbd_worker.c                   |    3 +-
 drivers/bluetooth/Kconfig                          |   14 +
 drivers/bluetooth/Makefile                         |    3 +
 drivers/bluetooth/btbcm.c                          |    7 +-
 drivers/bluetooth/btintel.c                        |  152 +-
 drivers/bluetooth/btintel.h                        |   19 +
 drivers/bluetooth/btintel_pcie.c                   | 1545 ++++-
 drivers/bluetooth/btintel_pcie.h                   |  257 +-
 drivers/bluetooth/btmrvl_main.c                    |    4 +-
 drivers/bluetooth/btmtk.c                          |  515 +-
 drivers/bluetooth/btmtk.h                          |   12 +
 drivers/bluetooth/btmtksdio.c                      |   55 +-
 drivers/bluetooth/btnxpuart.c                      |    4 +-
 drivers/bluetooth/{btusb.c => btusb_main.c}        |  370 +-
 drivers/bluetooth/btusb_qcom.c                     | 4557 +++++++++++++++
 drivers/bluetooth/btusb_qcom.h                     |   99 +
 drivers/bluetooth/hci_bcm.c                        |    1 +
 drivers/bluetooth/hci_bcsp.c                       |   26 +-
 drivers/bluetooth/hci_h4.c                         |  123 +-
 drivers/bluetooth/hci_h5.c                         |   11 +-
 drivers/bluetooth/hci_ll.c                         |    2 +-
 drivers/bluetooth/hci_serdev.c                     |   46 +-
 drivers/bluetooth/hci_uart.h                       |   39 +-
 drivers/bluetooth/hci_vhci.c                       |    4 +
 drivers/bluetooth/virtio_bt.c                      |   25 +-
 drivers/dibs/dibs_loopback.c                       |    5 +-
 drivers/dpll/dpll_netlink.c                        |    2 +-
 drivers/dpll/dpll_nl.c                             |   20 +-
 drivers/dpll/zl3073x/dpll.c                        |  237 +-
 drivers/dpll/zl3073x/out.h                         |   36 +
 drivers/dpll/zl3073x/prop.c                        |   56 +-
 drivers/infiniband/hw/mlx5/Makefile                |    1 -
 drivers/infiniband/hw/mlx5/cmd.c                   |   21 -
 drivers/infiniband/hw/mlx5/cmd.h                   |    2 -
 drivers/infiniband/hw/mlx5/data_direct.c           |  227 -
 drivers/infiniband/hw/mlx5/data_direct.h           |   23 -
 drivers/infiniband/hw/mlx5/main.c                  |  144 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   18 +-
 drivers/infiniband/hw/mlx5/mr.c                    |    7 +-
 drivers/infiniband/hw/mlx5/odp.c                   |    2 +-
 drivers/infiniband/hw/mlx5/std_types.c             |    3 +-
 drivers/infiniband/hw/mlx5/umr.c                   |   11 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   27 +-
 drivers/misc/lan966x_pci.dtso                      |    5 +-
 drivers/mmc/core/quirks.h                          |    3 +
 drivers/net/amt.c                                  |   18 +-
 drivers/net/bareudp.c                              |    1 +
 drivers/net/bonding/bond_3ad.c                     |    1 -
 drivers/net/bonding/bond_alb.c                     |   63 +-
 drivers/net/can/bxcan.c                            |    2 +-
 drivers/net/can/c_can/c_can_platform.c             |    4 +-
 drivers/net/can/flexcan/flexcan-core.c             |    2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c              |    2 +-
 drivers/net/can/m_can/m_can_platform.c             |    2 +-
 drivers/net/can/sja1000/f81601.c                   |    2 +-
 drivers/net/can/sja1000/sja1000_platform.c         |    2 +-
 drivers/net/can/slcan/slcan-core.c                 |    5 +-
 drivers/net/dsa/Kconfig                            |   19 +-
 drivers/net/dsa/Makefile                           |    3 +-
 drivers/net/dsa/b53/b53_mdio.c                     |    2 +-
 drivers/net/dsa/b53/b53_srab.c                     |    2 +-
 drivers/net/dsa/bcm_sf2.c                          |    2 +-
 drivers/net/dsa/hirschmann/hellcreek.c             |    2 +-
 drivers/net/dsa/ks8995.c                           |  857 ---
 drivers/net/dsa/lan9303_i2c.c                      |    2 +-
 drivers/net/dsa/lan9303_mdio.c                     |    2 +-
 drivers/net/dsa/lantiq/lantiq_gswip.h              |    2 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c       |   19 +-
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                |   66 +-
 drivers/net/dsa/lantiq/mxl-gsw1xx.h                |    2 +
 drivers/net/dsa/microchip/Kconfig                  |    1 +
 drivers/net/dsa/microchip/ksz8.c                   |  254 +-
 drivers/net/dsa/microchip/ksz8.h                   |    2 +
 drivers/net/dsa/microchip/ksz8_reg.h               |    2 +
 drivers/net/dsa/microchip/ksz9477.c                |    1 +
 drivers/net/dsa/microchip/ksz_common.c             |  136 +-
 drivers/net/dsa/microchip/ksz_common.h             |   18 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |   68 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |  490 +-
 drivers/net/dsa/microchip/ksz_ptp.h                |    9 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h            |   16 +
 drivers/net/dsa/microchip/ksz_spi.c                |   33 +-
 drivers/net/dsa/microchip/lan937x_main.c           |    1 +
 drivers/net/dsa/motorcomm/Kconfig                  |   17 +
 drivers/net/dsa/motorcomm/Makefile                 |    9 +
 drivers/net/dsa/motorcomm/chip.c                   | 2680 +++++++++
 drivers/net/dsa/motorcomm/chip.h                   |  568 ++
 drivers/net/dsa/motorcomm/leds.c                   |  655 +++
 drivers/net/dsa/motorcomm/leds.h                   |  118 +
 drivers/net/dsa/motorcomm/mdio_bus.c               |  299 +
 drivers/net/dsa/motorcomm/mdio_bus.h               |   54 +
 drivers/net/dsa/motorcomm/mib.c                    |  431 ++
 drivers/net/dsa/motorcomm/mib.h                    |  167 +
 drivers/net/dsa/motorcomm/pcs-921x.c               |  245 +
 drivers/net/dsa/motorcomm/pcs.h                    |   13 +
 drivers/net/dsa/motorcomm/smi.c                    |  180 +
 drivers/net/dsa/motorcomm/smi.h                    |   61 +
 drivers/net/dsa/motorcomm/tc.c                     | 1711 ++++++
 drivers/net/dsa/motorcomm/tc.h                     |  387 ++
 drivers/net/dsa/mt7530-mdio.c                      |   14 +-
 drivers/net/dsa/mt7530-mmio.c                      |    2 +-
 drivers/net/dsa/mt7530.c                           |  836 ++-
 drivers/net/dsa/mt7530.h                           |  221 +-
 drivers/net/dsa/mv88e6060.c                        |    3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |    9 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   70 +-
 drivers/net/dsa/qca/qca8k-common.c                 |   15 +-
 drivers/net/dsa/realtek/Makefile                   |   28 +-
 drivers/net/dsa/realtek/realtek.h                  |    8 +-
 drivers/net/dsa/realtek/rtl8365mb_main.c           |  313 +-
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           |    4 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |    2 +-
 drivers/net/dsa/realtek/rtl83xx.c                  |   43 +-
 drivers/net/dsa/rzn1_a5psw.c                       |    2 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |    2 +-
 drivers/net/dsa/vitesse-vsc73xx-spi.c              |    9 +-
 drivers/net/dsa/yt921x.c                           | 4982 -----------------
 drivers/net/dsa/yt921x.h                           |  977 ----
 drivers/net/ethernet/8390/pcnet_cs.c               |    9 +-
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/adaptec/starfire.c            |    6 +-
 drivers/net/ethernet/adi/adin1140.c                |    4 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |  363 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |   29 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |   23 +-
 drivers/net/ethernet/alacritech/slicoss.c          |    3 +-
 drivers/net/ethernet/alibaba/eea/eea_adminq.c      |   35 +-
 drivers/net/ethernet/alibaba/eea/eea_ethtool.c     |    4 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |    5 +-
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c      |    2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |    2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |    5 +-
 .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |    2 -
 drivers/net/ethernet/atheros/ag71xx.c              |   36 +-
 drivers/net/ethernet/atheros/alx/main.c            |   13 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_hw.h      |    2 +-
 drivers/net/ethernet/atheros/atl1e/atl1e.h         |    2 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_hw.c      |    2 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |    2 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |    2 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |    2 +-
 drivers/net/ethernet/atheros/atlx/atlx.c           |    1 +
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |  125 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |    9 -
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  101 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |    2 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.h       |    2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   25 +-
 drivers/net/ethernet/broadcom/bcmsysport.h         |    2 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   20 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |   79 +-
 drivers/net/ethernet/broadcom/bnge/bnge_resc.c     |    2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c     |    6 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |    3 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c    |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_hsi.h    |    2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_init_ops.h   |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   |    8 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_reg.h    |    4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  |   18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c      |   61 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h      |   15 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   49 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   11 +-
 drivers/net/ethernet/broadcom/tg3.c                |   78 +-
 drivers/net/ethernet/cadence/macb.h                |  120 +-
 drivers/net/ethernet/cadence/macb_main.c           | 1328 +++--
 drivers/net/ethernet/cadence/macb_ptp.c            |   70 +-
 .../net/ethernet/cavium/liquidio/cn66xx_device.c   |    2 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c    |    2 +-
 .../net/ethernet/cavium/liquidio/octeon_config.h   |    4 +-
 drivers/net/ethernet/cavium/liquidio/octeon_iq.h   |    2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_main.h |    2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_nic.h  |    2 +-
 .../net/ethernet/cavium/liquidio/request_manager.c |    2 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |    5 +-
 drivers/net/ethernet/cavium/thunder/nic.h          |    2 +-
 drivers/net/ethernet/cavium/thunder/nic_main.c     |    2 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c      |    2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |   19 +-
 drivers/net/ethernet/cortina/gemini.c              |   32 +-
 drivers/net/ethernet/cortina/gemini.h              |    2 +-
 drivers/net/ethernet/davicom/dm9000.c              |    6 +-
 drivers/net/ethernet/dec/tulip/de2104x.c           |    2 +-
 drivers/net/ethernet/dec/tulip/interrupt.c         |    4 +-
 drivers/net/ethernet/dec/tulip/media.c             |    2 +-
 drivers/net/ethernet/dec/tulip/tulip.h             |    4 +-
 drivers/net/ethernet/dec/tulip/winbond-840.c       |    2 +-
 .../ethernet/freescale/dpaa2/dpaa2-eth-devlink.c   |   45 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |    6 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |    3 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c   |    3 +
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |    4 +-
 drivers/net/ethernet/freescale/enetc/Kconfig       |    1 +
 drivers/net/ethernet/freescale/enetc/enetc.c       |   68 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   11 +-
 .../net/ethernet/freescale/enetc/enetc4_debugfs.c  |   51 +-
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |    1 +
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |   85 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |    6 +
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |   26 +
 .../net/ethernet/freescale/enetc/enetc_mailbox.h   |  109 +-
 drivers/net/ethernet/freescale/enetc/enetc_msg.c   |  643 ++-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |   64 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   21 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  146 +-
 .../net/ethernet/freescale/enetc/enetc_pf_common.h |   19 +
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c   |    1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |  453 +-
 drivers/net/ethernet/freescale/fec.h               |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |   18 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   24 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |    1 +
 drivers/net/ethernet/freescale/xgmac_mdio.c        |    4 +-
 drivers/net/ethernet/google/gve/gve.h              |   87 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |  376 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |   30 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |    5 +-
 drivers/net/ethernet/google/gve/gve_flow_rule.c    |   15 +-
 drivers/net/ethernet/google/gve/gve_main.c         | 1067 ++--
 drivers/net/ethernet/google/gve/gve_utils.c        |    4 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |    2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |    4 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c   |    4 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |    2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h   |    4 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c  |   12 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |    5 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |   12 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   10 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   11 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |    7 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |    2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    2 +-
 drivers/net/ethernet/huawei/hinic/hinic_tx.c       |   10 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c  |    7 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c     |    8 +-
 drivers/net/ethernet/i825xx/sni_82596.c            |    2 +-
 drivers/net/ethernet/ibm/emac/core.c               |    7 +-
 drivers/net/ethernet/ibm/emac/core.h               |    5 +-
 drivers/net/ethernet/ibm/emac/mal.c                |   43 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |  670 ++-
 drivers/net/ethernet/ibm/ibmveth.h                 |    5 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |   19 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c    |    9 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c       |    2 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   12 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   70 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    5 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    7 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |    5 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    5 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   12 +
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |    8 +-
 drivers/net/ethernet/intel/ice/Makefile            |    2 +-
 drivers/net/ethernet/intel/ice/ice.h               |   17 +-
 drivers/net/ethernet/intel/ice/ice_arfs.c          |    8 +-
 drivers/net/ethernet/intel/ice/ice_arfs.h          |    2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c        |    2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  495 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h          |    4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   14 +-
 .../{ice_ethtool_fdir.c => ice_ethtool_ntuple.c}   |  145 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c          |   38 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h          |   14 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  354 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   15 +-
 drivers/net/ethernet/intel/ice/ice_parser.c        |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   84 +
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   11 +
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |    6 +-
 drivers/net/ethernet/intel/ice/ice_trace.h         |   18 +
 drivers/net/ethernet/intel/ice/ice_tspll.c         |  120 +-
 drivers/net/ethernet/intel/ice/ice_tspll.h         |    6 +
 drivers/net/ethernet/intel/ice/ice_txclk.c         |   20 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |    6 +-
 drivers/net/ethernet/intel/ice/virt/fdir.c         |   28 +-
 drivers/net/ethernet/intel/ice/virt/queues.c       |   17 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |   12 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   19 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   71 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   60 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |    2 +-
 drivers/net/ethernet/marvell/mvmdio.c              |    4 +-
 drivers/net/ethernet/marvell/mvneta.c              |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h         |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c     |    8 +-
 .../ethernet/marvell/octeon_ep/octep_pfvf_mbox.c   |    1 -
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   25 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h    |    2 +
 .../net/ethernet/marvell/octeontx2/af/cn20k/npa.c  |    1 -
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  |    5 +-
 .../ethernet/marvell/octeontx2/af/lmac_common.h    |    2 +
 .../net/ethernet/marvell/octeontx2/af/mcs_reg.h    |    2 -
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |   40 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h    |    2 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |    5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   12 +
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |    8 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   46 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   37 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npa.c    |   10 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    1 -
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |    2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   10 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |    7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   18 +
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |    3 -
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  101 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_reg.h  |    2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |    1 -
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    9 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |    2 +
 drivers/net/ethernet/marvell/octeontx2/nic/qos.h   |    2 -
 .../ethernet/marvell/prestera/prestera_router.c    |   12 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          |    4 +-
 drivers/net/ethernet/marvell/sky2.c                |    2 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |    3 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    2 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c    |   11 +-
 .../net/ethernet/mellanox/mlx5/core/data_direct.c  |  400 ++
 drivers/net/ethernet/mellanox/mlx5/core/devlink.h  |    1 -
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rep/neigh.c |   29 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_priv.h   |   14 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   19 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c  |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |    4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |    3 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   23 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |    2 +-
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   93 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   20 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   37 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/conn.c    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |    6 +-
 .../net/ethernet/mellanox/mlx5/core/lag/debugfs.c  |   14 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  154 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |    2 +-
 .../ethernet/mellanox/mlx5/core/lag/shared_fdb.c   |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   23 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    5 +
 .../net/ethernet/mellanox/mlx5/core/sf/hw_table.c  |   19 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |    4 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   76 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h       |    1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws_pools.c |   11 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.c      |   12 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.h      |    5 +
 .../mellanox/mlx5/core/steering/hws/send.c         |   34 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |    7 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |   19 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |   83 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |   38 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   57 +-
 drivers/net/ethernet/meta/Kconfig                  |   13 +
 drivers/net/ethernet/meta/Makefile                 |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h            |    9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   34 +-
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c    |    5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |    2 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |   15 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |   87 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |   19 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |    9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |    4 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |    2 -
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |  129 +-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c        |   13 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  189 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   17 +
 drivers/net/ethernet/meta/mpnic/Makefile           |   16 +
 drivers/net/ethernet/meta/mpnic/mpnic.h            |   69 +
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h        |  319 ++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c       |  561 ++
 drivers/net/ethernet/meta/mpnic/mpnic_irq.c        |   64 +
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c     |  371 ++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h     |   64 +
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c        |  208 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c       | 1573 ++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h       |  188 +
 drivers/net/ethernet/micrel/ks8842.c               |    4 +-
 drivers/net/ethernet/microchip/fdma/Makefile       |    4 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c     |   65 +-
 drivers/net/ethernet/microchip/fdma/fdma_api.h     |   42 +-
 drivers/net/ethernet/microchip/fdma/fdma_pci.c     |  208 +
 drivers/net/ethernet/microchip/fdma/fdma_pci.h     |   57 +
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |    4 +-
 drivers/net/ethernet/microchip/lan966x/Makefile    |    4 +
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |   97 +-
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  |  731 +++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  121 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |   69 +
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |   25 +
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |    6 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |    2 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |    2 +
 .../microchip/sparx5/lan969x/lan969x_calendar.c    |    8 +-
 .../microchip/sparx5/lan969x/lan969x_fdma.c        |    5 +-
 .../microchip/sparx5/lan969x/lan969x_regs.c        |   10 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |    2 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   28 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |  204 +
 .../net/ethernet/microchip/sparx5/sparx5_psfp.c    |   10 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |   53 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |    1 -
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |   10 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |   10 +
 drivers/net/ethernet/microchip/sparx5/sparx5_tas.c |  806 +++
 drivers/net/ethernet/microchip/sparx5/sparx5_tc.c  |   17 +
 drivers/net/ethernet/microchip/vcap/Kconfig        |    1 -
 drivers/net/ethernet/microsoft/Kconfig             |   26 +-
 drivers/net/ethernet/microsoft/Makefile            |    2 +-
 drivers/net/ethernet/microsoft/mana/Makefile       |    9 +-
 drivers/net/ethernet/microsoft/mana/gdma_cdx.c     |  340 ++
 drivers/net/ethernet/microsoft/mana/gdma_main.c    | 1063 +---
 drivers/net/ethernet/microsoft/mana/gdma_pci.c     |  917 +++
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   24 +-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |    5 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   70 +-
 drivers/net/ethernet/mucse/Kconfig                 |    2 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile         |    3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h         |  216 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c    |  167 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h      |   45 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c     | 2262 ++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h     |   88 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c    |  208 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c     |  179 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h     |    4 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c  |  283 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h  |   60 +
 drivers/net/ethernet/natsemi/xtsonic.c             |    2 +-
 drivers/net/ethernet/nebula-matrix/Kconfig         |   32 +
 drivers/net/ethernet/nebula-matrix/Makefile        |    6 +
 drivers/net/ethernet/nebula-matrix/nbl/Makefile    |    7 +
 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h  |   31 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c       |  153 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h       |   15 +
 .../ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h |   31 +
 .../nebula-matrix/nbl/nbl_include/nbl_def_common.h |   31 +
 .../nebula-matrix/nbl/nbl_include/nbl_def_hw.h     |   17 +
 .../nebula-matrix/nbl/nbl_include/nbl_include.h    |   23 +
 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c  |  192 +
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |    4 +
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   10 +-
 drivers/net/ethernet/netronome/nfp/nic/dcb.c       |    3 -
 drivers/net/ethernet/oa_tc6.c                      |   46 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |   10 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |    2 +
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |   10 +-
 drivers/net/ethernet/pensando/ionic/ionic_if.h     |   31 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   13 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_ctx.c    |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h          |    2 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |    6 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     |    2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |   19 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |    2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c  |    4 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c    |    2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c    |    5 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    4 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_common.c   |    6 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c   |    6 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c            |  137 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.h            |   15 +
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c     |  469 +-
 drivers/net/ethernet/qualcomm/ppe/ppe_config.h     |    4 +
 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c    |   14 +-
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h       |   83 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |   75 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h |    2 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_handlers.c   |   34 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h    |    9 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_command.c    |    9 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c   |   14 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |   13 +-
 drivers/net/ethernet/realtek/Kconfig               |    2 +-
 drivers/net/ethernet/realtek/r8169_main.c          | 1820 +++++-
 drivers/net/ethernet/renesas/ravb.h                |   35 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  253 +-
 drivers/net/ethernet/renesas/ravb_ptp.c            |   38 +-
 drivers/net/ethernet/renesas/rswitch_main.c        |    7 +-
 drivers/net/ethernet/rocker/rocker_main.c          |    2 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c         |    2 +-
 drivers/net/ethernet/sfc/Kconfig                   |    2 +-
 drivers/net/ethernet/sfc/mae.c                     |    2 +
 drivers/net/ethernet/sfc/net_driver.h              |   21 +-
 drivers/net/ethernet/sfc/ptp.c                     |    1 -
 drivers/net/ethernet/sfc/siena/ptp.c               |    1 -
 drivers/net/ethernet/sfc/tc.c                      |    7 +
 drivers/net/ethernet/sfc/tc_counters.c             |   11 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c        |    4 +-
 drivers/net/ethernet/smsc/Kconfig                  |    3 +-
 drivers/net/ethernet/smsc/smc9194.h                |  241 -
 drivers/net/ethernet/spacemit/k1_emac.c            |    4 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |    6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-eic7700.c    |   13 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   44 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  265 +-
 .../ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c  |    7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  131 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c   |    7 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c |   12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   77 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c  |   52 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   88 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    2 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   18 -
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |    2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   18 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   17 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c   |    2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |    7 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  495 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   39 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   17 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   21 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |  120 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  137 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |    2 +-
 drivers/net/ethernet/sun/cassini.c                 |    4 +-
 drivers/net/ethernet/sun/niu.c                     |   10 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |    2 +-
 drivers/net/ethernet/ti/cpsw.c                     |   35 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    2 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |    4 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |    2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c        |    5 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |    6 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   18 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |    6 +-
 drivers/net/ethernet/wiznet/w5100.c                |  234 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    7 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  138 +-
 drivers/net/ethernet/xscale/ptp_ixp46x.c           |    1 +
 drivers/net/fddi/skfp/cfm.c                        |    2 +-
 drivers/net/fddi/skfp/ecm.c                        |    2 +-
 drivers/net/fddi/skfp/fplustm.c                    |    4 +-
 drivers/net/fddi/skfp/h/hwmtm.h                    |    2 +-
 drivers/net/fddi/skfp/h/sba.h                      |    2 +-
 drivers/net/fddi/skfp/pcmplc.c                     |    2 +-
 drivers/net/fddi/skfp/rmt.c                        |    2 +-
 drivers/net/gtp.c                                  |    9 +-
 drivers/net/hyperv/netvsc.c                        |   10 +-
 drivers/net/ieee802154/at86rf230.c                 |    2 +-
 drivers/net/loopback.c                             |    2 +-
 drivers/net/macsec.c                               |   60 +-
 drivers/net/mctp/mctp-usblib-test.c                |  543 +-
 drivers/net/mdio/Kconfig                           |    4 +-
 drivers/net/mdio/mdio-bcm-iproc.c                  |    2 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |    2 +-
 drivers/net/mdio/mdio-mux-meson-g12a.c             |    2 +-
 drivers/net/mdio/mdio-realtek-rtl9300.c            |  546 +-
 drivers/net/netconsole.c                           |  132 +-
 drivers/net/netdevsim/bpf.c                        |   11 +
 drivers/net/netdevsim/bus.c                        |    7 +-
 drivers/net/netdevsim/ethtool.c                    |   53 +
 drivers/net/netdevsim/ipsec.c                      |   10 +-
 drivers/net/netdevsim/netdev.c                     |   10 +-
 drivers/net/netdevsim/netdevsim.h                  |    8 +-
 drivers/net/netdevsim/psp.c                        |   33 -
 drivers/net/netkit.c                               |   17 +-
 drivers/net/ovpn/bind.c                            |    2 +-
 drivers/net/ovpn/io.c                              |    6 +-
 drivers/net/ovpn/socket.h                          |    2 -
 drivers/net/pcs/Kconfig                            |   23 +
 drivers/net/pcs/Makefile                           |    5 +-
 drivers/net/pcs/pcs-lynx.c                         |   59 +-
 drivers/net/pcs/pcs-rzn1-miic.c                    |   42 +-
 drivers/net/pcs/pcs-xpcs-plat.c                    |    2 +-
 drivers/net/pcs/pcs-xpcs-rk.c                      |  598 ++
 drivers/net/pcs/pcs-xpcs.c                         |   35 +-
 drivers/net/pfcp.c                                 |    6 +-
 drivers/net/phy/Kconfig                            |   14 +-
 drivers/net/phy/Makefile                           |    3 +-
 drivers/net/phy/air_en8811h.c                      |   84 +-
 drivers/net/phy/broadcom.c                         |    7 +
 drivers/net/phy/dp83848.c                          |    3 +
 drivers/net/phy/dp83867.c                          |  111 +-
 drivers/net/phy/dp83td510.c                        |   72 +
 drivers/net/phy/marvell.c                          |  102 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c             |   26 +-
 drivers/net/phy/micrel.c                           |    2 +-
 drivers/net/phy/microchip_t1.c                     |   18 +-
 drivers/net/phy/motorcomm.c                        |  228 +-
 drivers/net/phy/mxl-gpy.c                          |    2 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |    2 +-
 drivers/net/phy/phy-caps.h                         |    2 +
 drivers/net/phy/phy_caps.c                         |   26 +
 drivers/net/phy/phy_device.c                       |  565 +-
 drivers/net/phy/phy_fixup.c                        |   98 +
 drivers/net/phy/phy_led_triggers.c                 |   11 +-
 drivers/net/phy/phy_link_topology.c                |  101 +-
 drivers/net/phy/phylib-internal.h                  |    1 +
 drivers/net/phy/phylink.c                          |  313 +-
 drivers/net/phy/qcom/at803x.c                      |   98 +-
 drivers/net/phy/qcom/qca808x.c                     |   15 +-
 drivers/net/phy/qcom/qca83xx.c                     |   58 +
 drivers/net/phy/realtek/realtek_main.c             |  213 +-
 drivers/net/phy/sfp.c                              |   23 +-
 drivers/net/phy/xpowers/Makefile                   |    3 +
 drivers/net/phy/xpowers/ac200.c                    |  314 ++
 drivers/net/phy/xpowers/ac300.c                    |  387 ++
 drivers/net/phy/xpowers/acx00.c                    |  633 +++
 drivers/net/phy/xpowers/acx00.h                    |   28 +
 drivers/net/ppp/ppp_synctty.c                      |   20 +-
 drivers/net/ppp/pppoe.c                            |   22 +-
 drivers/net/pse-pd/realtek-pse-mcu-core.c          |    8 +-
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c           |    1 +
 drivers/net/pse-pd/realtek-pse-mcu.h               |    1 +
 drivers/net/pse-pd/si3474.c                        |   11 +-
 drivers/net/tap.c                                  |    8 +-
 drivers/net/team/team_core.c                       |   11 +
 drivers/net/tun.c                                  |   23 +-
 drivers/net/usb/asix_common.c                      |    5 -
 drivers/net/usb/ax88172a.c                         |    3 +-
 drivers/net/usb/ax88179_178a.c                     |    9 +-
 drivers/net/usb/ch9200.c                           |   14 +-
 drivers/net/usb/lan78xx.c                          |   10 +-
 drivers/net/usb/qmi_wwan.c                         |    1 +
 drivers/net/usb/r8152.c                            |   55 +-
 drivers/net/usb/r8153_ecm.c                        |    8 +-
 drivers/net/usb/rndis_host.c                       |   21 +
 drivers/net/usb/sierra_net.c                       |    2 +-
 drivers/net/usb/smsc95xx.c                         |    1 +
 drivers/net/usb/usbnet.c                           |    8 +-
 drivers/net/veth.c                                 |   11 +-
 drivers/net/virtio_net.c                           |   71 +-
 drivers/net/vrf.c                                  |    4 +-
 drivers/net/vxlan/vxlan_core.c                     |  802 +--
 drivers/net/vxlan/vxlan_mdb.c                      |   45 +-
 drivers/net/vxlan/vxlan_multicast.c                |   94 +-
 drivers/net/vxlan/vxlan_private.h                  |   34 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |  208 +-
 drivers/net/wan/slic_ds26522.c                     |    2 +-
 drivers/net/wireguard/noise.c                      |    2 -
 drivers/net/wireless/ath/ath10k/debug.c            |   10 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c           |   12 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |    1 +
 drivers/net/wireless/ath/ath10k/snoc.c             |    6 +-
 drivers/net/wireless/ath/ath11k/Kconfig            |    3 +
 drivers/net/wireless/ath/ath11k/ahb.c              |   16 +-
 drivers/net/wireless/ath/ath11k/ce.c               |    2 +-
 drivers/net/wireless/ath/ath11k/core.c             |   11 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   21 +-
 drivers/net/wireless/ath/ath11k/htc.c              |    5 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   33 +-
 drivers/net/wireless/ath/ath11k/mac.h              |    2 +-
 drivers/net/wireless/ath/ath11k/reg.c              |    4 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |    9 +
 drivers/net/wireless/ath/ath12k/ahb.c              |  207 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |    9 +
 drivers/net/wireless/ath/ath12k/ce.c               |    2 +-
 drivers/net/wireless/ath/ath12k/core.c             |   60 +-
 drivers/net/wireless/ath/ath12k/core.h             |    9 -
 drivers/net/wireless/ath/ath12k/debugfs.c          |   78 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |    2 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   92 +-
 drivers/net/wireless/ath/ath12k/dp.h               |  122 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   17 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    2 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   55 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    3 -
 drivers/net/wireless/ath/ath12k/dp_stats.h         |   25 +
 drivers/net/wireless/ath/ath12k/htc.c              |    5 +-
 drivers/net/wireless/ath/ath12k/hw.h               |   22 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  137 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   55 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  106 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    4 +
 drivers/net/wireless/ath/ath12k/reg.c              |    6 +-
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |    2 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |   47 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |   72 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |   12 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |   56 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h   |   26 -
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     |    5 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_tx.c     |    2 +-
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |   22 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   39 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |   12 +-
 drivers/net/wireless/ath/ath9k/ar9003_calib.c      |    5 +-
 drivers/net/wireless/ath/ath9k/channel.c           |    2 +
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    9 +
 drivers/net/wireless/ath/ath9k/mci.c               |    5 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    2 +-
 drivers/net/wireless/ath/carl9170/debug.c          |    5 +-
 drivers/net/wireless/ath/regd.c                    |    2 +
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   13 +-
 drivers/net/wireless/broadcom/b43/debugfs.c        |    2 +-
 drivers/net/wireless/broadcom/b43/main.c           |    5 +-
 drivers/net/wireless/broadcom/b43legacy/debugfs.c  |    2 +-
 drivers/net/wireless/broadcom/b43legacy/dma.c      |   24 +-
 drivers/net/wireless/broadcom/b43legacy/dma.h      |    4 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |    3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  228 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    5 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |    6 +
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |    2 +
 .../wireless/broadcom/brcm80211/brcmfmac/feature.h |    4 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |   13 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.h   |   11 +
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   10 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |    3 +-
 .../wireless/broadcom/brcm80211/brcmsmac/channel.c |    2 +
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |  441 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |  121 -
 drivers/net/wireless/intel/iwlegacy/debug.c        |    3 +
 drivers/net/wireless/intel/iwlwifi/Makefile        |    7 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |    4 +
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c   |    5 +-
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c   |   32 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |   88 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c       |   11 +-
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |   11 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |   36 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.c     |    3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c        |   19 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c        |   14 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |    3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/ucode.c     |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  276 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   20 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    5 +-
 .../wireless/intel/iwlwifi/fw/api/ctxt-info-v2.h   |  328 ++
 .../net/wireless/intel/iwlwifi/fw/api/ctxt-info.h  |  185 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |   86 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   51 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   53 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   23 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |   68 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   58 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |   11 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c    |  120 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  156 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/init.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   97 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   26 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  412 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   26 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   13 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   54 +-
 .../net/wireless/intel/iwlwifi/iwl-devtrace-io.h   |   18 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |  448 --
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |  107 -
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   33 +-
 drivers/net/wireless/intel/iwlwifi/iwl-scd.h       |   22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  348 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  228 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   24 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    4 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |   82 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |    4 +-
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   22 +-
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h      |    2 +
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |    6 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |   14 +-
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |    3 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |    6 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   20 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |    6 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |   35 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   10 +-
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |   12 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |   83 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  802 ++-
 drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |   20 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |    7 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   35 +-
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c |    7 +-
 .../net/wireless/intel/iwlwifi/mld/tests/tx-gp2.c  |  154 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |  182 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |  135 +
 drivers/net/wireless/intel/iwlwifi/mld/tx.h        |   41 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   95 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  141 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   44 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c       |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   15 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   35 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |    1 -
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    8 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info-v2.c |   30 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   14 +-
 .../intel/iwlwifi/pcie/{gen1_2 => }/internal.h     |  136 +-
 .../intel/iwlwifi/pcie/iwl-context-info-v2.h       |  320 +-
 .../wireless/intel/iwlwifi/pcie/iwl-context-info.h |  177 +-
 .../wireless/intel/iwlwifi/pcie/{gen1_2 => }/rx.c  |  198 +-
 .../intel/iwlwifi/pcie/{gen1_2 => }/trans-gen2.c   |   96 +-
 .../intel/iwlwifi/pcie/{gen1_2 => }/trans.c        |  929 ++-
 .../intel/iwlwifi/pcie/{gen1_2 => }/tx-gen2.c      |    9 +-
 .../wireless/intel/iwlwifi/pcie/{gen1_2 => }/tx.c  |  167 +-
 drivers/net/wireless/intel/iwlwifi/pcie/utils.c    |   91 +-
 drivers/net/wireless/intel/iwlwifi/pcie/utils.h    |   46 +-
 drivers/net/wireless/marvell/libertas/cfg.c        |    6 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |   10 +-
 drivers/net/wireless/marvell/libertas/mesh.c       |  506 --
 drivers/net/wireless/marvell/libertas/rx.c         |    9 +
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   10 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   20 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   27 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |   22 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    6 +
 drivers/net/wireless/marvell/mwifiex/init.c        |    1 +
 drivers/net/wireless/marvell/mwifiex/main.h        |    3 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |    3 +
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/Kconfig         |    1 +
 drivers/net/wireless/mediatek/mt76/channel.c       |   26 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |   17 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   57 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   31 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c    |   18 +-
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |   13 +
 .../net/wireless/mediatek/mt76/mt7615/pci_init.c   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |   17 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   20 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   24 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c   |   30 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_mcu.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7915/coredump.c   |    7 +-
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c |    6 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   17 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/debugfs.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   14 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   48 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   26 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    6 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    1 +
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/regd.c   |   28 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |    2 +-
 .../net/wireless/mediatek/mt76/mt7925/cached_cal.c |  298 +
 .../net/wireless/mediatek/mt76/mt7925/cached_cal.h |  151 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    2 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  115 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   78 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7925/nan.c    |  694 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/nan.h    |  103 +-
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   66 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |    8 +-
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   26 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   18 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   12 +-
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |   13 +-
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  |    1 +
 .../net/wireless/mediatek/mt76/mt7996/coredump.c   |    7 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |  323 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |    7 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   23 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  784 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  153 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   23 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |   42 +-
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |   36 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |  219 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |    9 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |   47 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   13 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |    8 +-
 drivers/net/wireless/morsemicro/mm81x/command.c    |    5 +-
 drivers/net/wireless/morsemicro/mm81x/core.h       |   23 +-
 drivers/net/wireless/morsemicro/mm81x/fw.c         |    9 +-
 drivers/net/wireless/morsemicro/mm81x/mac.c        |  474 +-
 drivers/net/wireless/morsemicro/mm81x/mmrc.c       |   34 +-
 drivers/net/wireless/morsemicro/mm81x/sdio.c       |    9 +-
 drivers/net/wireless/morsemicro/mm81x/skbq.c       |    7 +-
 drivers/net/wireless/morsemicro/mm81x/yaps_hw.c    |   14 +-
 drivers/net/wireless/nxp/nxpwifi/11ax.c            |    2 +
 drivers/net/wireless/nxp/nxpwifi/11n.c             |    4 +-
 drivers/net/wireless/nxp/nxpwifi/cfg80211.c        |   17 +-
 drivers/net/wireless/nxp/nxpwifi/debugfs.c         |   36 +-
 drivers/net/wireless/nxp/nxpwifi/fw.h              |    2 +
 drivers/net/wireless/nxp/nxpwifi/main.c            |   20 +-
 drivers/net/wireless/nxp/nxpwifi/scan.c            |   18 +
 drivers/net/wireless/nxp/nxpwifi/sdio.c            |   18 +-
 drivers/net/wireless/nxp/nxpwifi/sdio.h            |    1 +
 drivers/net/wireless/nxp/nxpwifi/util.c            |   43 +-
 drivers/net/wireless/nxp/nxpwifi/util.h            |    1 +
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    8 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00pci.c     |  104 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |   67 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  154 +-
 drivers/net/wireless/realtek/rtl8xxxu/regs.h       |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |    2 +-
 drivers/net/wireless/realtek/rtlwifi/base.c        |    2 +-
 .../realtek/rtlwifi/btcoexist/halbtc8192e2ant.c    |    2 +-
 .../realtek/rtlwifi/btcoexist/halbtc8723b2ant.c    |    2 +-
 .../realtek/rtlwifi/btcoexist/halbtc8821a2ant.c    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/core.c        |    4 +-
 drivers/net/wireless/realtek/rtlwifi/debug.h       |    2 +-
 drivers/net/wireless/realtek/rtlwifi/regd.c        |    4 +
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.h   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/pwrseq.h    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/reg.h   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/trx.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |   90 +-
 .../net/wireless/realtek/rtlwifi/rtl8192d/reg.h    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.c   |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/fw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/pwrseq.h    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/hw.c    |  100 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c   |   10 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/reg.h   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/trx.c   |    4 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |    1 -
 .../wireless/realtek/rtlwifi/rtl8723ae/pwrseq.h    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/dm.c    |    2 +-
 .../wireless/realtek/rtlwifi/rtl8723be/pwrseq.h    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/reg.h   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/trx.c   |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |   12 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/fw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   71 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/pwrseq.h    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/reg.h   |   14 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.c   |    2 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |    6 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |   18 +
 drivers/net/wireless/realtek/rtw88/Makefile        |    6 +
 drivers/net/wireless/realtek/rtw88/debug.c         |   10 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    7 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    8 +
 drivers/net/wireless/realtek/rtw88/pci.c           |   29 +
 drivers/net/wireless/realtek/rtw88/phy.c           |   39 +
 drivers/net/wireless/realtek/rtw88/phy.h           |    1 +
 drivers/net/wireless/realtek/rtw88/reg.h           |   36 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   36 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.h      |   63 -
 drivers/net/wireless/realtek/rtw88/rtw8723b.c      | 2534 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723b.h      |   14 +
 .../net/wireless/realtek/rtw88/rtw8723b_table.c    |  861 +++
 .../net/wireless/realtek/rtw88/rtw8723b_table.h    |   17 +
 drivers/net/wireless/realtek/rtw88/rtw8723bs.c     |   59 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |   60 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c      |   38 -
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h      |    1 -
 drivers/net/wireless/realtek/rtw88/rx.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |  504 +-
 drivers/net/wireless/realtek/rtw88/sdio.h          |   24 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    9 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |    3 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   90 +-
 drivers/net/wireless/realtek/rtw88/usb.h           |    5 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |    4 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |    4 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |   28 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    1 +
 drivers/net/wireless/realtek/rtw89/coex.c          | 1479 ++++-
 drivers/net/wireless/realtek/rtw89/coex.h          |    1 -
 drivers/net/wireless/realtek/rtw89/core.c          |  188 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  333 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   10 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  895 ++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  136 +-
 drivers/net/wireless/realtek/rtw89/led.c           |    2 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   26 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    3 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   62 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    4 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   37 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   32 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  213 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |   15 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   32 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   13 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    5 +
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |    4 +-
 .../wireless/realtek/rtw89/rtw8851b_rfk_table.c    |    3 +-
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   13 +
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   34 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    6 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   17 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |    9 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8922au.c     |   14 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c      |  252 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   13 +-
 drivers/net/wireless/realtek/rtw89/usb.c           |   18 +-
 drivers/net/wireless/realtek/rtw89/usb.h           |    3 +-
 drivers/net/wireless/realtek/rtw89/util.h          |    4 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   33 +-
 drivers/net/wireless/silabs/wfx/bh.c               |    6 +-
 drivers/net/wireless/silabs/wfx/bus_sdio.c         |    1 +
 drivers/net/wireless/silabs/wfx/main.c             |   37 +-
 drivers/net/wireless/st/cw1200/txrx.c              |    2 +-
 drivers/net/wireless/ti/wlcore/rx.c                |    5 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |    5 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  152 +-
 drivers/net/wireless/virtual/mac80211_hwsim_nan.c  |  267 +-
 drivers/net/wireless/virtual/mac80211_hwsim_nan.h  |   10 +
 drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c      |    5 +
 drivers/net/wwan/mhi_wwan_ctrl.c                   |  262 +-
 drivers/net/wwan/wwan_core.c                       |  172 +-
 drivers/net/wwan/wwan_hwsim.c                      |    4 +
 drivers/nvme/host/tcp.c                            |    2 +-
 drivers/nvme/target/tcp.c                          |    2 +-
 drivers/ptp/ptp_idt82p33.c                         |   25 +-
 drivers/ptp/ptp_idt82p33.h                         |    1 +
 drivers/ptp/ptp_ocp.c                              |  939 +++-
 drivers/ptp/ptp_qoriq.c                            |    1 +
 drivers/s390/net/ctcm_main.c                       |   14 +-
 drivers/s390/net/fsm.c                             |    9 +-
 drivers/s390/net/ism_drv.c                         |    3 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/rtl8723bs/Kconfig                  |   13 -
 drivers/staging/rtl8723bs/Makefile                 |   60 -
 drivers/staging/rtl8723bs/TODO                     |    7 -
 drivers/staging/rtl8723bs/core/rtw_ap.c            | 1943 -------
 drivers/staging/rtl8723bs/core/rtw_btcoex.c        |   75 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c           | 1936 -------
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |  253 -
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     | 1206 ----
 drivers/staging/rtl8723bs/core/rtw_io.c            |  145 -
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |  494 --
 drivers/staging/rtl8723bs/core/rtw_mlme.c          | 2568 ---------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      | 5901 --------------------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       | 1139 ----
 drivers/staging/rtl8723bs/core/rtw_recv.c          | 2249 --------
 drivers/staging/rtl8723bs/core/rtw_security.c      | 1470 -----
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |  549 --
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     | 1759 ------
 drivers/staging/rtl8723bs/core/rtw_xmit.c          | 2569 ---------
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h        |   65 -
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c    | 2595 ---------
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h    |  184 -
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c    | 2624 ---------
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h    |  146 -
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h       |  426 --
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c   |  556 --
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.h   |   39 -
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c  |  237 -
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.h  |   19 -
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c   |  554 --
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.h   |   40 -
 drivers/staging/rtl8723bs/hal/HalPhyRf.c           |  268 -
 drivers/staging/rtl8723bs/hal/HalPhyRf.h           |   39 -
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     | 1767 ------
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h     |   66 -
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c       |  144 -
 drivers/staging/rtl8723bs/hal/Mp_Precomp.h         |   23 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         | 1303 -----
 drivers/staging/rtl8723bs/hal/hal_com.c            |  767 ---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |  973 ----
 drivers/staging/rtl8723bs/hal/hal_intf.c           |  283 -
 drivers/staging/rtl8723bs/hal/hal_pwr_seq.c        |  128 -
 drivers/staging/rtl8723bs/hal/hal_sdio.c           |  100 -
 drivers/staging/rtl8723bs/hal/odm.c                |  988 ----
 drivers/staging/rtl8723bs/hal/odm.h                | 1109 ----
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c    |  210 -
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.h    |   39 -
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |  799 ---
 drivers/staging/rtl8723bs/hal/odm_DIG.h            |  164 -
 .../rtl8723bs/hal/odm_DynamicBBPowerSaving.c       |   81 -
 .../rtl8723bs/hal/odm_DynamicBBPowerSaving.h       |   31 -
 drivers/staging/rtl8723bs/hal/odm_DynamicTxPower.c |   22 -
 drivers/staging/rtl8723bs/hal/odm_DynamicTxPower.h |   29 -
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c |  158 -
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.h |   23 -
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c       |  439 --
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h       |   85 -
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c |  176 -
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h |   45 -
 drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h   |  160 -
 drivers/staging/rtl8723bs/hal/odm_interface.h      |   29 -
 drivers/staging/rtl8723bs/hal/odm_precomp.h        |   47 -
 drivers/staging/rtl8723bs/hal/odm_reg.h            |   91 -
 drivers/staging/rtl8723bs/hal/odm_types.h          |   40 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |  933 ----
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c        |  256 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  | 2826 ----------
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |  759 ---
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c    |  135 -
 drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c    |   69 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |  477 --
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |  568 --
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       | 1192 ----
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |  859 ---
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h |  232 -
 drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h   |  111 -
 drivers/staging/rtl8723bs/include/basic_types.h    |  175 -
 drivers/staging/rtl8723bs/include/cmd_osdep.h      |   16 -
 drivers/staging/rtl8723bs/include/drv_types.h      |  431 --
 drivers/staging/rtl8723bs/include/drv_types_sdio.h |   25 -
 drivers/staging/rtl8723bs/include/hal_btcoex.h     |   54 -
 drivers/staging/rtl8723bs/include/hal_com.h        |  152 -
 drivers/staging/rtl8723bs/include/hal_com_h2c.h    |   28 -
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h |  108 -
 drivers/staging/rtl8723bs/include/hal_com_reg.h    |  594 --
 drivers/staging/rtl8723bs/include/hal_data.h       |  276 -
 drivers/staging/rtl8723bs/include/hal_intf.h       |  250 -
 drivers/staging/rtl8723bs/include/hal_pg.h         |   63 -
 drivers/staging/rtl8723bs/include/hal_phy.h        |   73 -
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h    |   63 -
 drivers/staging/rtl8723bs/include/hal_phy_reg.h    |   17 -
 drivers/staging/rtl8723bs/include/hal_pwr_seq.h    |  226 -
 drivers/staging/rtl8723bs/include/hal_sdio.h       |   18 -
 drivers/staging/rtl8723bs/include/ieee80211.h      |  748 ---
 drivers/staging/rtl8723bs/include/ioctl_cfg80211.h |   58 -
 drivers/staging/rtl8723bs/include/osdep_intf.h     |   42 -
 drivers/staging/rtl8723bs/include/osdep_service.h  |   53 -
 .../rtl8723bs/include/osdep_service_linux.h        |  118 -
 drivers/staging/rtl8723bs/include/rtl8192c_recv.h  |   33 -
 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h   |  182 -
 drivers/staging/rtl8723bs/include/rtl8723b_dm.h    |   32 -
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h   |  246 -
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h  |   95 -
 drivers/staging/rtl8723bs/include/rtl8723b_rf.h    |   17 -
 drivers/staging/rtl8723bs/include/rtl8723b_spec.h  |  237 -
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |  421 --
 drivers/staging/rtl8723bs/include/rtw_ap.h         |   39 -
 drivers/staging/rtl8723bs/include/rtw_btcoex.h     |   27 -
 drivers/staging/rtl8723bs/include/rtw_byteorder.h  |   16 -
 drivers/staging/rtl8723bs/include/rtw_cmd.h        |  705 ---
 drivers/staging/rtl8723bs/include/rtw_eeprom.h     |  118 -
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |   78 -
 drivers/staging/rtl8723bs/include/rtw_event.h      |   92 -
 drivers/staging/rtl8723bs/include/rtw_ht.h         |   83 -
 drivers/staging/rtl8723bs/include/rtw_io.h         |   58 -
 drivers/staging/rtl8723bs/include/rtw_ioctl_set.h  |   27 -
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |  397 --
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |  708 ---
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h    |  254 -
 drivers/staging/rtl8723bs/include/rtw_qos.h        |   15 -
 drivers/staging/rtl8723bs/include/rtw_recv.h       |  457 --
 drivers/staging/rtl8723bs/include/rtw_rf.h         |  100 -
 drivers/staging/rtl8723bs/include/rtw_security.h   |  272 -
 drivers/staging/rtl8723bs/include/rtw_version.h    |    3 -
 drivers/staging/rtl8723bs/include/rtw_wifi_regd.h  |   16 -
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |  470 --
 drivers/staging/rtl8723bs/include/sdio_hal.h       |   14 -
 drivers/staging/rtl8723bs/include/sdio_ops.h       |   33 -
 drivers/staging/rtl8723bs/include/sdio_ops_linux.h |   29 -
 drivers/staging/rtl8723bs/include/sta_info.h       |  330 --
 drivers/staging/rtl8723bs/include/wifi.h           |  409 --
 drivers/staging/rtl8723bs/include/wlan_bssdef.h    |  195 -
 drivers/staging/rtl8723bs/include/xmit_osdep.h     |   43 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  | 2795 ---------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        | 1189 ----
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |  201 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |  465 --
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c  |  495 --
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c       |  129 -
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |  216 -
 drivers/usb/atm/cxacru.c                           |   18 +-
 drivers/usb/atm/speedtch.c                         |   10 +-
 fs/afs/rxrpc.c                                     |   57 +-
 fs/dlm/lowcomms.c                                  |   10 +-
 include/linux/bnge/hsi.h                           |  136 +-
 include/linux/dibs.h                               |    6 +-
 include/linux/ethtool.h                            |    4 +-
 include/linux/ieee80211-eht.h                      |   18 +-
 include/linux/ieee80211-nan.h                      |   28 +
 include/linux/ieee80211-uhr.h                      |  101 +-
 include/linux/ieee80211.h                          |   42 +-
 include/linux/if_vlan.h                            |   34 +-
 include/linux/igmp.h                               |    3 +-
 include/linux/llc.h                                |    5 -
 include/linux/mdio-mux.h                           |    2 +-
 include/linux/mlx5/data_direct.h                   |   47 +
 include/linux/mlx5/driver.h                        |    8 +
 include/linux/mlx5/eswitch.h                       |    3 +
 include/linux/mlx5/mlx5_ifc.h                      |   16 +-
 include/linux/mmc/sdio_ids.h                       |    2 +
 include/linux/net.h                                |   34 +-
 include/linux/netdevice.h                          |   73 +-
 include/linux/netpoll.h                            |    5 -
 include/linux/pcs/pcs-xpcs-rk.h                    |   11 +
 include/linux/phy.h                                |   40 +-
 include/linux/phy_link_topology.h                  |   43 +
 include/linux/phy_port.h                           |    5 +
 include/linux/phylink.h                            |    2 +
 include/linux/platform_data/microchip-ksz.h        |    2 +
 include/linux/skbuff.h                             |   36 +-
 include/linux/skbuff_ref.h                         |   66 +-
 include/linux/soc/marvell/octeontx2/asm.h          |    6 +-
 include/linux/stmmac.h                             |    2 +
 include/linux/tcp.h                                |    3 +
 include/linux/usb/rndis_host.h                     |    5 +-
 include/linux/wwan.h                               |    9 +
 include/net/addrconf.h                             |    3 +
 include/net/af_rxrpc.h                             |    5 +-
 include/net/af_vsock.h                             |    1 +
 include/net/arp.h                                  |   26 +-
 include/net/bluetooth/bluetooth.h                  |    4 +-
 include/net/bluetooth/hci.h                        |    1 +
 include/net/bluetooth/hci_core.h                   |   69 +-
 include/net/bluetooth/hci_h4.h                     |   60 +
 include/net/bluetooth/hci_mon.h                    |    2 +
 include/net/bluetooth/hci_sync.h                   |    1 +
 include/net/bluetooth/l2cap.h                      |  103 +-
 include/net/bluetooth/mgmt.h                       |   14 +
 include/net/bond_3ad.h                             |    7 -
 include/net/bond_alb.h                             |   14 +-
 include/net/cfg80211.h                             |  170 +-
 include/net/cfg802154.h                            |    9 +-
 include/net/dropreason-core.h                      |   38 +-
 include/net/dsa.h                                  |    2 +
 include/net/gso.h                                  |    7 +-
 include/net/ieee80211_radiotap.h                   |  113 +-
 include/net/inet_connection_sock.h                 |    1 +
 include/net/inet_sock.h                            |    2 +-
 include/net/ip.h                                   |   17 +-
 include/net/ip6_route.h                            |   13 +-
 include/net/ip6_tunnel.h                           |    1 +
 include/net/ip_fib.h                               |    4 +-
 include/net/ip_tunnels.h                           |   17 +-
 include/net/ip_vs.h                                |   50 +-
 include/net/llc.h                                  |  108 +-
 include/net/llc_c_ac.h                             |  180 -
 include/net/llc_c_ev.h                             |  217 -
 include/net/llc_c_st.h                             |   46 -
 include/net/llc_conn.h                             |  114 -
 include/net/llc_if.h                               |   63 -
 include/net/llc_pdu.h                              |  379 +-
 include/net/llc_s_ac.h                             |   35 -
 include/net/llc_s_ev.h                             |   61 -
 include/net/llc_s_st.h                             |   32 -
 include/net/llc_sap.h                              |   26 -
 include/net/mac80211.h                             |  108 +-
 include/net/mana/gdma.h                            |  106 +-
 include/net/mana/hw_channel.h                      |    8 +-
 include/net/mana/mana.h                            |    2 +
 include/net/mptcp.h                                |    9 +
 include/net/ndisc.h                                |   39 +-
 include/net/neighbour.h                            |   46 +-
 include/net/net_namespace.h                        |    5 +
 include/net/netdev_lock.h                          |   20 +-
 include/net/netdev_queues.h                        |   56 +-
 include/net/netfilter/nf_conntrack_seqadj.h        |    1 +
 include/net/netfilter/nf_flow_table.h              |    1 +
 include/net/netfilter/nf_queue.h                   |    3 +-
 include/net/netmem.h                               |   88 +-
 include/net/netns/netfilter.h                      |    2 +
 include/net/page_pool/helpers.h                    |   30 +-
 include/net/page_pool/memory_provider.h            |   10 +
 include/net/page_pool/types.h                      |    6 +-
 include/net/phy/realtek_phy.h                      |    7 -
 include/net/pkt_cls.h                              |    2 -
 include/net/psp/functions.h                        |    5 -
 include/net/psp/types.h                            |    4 +
 include/net/route.h                                |   13 +-
 include/net/sctp/sm.h                              |    1 +
 include/net/seg6_hmac.h                            |    3 +-
 include/net/sock.h                                 |    2 +
 include/net/strparser.h                            |   11 -
 include/net/tcp.h                                  |   47 +-
 include/net/udp.h                                  |    2 +-
 include/net/vxlan.h                                |   12 +-
 include/net/xsk_buff_pool.h                        |    3 +
 include/trace/events/bridge.h                      |    7 +-
 include/trace/events/fib.h                         |   13 +-
 include/trace/events/fib6.h                        |    8 +-
 include/trace/events/rxrpc.h                       |    4 +-
 include/uapi/linux/atm.h                           |    2 +-
 include/uapi/linux/dccp.h                          |   41 +-
 include/uapi/linux/dpll.h                          |    3 +-
 include/uapi/linux/ethtool.h                       |    2 +
 include/uapi/linux/ethtool_netlink_generated.h     |   22 +
 include/uapi/linux/handshake.h                     |    5 +-
 include/uapi/linux/if_addr.h                       |    1 +
 include/uapi/linux/if_link.h                       |    1 +
 include/uapi/linux/mii.h                           |    2 +-
 include/uapi/linux/netdev.h                        |    2 +-
 include/uapi/linux/netfilter/nfnetlink_conntrack.h |    1 +
 include/uapi/linux/netlink.h                       |   14 +
 include/uapi/linux/nl80211.h                       |  115 +-
 lib/ref_tracker.c                                  |    2 +-
 net/6lowpan/debugfs.c                              |   10 +-
 net/802/garp.c                                     |    4 +-
 net/802/psnap.c                                    |    2 +-
 net/8021q/vlan.c                                   |    8 +-
 net/8021q/vlan.h                                   |   22 +-
 net/8021q/vlan_core.c                              |    2 +-
 net/8021q/vlan_dev.c                               |   70 +-
 net/8021q/vlan_netlink.c                           |   52 +-
 net/8021q/vlanproc.c                               |   18 +-
 net/Kconfig                                        |    1 -
 net/atm/proc.c                                     |    7 +-
 net/batman-adv/bat_iv_ogm.c                        |   29 +-
 net/batman-adv/bat_v.c                             |   42 +-
 net/batman-adv/bridge_loop_avoidance.c             |    7 +-
 net/batman-adv/distributed-arp-table.c             |   16 +-
 net/batman-adv/hash.h                              |    2 +-
 net/batman-adv/main.c                              |    1 +
 net/batman-adv/mesh-interface.c                    |   20 +-
 net/batman-adv/multicast.c                         |    6 +-
 net/batman-adv/translation-table.c                 | 1289 +++--
 net/batman-adv/translation-table.h                 |    3 +
 net/batman-adv/types.h                             |   68 +-
 net/bluetooth/6lowpan.c                            |   50 +-
 net/bluetooth/Makefile                             |    2 +-
 net/bluetooth/bnep/core.c                          |   16 +-
 net/bluetooth/hci_conn.c                           |   28 +
 net/bluetooth/hci_core.c                           |   57 +-
 net/bluetooth/hci_debugfs.c                        |    9 +
 net/bluetooth/hci_event.c                          |  290 +-
 net/bluetooth/hci_h4.c                             |  160 +
 net/bluetooth/hci_sock.c                           |    8 +
 net/bluetooth/hci_sync.c                           |  138 +-
 net/bluetooth/iso.c                                |   18 +-
 net/bluetooth/l2cap_core.c                         |  371 +-
 net/bluetooth/l2cap_sock.c                         |  122 +-
 net/bluetooth/mgmt.c                               |  204 +-
 net/bluetooth/msft.c                               |    6 +
 net/bluetooth/rfcomm/core.c                        |    6 +-
 net/bluetooth/rfcomm/sock.c                        |    5 +-
 net/bluetooth/sco.c                                |   10 +-
 net/bluetooth/selftest.c                           |    1 +
 net/bluetooth/smp.c                                |    5 +-
 net/bridge/br.c                                    |    9 +-
 net/bridge/br_arp_nd_proxy.c                       |   61 +-
 net/bridge/br_device.c                             |   17 +-
 net/bridge/br_fdb.c                                |  283 +-
 net/bridge/br_forward.c                            |  290 +-
 net/bridge/br_if.c                                 |   13 +-
 net/bridge/br_input.c                              |   30 +-
 net/bridge/br_mdb.c                                |   16 +-
 net/bridge/br_mrp.c                                |    6 +-
 net/bridge/br_mst.c                                |   28 +-
 net/bridge/br_multicast.c                          |   27 +-
 net/bridge/br_netfilter_hooks.c                    |   33 +-
 net/bridge/br_netlink.c                            |   12 +-
 net/bridge/br_netlink_tunnel.c                     |   14 +-
 net/bridge/br_private.h                            |  252 +-
 net/bridge/br_stp_bpdu.c                           |    3 +-
 net/bridge/br_stp_if.c                             |    2 +-
 net/bridge/br_switchdev.c                          |    2 +-
 net/bridge/br_sysfs_if.c                           |   13 +-
 net/bridge/br_vlan.c                               |  299 +-
 net/bridge/br_vlan_options.c                       |   20 +-
 net/bridge/br_vlan_tunnel.c                        |    2 +-
 net/bridge/netfilter/nft_reject_bridge.c           |    8 +-
 net/ceph/messenger.c                               |    2 +-
 net/core/datagram.c                                |    2 +-
 net/core/dev.c                                     |  227 +-
 net/core/dev.h                                     |   15 +-
 net/core/dev_addr_lists.c                          |  251 +-
 net/core/dev_addr_lists_test.c                     |   18 +-
 net/core/devmem.c                                  |  288 +-
 net/core/devmem.h                                  |   60 +-
 net/core/gro.c                                     |    4 +
 net/core/gro_cells.c                               |    6 +-
 net/core/gso.c                                     |    6 +-
 net/core/lwtunnel.c                                |   35 +-
 net/core/neighbour.c                               |  444 +-
 net/core/net-sysfs.c                               |  150 +-
 net/core/net_test.c                                | 1385 ++++-
 net/core/netdev-genl.c                             |   37 +-
 net/core/netdev_config.c                           |   75 +-
 net/core/netdev_queues.c                           |   31 +-
 net/core/netdev_work.c                             |   19 +-
 net/core/netpoll.c                                 |   15 +
 net/core/page_pool_priv.h                          |   14 +-
 net/core/page_pool_user.c                          |    8 +-
 net/core/pktgen.c                                  |   17 +-
 net/core/rtnetlink.c                               |   36 +-
 net/core/selftests.c                               |    2 +-
 net/core/skb_fault_injection.c                     |    3 +
 net/core/skbuff.c                                  |  326 +-
 net/core/sock.c                                    |   63 +-
 net/core/stream.c                                  |    8 +-
 net/core/sysctl_net_core.c                         |   17 +-
 net/dcb/dcbnl.c                                    |    9 +
 net/devlink/core.c                                 |    2 +
 net/devlink/dev.c                                  |   10 +-
 net/devlink/devl_internal.h                        |    3 +
 net/devlink/netlink_gen.c                          |    9 +-
 net/devlink/netlink_gen.h                          |    2 +-
 net/devlink/port.c                                 |   19 +-
 net/dsa/Kconfig                                    |    6 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/tag.c                                      |    2 +-
 net/dsa/tag_ks8995.c                               |  180 +
 net/dsa/tag_ksz.c                                  |    5 +-
 net/ethernet/eth.c                                 |   18 +-
 net/ethtool/Makefile                               |    2 +-
 net/ethtool/common.c                               |  182 +
 net/ethtool/common.h                               |    2 +
 net/ethtool/ioctl.c                                |   33 +-
 net/ethtool/netlink.c                              |   40 +-
 net/ethtool/netlink.h                              |    8 +
 net/ethtool/port.c                                 |  385 ++
 net/ethtool/rings.c                                |   13 +-
 net/ethtool/strset.c                               |    5 +
 net/ethtool/ts.h                                   |    8 +-
 net/handshake/genl.c                               |    4 +-
 net/handshake/handshake-test.c                     |    2 +-
 net/handshake/request.c                            |    2 +-
 net/hsr/hsr_device.c                               |    2 +-
 net/hsr/hsr_forward.c                              |    2 +-
 net/hsr/hsr_netlink.c                              |   35 +-
 net/ieee802154/6lowpan/rx.c                        |    2 +-
 net/ieee802154/6lowpan/tx.c                        |    4 +-
 net/ieee802154/socket.c                            |    5 +-
 net/ipv4/Kconfig                                   |   12 +
 net/ipv4/Makefile                                  |    1 +
 net/ipv4/af_inet.c                                 |    3 -
 net/ipv4/arp.c                                     |  141 +-
 net/ipv4/bpf_tcp_ca.c                              |    5 +-
 net/ipv4/devinet.c                                 |   70 +-
 net/ipv4/esp4.c                                    |    4 +-
 net/ipv4/fib_frontend.c                            |    6 +-
 net/ipv4/fib_semantics.c                           |    6 +-
 net/ipv4/fib_trie.c                                |   18 +-
 net/ipv4/fou_nl.c                                  |    6 +-
 net/ipv4/gre_offload.c                             |    2 +-
 net/ipv4/igmp.c                                    |   23 +-
 net/ipv4/inet_connection_sock.c                    |    5 +
 net/ipv4/inet_hashtables.c                         |   11 +
 net/ipv4/inet_timewait_sock.c                      |    6 +-
 net/ipv4/ip_forward.c                              |    2 +-
 net/ipv4/ip_gre.c                                  |   11 +-
 net/ipv4/ip_output.c                               |   15 +-
 net/ipv4/ip_sockglue.c                             |   10 +-
 net/ipv4/ip_tunnel.c                               |  146 +-
 net/ipv4/ip_tunnel_core.c                          |   22 +-
 net/ipv4/ip_vti.c                                  |    2 +-
 net/ipv4/ipconfig.c                                |    3 +
 net/ipv4/ipip.c                                    |    3 +-
 net/ipv4/ipmr.c                                    |   17 +-
 net/ipv4/netfilter/arp_tables.c                    |    2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |    5 +
 net/ipv4/ping.c                                    |    5 +-
 net/ipv4/raw.c                                     |    4 +-
 net/ipv4/route.c                                   |   29 +-
 net/ipv4/syncookies.c                              |   12 +-
 net/ipv4/tcp.c                                     |   32 +-
 net/ipv4/tcp_bbr.c                                 |   13 +-
 net/ipv4/tcp_bic.c                                 |   14 +-
 net/ipv4/tcp_bpf.c                                 |   13 +-
 net/ipv4/tcp_cubic.c                               |   14 +-
 net/ipv4/tcp_hybla.c                               |   16 +-
 net/ipv4/tcp_input.c                               |   34 +-
 net/ipv4/tcp_ipv4.c                                |   20 +-
 net/ipv4/tcp_metrics.c                             |   20 +-
 net/ipv4/tcp_output.c                              |   28 +-
 net/ipv4/tcp_roccet.c                              | 1408 +++++
 net/ipv4/udp.c                                     |   26 +-
 net/ipv6/addrconf.c                                |   63 +-
 net/ipv6/af_inet6.c                                |    6 +-
 net/ipv6/ah6.c                                     |    2 +-
 net/ipv6/calipso.c                                 |    6 +-
 net/ipv6/datagram.c                                |    5 +-
 net/ipv6/esp6.c                                    |    4 +-
 net/ipv6/exthdrs.c                                 |    8 +-
 net/ipv6/ip6_fib.c                                 |   14 +-
 net/ipv6/ip6_gre.c                                 |  278 +-
 net/ipv6/ip6_output.c                              |    6 +-
 net/ipv6/ip6_tunnel.c                              |    1 +
 net/ipv6/ip6_vti.c                                 |    2 +-
 net/ipv6/ip6mr.c                                   |   11 +-
 net/ipv6/ipv6_sockglue.c                           |  123 +-
 net/ipv6/ndisc.c                                   |  219 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    2 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |    5 +
 net/ipv6/reassembly.c                              |    1 +
 net/ipv6/route.c                                   |  126 +-
 net/ipv6/seg6_hmac.c                               |    5 +-
 net/ipv6/seg6_iptunnel.c                           |   36 +-
 net/ipv6/seg6_local.c                              |    6 +-
 net/ipv6/sit.c                                     |  478 +-
 net/ipv6/tcp_ipv6.c                                |   21 +-
 net/ipv6/udp.c                                     |    8 +-
 net/iucv/af_iucv.c                                 |   20 +-
 net/kcm/kcmproc.c                                  |    2 +-
 net/kcm/kcmsock.c                                  |    4 +-
 net/key/af_key.c                                   |    5 +-
 net/l2tp/l2tp_core.c                               |   51 +-
 net/l2tp/l2tp_core.h                               |    6 +-
 net/l2tp/l2tp_debugfs.c                            |    4 +-
 net/l2tp/l2tp_netlink.c                            |   11 +-
 net/l2tp/l2tp_ppp.c                                |    8 +-
 net/llc/Kconfig                                    |    7 -
 net/llc/Makefile                                   |   10 +-
 net/llc/af_llc.c                                   | 1304 -----
 net/llc/llc_c_ac.c                                 | 1448 -----
 net/llc/llc_c_ev.c                                 |  742 ---
 net/llc/llc_c_st.c                                 | 4940 ----------------
 net/llc/llc_conn.c                                 | 1025 ----
 net/llc/llc_core.c                                 |   30 +-
 net/llc/llc_if.c                                   |  151 -
 net/llc/llc_input.c                                |  128 +-
 net/llc/llc_output.c                               |    3 +-
 net/llc/llc_pdu.c                                  |  366 --
 net/llc/llc_proc.c                                 |  245 -
 net/llc/llc_s_ac.c                                 |  220 -
 net/llc/llc_s_ev.c                                 |  109 -
 net/llc/llc_s_st.c                                 |  177 -
 net/llc/llc_sap.c                                  |  437 --
 net/llc/llc_station.c                              |  120 -
 net/llc/sysctl_net_llc.c                           |   71 -
 net/mac80211/agg-tx.c                              |    9 +-
 net/mac80211/ap.c                                  |    3 -
 net/mac80211/cfg.c                                 |  625 ++-
 net/mac80211/debugfs.c                             |    3 +-
 net/mac80211/debugfs_key.c                         |   18 +-
 net/mac80211/debugfs_netdev.c                      |    8 +-
 net/mac80211/driver-ops.c                          |   76 +
 net/mac80211/driver-ops.h                          |   64 +-
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ieee80211_i.h                         |   63 +-
 net/mac80211/iface.c                               |   38 +-
 net/mac80211/key.c                                 |   96 +-
 net/mac80211/key.h                                 |    3 +-
 net/mac80211/link.c                                |    1 +
 net/mac80211/main.c                                |   30 +-
 net/mac80211/mesh_pathtbl.c                        |   40 +-
 net/mac80211/mesh_plink.c                          |    4 +-
 net/mac80211/mlme.c                                |  155 +-
 net/mac80211/nan.c                                 |   33 +
 net/mac80211/offchannel.c                          |  357 +-
 net/mac80211/parse.c                               |   16 +-
 net/mac80211/rate.c                                |    6 -
 net/mac80211/rx.c                                  |  469 +-
 net/mac80211/s1g.c                                 |    8 -
 net/mac80211/scan.c                                |   28 +-
 net/mac80211/sta_info.c                            |  182 +-
 net/mac80211/sta_info.h                            |   12 +-
 net/mac80211/tdls.c                                |    4 +-
 net/mac80211/tests/chan-mode.c                     |   25 +-
 net/mac80211/tests/util.c                          |    6 +-
 net/mac80211/trace.h                               |   28 +
 net/mac80211/tx.c                                  |  551 +-
 net/mac80211/util.c                                |   47 +-
 net/mac802154/iface.c                              |   10 +-
 net/mctp/route.c                                   |    2 +-
 net/mpls/af_mpls.c                                 |   13 +-
 net/mptcp/options.c                                |   15 +-
 net/mptcp/protocol.c                               |   58 +-
 net/mptcp/protocol.h                               |   55 +-
 net/mptcp/subflow.c                                |   68 +-
 net/mptcp/token.c                                  |   68 +-
 net/mptcp/token_test.c                             |    4 +-
 net/ncsi/internal.h                                |    1 +
 net/ncsi/ncsi-manage.c                             |    2 +-
 net/ncsi/ncsi-rsp.c                                |   10 +-
 net/netfilter/core.c                               |   20 +-
 net/netfilter/ipset/ip_set_core.c                  |    2 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |    8 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   41 +-
 net/netfilter/ipvs/ip_vs_dh.c                      |   16 +-
 net/netfilter/ipvs/ip_vs_fo.c                      |    2 +-
 net/netfilter/ipvs/ip_vs_lblc.c                    |    4 +-
 net/netfilter/ipvs/ip_vs_lblcr.c                   |    8 +-
 net/netfilter/ipvs/ip_vs_lc.c                      |    2 +-
 net/netfilter/ipvs/ip_vs_mh.c                      |    2 +-
 net/netfilter/ipvs/ip_vs_nq.c                      |    2 +-
 net/netfilter/ipvs/ip_vs_ovf.c                     |    2 +-
 net/netfilter/ipvs/ip_vs_rr.c                      |    2 +-
 net/netfilter/ipvs/ip_vs_sed.c                     |    4 +-
 net/netfilter/ipvs/ip_vs_sh.c                      |    2 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   25 +-
 net/netfilter/ipvs/ip_vs_twos.c                    |    4 +-
 net/netfilter/ipvs/ip_vs_wlc.c                     |    4 +-
 net/netfilter/ipvs/ip_vs_wrr.c                     |    2 +-
 net/netfilter/nf_conncount.c                       |    2 +-
 net/netfilter/nf_conntrack_core.c                  |   12 +-
 net/netfilter/nf_conntrack_netlink.c               |   19 +-
 net/netfilter/nf_conntrack_ovs.c                   |    2 +-
 net/netfilter/nf_conntrack_seqadj.c                |   28 +-
 net/netfilter/nf_conntrack_standalone.c            |    2 +-
 net/netfilter/nf_flow_table_core.c                 |   17 +-
 net/netfilter/nf_flow_table_ip.c                   |  176 +-
 net/netfilter/nf_flow_table_path.c                 |    2 +
 net/netfilter/nf_hooks_lwtunnel.c                  |    2 +-
 net/netfilter/nf_internals.h                       |    2 +-
 net/netfilter/nf_log.c                             |    2 +-
 net/netfilter/nf_nat_core.c                        |   16 +-
 net/netfilter/nf_queue.c                           |    4 +-
 net/netfilter/nf_synproxy_core.c                   |    6 +-
 net/netfilter/nf_tables_api.c                      |   94 +-
 net/netfilter/nfnetlink_acct.c                     |    2 +-
 net/netfilter/nfnetlink_cthelper.c                 |    3 +-
 net/netfilter/nfnetlink_cttimeout.c                |    8 +-
 net/netfilter/nfnetlink_hook.c                     |   74 +-
 net/netfilter/nfnetlink_osf.c                      |    3 +-
 net/netfilter/nfnetlink_queue.c                    |   41 +-
 net/netfilter/nft_chain_nat.c                      |    1 +
 net/netfilter/nft_compat.c                         |   15 +
 net/netfilter/nft_ct.c                             |    7 +-
 net/netfilter/nft_exthdr.c                         |   34 +-
 net/netfilter/nft_payload.c                        |   40 +-
 net/netfilter/nft_set_pipapo.c                     |    6 +-
 net/netfilter/nft_set_rbtree.c                     |    3 +-
 net/netfilter/xt_CT.c                              |    6 +-
 net/netfilter/xt_IDLETIMER.c                       |    8 +-
 net/netfilter/xt_LED.c                             |    5 +-
 net/netfilter/xt_RATEEST.c                         |    2 +-
 net/netfilter/xt_TEE.c                             |    2 +-
 net/netfilter/xt_dccp.c                            |    2 +-
 net/netfilter/xt_hashlimit.c                       |    4 +-
 net/netfilter/xt_limit.c                           |    2 +-
 net/netfilter/xt_quota.c                           |    2 +-
 net/netfilter/xt_recent.c                          |    3 +-
 net/netfilter/xt_statistic.c                       |    2 +-
 net/netfilter/xt_string.c                          |    2 +-
 net/netlink/af_netlink.c                           |    8 +-
 net/netlink/policy.c                               |   16 +-
 net/openvswitch/actions.c                          |    9 +
 net/openvswitch/datapath.c                         |   16 +-
 net/openvswitch/datapath.h                         |    2 +-
 net/openvswitch/flow.c                             |    1 -
 net/openvswitch/flow_netlink.c                     |    2 -
 net/openvswitch/flow_table.c                       |    2 -
 net/openvswitch/vport-internal_dev.c               |    2 +
 net/openvswitch/vport-netdev.c                     |    1 -
 net/packet/af_packet.c                             |   19 +-
 net/phonet/socket.c                                |    5 +-
 net/psp/psp.h                                      |   13 +
 net/psp/psp_main.c                                 |   29 +-
 net/psp/psp_nl.c                                   |   51 +-
 net/psp/psp_sock.c                                 |  127 +-
 net/rds/ib.c                                       |   14 +-
 net/rds/ib.h                                       |    4 +-
 net/rds/ib_cm.c                                    |   47 +-
 net/rds/ib_recv.c                                  |   13 +-
 net/rds/rdma_transport.c                           |   13 +-
 net/rds/recv.c                                     |    6 +-
 net/rds/tcp_send.c                                 |    5 +-
 net/rxrpc/recvmsg.c                                |   22 +-
 net/rxrpc/rxperf.c                                 |   62 +-
 net/rxrpc/sendmsg.c                                |  103 +-
 net/sched/act_api.c                                |  129 +-
 net/sched/act_connmark.c                           |    6 +
 net/sched/act_ct.c                                 |    2 +-
 net/sched/act_gate.c                               |   18 +-
 net/sched/act_mirred.c                             |    3 +-
 net/sched/act_mpls.c                               |   11 +
 net/sched/act_nat.c                                |    6 +
 net/sched/act_simple.c                             |    7 +
 net/sched/act_skbmod.c                             |    9 +
 net/sched/cls_api.c                                |   38 +-
 net/sched/cls_basic.c                              |    3 +-
 net/sched/cls_bpf.c                                |   31 +-
 net/sched/cls_cgroup.c                             |    3 +-
 net/sched/cls_flow.c                               |    3 +-
 net/sched/cls_flower.c                             |   95 +-
 net/sched/cls_fw.c                                 |    3 +-
 net/sched/cls_matchall.c                           |    3 +-
 net/sched/cls_route.c                              |    3 +-
 net/sched/cls_u32.c                                |    3 +-
 net/sched/ematch.c                                 |    9 +-
 net/sched/sch_api.c                                |   86 +-
 net/sched/sch_cake.c                               |   69 +-
 net/sched/sch_fq.c                                 |   71 +-
 net/sched/sch_netem.c                              |    4 +-
 net/sched/sch_taprio.c                             |   14 +
 net/sched/sch_teql.c                               |   15 +-
 net/sctp/proc.c                                    |    6 +-
 net/sctp/sm_make_chunk.c                           |    5 +-
 net/sctp/socket.c                                  |   83 +-
 net/sctp/ulpqueue.c                                |    2 +-
 net/smc/af_smc.c                                   |   14 +-
 net/smc/smc_close.c                                |   18 +-
 net/smc/smc_core.c                                 |    4 +-
 net/smc/smc_pnet.c                                 |   29 +-
 net/smc/smc_tx.c                                   |   31 +-
 net/socket.c                                       |   32 +-
 net/strparser/strparser.c                          |   93 +-
 net/sunrpc/svcsock.c                               |    4 +-
 net/sunrpc/xprtsock.c                              |    4 +-
 net/tipc/bearer.c                                  |    6 +-
 net/tipc/bearer.h                                  |   17 +-
 net/tipc/group.c                                   |   19 +-
 net/tipc/monitor.c                                 |    3 +-
 net/tipc/msg.c                                     |    2 +-
 net/tipc/node.c                                    |    2 +-
 net/tipc/socket.c                                  |   12 +-
 net/tls/tls_device.c                               |   23 +-
 net/tls/tls_device_fallback.c                      |    2 +-
 net/tls/tls_main.c                                 |    2 -
 net/tls/tls_strp.c                                 |    2 +-
 net/tls/tls_sw.c                                   |    2 +-
 net/unix/af_unix.c                                 |    3 +-
 net/unix/sysctl_net_unix.c                         |    4 +-
 net/vmw_vsock/af_vsock.c                           |  154 +-
 net/vmw_vsock/af_vsock_tap.c                       |    4 -
 net/wireless/ap.c                                  |    7 +-
 net/wireless/chan.c                                |   46 +-
 net/wireless/core.c                                |  190 +-
 net/wireless/core.h                                |   58 +-
 net/wireless/debugfs.c                             |    3 +
 net/wireless/ibss.c                                |    3 +-
 net/wireless/mlme.c                                |  152 +-
 net/wireless/nl80211.c                             | 1280 ++++-
 net/wireless/rdev-ops.h                            |   90 +-
 net/wireless/reg.c                                 |  248 +-
 net/wireless/reg.h                                 |    2 +-
 net/wireless/scan.c                                |    9 +-
 net/wireless/sme.c                                 |   66 +-
 net/wireless/sysfs.c                               |   12 +-
 net/wireless/trace.h                               |  109 +-
 net/wireless/util.c                                |   51 +-
 net/wireless/wext-compat.c                         |    8 +-
 net/wireless/wext-sme.c                            |    3 +
 net/x25/af_x25.c                                   |    5 +-
 net/xdp/xsk.c                                      |    5 +
 net/xdp/xsk_buff_pool.c                            |   46 +-
 net/xfrm/xfrm_iptfs.c                              |    3 +-
 net/xfrm/xfrm_policy.c                             |    4 +-
 rust/kernel/net/netlink.rs                         |    8 +-
 scripts/context-analysis-suppression.txt           |    1 +
 tools/include/uapi/linux/netdev.h                  |    2 +-
 tools/net/ynl/Makefile                             |    1 +
 tools/net/ynl/Makefile.deps                        |   22 +-
 tools/net/ynl/generated/Makefile                   |    4 +-
 tools/net/ynl/lib/Makefile                         |    3 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |    8 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |   49 +-
 tools/net/ynl/tests/Makefile                       |    2 +-
 tools/net/ynl/ynltool/Makefile                     |   10 +-
 tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c   |    8 +-
 tools/testing/selftests/drivers/net/Makefile       |   11 +-
 tools/testing/selftests/drivers/net/README.rst     |    9 +
 .../testing/selftests/drivers/net/bonding/Makefile |    3 +-
 tools/testing/selftests/drivers/net/dsa/Makefile   |    1 +
 tools/testing/selftests/drivers/net/gro_hw.py      |   13 +
 .../selftests/drivers/net/{gro.py => gro_lib.py}   |  192 +-
 tools/testing/selftests/drivers/net/gro_lro.py     |   14 +
 tools/testing/selftests/drivers/net/gro_sw.py      |   13 +
 tools/testing/selftests/drivers/net/hds.py         |   29 -
 tools/testing/selftests/drivers/net/hw/Makefile    |   19 +-
 tools/testing/selftests/drivers/net/hw/config      |    1 +
 .../selftests/drivers/net/hw/devlink_rate_tc_bw.py |    5 +-
 .../testing/selftests/drivers/net/hw/devmem_lib.py |    4 +-
 .../drivers/net/hw/{gro_hw.py => gro_stats.py}     |    0
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c  |  422 +-
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |   56 +-
 .../selftests/drivers/net/hw/lib/py/__init__.py    |    7 +-
 tools/testing/selftests/drivers/net/hw/pause.py    |  944 ++++
 tools/testing/selftests/drivers/net/hw/toeplitz.py |   10 +-
 tools/testing/selftests/drivers/net/hw/tso.py      |  161 +
 tools/testing/selftests/drivers/net/hw/vlan.py     |  127 +
 .../selftests/drivers/net/lib/py/__init__.py       |    7 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |   19 +
 tools/testing/selftests/drivers/net/lib/py/feat.py |   43 +
 tools/testing/selftests/drivers/net/macsec.py      |   57 +-
 .../selftests/drivers/net/netconsole/Makefile      |    3 +-
 .../selftests/drivers/net/netdevsim/Makefile       |    8 +
 .../drivers/net/netdevsim/fib_notifications.sh     |   66 +
 tools/testing/selftests/drivers/net/pppoe_gro.py   |   45 +
 tools/testing/selftests/drivers/net/psp.py         |  236 +-
 .../testing/selftests/drivers/net/ring_reconfig.py |   26 +-
 tools/testing/selftests/drivers/net/rss_key.py     |  343 ++
 tools/testing/selftests/drivers/net/ruff.toml      |    4 +
 tools/testing/selftests/drivers/net/settings       |    2 +-
 tools/testing/selftests/drivers/net/so_txtime.c    |  159 +-
 tools/testing/selftests/drivers/net/so_txtime.py   |   80 +-
 tools/testing/selftests/drivers/net/team/Makefile  |    4 +-
 .../selftests/drivers/net/virtio_net/Makefile      |    1 +
 tools/testing/selftests/net/.gitignore             |    1 +
 tools/testing/selftests/net/Makefile               |    4 +
 tools/testing/selftests/net/bareudp.sh             |   92 +-
 tools/testing/selftests/net/big_tcp_tunnels.sh     |   58 +-
 tools/testing/selftests/net/bind_wildcard.c        |    5 +
 tools/testing/selftests/net/bpf_offload.py         |  139 +
 tools/testing/selftests/net/config                 |    3 +
 tools/testing/selftests/net/cork_fragsize.py       |    5 +-
 tools/testing/selftests/net/drop_monitor_tests.sh  |   13 +-
 tools/testing/selftests/net/fcnal-test.sh          |   29 +-
 tools/testing/selftests/net/fdb_flush.sh           |   38 +-
 tools/testing/selftests/net/fib-onlink-tests.sh    |   21 +-
 .../selftests/net/fib_nexthop_multiprefix.sh       |   22 +-
 tools/testing/selftests/net/fib_nexthop_nongw.sh   |   21 +-
 tools/testing/selftests/net/fib_rule_tests.sh      |   19 +-
 tools/testing/selftests/net/fib_tests.sh           |   66 +-
 tools/testing/selftests/net/forwarding/Makefile    |    2 +
 .../selftests/net/forwarding/bridge_mdb_max.sh     |  138 +
 tools/testing/selftests/net/fou_gre_gro.sh         |  164 +
 tools/testing/selftests/net/fou_mcast_encap.sh     |   11 +-
 tools/testing/selftests/net/gre_gso.sh             |   26 +-
 tools/testing/selftests/net/gtp.py                 |  123 +
 tools/testing/selftests/net/icmp.sh                |   32 +-
 tools/testing/selftests/net/icmp_redirect.sh       |   29 +-
 tools/testing/selftests/net/ip_local_port_range.c  |   52 +-
 tools/testing/selftests/net/l2tp.sh                |   22 +-
 tools/testing/selftests/net/lib.sh                 |   34 +
 tools/testing/selftests/net/lib/csum.c             |   55 +-
 tools/testing/selftests/net/lib/gro.c              |  136 +-
 .../selftests/net/lib/ksft_setup_loopback.sh       |    2 +-
 tools/testing/selftests/net/lib/py/__init__.py     |    9 +-
 tools/testing/selftests/net/lib/py/utils.py        |   22 +
 tools/testing/selftests/net/lib/py/ynl.py          |    9 +-
 tools/testing/selftests/net/lib/xdp_dummy.bpf.c    |    6 +
 tools/testing/selftests/net/mptcp/config           |   17 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  158 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |    9 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   59 +-
 .../selftests/net/ndisc_unsolicited_na_test.sh     |  221 +-
 tools/testing/selftests/net/netdev_lock.py         |   42 +
 tools/testing/selftests/net/netfilter/Makefile     |    2 +
 tools/testing/selftests/net/netfilter/config       |    2 +-
 .../selftests/net/netfilter/conntrack_dump_flush.c |  145 +-
 .../net/netfilter/conntrack_icmp_related.sh        |    2 +-
 .../selftests/net/netfilter/conntrack_vrf.sh       |   25 +-
 tools/testing/selftests/net/netfilter/nf_queue.c   |   22 +-
 .../selftests/net/netfilter/nft_nat_zones.sh       |   34 +-
 tools/testing/selftests/net/netfilter/nft_queue.sh |  110 +-
 tools/testing/selftests/net/openvswitch/config     |    3 +
 .../selftests/net/openvswitch/openvswitch.sh       |  202 +
 tools/testing/selftests/net/ovpn/Makefile          |    1 +
 tools/testing/selftests/net/ovpn/common.sh         |   81 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |   39 +
 .../selftests/net/ovpn/test-close-socket.sh        |    2 +
 tools/testing/selftests/net/ovpn/test-tcp-nagle.sh |   12 +
 tools/testing/selftests/net/ovpn/test.sh           |   56 +-
 .../packetdrill/tcp_rcv_ssthresh_scaling_ratio.pkt |   46 +
 tools/testing/selftests/net/rtnetlink.py           |  186 +-
 tools/testing/selftests/net/rtnetlink.sh           |    8 +-
 tools/testing/selftests/net/ruff.toml              |    4 +
 tools/testing/selftests/net/so_incoming_cpu.c      |    7 +-
 tools/testing/selftests/net/so_reserve_mem.c       |  448 ++
 .../selftests/net/srv6_encap_lookup_l3vpn_test.sh  |   19 +-
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh      |   19 +-
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh       |   40 +-
 .../selftests/net/srv6_end_dt6_l3vpn_test.sh       |   40 +-
 .../selftests/net/srv6_end_dx4_netfilter_test.sh   |   23 +-
 .../selftests/net/srv6_end_dx6_netfilter_test.sh   |   23 +-
 .../testing/selftests/net/srv6_end_flavors_test.sh |   23 +-
 .../selftests/net/srv6_end_next_csid_l3vpn_test.sh |   19 +-
 .../net/srv6_end_x_next_csid_l3vpn_test.sh         |   19 +-
 .../selftests/net/srv6_hencap_red_l3vpn_test.sh    |   19 +-
 .../selftests/net/srv6_hl2encap_red_l2vpn_test.sh  |   19 +-
 .../selftests/net/test_bridge_backup_port.sh       |   32 +-
 .../selftests/net/test_bridge_neigh_suppress.sh    |   34 +-
 tools/testing/selftests/net/test_neigh.sh          |   66 +-
 tools/testing/selftests/net/test_vxlan_mdb.sh      |   32 +-
 .../selftests/net/test_vxlan_nolocalbypass.sh      |   32 +-
 .../selftests/net/test_vxlan_vnifiltering.sh       |   26 +-
 tools/testing/selftests/net/tun.c                  |    9 +
 tools/testing/selftests/net/veth.sh                |   30 +
 tools/testing/selftests/net/vrf-xfrm-tests.sh      |   19 +-
 tools/testing/selftests/net/vrf_route_leaking.sh   |   19 +-
 .../testing/selftests/net/vrf_strict_mode_test.sh  |   19 +-
 tools/testing/selftests/net/xfrm_policy.sh         |    2 +-
 .../tc-testing/tc-tests/actions/batch-delete.json  |   33 +
 .../selftests/tc-testing/tc-tests/actions/ife.json |    2 +-
 .../tc-testing/tc-tests/infra/qdiscs.json          |    4 +
 .../selftests/tc-testing/tc-tests/qdiscs/hfsc.json |    2 +-
 tools/testing/selftests/tc-testing/tdc.sh          |   14 +
 tools/testing/vsock/util.c                         |    9 +
 tools/testing/vsock/util.h                         |    1 +
 tools/testing/vsock/vsock_test.c                   |  279 +
 tools/testing/vsock/vsock_uring_test.c             |  391 ++
 2083 files changed, 94685 insertions(+), 110398 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hns-dsaf-v1.yaml
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hns-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon,hns-nic.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,sa8255p-ethqos.yaml
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl8224-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/snps,dwmac-common.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wl1251.yaml
 create mode 100644 Documentation/devicetree/bindings/net/wiznet,w5100.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wiznet,w5x00.txt
 create mode 100644 Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
 create mode 100644 Documentation/netlink/specs/gtp.yaml
 create mode 100644 Documentation/netlink/specs/rt-nexthop.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
 create mode 100644 Documentation/networking/devlink/ptp_ocp.rst
 rename drivers/bluetooth/{btusb.c => btusb_main.c} (94%)
 create mode 100644 drivers/bluetooth/btusb_qcom.c
 create mode 100644 drivers/bluetooth/btusb_qcom.h
 delete mode 100644 drivers/infiniband/hw/mlx5/data_direct.c
 delete mode 100644 drivers/infiniband/hw/mlx5/data_direct.h
 delete mode 100644 drivers/net/dsa/ks8995.c
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 create mode 100644 drivers/net/dsa/motorcomm/chip.c
 create mode 100644 drivers/net/dsa/motorcomm/chip.h
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.c
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.h
 create mode 100644 drivers/net/dsa/motorcomm/mib.c
 create mode 100644 drivers/net/dsa/motorcomm/mib.h
 create mode 100644 drivers/net/dsa/motorcomm/pcs-921x.c
 create mode 100644 drivers/net/dsa/motorcomm/pcs.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h
 create mode 100644 drivers/net/dsa/motorcomm/tc.c
 create mode 100644 drivers/net/dsa/motorcomm/tc.h
 delete mode 100644 drivers/net/dsa/yt921x.c
 delete mode 100644 drivers/net/dsa/yt921x.h
 rename drivers/net/ethernet/intel/ice/{ice_ethtool_fdir.c => ice_ethtool_ntuple.c} (94%)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/data_direct.c
 create mode 100644 drivers/net/ethernet/meta/mpnic/Makefile
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic.h
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_csr.h
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_init.c
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_irq.c
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_pci.c
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
 create mode 100644 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
 create mode 100644 drivers/net/ethernet/microchip/fdma/fdma_pci.c
 create mode 100644 drivers/net/ethernet/microchip/fdma/fdma_pci.h
 create mode 100644 drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
 create mode 100644 drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
 create mode 100644 drivers/net/ethernet/microsoft/mana/gdma_cdx.c
 create mode 100644 drivers/net/ethernet/microsoft/mana/gdma_pci.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
 delete mode 100644 drivers/net/ethernet/smsc/smc9194.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 drivers/net/phy/phy_fixup.c
 create mode 100644 drivers/net/phy/xpowers/Makefile
 create mode 100644 drivers/net/phy/xpowers/ac200.c
 create mode 100644 drivers/net/phy/xpowers/ac300.c
 create mode 100644 drivers/net/phy/xpowers/acx00.c
 create mode 100644 drivers/net/phy/xpowers/acx00.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_stats.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/ctxt-info-v2.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/ctxt-info.h
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-io.c
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-io.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/tx-gp2.c
 rename drivers/net/wireless/intel/iwlwifi/pcie/{gen1_2 => }/internal.h (92%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{gen1_2 => }/rx.c (93%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{gen1_2 => }/trans-gen2.c (87%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{gen1_2 => }/trans.c (84%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{gen1_2 => }/tx-gen2.c (99%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{gen1_2 => }/tx.c (94%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/cached_cal.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/cached_cal.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723b.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723b.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723b_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723b_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723bs.c
 delete mode 100644 drivers/staging/rtl8723bs/Kconfig
 delete mode 100644 drivers/staging/rtl8723bs/Makefile
 delete mode 100644 drivers/staging/rtl8723bs/TODO
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_ap.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_btcoex.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_cmd.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_efuse.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_ieee80211.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_io.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_mlme.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_recv.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_security.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_wlan_util.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_xmit.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/Hal8723BReg.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalPhyRf.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalPhyRf.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/Mp_Precomp.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/hal_btcoex.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/hal_com.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/hal_intf.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/hal_pwr_seq.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/hal_sdio.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_CfoTracking.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_DIG.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_DIG.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_DynamicBBPowerSaving.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_DynamicBBPowerSaving.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_DynamicTxPower.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_DynamicTxPower.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_HWConfig.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_HWConfig.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_interface.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_precomp.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_reg.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_types.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/sdio_halinit.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/sdio_ops.c
 delete mode 100644 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h
 delete mode 100644 drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h
 delete mode 100644 drivers/staging/rtl8723bs/include/basic_types.h
 delete mode 100644 drivers/staging/rtl8723bs/include/cmd_osdep.h
 delete mode 100644 drivers/staging/rtl8723bs/include/drv_types.h
 delete mode 100644 drivers/staging/rtl8723bs/include/drv_types_sdio.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_btcoex.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_com.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_com_h2c.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_com_phycfg.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_com_reg.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_data.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_intf.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_pg.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_phy.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_phy_cfg.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_phy_reg.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_pwr_seq.h
 delete mode 100644 drivers/staging/rtl8723bs/include/hal_sdio.h
 delete mode 100644 drivers/staging/rtl8723bs/include/ieee80211.h
 delete mode 100644 drivers/staging/rtl8723bs/include/ioctl_cfg80211.h
 delete mode 100644 drivers/staging/rtl8723bs/include/osdep_intf.h
 delete mode 100644 drivers/staging/rtl8723bs/include/osdep_service.h
 delete mode 100644 drivers/staging/rtl8723bs/include/osdep_service_linux.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8192c_recv.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8723b_dm.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8723b_hal.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8723b_recv.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8723b_rf.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8723b_spec.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_ap.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_btcoex.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_byteorder.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_cmd.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_eeprom.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_efuse.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_event.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_ht.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_io.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_mlme.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_qos.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_recv.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_rf.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_security.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_version.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_wifi_regd.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_xmit.h
 delete mode 100644 drivers/staging/rtl8723bs/include/sdio_hal.h
 delete mode 100644 drivers/staging/rtl8723bs/include/sdio_ops.h
 delete mode 100644 drivers/staging/rtl8723bs/include/sdio_ops_linux.h
 delete mode 100644 drivers/staging/rtl8723bs/include/sta_info.h
 delete mode 100644 drivers/staging/rtl8723bs/include/wifi.h
 delete mode 100644 drivers/staging/rtl8723bs/include/wlan_bssdef.h
 delete mode 100644 drivers/staging/rtl8723bs/include/xmit_osdep.h
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/os_intfs.c
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/osdep_service.c
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/sdio_intf.c
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/wifi_regd.c
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/xmit_linux.c
 create mode 100644 include/linux/mlx5/data_direct.h
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h
 create mode 100644 include/net/bluetooth/hci_h4.h
 delete mode 100644 include/net/llc_c_ac.h
 delete mode 100644 include/net/llc_c_ev.h
 delete mode 100644 include/net/llc_c_st.h
 delete mode 100644 include/net/llc_conn.h
 delete mode 100644 include/net/llc_if.h
 delete mode 100644 include/net/llc_s_ac.h
 delete mode 100644 include/net/llc_s_ev.h
 delete mode 100644 include/net/llc_s_st.h
 delete mode 100644 include/net/llc_sap.h
 delete mode 100644 include/net/phy/realtek_phy.h
 create mode 100644 net/bluetooth/hci_h4.c
 create mode 100644 net/dsa/tag_ks8995.c
 create mode 100644 net/ethtool/port.c
 create mode 100644 net/ipv4/tcp_roccet.c
 delete mode 100644 net/llc/af_llc.c
 delete mode 100644 net/llc/llc_c_ac.c
 delete mode 100644 net/llc/llc_c_ev.c
 delete mode 100644 net/llc/llc_c_st.c
 delete mode 100644 net/llc/llc_conn.c
 delete mode 100644 net/llc/llc_if.c
 delete mode 100644 net/llc/llc_pdu.c
 delete mode 100644 net/llc/llc_proc.c
 delete mode 100644 net/llc/llc_s_ac.c
 delete mode 100644 net/llc/llc_s_ev.c
 delete mode 100644 net/llc/llc_s_st.c
 delete mode 100644 net/llc/llc_sap.c
 delete mode 100644 net/llc/llc_station.c
 delete mode 100644 net/llc/sysctl_net_llc.c
 create mode 100755 tools/testing/selftests/drivers/net/gro_hw.py
 rename tools/testing/selftests/drivers/net/{gro.py => gro_lib.py} (74%)
 mode change 100755 => 100644
 create mode 100755 tools/testing/selftests/drivers/net/gro_lro.py
 create mode 100755 tools/testing/selftests/drivers/net/gro_sw.py
 rename tools/testing/selftests/drivers/net/hw/{gro_hw.py => gro_stats.py} (100%)
 create mode 100755 tools/testing/selftests/drivers/net/hw/pause.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/vlan.py
 create mode 100644 tools/testing/selftests/drivers/net/lib/py/feat.py
 create mode 100755 tools/testing/selftests/drivers/net/pppoe_gro.py
 create mode 100755 tools/testing/selftests/drivers/net/rss_key.py
 create mode 100644 tools/testing/selftests/drivers/net/ruff.toml
 create mode 100755 tools/testing/selftests/net/fou_gre_gro.sh
 create mode 100755 tools/testing/selftests/net/gtp.py
 create mode 100755 tools/testing/selftests/net/netdev_lock.py
 create mode 100755 tools/testing/selftests/net/ovpn/test-tcp-nagle.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_ssthresh_scaling_ratio.pkt
 create mode 100644 tools/testing/selftests/net/ruff.toml
 create mode 100644 tools/testing/selftests/net/so_reserve_mem.c

