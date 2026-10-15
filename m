Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BD4AB1AF;
	Thu, 15 Oct 2026 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051568; cv=none; b=ZKCgo1EUpksZdkdStUU6PPjyib0QNoz9QCy8gMtjb6ee/nmyaT2038Io2aHkHZ4RYrDuqtGfVFkDNxjvSWFvZ6OLPXcFH3PhjpxEf/NOie+etgDU9k8+CPbvnhRGkJzUKmiAqC5kZYnAf++yBuPkQ8TsLmd8OCZGKWaB+U1NByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051568; c=relaxed/simple;
	bh=oJYs7+FOwLb/dKXfajd3vQUQya8Guws/380sm2/4hfw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CmRsHYrwRAyIiLY1i+UU8CnnrsS7bqTrxUYgVrH15xLd1P07lco7PgjzEeaZUB8YTrCxE3wnj82vfiAG4nQVfxldti2Sp5+88/iRYw7ZsiWo/l9OnJuJ/MDB0JbjJQKo1KexsumK9WlgT5FNg6E7KFnX4oaiZJyhFEgzzI78KTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FQGpeK5y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FQGpeK5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051572; x=1823587572;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=oJYs7+FOwLb/dKXfajd3vQUQya8Guws/380sm2/4hfw=;
  b=FQGpeK5y/bhWuq2a8kbU/5HczskMA0pxPFWiGsXVJeyKHPvcFMXCD1jC
   HF7qFGTcUSGK51LHmq8DQDh9gJ2g3lK+MWpR61JUDDIahrtd6rlR9ox9G
   VmBRpb6dWvXmSLGQxwlx6kqzUrGh18W1nqJgkfMx8f+cmu1AcUUzz87Dp
   TD6nqZSfHk+raj/1xQLIJV26aQcKfbOqKJPxvO5sUMhX3qU4lrjoRxQ/K
   K00t9eTWzuOo6b5e356pdXP1R9XuqqX1nTh1qVnWuImvS/bL5msbl+3Ds
   IfUd+/kRC4vFr/0ND8HTGVw2Bx/9cm5mXdxCyaEZ0KP9EikCifu6HjXC9
   g==;
X-CSE-ConnectionGUID: QDn73zA7SG6a8htV0XFwXw==
X-CSE-MsgGUID: R06jeVEcQReB2wyymeBBrg==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="296490670"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 01:06:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 15 Oct 2026 01:06:04 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 15 Oct 2026 01:05:58 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Subject: [PATCH net-next v15 0/9] net: dsa: add DSA support for the
 LAN9645x switch chip family
Date: Thu, 15 Oct 2026 10:05:54 +0200
Message-ID: <20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGOJ0GoC/43TzWrkMAwH8FcpOTeLJNuy3VPfY1kGf+4Y2kxJh
 uwsZd59nVwSWENyTAw/2ZL+392UxpKm7u3luxvTXKZyG+oHqteXLlzd8Dv1JdYfHQExEEIfJ3f
 5cINlqR6X6U+5h+sljmVO48W7KfUCyfschE7Rd1X5GlMuj7XEz25I935Ij3v3q55cy3S/jX/X2
 jOu52sVAeKwyow99D5nExwKy1m9f5Yw3sK1fP0It8/Vn2lnkjw2qZpZK5BJeGCDLVNspjzRjVl
 U07kYjLJKAMeWKXemOGHK5Z7oGUBlZ7xumWozFZpjU1XTssk+C5mzEy2TdybpY5OrKaME6xLLL
 ELL1JvJZ+aul7lTtpBYs4bm281maqBj0yxvByITjfdOmZZp9+aJftpqQkSF5ARxbN4TYYfimaW
 HZZukMeygjgqbW4+7KBlQJ9QlSwA6+WCNcOCa6i5M9kwDcEkTRXZOWaEgNDcfd3GyZE+oS54M6
 UBRMOpMTXULFMKpuy6JEpGcJmYk/G/7n8/nP3+WzwIrBQAA
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

This series provides the Microchip LAN9645X Switch driver.

The LAN9645x is a family of chips with ethernet switch functionality and
multiple peripheral functions. The switch delivers up to 9 ethernet
ports and 12 Gbps switching bandwidth.

