Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAED3911CA;
	Mon, 31 Aug 2026 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209687; cv=none; b=iC+K1kmdnRUR3otuTSGpF3k7S48sQGcKvdw3O2aruHcCwXShvW5yQZAMtWgZsEbbBjpFBGNb2Pcq7ZEPgC0LW0HJPHV1rDpSrmrbxssct70l9ZuLHRHOxc4JXXf+ZhhZNOuGfWlUZMPb9XSN/vWwGK5LbjmQND5/JweowTUnCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209687; c=relaxed/simple;
	bh=ANdiWPFih2idnpvrr2Hl7KOwHh7jQeF4NmoQAgC/XRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhvYnQKp51hRc76GEdBNMw6y08umQCiPSp2GqI6hIG/cmTC7O+zB3dt3zgNPjQO9GdNeO+PFteR2nJk9MS/UkgsiXQ2x3ibJ/MfZ8J1zobejj6xNf7QCsUlf14NlL9cpJlZiLjlWd7EuHZ8a4MS0H4qWmVc9CwIka8ZoFcbEYwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov94bhIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov94bhIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC21F000E9;
	Mon, 31 Aug 2026 20:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209684;
	bh=JCXaH/KkwkurpI8PA6YBfIYDPlmaq52TPg9vNa3W35A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ov94bhItVRCR7QrehR+nnFeHNNNWby+2eihVIv5ehtNhdRDwUXNggOymtexLSO576
	 l/yXw0WDOPky2UIRkpuJhgiAa331Kge0RYpXMIimJzgvk0IaXgzO1en0OWy9RfGU82
	 8z8IU6/K666NGe13+Tz6l6+j8nxGM/i8BHY5W06YMg/dS0aQoD1LGW0rTnzUd2CxHQ
	 LlJ3a3uBU7PAy+O6wdDwqy8N3T7+DLMmPrsuBL5InrAaN1AWQF2hNEbKoc0WGy8YLO
	 MSZ+JpRCc3Vdx2Fu2nYZOyVfXQ/+JrnDHWoCwq/fUfHAA7z2bl80JrWuXLHCCZGvQ+
	 UBFLFG0kkZsNQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 31 Aug 2026 22:54:20 +0200
Subject: [PATCH net-next v8 4/5] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ks8995-to-ksz8-v8-4-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

This adds support for the Microchip KSZ8995XA also known as the
Micrel KS8995XA switch to the KSZ driver.

Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
different from the KSZ8995XA.

The helper macros are named ksz_is_ksz8995xa() to make it
possible to add E and MA support in the future.

The KSZ8995XA has eight global TOS priority registers with one
bit per DSCP code point, providing two internal priority levels.
The registers are ordered in the opposite direction from the
other KSZ8 switches. Describe the two priorities in the chip
data, then augment the DCB helpers for this.

Practical testing also shows that its packet-size control bits use
the same semantics as the other KSZ8 switches. The polarity in the
manual appears to be wrong and makes the switch hang on big packets.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/microchip/Kconfig           |   1 +
 drivers/net/dsa/microchip/ksz8.c            | 205 +++++++++++++++++++++++-----
 drivers/net/dsa/microchip/ksz8.h            |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h        |   7 +
 drivers/net/dsa/microchip/ksz_common.c      |  53 ++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  11 +-
 drivers/net/dsa/microchip/ksz_dcb.c         |  55 +++++---
 drivers/net/dsa/microchip/ksz_spi.c         |  18 ++-
 include/linux/platform_data/microchip-ksz.h |   1 +
 9 files changed, 290 insertions(+), 63 deletions(-)

diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchip/Kconfig
index c71d3fd5dfeb..75c9b2114afd 100644
--- a/drivers/net/dsa/microchip/Kconfig
+++ b/drivers/net/dsa/microchip/Kconfig
@@ -2,6 +2,7 @@
 menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
 	tristate "Microchip KSZ8XXX/KSZ9XXX/LAN937X series switch support"
 	depends on NET_DSA
+	select NET_DSA_TAG_KS8995
 	select NET_DSA_TAG_KSZ
 	select NET_DSA_TAG_NONE
 	select NET_IEEE8021Q_HELPERS
diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 941ae9f66f70..f9272d1b7bf4 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -3,6 +3,7 @@
  * Microchip KSZ8XXX series switch driver
  *
  * It supports the following switches:
