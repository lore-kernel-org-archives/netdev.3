Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097836920D;
	Mon, 13 Jul 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926694; cv=none; b=mrLXi915fAKAhLeKQeB8ElHuosGm5kv0TJW748aJMbU4oAZeA+G8dHVHivwS5OjR2zQTi/aG9WImwOgqEqPrSgxp4wOVoxwVySArDLfSEKuUPv/CSLKd3q//hsPyo88RBt0PCuRPyGVjxPc5jP2Y6DIWG1NTfARGOSsd5Lpz/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926694; c=relaxed/simple;
	bh=9+s59vVF/Gq4K01YMEay/qs0kVj7lrirrvWr/fntb7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UG3ydC6wB8yyU8GRQQLDYkPXCGLcXyTskt55PB9afyvfCK88nZnHl16dyDrMooDBK97M5NJh0Dm+JhOdyh9v48bgdyKV0yHa8U37CnQBC0pxFG3sXql/scSAJebpCs5ExS+l0PbY4BDpjWKBqFuBAR5B5nOIvh4F4FAJMZDWZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ULONoqUn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ULONoqUn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 776274E40D82;
	Mon, 13 Jul 2026 07:11:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B96260341;
	Mon, 13 Jul 2026 07:11:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BBF711BD0B6C;
	Mon, 13 Jul 2026 09:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926687; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MM4O3FKQ8UCoY9QGTkKJE3vnVRNbZTCtLocOkRLeTwM=;
	b=ULONoqUnPziRw6rQgDjVGCp5MxEBaqjt+lo97iqCE6kjbb3BmVn/UMSHjDd9RXy21oaUM8
	VJeB50U0Op9J2oEyJcbykYdxNMp6KC49E2ipuvOwLiJal3UewNCwrIe6wuxi2+b7I1qpzP
	+4vZ1J/JlOzMiKclNxSW5yVGvA2+era+U9KztVorYyGZFrb2vxMMLnc6/A3Go9ay7WuA15
	9HS61XMlUziergggbVxp9VkWnJuvAnYX012ZjZO6THrvPmy7weDlDwl+5dCukOVzRWLag5
	OBefMHI18gIcyY7qvppveVeOL2X7aOlNzgRhkhPX2p3ajeIyWx66c3BsvxIPSQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:20 +0200
Subject: [PATCH net-next v2 01/10] net: dsa: microchip: implement
 ksz8463_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-1-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
In-Reply-To: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

KSZ8463 uses the ksz8_setup() as setup() callback for its DSA
operations. Its behavior is quite different than other KSZ8 switches,
especially its interrupt scheme.

Remove from the ksz8_setup()/ksz8_reset_switch() everything that is
ksz8463-related.
Create a dedicated ksz8463_setup() and a ksz8463_reset_switch() function.
This new ksz8463_setup() is widely inspired from ksz8_setup, it has
following differences:
- it doesn't configure drive strength (not supported on KSZ8463)
- it uses the ksz8463_reset_switch()
- it doesn't call ksz8_handle_global_errata() (the handled errata only
  affects the KSZ87xx variant)
- it doesn't configure IRQs. Note that ksz8_setup()'s IRQ initialization
  doesn't work for the KSZ8463 anyway. Proper support for it comes in
  upcoming patches.

Remove the teardown implementation from the KSZ8463 operations. Since
PTP and interrupts aren't setup, the common ksz_teardown() wouldn't do
anything anyway.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 126 +++++++++++++++++++++++++++++++++++----
 1 file changed, 114 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c4c769028a20..5ed63f425013 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -181,6 +181,14 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
 	return ksz8_ind_write8(dev, table, (u8)(offset), data);
 }
 
+static int ksz8463_reset_switch(struct ksz_device *dev)
+{
+	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
+	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET,
+		false);
+	return 0;
+}
+
 static int ksz8_reset_switch(struct ksz_device *dev)
 {
 	if (ksz_is_ksz88x3(dev)) {
@@ -189,11 +197,6 @@ static int ksz8_reset_switch(struct ksz_device *dev)
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);
 		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, false);