The switch chip has 5 integrated copper PHYs, support for 2x RGMII
interfaces, 2x SGMII and one QSGMII interface.

The switch chip is from the same design architecture family as ocelot
and lan966x, and the driver reflects this similarity. However, LAN9645x
does not have an internal CPU in any package, and must be driven
externally. For register IO it supports interfaces such as SPI, I2C and
MDIO.

The chip supports a variety of network features such as

* Mactable for MDB/FDB functionality
* Bridge forwarding offload
* VLAN-aware bridging
* IGMP/MLD snooping
* Link aggregation
* PTP timestamping
* FRER (802.1CB)
* Media Redundancy Protocol
* Parallel Redundancy and High-Availability Seamless Redundancy
  (HSR/PRP) in DANH/DANP mode
* Per stream filtering and policing
* Shapers such as Credit Based Shaping and Time Aware Shaing
* Frame preemption
* A TCAM (VCAP) for line-rate frame processing

The LAN9645x family consists of the following SKUs:

LAN96455F
LAN96457F
LAN96459F
LAN96455S
LAN96457S
LAN96459S

The difference between the SKUs is the number of supported ports (5, 7
or 9) and features supported. The F subfamily supports HSR/PRP and TSN,
while the S subfamily does not.

The intended way to bind this driver is using a parent MFD driver,
responsible for the register IO protocol, and distributing regmaps to
child devices. The goal is to use the same approach as the MFD driver in
drivers/mfd/ocelot-spi.c, which also resets the chip before it
instantiates its children.

This driver expects to request named regmaps from a parent device. This
approach is similar to the DSA driver

drivers/net/dsa/ocelot/ocelot_ext.c

which supports being driven by an external CPU via SPI with parent
device drivers/mfd/ocelot-spi.c.

The MFD driver will come in a later series, because there are
requirements on the number of child devices before a driver qualifies as
a MFD device.

Development is done using the LAN966x as a host CPU, running the lan966x
swichdev driver, using the EVB-LAN9668 EDS2 board.

The datasheet is available here:
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/LAN9645xF-Data-Sheet-DS00006065.pdf

This series will deliver the following features:

* Standalone ports
* Bridge forwarding and FDB offloading
* Multicast forwarding and MDB offloading
* VLAN-aware bridge
* Stats integration

More support will be added at a later stage. Here is a tentative plan of
future patches for this DSA driver:

* Add LAG support.
* Add TC matchall mirror support.
* Add TC matchall police support.
* Add DCB/qos support.
* Add simple TC support: mqprio, cbs, tbf, ebf.
* Add TC flower filter support.
* Add HSR/PRP offloading support.
* Add PTP support.
* Add TC taprio support.

For completeness I include tentative plan of planned patches for
LAN9645x peripherals:

* Extend pinctrl-ocelot for LAN9645x:
  https://lore.kernel.org/linux-gpio/20260119-pinctrl_ocelot_extend_support_for_lan9645x-v1-0-1228155ed0ee@microchip.com/
* Add driver for internal PHY:
  https://lore.kernel.org/netdev/20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com/
* MFD driver for managing register IO protocol and child device
  initialization.
* Extend pinctrl-microchip-sgpio for LAN9645x support.
* Extend i2c_designware for LAN9645x support.
* Add driver for outbound interrupt controller.
* Add serdes driver for lan9645x.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v15:
- Individual patches mention specific v15 changes
- basic: on link down, assert MAC_TX_RST and MAC_RX_RST instead of
  flushing the queues and asserting PORT_RST, which can hang the port
  when the MAC cannot transmit the frames still queued.
- vlan: refuse VLAN filtering on bridges with a vlan_protocol other than
  802.1Q, and only apply VLAN awareness while a port is bridged, so a
  join after a failed one is configured correctly.
- Link to v14: https://lore.kernel.org/r/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213@microchip.com

Changes in v14:
- Individual patches mention specific v14 changes
- tag: classify untagged and priority tagged frames to VID 0 on xmit,
  pull the VLAN header before reading it, restore the VLAN tag on rcv
  whenever one was popped, and add a .flow_dissect callback that
  accounts for popped VLAN tags.
- bindings: use the dt-bindings: net: dsa: subject prefix, and describe
  all switch register targets and the analyzer and PTP interrupts.