+ * - KSZ8995XA (the oldest ancestor)
  * - KSZ8463
  * - KSZ8863, KSZ8873 aka KSZ88X3
  * - KSZ8895, KSZ8864 aka KSZ8895 family
@@ -253,7 +254,17 @@ static int ksz8463_reset_switch(struct ksz_device *dev)
 
 static int ksz8_reset_switch(struct ksz_device *dev)
 {
-	if (ksz_is_ksz88x3(dev)) {
+	if (ksz_is_ksz8995xa(dev)) {
+		unsigned int port;
+
+		/* The KSZ8995XA switch itself cannot be reset by software, but
+		 * often boot loaders have fun with ports, so reset them. This
+		 * reset bit is self-clearing.
+		 */
+		for (port = 0; port < dev->info->port_cnt; port++)
+			ksz_port_cfg(dev, port, REG_PORT_STATUS_3,
+				     PORT_PHY_SOFT_RESET, true);
+	} else if (ksz_is_ksz88x3(dev)) {
 		/* reset switch */
 		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);
@@ -269,6 +280,31 @@ static int ksz8_reset_switch(struct ksz_device *dev)
 	return 0;
 }
 
+static int ksz8995xa_change_mtu(struct dsa_switch *ds, int port, int mtu)
+{
+	struct ksz_device *dev = ds->priv;
+	int frame_size;
+	u8 ctrl2 = 0;
+
+	if (!dsa_is_cpu_port(dev->ds, port))
+		return 0;
+
+	frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
+
+	/* The legal packet size bit polarity documented in the KSZ8995XA
+	 * manual appears to be wrong. Practical tests show that the same
+	 * semantics as the other switches are correct; using the documented
+	 * polarity makes the switch hang on big packets.
+	 */
+	if (frame_size <= KSZ8995XA_LEGAL_PACKET_SIZE)
+		ctrl2 |= KSZ8863_LEGAL_PACKET_ENABLE;
+	else if (frame_size > KSZ8863_NORMAL_PACKET_SIZE)
+		ctrl2 |= KSZ8863_HUGE_PACKET_ENABLE;
+
+	return ksz_rmw8(dev, REG_SW_CTRL_2, KSZ8863_LEGAL_PACKET_ENABLE |
+			KSZ8863_HUGE_PACKET_ENABLE, ctrl2);
+}
+
 static int ksz88xx_change_mtu(struct dsa_switch *ds, int port, int mtu)
 {
 	struct ksz_device *dev = ds->priv;
@@ -325,8 +361,8 @@ static int ksz88xx_max_mtu(struct dsa_switch *ds, int port)
 
 static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 {
-	u8 mask_4q, mask_2q;
-	u8 reg_4q, reg_2q;
+	u8 mask_4q = 0, mask_2q;
+	u8 reg_4q = 0, reg_2q;
 	u8 data_4q = 0;
 	u8 data_2q = 0;
 	int ret;
@@ -352,6 +388,10 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 		mask_2q = KSZ8873_PORT_2QUEUE_SPLIT_EN;
 		reg_4q = P1CR1;
 		reg_2q = P1CR1 + 1;
+	} else if (ksz_is_ksz8995xa(dev)) {
+		/* This switch has no 4way split support */
+		mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
+		reg_2q = REG_PORT_CTRL_0;
 	} else {
 		mask_4q = KSZ8795_PORT_4QUEUE_SPLIT_EN;
 		mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
@@ -373,9 +413,11 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 	else if (queues == 2)
 		data_2q = mask_2q;
 
-	ret = ksz_prmw8(dev, port, reg_4q, mask_4q, data_4q);
-	if (ret)
-		return ret;
+	if (mask_4q) {
+		ret = ksz_prmw8(dev, port, reg_4q, mask_4q, data_4q);
+		if (ret)
+			return ret;
+	}
 
 	return ksz_prmw8(dev, port, reg_2q, mask_2q, data_2q);
 }
@@ -970,6 +1012,10 @@ static int ksz8_r_phy_ctrl(struct ksz_device *dev, int port, u16 *val)
 	if (reg_val & PORT_MDIX_STATUS)
 		*val |= KSZ886X_CTRL_MDIX_STAT;
 
+	/* KSZ8995XA has no fancy features in register 0xA */
+	if (ksz_is_ksz8995xa(dev))
+		return 0;
+
 	ret = ksz_pread8(dev, port, REG_PORT_LINK_MD_CTRL, &reg_val);
 	if (ret < 0)
 		return ret;
@@ -1068,8 +1114,10 @@ static int ksz8_r_phy_bmcr(struct ksz_device *dev, u16 port, u16 *val)
 	if (ctrl & PORT_FORCE_FULL_DUPLEX)
 		*val |= BMCR_FULLDPLX;
 
-	if (speed & PORT_HP_MDIX)
-		*val |= KSZ886X_BMCR_HP_MDIX;
+	if (!ksz_is_ksz8995xa(dev)) {
+		if (speed & PORT_HP_MDIX)
+			*val |= KSZ886X_BMCR_HP_MDIX;
+	}
 
 	if (restart & PORT_FORCE_MDIX)
 		*val |= KSZ886X_BMCR_FORCE_MDI;
@@ -1164,6 +1212,9 @@ static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 			data |= LPA_LPACK;
 		break;
 	case PHY_REG_LINK_MD:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		ret = ksz_pread8(dev, p, REG_PORT_LINK_MD_CTRL, &val1);
 		if (ret)
 			return ret;
@@ -1307,13 +1358,15 @@ static int ksz8_w_phy_bmcr(struct ksz_device *dev, u16 port, u16 val)
 	if (val & BMCR_RESET)
 		return 0;
 
-	speed = 0;
-	if (val & KSZ886X_BMCR_HP_MDIX)
-		speed |= PORT_HP_MDIX;
+	if (!ksz_is_ksz8995xa(dev)) {
+		speed = 0;
+		if (val & KSZ886X_BMCR_HP_MDIX)
+			speed |= PORT_HP_MDIX;
 
-	ret = ksz_prmw8(dev, port, regs[P_SPEED_STATUS], PORT_HP_MDIX, speed);
-	if (ret)
-		return ret;
+		ret = ksz_prmw8(dev, port, regs[P_SPEED_STATUS], PORT_HP_MDIX, speed);
+		if (ret)
+			return ret;
+	}
 
 	ctrl = 0;
 	if (ksz_is_ksz88x3(dev)) {
@@ -1423,11 +1476,17 @@ static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 		}
 		break;
 	case PHY_REG_LINK_MD:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		if (val & PHY_START_CABLE_DIAG)
 			ksz_port_cfg(dev, p, REG_PORT_LINK_MD_CTRL, PORT_START_CABLE_DIAG, true);
 		break;
 
 	case PHY_REG_PHY_CTRL:
+		if (ksz_is_ksz8995xa(dev))
+			return -EOPNOTSUPP;
+
 		ret = ksz8_w_phy_ctrl(dev, p, val);
 		if (ret)
 			return ret;
@@ -1672,7 +1731,7 @@ static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
 {
 	struct ksz_device *dev = ds->priv;
 
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8995xa(dev))
 		return -ENOTSUPP;
 
 	/* Discard packets with VID not enabled on the switch */
@@ -2043,12 +2102,14 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 
 	ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);
 
-	/* replace priority */
-	offset = P_802_1P_CTRL;
-	if (ksz_is_ksz8463(dev))
-		offset = P1CR2;
-	ksz_port_cfg(dev, port, offset,
-		     masks[PORT_802_1P_REMAPPING], false);
+	if (!ksz_is_ksz8995xa(dev)) {
+		/* replace priority */
+		offset = P_802_1P_CTRL;
+		if (ksz_is_ksz8463(dev))
+			offset = P1CR2;
+		ksz_port_cfg(dev, port, offset,
+			     masks[PORT_802_1P_REMAPPING], false);
+	}
 
 	if (cpu_port)
 		member = dsa_user_ports(ds);
@@ -2057,6 +2118,21 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 
 	ksz8_cfg_port_member(dev, port, member);
 
+	if (ksz_is_ksz8995xa(dev)) {
+		/* Use VID 0 to identify untagged frames in the special tag */
+		ksz_pwrite16(dev, port, REG_PORT_CTRL_VID, 0);
+
+		/* The KSZ8995XA has a special tag format in the front of the frame
+		 * that need to be inserted by the CPU and then removed by each
+		 * port. PORT_REMOVE_TAG simply means "remove tags coming from the
+		 * CPU port" it does not affect ingress packets.
+		 */
+		if (cpu_port)
+			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_INSERT_TAG, true);
+		else
+			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_REMOVE_TAG, true);
+	}
+
 	/* Disable all WoL options by default. Otherwise
 	 * ksz_switch_macaddr_get/put logic will not work properly.
 	 * CPU port 4 has no WoL functionality.
@@ -2073,6 +2149,7 @@ static int ksz8_dsa_port_setup(struct dsa_switch *ds, int port)
 		return 0;
 
 	ksz8_port_setup(dev, port, false);
+
 	return ksz_dcb_init_port(dev, port);
 }
 
@@ -2147,7 +2224,9 @@ static void ksz8_config_cpu_port(struct dsa_switch *ds)
 	masks = dev->info->masks;
 	regs = dev->info->regs;
 
-	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
+	/* KSZ8995XA uses a tag in the header instead of the tail */
+	if (!ksz_is_ksz8995xa(dev))
+		ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
 
 	ksz8_port_setup(dev, dev->cpu_port, true);
 