-	} else if (ksz_is_ksz8463(dev)) {
-		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
-			KSZ8463_GLOBAL_SOFTWARE_RESET, true);
-		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
-			KSZ8463_GLOBAL_SOFTWARE_RESET, false);
 	} else {
 		/* reset switch */
 		ksz_write8(dev, REG_POWER_MANAGEMENT_1,
@@ -2300,6 +2303,110 @@ static void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
 	spin_unlock(&mib->stats64_lock);
 }
 
+static int ksz8463_setup(struct dsa_switch *ds)
+{
+	struct ksz_device *dev = ds->priv;
+	u16 storm_mask, storm_rate;
+	struct ksz_port *p;
+	const u16 *regs;
+	int i, ret;
+
+	regs = dev->info->regs;
+
+	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
+				       dev->info->num_vlans, GFP_KERNEL);
+	if (!dev->vlan_cache)
+		return -ENOMEM;
+
+	ret = ksz8463_reset_switch(dev);
+	if (ret) {
+		dev_err(ds->dev, "failed to reset switch\n");
+		return ret;
+	}
+
+	/* set broadcast storm protection 10% rate */
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	storm_mask = swab16(storm_mask);
+	storm_rate = swab16(storm_rate);
+	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
+			   storm_mask, storm_rate);
+
+	ksz8_config_cpu_port(ds);
+
+	ksz8_enable_stp_addr(dev);
+
+	ds->num_tx_queues = dev->info->num_tx_queues;
+
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
+			   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
+
+	ksz_init_mib_timer(dev);
+
+	ds->configure_vlan_while_not_filtering = false;
+	ds->dscp_prio_mapping_is_global = true;
+	ds->mtu_enforcement_ingress = true;
+
+	/* We rely on software untagging on the CPU port, so that we
+	 * can support both tagged and untagged VLANs
+	 */
+	ds->untag_bridge_pvid = true;
+
+	/* VLAN filtering is partly controlled by the global VLAN
+	 * Enable flag
+	 */
+	ds->vlan_filtering_is_global = true;
+
+	/* Enable automatic fast aging when link changed detected. */
+	ksz_cfg(dev, S_LINK_AGING_CTRL, SW_LINK_AUTO_AGING, true);
+
+	/* Enable aggressive back off algorithm in half duplex mode. */
+	ret = ksz_rmw8(dev, REG_SW_CTRL_1, SW_AGGR_BACKOFF, SW_AGGR_BACKOFF);
+	if (ret)
+		return ret;
+
+	/*
+	 * Make sure unicast VLAN boundary is set as default and
+	 * enable no excessive collision drop.
+	 */
+	ret = ksz_rmw8(dev, REG_SW_CTRL_2,
+		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
+		       UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
+	if (ret)
+		return ret;
+
+	ksz_cfg(dev, S_REPLACE_VID_CTRL, SW_REPLACE_VID, false);
+
+	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
+
+	for (i = 0; i < (dev->info->num_vlans / 4); i++)
+		ksz8_r_vlan_entries(dev, i);
+
+	/* Start with learning disabled on standalone user ports, and enabled
+	 * on the CPU port. In lack of other finer mechanisms, learning on the
+	 * CPU port will avoid flooding bridge local addresses on the network
+	 * in some cases.
+	 */
+	p = &dev->ports[dev->cpu_port];
+	p->learning = true;
+
+	ret = ksz_mdio_register(dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "failed to register the mdio");
+		return ret;
+	}
+
+	ret = ksz_dcb_init(dev);
+	if (ret)
+		return ret;
+
+	/* start switch */
+	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
+			   SW_START, SW_START);
+
+	return 0;
+}
+
 /**
  * ksz88x3_drive_strength_write() - Set the drive strength configuration for
  *				    KSZ8863 compatible chip variants.
@@ -2445,10 +2552,6 @@ static int ksz8_setup(struct dsa_switch *ds)
 	/* set broadcast storm protection 10% rate */
 	storm_mask = BROADCAST_STORM_RATE;
 	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
-	if (ksz_is_ksz8463(dev)) {
-		storm_mask = swab16(storm_mask);
-		storm_rate = swab16(storm_rate);
-	}
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   storm_mask, storm_rate);
 
@@ -2499,7 +2602,7 @@ static int ksz8_setup(struct dsa_switch *ds)
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
 
-	if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
+	if (!ksz_is_ksz88x3(dev))
 		ksz_cfg(dev, REG_SW_CTRL_19, SW_INS_TAG_ENABLE, true);
 
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
@@ -2889,8 +2992,7 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
 const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_tag_protocol	= ksz8463_get_tag_protocol,
 	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
-	.setup			= ksz8_setup,
-	.teardown		= ksz_teardown,
+	.setup			= ksz8463_setup,
 	.phy_read		= ksz8463_phy_read16,
 	.phy_write		= ksz8463_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,

-- 
2.54.0