- vlan: use TAG_NO_UNAWARE on ports with only tagged VLANs.
- mac table: keep a CPU port host entry while another database uses the
  same MAC table key.
- mdb: keep the PGID reference when a mac table write fails while
  widening a group, drop it on a failed narrow that keeps the same PGID,
  and keep a CPU port host entry while another database uses the same
  mac table key.
- bridge: only enable learning on bridged ports, start a joining port
  disabled so it does not learn before its STP state is applied, and
  honour host flood requests from bridged ports.
- stats: return 0 from get_sset_count() for other string sets, leave
  RMON fragments unset, and describe the pMAC counters correctly.
- Link to v13: https://lore.kernel.org/r/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2@microchip.com

Changes in v13:
- Individual patches mention specific v13 changes
- bindings: Drop the commit message paragraph citing
  Documentation/networking/phy.rst.
- basic: only redirect the CPU extraction queues to the NPI port while
  its link is up, and flush the CPU port module on NPI link up.
- Rebased on net-next, bumping DSA_TAG_PROTO_LAN9645X_VALUE to 37
- Link to v12: https://lore.kernel.org/r/20260908-dsa_lan9645x_switch_driver_base-v12-0-2d6aa59350cd@microchip.com

Changes in v12:
- reorder the series so bridge support lands after vlan, mac table and
  mdb support. port_fast_age() now exists before the STP state handling
  that needs it, and host address filtering is in place before bridging.
- include the CPU port module in the flood masks from the start, and
  remove it again in the bridge patch where port_set_host_flood() takes
  over on demand host flooding. Previously the host could not receive
  unicast until the mac table patch.
- vlan: serialize the VLAN table with fwd_domain_lock, and describe the
  untagged VLAN, TPID and C-component conformance limitations.
- tag driver: move an out-of-band VLAN tag into the payload before
  reading it, instead of relying on the conduit never advertising a VLAN
  TX offload.
- tag driver: restore the classified VLAN as a C-tag rather than following
  the IFH tag type, so a terminated frame lands on the VID the hardware
  forwarded it on.
- basic: drop the tail drop watermark setup, which programmed a
  condition that could not trigger.
- mdb: handle PGID exhaustion on both the add and delete paths, rather
  than leaving a departed port in the group.
- mdb: classify IPv4 multicast on the 01:00:5E prefix alone. Hardware does
  not apply the 23-bit rule, so some groups were programmed as entries it
  never matches.
- stats: give the hardware counters and the software shadow a common
  baseline, fix some rtnl_link_stats64 fields, and stop reporting the
  three eth-mac fields the hardware cannot measure.
- stats: stop the counter poller in .shutdown, which kept reading
  registers after the parent had been shut down.
- Link to v11: https://lore.kernel.org/r/20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com

Changes in v11:
- Update comment about vlan tag hwaccel use in tag driver.
- Bump DSA_TAG_PROTO value in include/net/dsa.h.
- stats: add comment about calling contexts of sw_lock in
  lan9645x_stats_get_stats64
- Link to v10: https://lore.kernel.org/r/20260713-dsa_lan9645x_switch_driver_base-v10-0-a4886a08fb15@microchip.com

Changes in v10:
- Individual patches mention specific v10 changes
- Update tag driver after skb ownership model change in DSA taggers.
- Link to v9: https://lore.kernel.org/r/20260708-dsa_lan9645x_switch_driver_base-v9-0-0d1512a326d7@microchip.com

Changes in v9:
- Individual patches mention specific v9 changes
- Drop RGMII muxing to port 4.
- Link to v8: https://lore.kernel.org/r/20260702-dsa_lan9645x_switch_driver_base-v8-0-90228d8bba58@microchip.com

Changes in v8:
- Individual patches mention specific v8 changes
- Do not use the name CPU_PORT for the chips internal CPU port module,
  as it collides with the DSA CPU port (the NPI front port). Drop the
  CPU_PORT macro and reference the module as lan9645x->num_phys_ports,
  mirroring ocelot/felix.
- Reword the port map and related comments to distinguish the chip CPU
  port modules (indices 9-10) from the DSA CPU port.
- Add a port_mux_lock mutex to serialize port mux arbitration in
  the phylink mac_prepare path.
- Link to v7: https://lore.kernel.org/r/20260603-dsa_lan9645x_switch_driver_base-v7-0-b2f90e676707@microchip.com