@@ -2323,6 +2402,10 @@ static int ksz8_enable_stp_addr(struct ksz_device *dev)
 {
 	struct alu_struct alu;
 
+	/* KSZ8995XA lacks STP */
+	if (ksz_is_ksz8995xa(dev))
+		return 0;
+
 	/* Setup STP address for STP operation. */
 	memset(&alu, 0, sizeof(alu));
 	ether_addr_copy(alu.mac, eth_stp_addr);
@@ -2650,13 +2733,17 @@ static int ksz8_setup(struct dsa_switch *ds)
 	struct ksz_port *p;
 	const u16 *regs;
 	int i, ret;
+	u8 val;
 
 	regs = dev->info->regs;
 
-	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
-				       dev->info->num_vlans, GFP_KERNEL);
-	if (!dev->vlan_cache)
-		return -ENOMEM;
+	/* KSZ8995XA has no SW controlled VLAN handling */
+	if (!ksz_is_ksz8995xa(dev)) {
+		dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+					       dev->info->num_vlans, GFP_KERNEL);
+		if (!dev->vlan_cache)
+			return -ENOMEM;
+	}
 
 	ret = ksz8_reset_switch(dev);
 	if (ret) {
@@ -2711,9 +2798,10 @@ static int ksz8_setup(struct dsa_switch *ds)
 	 * Make sure unicast VLAN boundary is set as default and
 	 * enable no excessive collision drop.
 	 */
-	ret = ksz_rmw8(dev, REG_SW_CTRL_2,
-		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
-		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
+	val = NO_EXC_COLLISION_DROP;
+	if (!ksz_is_ksz8995xa(dev))
+		val |= UNICAST_VLAN_BOUNDARY;
+	ret = ksz_rmw8(dev, REG_SW_CTRL_2, val, val);
 	if (ret)
 		return ret;
 
@@ -2721,11 +2809,15 @@ static int ksz8_setup(struct dsa_switch *ds)
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
 
-	if (!ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz8995xa(dev))
+		ksz_cfg(dev, REG_SW_CTRL_9, SW_SPECIAL_TAG, true);
+	else if (!ksz_is_ksz88x3(dev))
 		ksz_cfg(dev, REG_SW_CTRL_19, SW_INS_TAG_ENABLE, true);
 
-	for (i = 0; i < (dev->info->num_vlans / 4); i++)
-		ksz8_r_vlan_entries(dev, i);
+	if (!ksz_is_ksz8995xa(dev)) {
+		for (i = 0; i < (dev->info->num_vlans / 4); i++)
+			ksz8_r_vlan_entries(dev, i);
+	}
 
 	/* Make sure PME (WoL) is not enabled. If requested, it will
 	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
@@ -2976,6 +3068,13 @@ static int ksz8_switch_init(struct ksz_device *dev)
 	return 0;
 }
 
+static enum dsa_tag_protocol ksz8995xa_get_tag_protocol(struct dsa_switch *ds,
+							int port,
+							enum dsa_tag_protocol mp)
+{
+	return DSA_TAG_PROTO_KS8995;
+}
+
 static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
 						      int port,
 						      enum dsa_tag_protocol mp)
@@ -3072,6 +3171,16 @@ const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
+/*
+ * The KS(Z)8995XA has no indirect access, meaning no MIB counters,
+ * no FDB access, and no VLAN handling.
+ */
+const struct ksz_dev_ops ksz8995xa_dev_ops = {
+	.get_port_addr = ksz8_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.init = ksz8_switch_init,
+};
+
 const struct ksz_dev_ops ksz8463_dev_ops = {
 	.get_port_addr = ksz8463_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
@@ -3111,6 +3220,38 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.pme_pwrite8 = ksz8_pme_pwrite8,
 };
 
+/*
+ * Restricted operations for KSZ8995XA, so many things are not supported
+ * by this old switch that we need diet DSA operations.
+ */
+const struct dsa_switch_ops ksz8995xa_switch_ops = {
+	.get_tag_protocol	= ksz8995xa_get_tag_protocol,
+	.setup			= ksz8_setup,
+	.teardown		= ksz_teardown,
+	.phy_read		= ksz8_phy_read16,
+	.phy_write		= ksz8_phy_write16,
+	.phylink_get_caps	= ksz8_phylink_get_caps,
+	.port_setup		= ksz8_dsa_port_setup,
+	.port_bridge_join	= ksz_port_bridge_join,
+	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
+	.port_stp_state_set	= ksz_port_stp_state_set,
+	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
+	.port_bridge_flags	= ksz_port_bridge_flags,
+	.port_fast_age		= ksz8_flush_dyn_mac_table,
+	.port_mirror_add	= ksz8_port_mirror_add,
+	.port_mirror_del	= ksz8_port_mirror_del,
+	.port_change_mtu	= ksz8995xa_change_mtu,
+	.port_max_mtu		= ksz88xx_max_mtu,
+	.port_get_default_prio	= ksz_port_get_default_prio,
+	.port_set_default_prio	= ksz_port_set_default_prio,
+	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
+	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
+	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
+	.port_get_apptrust	= ksz_port_get_apptrust,
+	.port_set_apptrust	= ksz_port_set_apptrust,
+};
+
 const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index bc371cc26c6f..9b37c56c9617 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -12,11 +12,13 @@
 #include <net/dsa.h>
 #include "ksz_common.h"
 
+extern const struct ksz_dev_ops ksz8995xa_dev_ops;
 extern const struct ksz_dev_ops ksz8463_dev_ops;
 extern const struct ksz_dev_ops ksz87xx_dev_ops;
 extern const struct ksz_dev_ops ksz88xx_dev_ops;
 extern const struct phylink_mac_ops ksz88x3_phylink_mac_ops;
 extern const struct phylink_mac_ops ksz8_phylink_mac_ops;
+extern const struct dsa_switch_ops ksz8995xa_switch_ops;
 extern const struct dsa_switch_ops ksz8463_switch_ops;
 extern const struct dsa_switch_ops ksz87xx_switch_ops;
 extern const struct dsa_switch_ops ksz88xx_switch_ops;
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 6bc511da1f7d..bd99699aae02 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -30,6 +30,11 @@
 #define KSZ88X3_REG_FVID_AND_HOST_MODE  0xC6
 #define KSZ88X3_PORT3_RMII_CLK_INTERNAL BIT(3)
 
+#define REG_SW_ID_0			0x00
+#define REG_SW_ID_1			0x01
+
+#define SW_START_SWITCH			BIT(0)
+
 #define REG_SW_CTRL_0			0x02
 
 #define SW_NEW_BACKOFF			BIT(7)
@@ -95,6 +100,8 @@
 #define SW_LED_LINK_ACT_DUPLEX		2
 #define SW_LED_LINK_DUPLEX		3
 
+#define SW_SPECIAL_TAG			BIT(0) /* KSZ8995XA only */
+
 #define REG_SW_CTRL_10			0x0C
 
 #define SW_PASS_PAUSE			BIT(0)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1a9d6f83a023..6c15ac97a7e3 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -446,6 +446,20 @@ static const u8 ksz8895_shifts[] = {
 	[DYNAMIC_MAC_SRC_PORT]		= 24,
 };
 
+static const u16 ksz8995xa_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x68,
+	[P_FORCE_CTRL]			= 0x0C,
+	[P_LINK_STATUS]			= 0x0E,
+	[P_LOCAL_CTRL]			= 0x0C,
+	[P_NEG_RESTART_CTRL]		= 0x0D,
+	[P_REMOTE_STATUS]		= 0x0E,
+	[P_SPEED_STATUS]		= 0x09,
+	[P_STP_CTRL]			= 0x02,
+	[S_START_CTRL]			= 0x01,
+	[S_BROADCAST_CTRL]		= 0x06,
+	[S_MULTICAST_CTRL]		= 0x04,
+};
+
 static const u16 ksz9477_regs[] = {
 	[REG_SW_MAC_ADDR]		= 0x0302,
 	[P_STP_CTRL]			= 0x0B04,
@@ -1377,6 +1391,21 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false},
 	},
 
