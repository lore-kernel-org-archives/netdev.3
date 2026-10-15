Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFB4ADD9B;
	Thu, 15 Oct 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051590; cv=none; b=XfDSlCGne+2jet8cF/Ekihi4Nmej2Aa16q4e5NZpCLqOWAkGKLzH3x2W6gCvPhTnoI7EfMqcBy1cKi+S2Deuq4sOKqsn5dHgdv5fA2Yx2aKz491Y0Sjzgq4D7Pb8hgDXsqaCySsqyKGH7CC+3Jf6kOgCBeHlI3JOuW5yMW4h4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051590; c=relaxed/simple;
	bh=4AHgwgYlttdvIkYkYZy1onWf25vyhCogcUWTRDf4Nh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LyIA3Bu2NY09ada4lIm+0K7ZIttMNPr/CvgB0H5Guw+cEN/0yyx4dnNNODsVCZStIghMEVdkvygsDibhmNqPczsvCN/+oAJpjqyIleUxBj3Mq+qX0MRamMToPbMCsVf4viMxsTR4t8yq9dptTmjE6LKnEKaB5h0bq+JdXuHRmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RraUGXA9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RraUGXA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792051593; x=1823587593;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4AHgwgYlttdvIkYkYZy1onWf25vyhCogcUWTRDf4Nh0=;
  b=RraUGXA92NReA/mVPyTv3xtuXSNzUFwlE+TukLVxnk5sBsifrMbz8rS9
   JHe7Y0Er7QuZ/tzF5xZT3ak4EmlhwiD7zsqTPRKqSiilvi7/EdaMkm4YZ
   t9jfXYSH3RRTjOczY9gREpl46rn9PjnUkB196jZYmAY6nIzCYkyhOwLnC
   moScG3/Fk+MKLueTjDSq1kOAQd9/OjIgbIr3rtUJ6DGKriIPeF7n7d73k
   Wc/Xg0I36nLc5B8g6xMAV/pSKIxatIiMepnUZv2pdv4mSoQ7rUYLgAAfS
   AoJXo42zN0caYaOgpP/gz0qK8u/iGiTshMNas/pnmBqKVgYVn8+PY7KOo
   A==;
X-CSE-ConnectionGUID: FARu/vrCTUi++q38xjwbEA==
X-CSE-MsgGUID: 0L+4vHJ4Sm2079WsXhCPfw==
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="296490684"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 01:06:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 15 Oct 2026 01:06:23 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 15 Oct 2026 01:06:20 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Thu, 15 Oct 2026 10:05:58 +0200
Subject: [PATCH net-next v15 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261015-dsa_lan9645x_switch_driver_base-v15-4-562f316f78b9@microchip.com>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9@microchip.com>
In-Reply-To: <20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9@microchip.com>
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

Add the LAN9645X basic DSA driver with initialization, parent regmap
requests, port module initialization for NPI, CPU ports and front ports,
and phylink integration for MAC side configuration.

This patch only wires up the internal CuPHYs (ports 0-4) and the RGMII
paths for ports 7 and 8. The supported SerDes-based modes: SGMII,
QSGMII, 1000BASE-X and 2500BASE-X on ports 5-8 are deferred, and support
will be added in follow-up patches. Port 5-6 have no usable interface
mode in this patch, and should not be declared in DT until SerDes
support lands.

If port 5 or 6 is declared in DT as a user port, phylink_create()
rejects the empty supported_interfaces and dsa_tree_setup_ports() falls
back to setting the port up as unused, so the switch still probes.
DSA logs an error including the port number. Declared as a CPU port
there is no such fallback, and the probe fails, and our driver logs an
error including the port number.

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

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v15:
- Link down now asserts MAC_TX_RST and MAC_RX_RST instead of flushing
  the queues and asserting PORT_RST, which can hang the port when the
  MAC cannot transmit the frames still queued.

Changes in v13:
- Only redirect the CPU extraction queues to the NPI port while the
  NPI port link is up. This avoids queuing CPU frames to the NPI port
  while its MAC is held in reset.
- Configure CPU extraction group 0 for manual extraction, instead of
  the default where the VRAP engine owns it, so QSYS_SW_STATUS.EQ_AVAIL
  of the CPU port module can be polled when flushing it on NPI link up.

Changes in v12:
- Drop lan9645x_port_set_tail_drop_wm(). This tail dropping config
  is only active under cut through forwarding, which we never enable.
- lan9645x_reset_switch(): skip the memory init when the switch core is
  already enabled. We expect parent device to reset before probe, but if
  it does not, we must skip memory init if switch core is already
  enabled.
- Drop unused shared_queue_sz field and LAN9645X_BUFFER_MEMORY define.
- Set ds->max_num_bridges = 1 next to ds->fdb_isolation. We support a
  single offloaded bridge, so let the core enforce it.
- Reject an NPI port with no usable interface mode.
- Kconfig: select REGMAP.
- Include the CPU port module in the unicast and multicast flood masks.
  Host address filtering needs the fdb and mdb operations, and unknown
  traffic needs port_set_host_flood(), so until bridge support lands the
  host depends on flooding to receive anything.
- Describe in the commit what happens if port 5 or 6 is declared in DT.
- Drop unused register writes from lan9645x_port_cpu_init().
- Update PGID table comment.
- Drop the unused PGID_AGGR_NUM, LAN9645X_ISDX_MAX, LAN9645X_ESDX_MAX and
  LAN9645X_SFID_MAX defines, along with PGID_ENTRIES.
- Follow the LAN9645X_IFH_LEN rename in the tag driver.
- Drop ds->dscp_prio_mapping_is_global. It is only consulted after
  port_add_dscp_prio() or port_del_dscp_prio() succeeds, neither of which
  this series implements.
- Program QSYS_RES_CFG through lan9645x_wm_enc().
- Return -ENOMEM directly, not via dev_err_probe(), and add the missing
  newlines to the remaining probe messages.
- lan9645x_npi_port_deinit(): restore the NPI bit in the CPU port module
  source PGID that lan9645x_npi_port_init() cleared.
- Spell the part LAN9645x in the Kconfig prompt, the help text and
  MODULE_DESCRIPTION.
- Drop the unread NULL sentinel from lan9645x_resource_names[].
- Resolve the regmap and the register address once in
  lan9645x_rd_poll_timeout() and lan9645x_rd_poll_slow().
- lan9645x_get_max_mtu(): drop the NPI case. DSA only asks for the user
  port limit and adds the tag overhead back itself when it sizes the
  conduit MTU.
- lan9645x_phylink_mac_prepare(): drop the port range check. Ports 5 and 6
  get no phylink instance, and ds->num_ports bounds the rest.
- lan9645x_phylink_mac_link_up(): drop the unreachable SPEED_2500 case,
  and the DEV_CLOCK_CFG.LINK_SPEED fixup it forced.
  lan9645x_phylink_get_caps() does not advertise MAC_2500FD.
- Fix DEV_MAC_IFG_CFG.TX_IFG, which had its full and half duplex values
  swapped.
- Drop the unused afi target regmap request.
- Name the first per port regmap dev0 rather than dev, so the nine read
  uniformly.
- Bound the ANA_PGID_CFG.OBEY_VLAN loop at PGID_AGGR.
- lan9645x_phylink_mac_prepare(): drop the HSIO_HW_CFG.RGMII_0_CFG write.
  The field resets to DEV7 and nothing else writes it.
- lan9645x_phylink_port_down(): restore QSYS_SW_PORT_MODE.AGING_MODE to 2
  after the flush, which is the reset value, rather than 1. Mode 1 exempts
  frames from the CPU interface from the transmit ageing that
  lan9645x_setup() enables, and every port sat in it from probe.

Changes in v9:
- Drop the DEV4 RGMII muxing support.

Changes in v8:
- Remove the CPU_PORT macro, which named the chips internal CPU port
  module and collided with the DSA CPU port terminology. Reference the
  module as lan9645x->num_phys_ports.
- Rework the port map comment to distinguish the chip CPU port modules
  (indices 9-10) from the DSA CPU port (the NPI front port).
- Derive PGID_GP_START from NUM_PHYS_PORTS instead of CPU_PORT.
- Add a port_mux_lock mutex to serialize port mux arbitration in
  lan9645x_phylink_mac_prepare().

Changes in v7:
- use cpu queue LAN9645X_CPUQ_TRAP for bpdu frames

Changes in v5:
- remove dd_dis and tsn_dis, and add SKU supported port validation
  during setup
- phylink: remove MAC_2500FD
- phylink: add comment about empty supported_interfaces for port 5-6.
- phylink: fix 2:1 rgmii port muxing for port module 4 and 7 to be fully
  dynamic and validate requested mux settings.
- phylink: add comment about 2:1 rgmii port muxing for port module 4
  and 7.
- rx/tx-internal-delay-ps checked against support 2ns value
- update commit message
- init lan9645x->npi = -1 at probe and check port < 0 in npi_deinit

Changes in v4:
- add comment to QSYS_RES_CFG configuration
- phylink_mac_prepare: fix to make sure we can dynamically change rgmii
  on port 4
- move ports allocation to probe
- tag_npi_setup: reject cascaded setups
- skip WARN_ON in lan9645x_to_port

Changes in v3:
- move DEV_MAC_TAGS_CFG config to port setup, for vlan overhead in port
  frame maxlen
- remove code disabling ipv6 on conduit
- use of_property_read_u32 for {rx,tx}-internal-delay-ps
- use dsa_user_ports(ds) instead of
  GENMASK(lan9645x->num_phys_ports - 1, 0) as base flood mask.
- update obey vlan comment

Changes in v2:
- source Kconfig from drivers/net/dsa/Kconfig
- sorting in Kconfig and Makefiles
- remove unused struct fields
- remote path delays
- use port_setup and dp->dn instead of DTS parsing
- phylink: split rgmii setup into dll and speed config
- phylink: remove pcs/sgmii/qsgmii related code
- phylink: simplify mac_prepare
- phylink: remove phylink_ops wrappers
- phylink: remove unrelated config from link up
- phylink: reorder functions according to phylink call order
---
 drivers/net/dsa/Kconfig                            |   2 +
 drivers/net/dsa/microchip/Makefile                 |   1 +
 drivers/net/dsa/microchip/lan9645x/Kconfig         |  12 +
 drivers/net/dsa/microchip/lan9645x/Makefile        |   8 +
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 456 +++++++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_main.h | 348 ++++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  | 116 ++++++
 .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  | 316 ++++++++++++++
 drivers/net/dsa/microchip/lan9645x/lan9645x_port.c | 166 ++++++++
 9 files changed, 1425 insertions(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index fe8cd5338fda..d62f0cccf13d 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -82,6 +82,8 @@ config NET_DSA_MV88E6060
 
 source "drivers/net/dsa/microchip/Kconfig"
 
+source "drivers/net/dsa/microchip/lan9645x/Kconfig"
+
 source "drivers/net/dsa/motorcomm/Kconfig"
 
 source "drivers/net/dsa/mv88e6xxx/Kconfig"
diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/microchip/Makefile
index 9347cfb3d0b5..e75f17888f75 100644
--- a/drivers/net/dsa/microchip/Makefile
+++ b/drivers/net/dsa/microchip/Makefile
@@ -12,3 +12,4 @@ endif
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C)	+= ksz9477_i2c.o
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_SPI)		+= ksz_spi.o
 obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI)	+= ksz8863_smi.o
+obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X)	+= lan9645x/
diff --git a/drivers/net/dsa/microchip/lan9645x/Kconfig b/drivers/net/dsa/microchip/lan9645x/Kconfig
new file mode 100644
index 000000000000..4e3e0d2f5846
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NET_DSA_MICROCHIP_LAN9645X
+	tristate "Microchip LAN9645x switch support"
+	depends on NET_DSA
+	select NET_DSA_TAG_LAN9645X
+	select REGMAP
+	help
+	  This driver adds DSA support for Microchip LAN9645x switch chips.
+	  The lan9645x switch is a multi-port Gigabit AVB/TSN Ethernet Switch
+	  with five integrated 10/100/1000Base-T PHYs. In addition to the
+	  integrated PHYs, it supports up to 2 RGMII/RMII, up to 2
+	  BASE-X/SERDES/2.5GBASE-X and one Quad-SGMII/Quad-USGMII interfaces.
diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
new file mode 100644
index 000000000000..7cc0ae0ada40
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) += mchp-lan9645x.o
+
+mchp-lan9645x-objs := \
+	lan9645x_main.o \
+	lan9645x_npi.o \
+	lan9645x_phylink.o \
+	lan9645x_port.o \
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
new file mode 100644
index 000000000000..c7de3836e696
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/platform_device.h>
+
+#include "lan9645x_main.h"
+
+static const char *lan9645x_resource_names[NUM_TARGETS] = {
+	[TARGET_GCB]          = "gcb",
+	[TARGET_QS]           = "qs",
+	[TARGET_CHIP_TOP]     = "chip_top",
+	[TARGET_REW]          = "rew",
+	[TARGET_SYS]          = "sys",
+	[TARGET_HSIO]         = "hsio",
+	[TARGET_DEV + 0]      = "dev0",
+	[TARGET_DEV + 1]      = "dev1",
+	[TARGET_DEV + 2]      = "dev2",
+	[TARGET_DEV + 3]      = "dev3",
+	[TARGET_DEV + 4]      = "dev4",
+	[TARGET_DEV + 5]      = "dev5",
+	[TARGET_DEV + 6]      = "dev6",
+	[TARGET_DEV + 7]      = "dev7",
+	[TARGET_DEV + 8]      = "dev8",
+	[TARGET_QSYS]         = "qsys",
+	[TARGET_ANA]          = "ana",
+};
+
+static int lan9645x_tag_npi_setup(struct dsa_switch *ds)
+{
+	struct dsa_port *dp, *first_cpu_dp = NULL;
+	struct lan9645x *lan9645x = ds->priv;
+	struct phylink_config c = {};
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (dp->cpu_dp->ds != ds) {
+			dev_err(ds->dev,
+				"NPI port on a remote switch is not supported\n");
+			return -EINVAL;
+		}
+
+		if (first_cpu_dp && dp->cpu_dp != first_cpu_dp) {
+			dev_err(ds->dev, "Multiple NPI ports not supported\n");
+			return -EINVAL;
+		}
+
+		first_cpu_dp = dp->cpu_dp;
+	}
+
+	if (!first_cpu_dp)
+		return -EINVAL;
+
+	lan9645x_phylink_get_caps(lan9645x, first_cpu_dp->index, &c);
+	if (phy_interface_empty(c.supported_interfaces)) {
+		dev_err(ds->dev,
+			"Port %d has no usable interface mode, cannot be NPI port\n",
+			first_cpu_dp->index);
+		return -EINVAL;
+	}
+
+	lan9645x_npi_port_init(lan9645x, first_cpu_dp);
+
+	return 0;
+}
+
+static enum dsa_tag_protocol lan9645x_get_tag_protocol(struct dsa_switch *ds,
+						       int port,
+						       enum dsa_tag_protocol tp)
+{
+	return DSA_TAG_PROTO_LAN9645X;
+}
+
+static void lan9645x_teardown(struct dsa_switch *ds)
+{
+	struct lan9645x *lan9645x = ds->priv;
+
+	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
+}
+
+static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+{
+	return lan9645x_port_set_maxlen(ds->priv, port, new_mtu);
+}
+
+static int lan9645x_get_max_mtu(struct dsa_switch *ds, int port)
+{
+	/* Actual MAC max MTU is around 16KB. We set 10000 - overhead which
+	 * should be sufficient for all jumbo frames. Larger frames can cause
+	 * problems especially with flow control, since we only have 160K queue
+	 * buffer.
+	 *
+	 * DSA only asks for the user port limit, and adds the tag overhead
+	 * back when it sizes the conduit MTU, so the CPU port is not a case
+	 * here.
+	 */
+	return 10000 - ETH_HLEN - ETH_FCS_LEN;
+}
+
+static int lan9645x_reset_switch(struct lan9645x *lan9645x)
+{
+	u32 val = 0;
+	int err;
+
+	/* The parent must reset the whole chip before instantiating its
+	 * children, so the switch core is disabled when we get here. The
+	 * sequence below must not run more than once: initializing the
+	 * memories on a running core corrupts pointers inside the queue
+	 * system, which eventually fills up and stops passing traffic. If the
+	 * core is already enabled the chip was not reset, so skip it.
+	 */
+	if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
+		return 0;
+
+	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
+	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);
+	err = lan9645x_rd_poll_timeout(lan9645x, SYS_RAM_INIT, val,
+				       SYS_RAM_INIT_RAM_INIT_GET(val) == 0);
+	if (err) {
+		dev_err(lan9645x->dev, "Failed to init chip RAM.\n");
+		return err;
+	}
+	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(1), lan9645x, SYS_RESET_CFG);
+
+	return 0;
+}
+
+static int lan9645x_setup(struct dsa_switch *ds)
+{
+	struct lan9645x *lan9645x = ds->priv;
+	struct device *dev = lan9645x->dev;
+	u32 front_ports, res_wm;
+	int supported, used = 0;
+	struct dsa_port *dp;
+	int err;
+
+	lan9645x->num_phys_ports = ds->num_ports;
+	front_ports = dsa_user_ports(ds);
+	supported = lan9645x->num_phys_ports - lan9645x->num_port_dis;
+
+	dsa_switch_for_each_available_port(dp, ds)
+		used++;
+
+	if (used > supported) {
+		dev_err(ds->dev,
+			"%d physical ports in use in DT, SKU supports at most %d\n",
+			used, supported);
+		return -EINVAL;
+	}
+
+	err = lan9645x_reset_switch(lan9645x);
+	if (err)
+		return err;
+
+	err = lan9645x_tag_npi_setup(ds);
+	if (err) {
+		dev_err(dev, "Failed to setup NPI port.\n");
+		return err;
+	}
+
+	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
+	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
+	       ANA_AGGR_CFG_AC_DMAC_ENA,
+	       lan9645x, ANA_AGGR_CFG);
+
+	/* Flush queues */
+	lan_wr(GENMASK(1, 0), lan9645x, QS_XTR_FLUSH);
+
+	/* Allow to drain */
+	usleep_range(1000, 2000);
+
+	/* All Queues normal */
+	lan_wr(0x0, lan9645x, QS_XTR_FLUSH);
+
+	/* Set MAC age time to default value, the entry is aged after
+	 * 2 * AGE_PERIOD
+	 */
+	lan_wr(ANA_AUTOAGE_AGE_PERIOD_SET(BR_DEFAULT_AGEING_TIME / 2 / HZ),
+	       lan9645x, ANA_AUTOAGE);
+
+	/* Disable learning for frames discarded by VLAN ingress filtering */
+	lan_rmw(ANA_ADVLEARN_VLAN_CHK_SET(1),
+		ANA_ADVLEARN_VLAN_CHK,
+		lan9645x, ANA_ADVLEARN);
+
+	/* Queue system frame ageing. We target 2s ageing.
+	 *
+	 * Register unit is 1024 cycles.
+	 *
+	 * ASIC: 165.625 Mhz  ~ 6.0377 ns period
+	 *
+	 * 1024 * 6.0377 ns =~ 6182 ns
+	 * val = 2000000000ns / 6182ns
+	 */
+	lan_wr(SYS_FRM_AGING_AGE_TX_ENA_SET(1) |
+	       SYS_FRM_AGING_MAX_AGE_SET((2000000000 / 6182)),
+	       lan9645x,  SYS_FRM_AGING);
+
+	/* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and dataplane
+	 * use the same masks. Control frames are redirected to CPU, and
+	 * the network stack is responsible for forwarding these.
+	 * The dataplane is forwarding according to the offloaded MDB entries.
+	 */
+	lan_wr(ANA_FLOODING_IPMC_FLD_MC4_DATA_SET(PGID_MCIPV4) |
+	       ANA_FLOODING_IPMC_FLD_MC4_CTRL_SET(PGID_MC) |
+	       ANA_FLOODING_IPMC_FLD_MC6_DATA_SET(PGID_MCIPV6) |
+	       ANA_FLOODING_IPMC_FLD_MC6_CTRL_SET(PGID_MC),
+	       lan9645x, ANA_FLOODING_IPMC);
+
+	for (int prio = 0; prio < NUM_PRIO_QUEUES; ++prio)
+		lan_wr(ANA_FLOODING_FLD_MULTICAST_SET(PGID_MC) |
+		       ANA_FLOODING_FLD_UNICAST_SET(PGID_UC) |
+		       ANA_FLOODING_FLD_BROADCAST_SET(PGID_BC),
+		       lan9645x, ANA_FLOODING(prio));
+
+	/* Allow VLAN table to control whether cpu copy from the pgid table is
+	 * enabled. Only the destination analysis resolves a CPU copy, so the
+	 * aggregation and source regions are left at their reset value.
+	 */
+	for (int i = 0; i < PGID_AGGR; ++i)
+		lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
+		       lan9645x, ANA_PGID_CFG(i));
+
+	/* Disable bridging by default */
+	for (int p = 0; p < lan9645x->num_phys_ports; p++) {
+		lan_wr(0, lan9645x, ANA_PGID(PGID_SRC + p));
+
+		/* Do not forward BPDU frames to the front ports and trap them
+		 * to CPU
+		 */
+		lan_wr(ANA_CPU_FWD_BPDU_CFG_BPDU_REDIR_ENA,
+		       lan9645x, ANA_CPU_FWD_BPDU_CFG(p));
+	}
+
+	for (int i = 0; i < 16; i++) {
+		/* The register instance number corresponds to the
+		 * address of the extracted frame. For instance:
+		 * CPUQ_8021_CFG[4].CPUQ_BPDU_VAL
+		 * is the cpu extraction queue used for BPDU frames
+		 * with address 01-80-C2-00-00-04
+		 */
+		lan_rmw(ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL_SET(LAN9645X_CPUQ_TRAP),
+			ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL,
+			lan9645x, ANA_CPUQ_8021_CFG(i));
+	}
+
+	/* Reserve 1664 bytes, 26 buffer cells, per (port, prio) for source
+	 * tracking (resource 0, indices 0..95) and destination tracking
+	 * (resource 2, indices 512..607). These are access watermarks, not
+	 * pre-allocations: a flow draws from its reservation first, then
+	 * from the shared pool. Keeping the reservation above a max-size
+	 * Ethernet frame prevents a single frame from spilling into the
+	 * shared pool, and cause pause frames to be emitted without actual
+	 * congestion.
+	 */
+	res_wm = QSYS_RES_CFG_WM_HIGH_SET(lan9645x_wm_enc(QS_SRC_BUF_RSV));
+	for (int i = 0; i <= QSYS_Q_RSRV; ++i) {
+		lan_wr(res_wm, lan9645x, QSYS_RES_CFG(i));
+		lan_wr(res_wm, lan9645x, QSYS_RES_CFG(512 + i));
+	}
+
+	lan9645x_port_cpu_init(lan9645x);
+
+	/* Multicast to cpu and all front ports */
+	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
+	       ANA_PGID(PGID_MC));
+
+	/* IP multicast to cpu and all front ports */
+	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
+	       ANA_PGID(PGID_MCIPV4));
+	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
+	       ANA_PGID(PGID_MCIPV6));
+
+	/* Unicast to cpu and all front ports */
+	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
+	       ANA_PGID(PGID_UC));
+
+	/* Broadcast to cpu and all front ports */
+	lan_wr(BIT(lan9645x->num_phys_ports) | front_ports, lan9645x,
+	       ANA_PGID(PGID_BC));
+
+	ds->mtu_enforcement_ingress = true;
+	ds->assisted_learning_on_cpu_port = true;
+	ds->fdb_isolation = true;
+	ds->max_num_bridges = 1;
+
+	dev_info(lan9645x->dev,
+		 "SKU features: max_ports=%d\n",
+		 lan9645x->num_phys_ports - lan9645x->num_port_dis);
+
+	return 0;
+}
+
+static void lan9645x_port_phylink_get_caps(struct dsa_switch *ds, int port,
+					   struct phylink_config *config)
+{
+	lan9645x_phylink_get_caps(ds->priv, port, config);
+}
+
+static const struct dsa_switch_ops lan9645x_switch_ops = {
+	.get_tag_protocol		= lan9645x_get_tag_protocol,
+
+	.setup				= lan9645x_setup,
+	.teardown			= lan9645x_teardown,
+	.port_setup			= lan9645x_port_setup,
+
+	/* Phylink integration */
+	.phylink_get_caps		= lan9645x_port_phylink_get_caps,
+
+	/* MTU  */
+	.port_change_mtu		= lan9645x_change_mtu,
+	.port_max_mtu			= lan9645x_get_max_mtu,
+};
+
+static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
+{
+	const char *resource_name;
+	struct regmap *tgt_map;
+
+	for (int i = 0; i < NUM_TARGETS; i++) {
+		resource_name = lan9645x_resource_names[i];
+		if (!resource_name)
+			continue;
+
+		tgt_map = dev_get_regmap(lan9645x->dev->parent, resource_name);
+		if (IS_ERR_OR_NULL(tgt_map)) {
+			dev_err(lan9645x->dev, "Failed to get regmap=%s\n",
+				resource_name);
+			return -ENODEV;
+		}
+
+		lan9645x->rmap[i] = tgt_map;
+	}
+
+	return 0;
+}
+
+static void lan9645x_set_feat_dis(struct lan9645x *lan9645x)
+{
+	u32 feat_dis;
+
+	/* The features which can be physically disabled on some SKUs are:
+	 * 1) Number of ports can be 5, 7 or 9. Any ports can be used, the chip
+	 *    tracks how many are active.
+	 * 2) HSR/PRP. The duplicate discard table can be disabled.
+	 * 3) TAS, frame preemption and PSFP can be disabled.
+	 */
+	feat_dis = lan_rd(lan9645x, GCB_FEAT_DISABLE);
+
+	lan9645x->num_port_dis =
+		GCB_FEAT_DISABLE_FEAT_NUM_PORTS_DIS_GET(feat_dis);
+}
+
+static int lan9645x_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lan9645x *lan9645x;
+	struct dsa_switch *ds;
+	int err = 0;
+
+	lan9645x = devm_kzalloc(dev, sizeof(*lan9645x), GFP_KERNEL);
+	if (!lan9645x)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, lan9645x);
+	lan9645x->dev = dev;
+
+	err = lan9645x_request_target_regmaps(lan9645x);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to request regmaps\n");
+
+	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
+
+	lan9645x->ports = devm_kcalloc(lan9645x->dev, NUM_PHYS_PORTS,
+				       sizeof(struct lan9645x_port *),
+				       GFP_KERNEL);
+	if (!lan9645x->ports)
+		return -ENOMEM;
+
+	for (int port = 0; port < NUM_PHYS_PORTS; port++) {
+		struct lan9645x_port *p;
+
+		p = devm_kzalloc(lan9645x->dev, sizeof(*p), GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+
+		p->lan9645x = lan9645x;
+		p->chip_port = port;
+		lan9645x->ports[port] = p;
+	}
+
+	ds->dev = dev;
+	ds->num_ports = NUM_PHYS_PORTS;
+	ds->num_tx_queues = NUM_PRIO_QUEUES;
+
+	ds->ops = &lan9645x_switch_ops;
+	ds->phylink_mac_ops = &lan9645x_phylink_mac_ops;
+	ds->priv = lan9645x;
+
+	lan9645x->ds = ds;
+	lan9645x->npi = -1;
+
+	lan9645x_set_feat_dis(lan9645x);
+
+	err = dsa_register_switch(ds);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register DSA switch\n");
+
+	return 0;
+}
+
+static void lan9645x_remove(struct platform_device *pdev)
+{
+	struct lan9645x *lan9645x = dev_get_drvdata(&pdev->dev);
+
+	if (!lan9645x)
+		return;
+
+	/* Calls lan9645x DSA .teardown */
+	dsa_unregister_switch(lan9645x->ds);
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static void lan9645x_shutdown(struct platform_device *pdev)
+{
+	struct lan9645x *lan9645x = dev_get_drvdata(&pdev->dev);
+
+	if (!lan9645x)
+		return;
+
+	dsa_switch_shutdown(lan9645x->ds);
+
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+static const struct of_device_id lan9645x_switch_of_match[] = {
+	{ .compatible = "microchip,lan96455s-switch" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lan9645x_switch_of_match);
+
+static struct platform_driver lan9645x_switch_driver = {
+	.driver = {
+		.name = "lan96455s-switch",
+		.of_match_table = lan9645x_switch_of_match,
+	},
+	.probe = lan9645x_probe,
+	.remove = lan9645x_remove,
+	.shutdown = lan9645x_shutdown,
+};
+module_platform_driver(lan9645x_switch_driver);
+
+MODULE_DESCRIPTION("LAN9645x Switch Driver");
+MODULE_AUTHOR("Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
new file mode 100644
index 000000000000..3a4abedafa2c
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
@@ -0,0 +1,348 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#ifndef __LAN9645X_MAIN_H__
+#define __LAN9645X_MAIN_H__
+
+#include <linux/dsa/lan9645x.h>
+#include <linux/if_bridge.h>
+#include <linux/regmap.h>
+#include <net/dsa.h>
+
+#include "lan9645x_regs.h"
+
+/* Port modules 0-8 are front (user) ports. The chip additionally has two
+ * logical CPU port modules at indices 9 and 10. These are not the DSA CPU port.
+ * The CPU port modules are logical ports in the chip intended for management.
+ *
+ * The frame delivery mechanism can vary: direct register injection/extraction,
+ * or a front port can be used as the management port, called a Node Processor
+ * Interface (NPI) in the datasheet.
+ *
+ * LAN9645X uses the NPI approach, so the DSA CPU port is a front port
+ * (see lan9645x->npi) configured as NPI port.
+ *
+ * Therefore the CPU datapath has two port module indices of interest,
+ * lan9645x->npi and the cpu port module at index 9.
+ */
+#define NUM_PHYS_PORTS		9
+
+#define NUM_PRIO_QUEUES		8
+
+#define QS_SRC_BUF_RSV		1664
+
+/* Reserved amount for (SRC, PRIO) at index 8*SRC + PRIO
+ * See QSYS:RES_CTRL[*]:RES_CFG description
+ */
+#define QSYS_Q_RSRV			95
+
+/* Reserved VLAN IDs. */
+#define UNAWARE_PVID			0
+#define HOST_PVID			4095
+#define VLAN_MAX			(HOST_PVID - 1)
+
+/* Port Group Identifiers (PGID) are port-masks applied to all frames.
+ *
+ * The forwarding engine outputs two masks for the forwarding decision, DEST and
+ * CPUQ. DEST determines which front ports will receive a frame, and CPUQ
+ * whether the frame is forwarded to the CPU.
+ *
+ * The replicated registers are organized like so in HW:
+ *
+ * 0-63:         Destination analysis.
+ * 64-79:        Aggregation analysis
+ * 80-(80+10-1): Source port analysis
+ *
+ * Destination: Destination PGIDs are the result of mac table lookups or
+ * flooding decisions. The resolved destination PGID will feed into DEST and set
+ * the bit for ANA_PGID_CFG.CPUQ_DST_PGID in CPUQ, if the CPU port module bit is
+ * set in the PGID. This is how PGID_CPU and host flooding work.
+ *
+ * The first NUM_PHYS_PORTS destination PGIDs can not be used freely, because
+ * dynamic learning writes mac table entries with DEST_IDX taken from the
+ * ingress ports ANA_PORT_CFG.PORTID_VAL. They come out of reset as BIT(i)
+ * for that reason.
+ *
+ * PGID NUM_PHYS_PORTS..63 come out of reset as zero and have no reserved
+ * role. We use them for L2 Multicast and flooding (see FLOODING and
+ * FLOODING_IPMC) and reserve a few at the end of the range. The CPU port module
+ * has no reserved destination PGID. It does have a reserved source PGID at
+ * PGID_SRC + NUM_PHYS_PORTS.
+ *
+ * Aggregation: Each frame receives a link aggregation code from the analyzer,
+ * based on a configurable algorithm. This code picks out one of the 16
+ * aggregation PGIDs to mask out ports in DEST. If no aggregation is configured,
+ * these are all-ones. The CPU port module bit is inert here.
+ *
+ * Source: Control which ports a given source port can forward to. A frame that
+ * is received on port n, uses entry PGID_SRC + n to mask out DEST.
+ * The default values are all bits set except for the index itself
+ * (no loopback). The CPU port module bit is inert here.
+ */
+
+#define PGID_AGGR			64
+#define PGID_SRC			80
+
+/* General purpose PGIDs. */
+#define PGID_GP_START			NUM_PHYS_PORTS
+#define PGID_GP_END			PGID_MRP
+
+/* Reserved PGIDs.
+ * PGID_MRP is a blackhole PGID
+ */
+#define PGID_MRP			(PGID_AGGR - 7)
+#define PGID_CPU			(PGID_AGGR - 6)
+#define PGID_UC				(PGID_AGGR - 5)
+#define PGID_BC				(PGID_AGGR - 4)
+#define PGID_MC				(PGID_AGGR - 3)
+#define PGID_MCIPV4			(PGID_AGGR - 2)
+#define PGID_MCIPV6			(PGID_AGGR - 1)
+
+/* Flooding PGIDS:
+ * PGID_UC
+ * PGID_MC*
+ * PGID_BC
+ */
+
+#define GWM_MULTIPLIER_BIT		BIT(8)
+#define LAN9645X_BUFFER_CELL_SZ		64
+
+#define RD_SLEEP_US			3
+#define RD_SLEEPTIMEOUT_US		100000
+#define SLOW_RD_SLEEP_US		1000
+#define SLOW_RD_SLEEPTIMEOUT_US		4000000
+
+/* regmap_read_poll_timeout() re-evaluates its map and address arguments on
+ * every iteration, so resolve both once up front.
+ */
+#define lan9645x_rd_poll_timeout(_lan9645x, _reg_macro, _val, _cond)	\
+({									\
+	struct regmap *__map = lan_rmap((_lan9645x), _reg_macro);	\
+	u32 __addr = lan_rel_addr(_reg_macro);				\
+									\
+	regmap_read_poll_timeout(__map, __addr, (_val), (_cond),		\
+				 RD_SLEEP_US, RD_SLEEPTIMEOUT_US);	\
+})
+
+#define lan9645x_rd_poll_slow(_lan9645x, _reg_macro, _val, _cond)	\
+({									\
+	struct regmap *__map = lan_rmap((_lan9645x), _reg_macro);	\
+	u32 __addr = lan_rel_addr(_reg_macro);				\
+									\
+	regmap_read_poll_timeout(__map, __addr, (_val), (_cond),		\
+				 SLOW_RD_SLEEP_US,			\
+				 SLOW_RD_SLEEPTIMEOUT_US);		\
+})
+
+/* NPI port prefix config encoding
+ *
+ * 0: No CPU extraction header (normal frames)
+ * 1: CPU extraction header without prefix
+ * 2: CPU extraction header with short prefix
+ * 3: CPU extraction header with long prefix
+ */
+enum lan9645x_tag_prefix {
+	LAN9645X_TAG_PREFIX_DISABLED = 0,
+	LAN9645X_TAG_PREFIX_NONE = 1,
+	LAN9645X_TAG_PREFIX_SHORT = 2,
+	LAN9645X_TAG_PREFIX_LONG = 3,
+};
+
+enum {
+	LAN9645X_SPEED_DISABLED = 0,
+	LAN9645X_SPEED_10 = 1,
+	LAN9645X_SPEED_100 = 2,
+	LAN9645X_SPEED_1000 = 3,
+	LAN9645X_SPEED_2500 = 4,
+};
+
+/* Rewriter VLAN port tagging encoding for REW:PORT[0-10]:TAG_CFG.TAG_CFG
+ *
+ * 0: Port tagging disabled.
+ * 1: Tag all frames, except when VID=PORT_VLAN_CFG.PORT_VID or VID=0.
+ * 2: Tag all frames, except when VID=0.
+ * 3: Tag all frames.
+ */
+enum lan9645x_vlan_port_tag {
+	LAN9645X_TAG_DISABLED = 0,
+	LAN9645X_TAG_NO_PVID_NO_UNAWARE = 1,
+	LAN9645X_TAG_NO_UNAWARE = 2,
+	LAN9645X_TAG_ALL = 3,
+};
+
+struct lan9645x {
+	struct device *dev;
+	struct dsa_switch *ds;
+	struct regmap *rmap[NUM_TARGETS];
+
+	/* NPI chip_port */
+	int npi;
+
+	u8 num_phys_ports;
+	struct lan9645x_port **ports;
+
+	int num_port_dis;
+};
+
+struct lan9645x_port {
+	struct lan9645x *lan9645x;
+
+	u8 chip_port;
+
+	bool rx_internal_delay;
+	bool tx_internal_delay;
+};
+
+extern const struct phylink_mac_ops lan9645x_phylink_mac_ops;
+
+/* PFC_CFG.FC_LINK_SPEED encoding */
+static inline int lan9645x_speed_fc_enc(int speed)
+{
+	switch (speed) {
+	case LAN9645X_SPEED_10:
+		return 3;
+	case LAN9645X_SPEED_100:
+		return 2;
+	case LAN9645X_SPEED_1000:
+		return 1;
+	case LAN9645X_SPEED_2500:
+		return 0;
+	default:
+		WARN_ON_ONCE(1);
+		return 1;
+	}
+}
+
+/* Watermark encode. See QSYS:RES_CTRL[*]:RES_CFG.WM_HIGH for details.
+ * Returns lowest encoded number which will fit request/ is larger than request.
+ * Or the maximum representable value, if request is too large.
+ */
+static inline u32 lan9645x_wm_enc(u32 value)
+{
+	value = DIV_ROUND_UP(value, LAN9645X_BUFFER_CELL_SZ);
+
+	if (value >= GWM_MULTIPLIER_BIT) {
+		value = DIV_ROUND_UP(value, 16);
+		if (value >= GWM_MULTIPLIER_BIT)
+			value = (GWM_MULTIPLIER_BIT - 1);
+		value |= GWM_MULTIPLIER_BIT;
+	}
+
+	return value;
+}
+
+static inline struct lan9645x_port *lan9645x_to_port(struct lan9645x *lan9645x,
+						     int port)
+{
+	return lan9645x->ports[port];
+}
+
+static inline struct regmap *lan_tgt2rmap(struct lan9645x *lan9645x,
+					  enum lan9645x_target t, int tinst)
+{
+	return lan9645x->rmap[t + tinst];
+}
+
+static inline u32 __lan_rel_addr(int gbase, int ginst, int gcnt,
+				 int gwidth, int raddr, int rinst,
+				 int rcnt, int rwidth)
+{
+	WARN_ON(ginst >= gcnt);
+	WARN_ON(rinst >= rcnt);
+	return gbase + ginst * gwidth + raddr + rinst * rwidth;
+}
+
+/* Get register address relative to target instance */
+static inline u32 lan_rel_addr(enum lan9645x_target t, int tinst, int tcnt,
+			       int gbase, int ginst, int gcnt, int gwidth,
+			       int raddr, int rinst, int rcnt, int rwidth)
+{
+	WARN_ON(tinst >= tcnt);
+	return __lan_rel_addr(gbase, ginst, gcnt, gwidth, raddr, rinst,
+			      rcnt, rwidth);
+}
+
+static inline u32 lan_rd(struct lan9645x *lan9645x, enum lan9645x_target t,
+			 int tinst, int tcnt, int gbase, int ginst,
+			 int gcnt, int gwidth, int raddr, int rinst,
+			 int rcnt, int rwidth)
+{
+	u32 addr, val = 0;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	WARN_ON_ONCE(regmap_read(lan_tgt2rmap(lan9645x, t, tinst), addr, &val));
+
+	return val;
+}
+
+static inline int lan_bulk_rd(void *val, size_t val_count,
+			      struct lan9645x *lan9645x,
+			      enum lan9645x_target t, int tinst, int tcnt,
+			      int gbase, int ginst, int gcnt, int gwidth,
+			      int raddr, int rinst, int rcnt, int rwidth)
+{
+	u32 addr;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	return regmap_bulk_read(lan_tgt2rmap(lan9645x, t, tinst), addr, val,
+				val_count);
+}
+
+static inline struct regmap *lan_rmap(struct lan9645x *lan9645x,
+				      enum lan9645x_target t, int tinst,
+				      int tcnt, int gbase, int ginst,
+				      int gcnt, int gwidth, int raddr,
+				      int rinst, int rcnt, int rwidth)
+{
+	return lan_tgt2rmap(lan9645x, t, tinst);
+}
+
+static inline void lan_wr(u32 val, struct lan9645x *lan9645x,
+			  enum lan9645x_target t, int tinst, int tcnt,
+			  int gbase, int ginst, int gcnt, int gwidth,
+			  int raddr, int rinst, int rcnt, int rwidth)
+{
+	u32 addr;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	WARN_ON_ONCE(regmap_write(lan_tgt2rmap(lan9645x, t, tinst), addr, val));
+}
+
+static inline void lan_rmw(u32 val, u32 mask, struct lan9645x *lan9645x,
+			   enum lan9645x_target t, int tinst, int tcnt,
+			   int gbase, int ginst, int gcnt, int gwidth,
+			   int raddr, int rinst, int rcnt, int rwidth)
+{
+	u32 addr;
+
+	addr = lan_rel_addr(t, tinst, tcnt, gbase, ginst, gcnt, gwidth,
+			    raddr, rinst, rcnt, rwidth);
+
+	WARN_ON_ONCE(regmap_update_bits(lan_tgt2rmap(lan9645x, t, tinst),
+					addr, mask, val));
+}
+
+/* lan9645x_npi.c */
+void lan9645x_npi_port_init(struct lan9645x *lan9645x,
+			    struct dsa_port *cpu_port);
+void lan9645x_npi_port_deinit(struct lan9645x *lan9645x, int port);
+void lan9645x_npi_cpuq_redirect(struct lan9645x *lan9645x, bool enable);
+
+/* lan9645x_port.c */
+int lan9645x_port_setup(struct dsa_switch *ds, int port);
+int lan9645x_port_set_maxlen(struct lan9645x *lan9645x, int port, size_t sdu);
+void lan9645x_port_cpu_init(struct lan9645x *lan9645x);
+
+/* lan9645x_phylink.c */
+void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
+			       struct phylink_config *c);
+void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port);
+
+#endif /* __LAN9645X_MAIN_H__ */
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
new file mode 100644
index 000000000000..945fc026b3ca
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include "lan9645x_main.h"
+
+void lan9645x_npi_port_init(struct lan9645x *lan9645x,
+			    struct dsa_port *cpu_port)
+{
+	int port = cpu_port->index;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+	lan9645x->npi = port;
+
+	dev_dbg(lan9645x->dev, "NPI port=%d\n", port);
+
+	/* Never send injected frames back to the CPU. CPU queues are redirected
+	 * to the NPI port on link up, see lan9645x_npi_cpuq_redirect().
+	 */
+	lan_wr(QSYS_EXT_CPU_CFG_EXT_CPUQ_MSK_SET(0) |
+	       QSYS_EXT_CPU_CFG_EXT_CPU_PORT_SET(p->chip_port) |
+	       QSYS_EXT_CPU_CFG_EXT_CPU_KILL_ENA_SET(1) |
+	       QSYS_EXT_CPU_CFG_INT_CPU_KILL_ENA_SET(1),
+	       lan9645x, QSYS_EXT_CPU_CFG);
+
+	/* Configure IFH prefix mode for NPI port. We can not use an injection
+	 * prefix, because it requires all frames sent on the port to contain
+	 * the prefix. Frames without the prefix would get stuck in the queue
+	 * system rendering the port unusable. Since we do not control
+	 * what is sent to the NPI port, no prefix is our only option.
+	 */
+	lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_LONG) |
+		SYS_PORT_MODE_INCL_INJ_HDR_SET(LAN9645X_TAG_PREFIX_NONE),
+		SYS_PORT_MODE_INCL_XTR_HDR |
+		SYS_PORT_MODE_INCL_INJ_HDR,
+		lan9645x,
+		SYS_PORT_MODE(p->chip_port));
+
+	/* Rewriting and extraction with IFH does not play nice together. A VLAN
+	 * tag pushed into the frame by REW will cause 4 bytes at the end of the
+	 * extraction header to be overwritten with the top 4 bytes of the DMAC.
+	 *
+	 * We can not use REW_PORT_CFG_NO_REWRITE=1 as that disabled RTAGD
+	 * setting in the IFH
+	 */
+	lan_rmw(REW_TAG_CFG_TAG_CFG_SET(LAN9645X_TAG_DISABLED),
+		REW_TAG_CFG_TAG_CFG, lan9645x, REW_TAG_CFG(p->chip_port));
+
+	/* Clear rewriter port vid */
+	lan_wr(0, lan9645x, REW_PORT_VLAN_CFG(p->chip_port));
+
+	/* Make sure frames with src_port=<CPU port module> are not reflected
+	 * back via the NPI port. This could happen if a frame is flooded for
+	 * instance. The *_CPU_KILL_ENA flags above only have an effect when a
+	 * frame is output due to a CPU forwarding decision such as trapping or
+	 * cpu copy.
+	 */
+	lan_rmw(0, BIT(port), lan9645x,
+		ANA_PGID(PGID_SRC + lan9645x->num_phys_ports));
+}
+
+/* Toggle CPU queue redirect to the NPI port, flushing the CPU port module on
+ * enable
+ */
+void lan9645x_npi_cpuq_redirect(struct lan9645x *lan9645x, bool enable)
+{
+	int cpu_port = lan9645x->num_phys_ports;
+	u32 val;
+	int err;
+
+	lan_rmw(QSYS_EXT_CPU_CFG_EXT_CPUQ_MSK_SET(enable ? GENMASK(7, 0) : 0),
+		QSYS_EXT_CPU_CFG_EXT_CPUQ_MSK,
+		lan9645x, QSYS_EXT_CPU_CFG);
+
+	if (!enable)
+		return;
+
+	lan_wr(QS_XTR_FLUSH_FLUSH_SET(BIT(0)), lan9645x, QS_XTR_FLUSH);
+
+	err = lan9645x_rd_poll_slow(lan9645x, QSYS_SW_STATUS(cpu_port), val,
+				    !QSYS_SW_STATUS_EQ_AVAIL_GET(val));
+	if (err)
+		dev_err(lan9645x->dev, "CPU port %d flush timeout\n", cpu_port);
+
+	lan_wr(QS_XTR_FLUSH_FLUSH_SET(0), lan9645x, QS_XTR_FLUSH);
+}
+
+void lan9645x_npi_port_deinit(struct lan9645x *lan9645x, int port)
+{
+	u32 no_cpu_port = FIELD_MAX(QSYS_EXT_CPU_CFG_EXT_CPU_PORT);
+	struct lan9645x_port *p;
+
+	if (port < 0)
+		return;
+
+	lan9645x->npi = -1;
+	p = lan9645x_to_port(lan9645x, port);
+
+	lan_wr(QSYS_EXT_CPU_CFG_EXT_CPUQ_MSK_SET(0) |
+	       QSYS_EXT_CPU_CFG_EXT_CPU_PORT_SET(no_cpu_port) |
+	       QSYS_EXT_CPU_CFG_EXT_CPU_KILL_ENA_SET(1) |
+	       QSYS_EXT_CPU_CFG_INT_CPU_KILL_ENA_SET(1),
+	       lan9645x, QSYS_EXT_CPU_CFG);
+
+	lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_DISABLED) |
+		SYS_PORT_MODE_INCL_INJ_HDR_SET(LAN9645X_TAG_PREFIX_DISABLED),
+		SYS_PORT_MODE_INCL_XTR_HDR |
+		SYS_PORT_MODE_INCL_INJ_HDR,
+		lan9645x,
+		SYS_PORT_MODE(p->chip_port));
+
+	lan_rmw(BIT(p->chip_port),
+		BIT(p->chip_port), lan9645x,
+		ANA_PGID(PGID_SRC + lan9645x->num_phys_ports));
+}
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
new file mode 100644
index 000000000000..4104071d48bd
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/phy.h>
+
+#include "lan9645x_main.h"
+
+/* Port 7 is RGMII_0 and port 8 is RGMII_1 */
+#define RGMII_IDX(port) ((port) == 8 ? 1 : 0)
+
+void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
+			       struct phylink_config *c)
+{
+	c->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
+			      MAC_100 | MAC_1000FD;
+
+	switch (port) {
+	case 0 ... 4:
+		__set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interfaces);
+		break;
+	case 5 ... 6:
+		/* SerDes ports: QSGMII/SGMII/1000BASEX/2500BASEX modes
+		 * require PCS support which is not yet implemented. With an
+		 * empty supported_interfaces, phylink_create() fails and
+		 * dsa_tree_setup_ports() retries the port as unused, so a
+		 * user port declared in DT is only disabled. A CPU port has
+		 * no such fallback and fails the probe, which
+		 * lan9645x_tag_npi_setup() rejects explicitly.
+		 */
+		break;
+	case 7 ... 8:
+		/* QSGMII mode on ports 7-8 requires SerDes PCS support,
+		 * which is not yet implemented.
+		 */
+		phy_interface_set_rgmii(c->supported_interfaces);
+		break;
+	default:
+		break;
+	}
+}
+
+static void lan9645x_rgmii_set_speed(struct lan9645x *lan9645x, int port,
+				     int speed)
+{
+	u8 tx_clk;
+
+	tx_clk = speed == SPEED_1000 ? 1 :
+		 speed == SPEED_100  ? 2 :
+		 speed == SPEED_10   ? 3 : 0;
+
+	lan_rmw(HSIO_RGMII_CFG_RGMII_RX_RST_SET(0) |
+		HSIO_RGMII_CFG_RGMII_TX_RST_SET(0) |
+		HSIO_RGMII_CFG_TX_CLK_CFG_SET(tx_clk),
+		HSIO_RGMII_CFG_RGMII_RX_RST |
+		HSIO_RGMII_CFG_RGMII_TX_RST |
+		HSIO_RGMII_CFG_TX_CLK_CFG,
+		lan9645x, HSIO_RGMII_CFG(RGMII_IDX(port)));
+}
+
+static void lan9645x_rgmii_dll_config(struct lan9645x_port *p)
+{
+	u32 rx_idx, tx_idx;
+
+	/* DLL register layout:
+	 * (N*2):   RGMII_N_RX
+	 * (N*2)+1: RGMII_N_TX
+	 */
+	rx_idx = RGMII_IDX(p->chip_port) * 2;
+	tx_idx = RGMII_IDX(p->chip_port) * 2 + 1;
+
+	/* Enable DLL in RGMII clock paths, deassert DLL reset, and start the
+	 * delay tune FSM.
+	 */
+	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
+		HSIO_DLL_CFG_DLL_RST_SET(0) |
+		HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
+		HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),
+		HSIO_DLL_CFG_DLL_CLK_ENA |
+		HSIO_DLL_CFG_DLL_RST |
+		HSIO_DLL_CFG_DLL_ENA |
+		HSIO_DLL_CFG_DELAY_ENA,
+		p->lan9645x, HSIO_DLL_CFG(rx_idx));
+
+	lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
+		HSIO_DLL_CFG_DLL_RST_SET(0) |
+		HSIO_DLL_CFG_DLL_ENA_SET(p->tx_internal_delay) |
+		HSIO_DLL_CFG_DELAY_ENA_SET(p->tx_internal_delay),
+		HSIO_DLL_CFG_DLL_CLK_ENA |
+		HSIO_DLL_CFG_DLL_RST |
+		HSIO_DLL_CFG_DLL_ENA |
+		HSIO_DLL_CFG_DELAY_ENA,
+		p->lan9645x, HSIO_DLL_CFG(tx_idx));
+}
+
+static struct lan9645x_port *
+lan9645x_phylink_config_to_port(struct phylink_config *config)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+
+	return lan9645x_to_port(dp->ds->priv, dp->index);
+}
+
+static int lan9645x_phylink_mac_prepare(struct phylink_config *config,
+					unsigned int mode,
+					phy_interface_t iface)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+	struct lan9645x *lan9645x = p->lan9645x;
+	int port = p->chip_port;
+
+	lan_rmw(HSIO_HW_CFG_GMII_ENA_SET(BIT(port)),
+		HSIO_HW_CFG_GMII_ENA_SET(BIT(port)), lan9645x, HSIO_HW_CFG);
+
+	return 0;
+}
+
+static void lan9645x_phylink_mac_config(struct phylink_config *config,
+					unsigned int mode,
+					const struct phylink_link_state *state)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+
+	if (phy_interface_mode_is_rgmii(state->interface))
+		lan9645x_rgmii_dll_config(p);
+}
+
+static bool lan9645x_port_is_cuphy(struct lan9645x *lan9645x, int port,
+				   phy_interface_t interface)
+{
+	return port >= 0 && port <= 4 && interface == PHY_INTERFACE_MODE_GMII;
+}
+
+void lan9645x_phylink_port_down(struct lan9645x *lan9645x, int port)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+
+	/* Disable traffic being sent to or from switch port */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(0),
+		QSYS_SW_PORT_MODE_PORT_ENA,
+		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
+
+	/* With MAC_TX_RST and MAC_RX_RST asserted, the queue system treats
+	 * the MAC as accepting every frame, so the frames queued to the port
+	 * are discarded also when the MAC cannot transmit them, for example
+	 * when the PHY is powered down or the MAC is held by a received pause
+	 * frame. PORT_RST resets the FIFOs between the system and MAC clock
+	 * domains, and asserting it while they still hold frames hangs the
+	 * port, so it is kept deasserted.
+	 */
+	lan_rmw(DEV_CLOCK_CFG_MAC_TX_RST_SET(1) |
+		DEV_CLOCK_CFG_MAC_RX_RST_SET(1) |
+		DEV_CLOCK_CFG_PORT_RST_SET(0),
+		DEV_CLOCK_CFG_MAC_TX_RST |
+		DEV_CLOCK_CFG_MAC_RX_RST |
+		DEV_CLOCK_CFG_PORT_RST,
+		lan9645x, DEV_CLOCK_CFG(p->chip_port));
+}
+
+static void lan9645x_phylink_mac_link_down(struct phylink_config *config,
+					   unsigned int link_an_mode,
+					   phy_interface_t interface)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+	struct lan9645x *lan9645x = p->lan9645x;
+
+	/* Stop forwarding all CPU queues to the NPI port before the port is put
+	 * in reset
+	 */
+	if (p->chip_port == lan9645x->npi)
+		lan9645x_npi_cpuq_redirect(lan9645x, false);
+
+	lan9645x_phylink_port_down(lan9645x, p->chip_port);
+}
+
+static void lan9645x_phylink_mac_link_up(struct phylink_config *config,
+					 struct phy_device *phydev,
+					 unsigned int link_an_mode,
+					 phy_interface_t interface, int speed,
+					 int duplex, bool tx_pause,
+					 bool rx_pause)
+{
+	struct lan9645x_port *p = lan9645x_phylink_config_to_port(config);
+	int rx_ifg1, rx_ifg2, tx_ifg, gtx_clk = 0;
+	struct lan9645x *lan9645x = p->lan9645x;
+	int gspeed = LAN9645X_SPEED_DISABLED;
+	int port = p->chip_port;
+	int mode = 0;
+	int fc_spd;
+	bool fdx;
+
+	/* Configure RGMII TX clock for the negotiated speed */
+	if (phy_interface_mode_is_rgmii(interface))
+		lan9645x_rgmii_set_speed(lan9645x, port, speed);
+
+	fdx = duplex == DUPLEX_FULL || speed == SPEED_1000;
+
+	if (fdx)
+		mode |= DEV_MAC_MODE_CFG_FDX_ENA_SET(1);
+
+	tx_ifg = fdx ? 0x6 : 0x5;
+	rx_ifg2 = 0x2;
+
+	switch (speed) {
+	case SPEED_10:
+		rx_ifg1 = 0x2;
+		gspeed = LAN9645X_SPEED_10;
+		break;
+	case SPEED_100:
+		rx_ifg1 = 0x1;
+		gspeed = LAN9645X_SPEED_100;
+		break;
+	case SPEED_1000:
+		gspeed = LAN9645X_SPEED_1000;
+		mode |= DEV_MAC_MODE_CFG_GIGA_MODE_ENA_SET(1);
+		rx_ifg1 = 0x1;
+		gtx_clk = 1;
+		break;
+	default:
+		dev_err(lan9645x->dev, "Unsupported speed on port %d: %d\n",
+			p->chip_port, speed);
+		return;
+	}
+
+	fc_spd = lan9645x_speed_fc_enc(gspeed);
+
+	lan_rmw(mode,
+		DEV_MAC_MODE_CFG_FDX_ENA |
+		DEV_MAC_MODE_CFG_GIGA_MODE_ENA,
+		lan9645x, DEV_MAC_MODE_CFG(p->chip_port));
+
+	lan_rmw(DEV_MAC_IFG_CFG_TX_IFG_SET(tx_ifg) |
+		DEV_MAC_IFG_CFG_RX_IFG1_SET(rx_ifg1) |
+		DEV_MAC_IFG_CFG_RX_IFG2_SET(rx_ifg2),
+		DEV_MAC_IFG_CFG_TX_IFG |
+		DEV_MAC_IFG_CFG_RX_IFG1 |
+		DEV_MAC_IFG_CFG_RX_IFG2,
+		lan9645x, DEV_MAC_IFG_CFG(p->chip_port));
+
+	if (lan9645x_port_is_cuphy(lan9645x, port, interface)) {
+		lan_rmw(CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA_SET(gtx_clk),
+			CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA, lan9645x,
+			CHIP_TOP_CUPHY_PORT_CFG(p->chip_port));
+	}
+
+	lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(1),
+		SYS_PAUSE_CFG_PAUSE_ENA,
+		lan9645x, SYS_PAUSE_CFG(p->chip_port));
+
+	/* Flow control */
+	lan_rmw(SYS_MAC_FC_CFG_FC_LINK_SPEED_SET(fc_spd) |
+		SYS_MAC_FC_CFG_FC_LATENCY_CFG_SET(0x7) |
+		SYS_MAC_FC_CFG_ZERO_PAUSE_ENA_SET(1) |
+		SYS_MAC_FC_CFG_PAUSE_VAL_CFG_SET(0xffff) |
+		SYS_MAC_FC_CFG_RX_FC_ENA_SET(rx_pause ? 1 : 0) |
+		SYS_MAC_FC_CFG_TX_FC_ENA_SET(tx_pause ? 1 : 0),
+		SYS_MAC_FC_CFG_FC_LINK_SPEED |
+		SYS_MAC_FC_CFG_FC_LATENCY_CFG |
+		SYS_MAC_FC_CFG_ZERO_PAUSE_ENA |
+		SYS_MAC_FC_CFG_PAUSE_VAL_CFG |
+		SYS_MAC_FC_CFG_RX_FC_ENA |
+		SYS_MAC_FC_CFG_TX_FC_ENA,
+		lan9645x, SYS_MAC_FC_CFG(p->chip_port));
+
+	/* Enable MAC module */
+	lan_wr(DEV_MAC_ENA_CFG_RX_ENA_SET(1) |
+	       DEV_MAC_ENA_CFG_TX_ENA_SET(1),
+	       lan9645x, DEV_MAC_ENA_CFG(p->chip_port));
+
+	/* Take out the clock from reset. Note this write will set all these
+	 * fields to zero:
+	 *
+	 * DEV_CLOCK_CFG[*].MAC_TX_RST
+	 * DEV_CLOCK_CFG[*].MAC_RX_RST
+	 * DEV_CLOCK_CFG[*].PCS_TX_RST
+	 * DEV_CLOCK_CFG[*].PCS_RX_RST
+	 * DEV_CLOCK_CFG[*].PORT_RST
+	 * DEV_CLOCK_CFG[*].PHY_RST
+	 *
+	 * Note link_down will assert MAC_RX_RST and MAC_TX_RST, so
+	 * we are effectively taking the mac tx/rx clocks out of reset.
+	 *
+	 * This linkspeed field has a slightly different encoding from others:
+	 *
+	 * - 0 is no-link
+	 * - 1 is both 2500/1000
+	 * - 2 is 100mbit
+	 * - 3 is 10mbit
+	 *
+	 */
+	lan_wr(DEV_CLOCK_CFG_LINK_SPEED_SET(fc_spd),
+	       lan9645x,
+	       DEV_CLOCK_CFG(p->chip_port));
+
+	/* Core: Enable port for frame transfer */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1) |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG_SET(1) |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE_SET(1) |
+		QSYS_SW_PORT_MODE_TX_PFC_ENA_SET(0),
+		QSYS_SW_PORT_MODE_PORT_ENA |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE |
+		QSYS_SW_PORT_MODE_TX_PFC_ENA,
+		lan9645x, QSYS_SW_PORT_MODE(p->chip_port));
+
+	/* Forward all CPU queues to the NPI port */
+	if (port == lan9645x->npi)
+		lan9645x_npi_cpuq_redirect(lan9645x, true);
+}
+
+const struct phylink_mac_ops lan9645x_phylink_mac_ops = {
+	.mac_prepare			= lan9645x_phylink_mac_prepare,
+	.mac_config			= lan9645x_phylink_mac_config,
+	.mac_link_down			= lan9645x_phylink_mac_link_down,
+	.mac_link_up			= lan9645x_phylink_mac_link_up,
+};
diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
new file mode 100644
index 000000000000..4d2d922bacba
--- /dev/null
+++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Microchip Technology Inc.
+ */
+
+#include <linux/of_net.h>
+
+#include "lan9645x_main.h"
+
+void lan9645x_port_cpu_init(struct lan9645x *lan9645x)
+{
+	u32 cpu_module_mask = BIT(lan9645x->num_phys_ports);
+
+	/* Map the 8 CPU extraction queues to the CPU port module (datasheet is
+	 * wrong)
+	 */
+	lan_wr(0, lan9645x, QSYS_CPU_GROUP_MAP);
+
+	/* Configure first cpu port for manual extraction. */
+	lan_rmw(QS_XTR_GRP_CFG_MODE_SET(1),
+		QS_XTR_GRP_CFG_MODE,
+		lan9645x, QS_XTR_GRP_CFG(0));
+
+	/* The CPU will only use its reserved buffer in the shared queue system
+	 * and none of the shared buffer space, therefore we disable resource
+	 * sharing in egress direction. We must not disable resource sharing in
+	 * the ingress direction, because some traffic test scenarios require
+	 * loads of buffer memory for frames initiated by the CPU.
+	 */
+	lan_rmw(QSYS_EGR_NO_SHARING_EGR_NO_SHARING_SET(cpu_module_mask),
+		QSYS_EGR_NO_SHARING_EGR_NO_SHARING_SET(cpu_module_mask),
+		lan9645x, QSYS_EGR_NO_SHARING);
+
+	/* The CPU should also discard frames forwarded to it if it has run
+	 * out of the reserved buffer space. Otherwise they will be held back
+	 * in the ingress queues with potential head-of-line blocking effects.
+	 */
+	lan_rmw(QSYS_EGR_DROP_MODE_EGRESS_DROP_MODE_SET(cpu_module_mask),
+		QSYS_EGR_DROP_MODE_EGRESS_DROP_MODE_SET(cpu_module_mask),
+		lan9645x, QSYS_EGR_DROP_MODE);
+
+	lan_wr(cpu_module_mask, lan9645x, ANA_PGID(PGID_CPU));
+
+	/* Enable switching to/from cpu port. Keep default aging-mode. */
+	lan_rmw(QSYS_SW_PORT_MODE_PORT_ENA_SET(1) |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG_SET(1) |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE_SET(1),
+		QSYS_SW_PORT_MODE_PORT_ENA |
+		QSYS_SW_PORT_MODE_SCH_NEXT_CFG |
+		QSYS_SW_PORT_MODE_INGRESS_DROP_MODE,
+		lan9645x, QSYS_SW_PORT_MODE(lan9645x->num_phys_ports));
+}
+
+/* VLAN tag overhead is handled by DEV_MAC_TAGS_CFG */
+int lan9645x_port_set_maxlen(struct lan9645x *lan9645x, int port, size_t sdu)
+{
+	struct lan9645x_port *p = lan9645x_to_port(lan9645x, port);
+	int maxlen = sdu + ETH_HLEN + ETH_FCS_LEN;
+
+	if (port == lan9645x->npi) {
+		maxlen += LAN9645X_IFH_LEN_BYTES;
+		maxlen += LAN9645X_LONG_PREFIX_LEN;
+	}
+
+	lan_wr(DEV_MAC_MAXLEN_CFG_MAX_LEN_SET(maxlen), lan9645x,
+	       DEV_MAC_MAXLEN_CFG(p->chip_port));
+
+	/* Set Pause WM hysteresis */
+	lan_rmw(SYS_PAUSE_CFG_PAUSE_STOP_SET(lan9645x_wm_enc(4 * maxlen)) |
+		SYS_PAUSE_CFG_PAUSE_START_SET(lan9645x_wm_enc(6 * maxlen)),
+		SYS_PAUSE_CFG_PAUSE_START |
+		SYS_PAUSE_CFG_PAUSE_STOP,
+		lan9645x,
+		SYS_PAUSE_CFG(p->chip_port));
+
+	return 0;
+}
+
+static void lan9645x_parse_mac_delay(struct lan9645x *lan9645x, int port,
+				     struct device_node *dn, const char *name,
+				     bool *out)
+{
+	u32 val;
+
+	if (of_property_read_u32(dn, name, &val))
+		return;
+
+	if (val != 0 && val != 2000) {
+		dev_warn(lan9645x->dev,
+			 "port %d: %s only supports a 2ns delay (on/off), got %u ps\n",
+			 port, name, val);
+		return;
+	}
+
+	*out = val == 2000;
+}
+
+int lan9645x_port_setup(struct dsa_switch *ds, int port)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct lan9645x *lan9645x = ds->priv;
+	struct lan9645x_port *p;
+
+	p = lan9645x_to_port(lan9645x, port);
+
+	if (dp->dn) {
+		lan9645x_parse_mac_delay(lan9645x, port, dp->dn,
+					 "rx-internal-delay-ps",
+					 &p->rx_internal_delay);
+
+		lan9645x_parse_mac_delay(lan9645x, port, dp->dn,
+					 "tx-internal-delay-ps",
+					 &p->tx_internal_delay);
+	}
+
+	/* Disable learning on port */
+	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(0),
+		ANA_PORT_CFG_LEARN_ENA,
+		lan9645x, ANA_PORT_CFG(p->chip_port));
+
+	lan9645x_port_set_maxlen(lan9645x, port, ETH_DATA_LEN);
+
+	/* Load HDX backoff seed (fixed per-port, one-shot strobe) */
+	lan_rmw(DEV_MAC_HDX_CFG_SEED_SET(p->chip_port) |
+		DEV_MAC_HDX_CFG_SEED_LOAD_SET(1),
+		DEV_MAC_HDX_CFG_SEED |
+		DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
+		DEV_MAC_HDX_CFG(p->chip_port));
+
+	lan_rmw(DEV_MAC_HDX_CFG_SEED_LOAD_SET(0),
+		DEV_MAC_HDX_CFG_SEED_LOAD, lan9645x,
+		DEV_MAC_HDX_CFG(p->chip_port));
+
+	/* Set SMAC of Pause frame (00:00:00:00:00:00) */
+	lan_wr(0, lan9645x, DEV_FC_MAC_LOW_CFG(p->chip_port));
+	lan_wr(0, lan9645x, DEV_FC_MAC_HIGH_CFG(p->chip_port));
+
+	lan9645x_phylink_port_down(lan9645x, port);
+
+	/* Drop frames with multicast source address */
+	lan_rmw(ANA_DROP_CFG_DROP_MC_SMAC_ENA_SET(1),
+		ANA_DROP_CFG_DROP_MC_SMAC_ENA, lan9645x,
+		ANA_DROP_CFG(p->chip_port));
+
+	lan_rmw(DEV_MAC_TAGS_CFG_VLAN_AWR_ENA_SET(1) |
+		DEV_MAC_TAGS_CFG_PB_ENA_SET(1) |
+		DEV_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA_SET(1) |
+		DEV_MAC_TAGS_CFG_TAG_ID_SET(ETH_P_8021AD),
+		DEV_MAC_TAGS_CFG_VLAN_AWR_ENA |
+		DEV_MAC_TAGS_CFG_PB_ENA |
+		DEV_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA |
+		DEV_MAC_TAGS_CFG_TAG_ID,
+		lan9645x, DEV_MAC_TAGS_CFG(p->chip_port));
+
+	/* Enable receiving frames on the port, and activate auto-learning of
+	 * MAC addresses. LEARNAUTO is ignored when LEARN_ENA=0.
+	 */
+	lan_rmw(ANA_PORT_CFG_LEARNAUTO_SET(1) |
+		ANA_PORT_CFG_RECV_ENA_SET(1) |
+		ANA_PORT_CFG_PORTID_VAL_SET(p->chip_port),
+		ANA_PORT_CFG_LEARNAUTO |
+		ANA_PORT_CFG_RECV_ENA |
+		ANA_PORT_CFG_PORTID_VAL,
+		lan9645x, ANA_PORT_CFG(p->chip_port));
+
+	return 0;
+}

-- 
2.52.0