Changes in v7:
- Individual patches mention specific v7 changes
- Do not mark the BPDU range 01:80:C2:00:00:0X as offloaded in the tag driver.
- Refactor cpu queue based frame classification to use categories default, trap
  and copy, which mirrors usage instead of being based on frame types.
- Add registers ANA:COMMON:CPUQ_8021_CFG for bpdu cpu queue configuration.
- Use cpu queue LAN9645X_CPUQ_TRAP for bpdu frames.
- Refactor IGMP/MLD/IPMC_CTRL to use new LAN9645X_CPUQ_DEF,
  LAN9645X_CPUQ_TRAP and LAN9645X_CPUQ_COPY queues.
- Add __aligned(2) to mac variable in lan9645x_mdb_update_dest.
- Link to v6: https://lore.kernel.org/r/20260527-dsa_lan9645x_switch_driver_base-v6-0-4d409ae64f3c@microchip.com

Changes in v6:
- Individual patches mention specific v6 changes
- Rebased on net-next, bumping DSA_TAG_PROTO_LAN9645X_VALUE to 34
- Link to v5: https://lore.kernel.org/r/20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com

Changes in v5:
- Individual patches mention specific v5 changes
- Undo offset fix in postpull_rcsum. The original logic was correct for
  CHECKSUM_COMPLETE host NICs
- Use __always_inline in lan9645x_ifh_{get,set}
- remove double space after = in set_merge_mask
- remove unused fields dd_dis and tsn_dis, and add SKU supported port validation
  during setup
- phylink: remove MAC_2500FD
- phylink: add comment about empty supported_interfaces for port 5-6.
- phylink: fix 2:1 rgmii port muxing for port module 4 and 7 to be fully
  dynamic and validate requested mux settings.
- phylink: add comment about 2:1 rgmii port muxing for port module 4
  and 7.
- rx/tx-internal-delay-ps checked against supported 2ns value
- init lan9645x->npi = -1 at probe and check port < 0 in npi_deinit
- use ds->ageing_time_max
- use packed p->host_flood_req for atomic r/w
- fix typo in set_ageing_time comment
- include lan9645x->bridge deref under lock in brige_join
- switch -EBUSY to -EINVAL for vlan add/del in the reserved range.
- remove reserved HSR vlan
- lan9645x_mac_init returns error on table init timeout
- add comment about skipping LOCKED entries on fdb dump
- skip igmp/mld redir for npi port
- make lan9645x_stats_init void
- add SCNT_TX_BUFDROP to tx_dropped
- change rmon range {0,64} -> {64, 64}. Runt frames counted elsewhere.
- remove rx_crc, rx_symbol_err from rx_packets, as they are already
  counted in SZ_* buckets.
- add defensive cancel_delayed_work_sync in stats_free
- Link to v4: https://lore.kernel.org/r/20260430-dsa_lan9645x_switch_driver_base-v4-0-f1b6005fa8b7@microchip.com

Changes in v4:
- v3 was deferred, but I made some changes based on the Sashiko review
- Individual patches mention specific v4 changes
- Fix offset in postpull_rcsum so prefix eth header is cleared, not
  actual eth header, so tag driver works with CHECKSUM_COMPLETE host
  NICs
- Fix untagged rx on vlan aware port with pvid
- Add comment to QSYS_RES_CFG configuration
- Phylink_mac_prepare: fix to make sure we can dynamically change rgmii
  on port 4
- Move ports allocation to probe
- tag_npi_setup: reject cascaded setups
- Skip WARN_ON in lan9645x_to_port
- set_host_flood changed to per port work to coalesce values and skip
  atomic allocations
- Fix clear HOST_PVID vlan membership when a port joins a bridge.
- Explicit default value write to tag type register for untagged frames
- Use lan_rmw for ANA_DROP_CFG
- Add comment for error path in lan9645x_vlan_hw_wr
- Remove mac_entries list and just do direct IO to mac table from
  fdb_add/fdb_del.
- Clean up fresh mdb when hw mac table write fails.
- Remove rx_uc and tx_uc from ethtool stats list, as they are derivable
  from the eth-mac group
- Split stats_init into stats_alloc and stats_init, use alloc in probe
  and init in dsa_setup