+	[KSZ8995XA] = {
+		.chip_id = KSZ8995XA_CHIP_ID, /* Also known as KS8995XA */
+		.dev_name = "KSZ8995XA",
+		.cpu_ports = 0x10,	/* can be configured as cpu port */
+		.port_cnt = 5,		/* total cpu and user ports */
+		.num_tx_queues = 2,	/* low/hi priority queues, no more */
+		.num_ipms = 2,
+		.ops = &ksz8995xa_dev_ops,
+		.switch_ops = &ksz8995xa_switch_ops,
+		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
+		.regs = ksz8995xa_regs,
+		.supports_mii = {true, true, true, true, true},
+		.internal_phy = {true, true, true, true, false},
+	},
+
 	[KSZ9477] = {
 		.chip_id = KSZ9477_CHIP_ID,
 		.dev_name = "KSZ9477",
@@ -2649,6 +2678,10 @@ void ksz_init_mib_timer(struct ksz_device *dev)
 {
 	int i;
 
+	/* KSZ8995XA lacks MiB features */
+	if (ksz_is_ksz8995xa(dev))
+		return;
+
 	INIT_DELAYED_WORK(&dev->mib_read, ksz_mib_read_work);
 
 	for (i = 0; i < dev->info->port_cnt; i++) {
@@ -2944,11 +2977,15 @@ static int ksz_switch_detect(struct ksz_device *dev)
 			return -ENODEV;
 		break;
 	case KSZ8895_FAMILY_ID:
-		if (id2 == KSZ8895_CHIP_ID_95 ||
-		    id2 == KSZ8895_CHIP_ID_95R)
+		if (id2 == KSZ8895_CHIP_ID_95XA) {
+			dev->chip_id = KSZ8995XA_CHIP_ID;
+			break;
+		} else if (id2 == KSZ8895_CHIP_ID_95 ||
+			   id2 == KSZ8895_CHIP_ID_95R) {
 			dev->chip_id = KSZ8895_CHIP_ID;
-		else
+		} else {
 			return -ENODEV;
+		}
 		ret = ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);
 		if (ret)
 			return ret;
@@ -4029,11 +4066,13 @@ int ksz_switch_register(struct ksz_device *dev)
 	if (ret)
 		return ret;
 
-	/* Read MIB counters every 30 seconds to avoid overflow. */
-	dev->mib_read_interval = msecs_to_jiffies(5000);
+	if (!ksz_is_ksz8995xa(dev)) {
+		/* Read MIB counters every 30 seconds to avoid overflow. */
+		dev->mib_read_interval = msecs_to_jiffies(5000);
 
-	/* Start the MIB timer. */
-	schedule_delayed_work(&dev->mib_read, 0);
+		/* Start the MIB timer. */
+		schedule_delayed_work(&dev->mib_read, 0);
+	}
 
 	return ret;
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index cbe98494578c..93be74f7a265 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -281,6 +281,7 @@ enum ksz_model {
 	KSZ88X3,
 	KSZ8864,
 	KSZ8895,
+	KSZ8995XA,
 	KSZ9477,
 	KSZ9896,
 	KSZ9897,
@@ -789,7 +790,13 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 static inline bool ksz_is_8895_family(struct ksz_device *dev)
 {
 	return dev->chip_id == KSZ8895_CHIP_ID ||
-	       dev->chip_id == KSZ8864_CHIP_ID;
+	       dev->chip_id == KSZ8864_CHIP_ID ||
+	       dev->chip_id == KSZ8995XA_CHIP_ID;
+}
+
+static inline bool ksz_is_ksz8995xa(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8995XA_CHIP_ID;
 }
 
 static inline bool is_ksz8(struct ksz_device *dev)
@@ -860,6 +867,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ87_CHIP_ID_94		0x6
 #define KSZ87_CHIP_ID_95		0x9
 #define KSZ88_CHIP_ID_63		0x3
+#define KSZ8895_CHIP_ID_95XA		0x0
 #define KSZ8895_CHIP_ID_95		0x4
 #define KSZ8895_CHIP_ID_95R		0x6
 
@@ -923,6 +931,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ8863_HUGE_PACKET_SIZE	1916
 #define KSZ8863_NORMAL_PACKET_SIZE	1536
 #define KSZ8_LEGAL_PACKET_SIZE		1518
+#define KSZ8995XA_LEGAL_PACKET_SIZE	1522
 #define KSZ9477_MAX_FRAME_SIZE		9000
 
 #define KSZ8873_REG_GLOBAL_CTRL_12	0x0e
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index 7131c5caac54..968de88e8ddd 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -20,10 +20,12 @@
 #define KSZ8_PORT_DIFFSERV_ENABLE		BIT(6)
 #define KSZ8_PORT_802_1P_ENABLE			BIT(5)
 #define KSZ8_PORT_BASED_PRIO_M			GENMASK(4, 3)
+#define KSZ8995XA_PORT_BASED_PRIO		BIT(4)
 
 #define KSZ8463_REG_TOS_DSCP_CTRL		0x16
 #define KSZ88X3_REG_TOS_DSCP_CTRL		0x60
 #define KSZ8765_REG_TOS_DSCP_CTRL		0x90
+#define KSZ8995XA_REG_TOS_DSCP_CTRL_7		0x67
 
 #define KSZ9477_REG_SW_MAC_TOS_CTRL		0x033e
 #define KSZ9477_SW_TOS_DSCP_REMAP		BIT(0)
@@ -98,8 +100,11 @@ static void ksz_get_default_port_prio_reg(struct ksz_device *dev, int *reg,
 {
 	if (is_ksz8(dev)) {
 		*reg = KSZ8_REG_PORT_1_CTRL_0;
-		*mask = KSZ8_PORT_BASED_PRIO_M;
-		*shift = __bf_shf(KSZ8_PORT_BASED_PRIO_M);
+		if (ksz_is_ksz8995xa(dev))
+			*mask = KSZ8995XA_PORT_BASED_PRIO;
+		else
+			*mask = KSZ8_PORT_BASED_PRIO_M;
+		*shift = __bf_shf(*mask);
 		if (ksz_is_ksz8463(dev))
 			*reg = KSZ8463_REG_PORT_1_CTRL_0;
 	} else {
@@ -112,31 +117,45 @@ static void ksz_get_default_port_prio_reg(struct ksz_device *dev, int *reg,
 /**
  * ksz_get_dscp_prio_reg - Retrieves the DSCP-to-priority-mapping register
  * @dev: Pointer to the KSZ switch device structure
+ * @dscp: DSCP value for which to retrieve the register
  * @reg: Pointer to the register address to be set
- * @per_reg: Pointer to the number of DSCP values per register
  * @mask: Pointer to the mask to be set
+ * @shift: Pointer to the bit shift to be set
  *
- * This function retrieves the DSCP to priority mapping register, the number of
- * DSCP values per register, and the mask to be set.
+ * This function retrieves the register, mask and shift for a DSCP to priority
+ * mapping entry.
  */
-static void ksz_get_dscp_prio_reg(struct ksz_device *dev, int *reg,
-				  int *per_reg, u8 *mask)
+static void ksz_get_dscp_prio_reg(struct ksz_device *dev, u8 dscp, int *reg,
+				  u8 *mask, int *shift)
 {
+	int per_reg;
+
+	if (ksz_is_ksz8995xa(dev)) {
+		/* KSZ8995XA stores DSCP groups in descending register order. */
+		*reg = KSZ8995XA_REG_TOS_DSCP_CTRL_7 - dscp / 8;
+		*mask = BIT(0);
+		*shift = dscp % 8;
+		return;
+	}
+
 	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev)) {
 		*reg = KSZ8765_REG_TOS_DSCP_CTRL;
-		*per_reg = 4;
+		per_reg = 4;
 		*mask = GENMASK(1, 0);
 	} else if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev)) {
 		*reg = KSZ88X3_REG_TOS_DSCP_CTRL;
-		*per_reg = 4;
+		per_reg = 4;
 		*mask = GENMASK(1, 0);
 		if (ksz_is_ksz8463(dev))
 			*reg = KSZ8463_REG_TOS_DSCP_CTRL;
 	} else {
 		*reg = KSZ9477_REG_DIFFSERV_PRIO_MAP;
-		*per_reg = 2;
+		per_reg = 2;
 		*mask = GENMASK(2, 0);
 	}
+
+	*reg += dscp / per_reg;
+	*shift = (dscp % per_reg) * (8 / per_reg);
 }
 
 /**
@@ -236,10 +255,10 @@ int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
 int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 {
 	struct ksz_device *dev = ds->priv;
-	int reg, per_reg, ret, shift;
+	int reg, ret, shift;
 	u8 data, mask;
 
-	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
+	ksz_get_dscp_prio_reg(dev, dscp, &reg, &mask, &shift);
 
 	/* If DSCP remapping is disabled, DSCP bits 3-5 are used as Internal
 	 * Priority Map (IPM)
@@ -260,13 +279,10 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
 	/* In case DSCP remapping is enabled, we need to write the DSCP to
 	 * priority mapping table.
 	 */
-	reg += dscp / per_reg;
 	ret = ksz_read8(dev, reg, &data);
 	if (ret)
 		return ret;
 
-	shift = (dscp % per_reg) * (8 / per_reg);
-
 	return (data >> shift) & mask;
 }
 
@@ -283,15 +299,12 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
  */
 static int ksz_set_global_dscp_entry(struct ksz_device *dev, u8 dscp, u8 ipm)
 {
-	int reg, per_reg, shift;
+	int reg, shift;
 	u8 mask;
 
-	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
-
-	shift = (dscp % per_reg) * (8 / per_reg);
+	ksz_get_dscp_prio_reg(dev, dscp, &reg, &mask, &shift);
 
-	return ksz_rmw8(dev, reg + (dscp / per_reg), mask << shift,
-			ipm << shift);
+	return ksz_rmw8(dev, reg, mask << shift, ipm << shift);
 }
 
 /**
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 77aecac32466..2c55014246e5 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -161,7 +161,8 @@ static int ksz_spi_probe(struct spi_device *spi)
 		 chip->chip_id == KSZ8794_CHIP_ID ||
 		 chip->chip_id == KSZ8765_CHIP_ID)
 		regmap_config = ksz8795_regmap_config;
-	else if (chip->chip_id == KSZ8895_CHIP_ID ||
+	else if (chip->chip_id == KSZ8995XA_CHIP_ID ||
+		 chip->chip_id == KSZ8895_CHIP_ID ||
 		 chip->chip_id == KSZ8864_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
 	else
@@ -185,7 +186,10 @@ static int ksz_spi_probe(struct spi_device *spi)
 		dev->pdata = spi->dev.platform_data;
 
 	/* setup spi */
-	spi->mode = SPI_MODE_3;
+	if (chip->chip_id == KSZ8995XA_CHIP_ID)
+		spi->mode = SPI_MODE_0;
+	else
+		spi->mode = SPI_MODE_3;
 	ret = spi_setup(spi);
 	if (ret)
 		return ret;
@@ -239,6 +243,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "micrel,ksz8795",
 		.data = &ksz_switch_chips[KSZ8795]
 	},
+	{
+		.compatible = "micrel,ks8995",
+		.data = &ksz_switch_chips[KSZ8995XA]
+	},
 	{
 		.compatible = "microchip,ksz8463",
 		.data = &ksz_switch_chips[KSZ8463]
@@ -271,6 +279,10 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,ksz8895",
 		.data = &ksz_switch_chips[KSZ8895]
 	},
+	{
+		.compatible = "microchip,ksz8995xa",
+		.data = &ksz_switch_chips[KSZ8995XA]
+	},
 	{
 		.compatible = "microchip,ksz9477",
 		.data = &ksz_switch_chips[KSZ9477]
@@ -332,6 +344,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ksz_dt_ids);
 
 static const struct spi_device_id ksz_spi_ids[] = {
+	{ "ks8995" },
 	{ "ksz8463" },
 	{ "ksz8765" },
 	{ "ksz8794" },
@@ -340,6 +353,7 @@ static const struct spi_device_id ksz_spi_ids[] = {
 	{ "ksz8864" },
 	{ "ksz8873" },
 	{ "ksz8895" },
+	{ "ksz8995" },
 	{ "ksz9477" },
 	{ "ksz9896" },
 	{ "ksz9897" },
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 028781ad4059..d8eddd21c3c7 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -31,6 +31,7 @@ enum ksz_chip_id {
 	KSZ88X3_CHIP_ID = 0x8830,
 	KSZ8864_CHIP_ID = 0x8864,
 	KSZ8895_CHIP_ID = 0x8895,
+	KSZ8995XA_CHIP_ID = 0x8995,
 	KSZ9477_CHIP_ID = 0x00947700,
 	KSZ9896_CHIP_ID = 0x00989600,
 	KSZ9897_CHIP_ID = 0x00989700,

-- 
2.55.0