- Link to v3: https://lore.kernel.org/r/20260410-dsa_lan9645x_switch_driver_base-v3-0-aadc8595306d@microchip.com

Changes in v3:
- Individual patches mention specific v3 changes.
- Add guard before vlan_remove_tag on xmit
- Add pskb_may_pull checks on rx
- Remove additionalProperties: true in bindings
- Remove unnecessary | from description in bindings
- Change top level $ref to dsa.yaml#/$defs/ethernet-ports
- Use ethernet-ports and ethernet-port
- Move ethernet-ports under properties instead of patternProperties
- Move unevaluatedProperties: false after $ref
- Update bindings example to use ethernet-ports and ethernet-port
- Move DEV_MAC_TAGS_CFG to port setup, instead of vlan config, so vlan
  overhead is always included in port frame maxlen calculation.
- Remove code disabling ipv6 on conduit
- Use of_property_read_u32 for {rx,tx}-internal-delay-ps
- Use dsa_user_ports(ds) instead of
  GENMASK(lan9645x->num_phys_ports - 1, 0) as base flood mask.
- Add comment explaining obey vlan
- Allow disabling aging with explicit zero parameters.
- Fix non-forwarding STP states in bridge fwd calculation.
- Restore host flood state on bridge leave.
- Avoid mac_entry dealloc when mac table writes fail.
- Avoid mdb_entry dealloc when mac table writes fail.
- Dealloc mac_entries on deinit.
- Dealloc mdb_entries on deinit.
- Link to v2: https://lore.kernel.org/r/20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com

Changes in v2:
- Individual patches have specific v2 changes.
- Ran DSA, and std counters, selftests, which prompted several changes.
  The following selftests pass, except for some expected failures:
    - bridge_vlan_aware.sh
    - bridge_vlan_unaware.sh
    - bridge_vlan_mcast.sh
    - no_forwarding.sh
    - bridge_mdb.sh
    - bridge_mld.sh
    - test_fdb_stress_test.sh
    - .../drivers/net/hw/ethtool_rmon.sh
    - .../drivers/net/hw/ethtool_std_stats.sh (from Ioana's series)
- Added new patch for MDB management, as this was required for selftests.
- Added port_set_host_flood to enable unknown traffic to standalone during
  promisc/ALL_MULTI (selftests).
- Remove the dubugfs.
- Link to v1: https://lore.kernel.org/r/20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com

---
Jens Emil Schulz Østergaard (9):
      net: dsa: add tag driver for LAN9645X
      dt-bindings: net: dsa: add Microchip LAN9645x switch
      net: dsa: lan9645x: add autogenerated register macros
      net: dsa: lan9645x: add basic dsa driver for LAN9645X
      net: dsa: lan9645x: add vlan support
      net: dsa: lan9645x: add mac table integration
      net: dsa: lan9645x: add mdb management
      net: dsa: lan9645x: add bridge support
      net: dsa: lan9645x: add port statistics

 .../net/dsa/microchip,lan96455s-switch.yaml        |  208 +++
 MAINTAINERS                                        |   10 +
 drivers/net/dsa/Kconfig                            |    2 +
 drivers/net/dsa/microchip/Makefile                 |    1 +
 drivers/net/dsa/microchip/lan9645x/Kconfig         |   12 +
 drivers/net/dsa/microchip/lan9645x/Makefile        |   12 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_mac.c  |  268 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 1073 +++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h |  443 +++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c  |  582 ++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  |  116 ++
 .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  |  316 ++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c |  180 ++
 drivers/net/dsa/microchip/lan9645x/lan9645x_regs.h | 1932 ++++++++++++++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.c    |  854 +++++++++
 .../net/dsa/microchip/lan9645x/lan9645x_stats.h    |  229 +++
 drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c |  411 +++++
 include/linux/dsa/lan9645x.h                       |   54 +
 include/net/dsa.h                                  |    2 +
 net/dsa/Kconfig                                    |   11 +
 net/dsa/Makefile                                   |    1 +
 net/dsa/tag_lan9645x.c                             |  514 ++++++
 22 files changed, 7231 insertions(+)
---
base-commit: 518bf436318e8d1162391cd77d69d65198a4a25b
change-id: 20260210-dsa_lan9645x_switch_driver_base-312bbfc37edb

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

