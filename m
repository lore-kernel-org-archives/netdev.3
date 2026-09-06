Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E43C9EF4
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700476; cv=none; b=Py39IqC5C31vMoIv/l5LxctI5W/kGv0EM9vv2J0DXXsN+gIFHHUYaY+UHbKTo7CIahh7+kegGUkQP3jJ8+W+8n+ZGNLqlSgQTZ7/BtBJulIf15pIhkJG3Sqy9L0mOwYxyTy2NKLTW4WHh/zp0QE/Nsgxt8wMNs/Wn3bbox8hAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700476; c=relaxed/simple;
	bh=mDuuG8QPs0tjtvTNVEV6Zqj47CC19id0dGC8TfD7gcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdwdrC2tQtSnhV2IVqa4jsO6Dl1Jplz7LUBrPNGquNISt5jKK/5dkbOfEvQHkCbfi2viVJNdthvTUfg1C9GNKYt9JEw0ba0vfIvVLS3G2yapYTBKn5uc8JbeF1f3kOjfqKzGXEJ7ExwnvvjsyDePz46nST/QH6FHyUBKt87A8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV7Tzuy6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV7Tzuy6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d53197d8b5so22838985ad.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788700474; x=1789305274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sLOlJMtfrETY3822qdYZg30BkO/eK1Yw5q64p9t9ZVs=;
        b=QV7Tzuy60FoChJJ62iepWrpjhwPpMH4+FicgT78eA1iLSgnKoQGs+oXjS5j0LPWqw5
         ygMiLg39sg/WFK184LvFf3jhYeE8kp3RXOf1nJfsMaeI/H8jVhNyw9JTec5dpRV+weu4
         Ot056gllaykn7SsmCK4Wll0y8rfQoyC7fKS22qBDMDqfS0Z14iKgGJOAzAQoQierPCyz
         FNHtZfEWSGT6fNYeYjM1+ZBI1aIdsMi8lM35GTyRSwCCGi98BVm5Pf01uDI0KT6w8/Of
         PjbajZerHolRNkzENmKgVlWPkX4qCtloGJVj/bIFDw2EOHMC0hWPoqfQIw+qdpS4RVPO
         k7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788700474; x=1789305274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sLOlJMtfrETY3822qdYZg30BkO/eK1Yw5q64p9t9ZVs=;
        b=H/Qpk4A5a8IfMipw5pd0mF7b90nBzXagZkxGxc7Gpf+tUBiZQiq3M7lkWsm/Gdthj7
         1j/QYU+q4GFNairCuW5XrnCs8lJF9J2di6IVMuf2iR1K85l2SDnmXVkY0e0uZIa2flWY
         HepmVJ9kwh7Vi3jQHCcABolYCL64w8m9bBd4m8xviGR5OHbdxp+NgGlikx33RiIFCerR
         Q1I4FXXu2j50rQv26UaogKBOjgN8ZHRAJjeH2zHhhM+Zse6FctxbLcFvYN96aeAYxveY
         u+tD2XGbn6s5nGxYYwnmdlE0xV0kMMqD3JgIQr3ovI37fKYy/E+2zbfGky8hwsR/6pNg
         qy/g==
X-Gm-Message-State: AFuF++ksk4d3SXqv4ClPL1VbWc6fyD+SRrjcJxQHmORyxTpXT+WQjPAA
	UjIF5UC+d83xf1guT7zpFp0+9SdGTWlNDA0GlO6XIL5/miwBI/I1bu/ZiickdDv9
X-Gm-Gg: AYBFou0IojIoN7HpGPaBOHYCj4J/W7eu2amLaiZyAa+uASgN6zb8esJSoVVYBOuyPOn
	w4XuFFy1EWe6rpxYSPf4aDEnE7Jqu0dfZjbma7dt/Hyte9xAIr3cmculwjIxuDKOUgqY2e9Q7t5
	ewQe75x9JDQdbS1mMyujZ6v4SSl6vY22AFpopg0J7g2QhwnPgj8KcGKiNSVfw0kBuS8cjgvTKzJ
	ZtnhWh8cjrjBHnMDrmHj6tS2VajwsEYlqsMg5uy8IOOVQA4pc1YADNTCIWgOAnBAVfF5fdwj8/c
	nKMtSHo2eBG0D/uxPpsf/g9ldVGguf6kCgu9K8w0zjrNBQi6v16Vh3skFwVTAubRRZnLfbElO5v
	LhDhLKuYbTWaLGbd21WqGI+fdvI3liIV2/6uvUp2839nSBcO4AAg3p4YGnnvnrTqsGYKTocD+BF
	xA6wMfoIDroZu+AiJZ3x/mIqlsj0gyfgylpmeCkQPV4i7Z68vhooHA+dIMIuBPEZFy9hm9iSJ9o
	d1TYs5FovcGNA==
X-Received: by 2002:a17:902:fd86:b0:2d6:3c2f:6a5 with SMTP id d9443c01a7336-2db125a342dmr262172625ad.14.1788700473767;
        Sun, 06 Sep 2026 06:14:33 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b2f8sm32259965ad.21.2026.09.06.06.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:14:33 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/6] net: dsa: motorcomm: Split MIB buffers
Date: Sun,  6 Sep 2026 21:14:07 +0800
Message-ID: <20260906131414.2683362-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906131414.2683362-1-mmyangfl@gmail.com>
References: <20260906131414.2683362-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With MIB improvement introduced later, struct yt921x_priv will be over
20k which is not very good for a single kmalloc(). Dynamically allocate
the MIB structures to reduce the size of struct yt921x_priv, and do not
waste memory on dummy ports.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 112 +++++++++++++++++++++++--------
 drivers/net/dsa/motorcomm/chip.h |  16 +++--
 2 files changed, 96 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index ad5fe1ccb1d7..95041a2fb0ec 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -549,9 +549,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
 	struct device *dev = to_device(priv);
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
 	int res = 0;
 
+	mib = &pm->stats;
+
 	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
 	 * to keep its consistency, since we have to read registers one by one
 	 * and there is no way to make a snapshot of MIB stats.
@@ -589,11 +592,11 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		WRITE_ONCE(*valp, val);
 	}
 
-	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
+	pm->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
 			mib->rx_128_255byte + mib->rx_256_511byte +
 			mib->rx_512_1023byte + mib->rx_1024_1518byte +
 			mib->rx_jumbo;
-	pp->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
+	pm->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
 			mib->tx_128_255byte + mib->tx_256_511byte +
 			mib->tx_512_1023byte + mib->tx_1024_1518byte +
 			mib->tx_jumbo;
@@ -606,10 +609,11 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 
 static void yt921x_mib_poll(struct work_struct *work)
 {
-	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
-						    mib_read.work);
-	struct yt921x_priv *priv = (void *)(pp - pp->index) -
-				   offsetof(struct yt921x_priv, ports);
+	struct yt921x_mib *pm = container_of_const(work, struct yt921x_mib,
+						   work.work);
+	struct yt921x_port *pp = pm->port;
+	struct yt921x_priv *priv = container_of_const(pp, struct yt921x_priv,
+						      ports[pp->index]);
 	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
 	int port = pp->index;
 	int res;
@@ -620,7 +624,7 @@ static void yt921x_mib_poll(struct work_struct *work)
 	if (res)
 		delay *= 4;
 
-	schedule_delayed_work(&pp->mib_read, delay);
+	schedule_delayed_work(&pm->work, delay);
 }
 
 static void
@@ -643,9 +647,14 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
 	size_t j;
 
+	if (!pm)
+		return;
+	mib = &pm->stats;
+
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -685,16 +694,21 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	mac_stats->FramesTransmittedOK = pp->tx_frames;
+	mac_stats->FramesTransmittedOK = pm->tx_frames;
 	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
 	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
-	mac_stats->FramesReceivedOK = pp->rx_frames;
+	mac_stats->FramesReceivedOK = pm->rx_frames;
 	mac_stats->FrameCheckSequenceErrors = mib->rx_crc_errors;
 	mac_stats->AlignmentErrors = mib->rx_alignment_errors;
 	mac_stats->OctetsTransmittedOK = mib->tx_good_bytes;
@@ -721,7 +735,12 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
@@ -750,7 +769,12 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
@@ -786,7 +810,12 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
@@ -802,8 +831,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	/* stats->tx_heartbeat_errors */
 	stats->tx_window_errors = mib->tx_late_collisions;
 
-	stats->rx_packets = pp->rx_frames;
-	stats->tx_packets = pp->tx_frames;
+	stats->rx_packets = pm->rx_frames;
+	stats->tx_packets = pm->tx_frames;
 	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
 	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
 	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
@@ -822,7 +851,12 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
@@ -3953,11 +3987,14 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_mib *pm;
 	int port = dp->index;
 	int res;
 
 	/* No need to sync; port control block is hold until device remove */
-	cancel_delayed_work(&priv->ports[port].mib_read);
+	pm = priv->ports[port].mib;
+	if (pm)
+		cancel_delayed_work(&pm->work);
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_port_down(priv, port);
@@ -3976,6 +4013,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_mib *pm;
 	int port = dp->index;
 	int res;
 
@@ -3988,7 +4026,9 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
 			port, res);
 
-	schedule_delayed_work(&priv->ports[port].mib_read, 0);
+	pm = priv->ports[port].mib;
+	if (pm)
+		schedule_delayed_work(&pm->work, 0);
 }
 
 static void
@@ -4108,11 +4148,35 @@ yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
 	return DSA_TAG_PROTO_YT921X;
 }
 
+static void yt921x_dsa_port_teardown(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+
+	if (pm)
+		disable_delayed_work_sync(&pm->work);
+}
+
 static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct device *dev = to_device(priv);
+	struct yt921x_mib *pm = pp->mib;
 	int res;
 
+	if (!pm && (BIT(port) & (priv->info->internal_mask |
+		    priv->info->external_mask))) {
+		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
+		if (!pm)
+			return -ENOMEM;
+		pp->mib = pm;
+
+		pm->port = pp;
+		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
+	}
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_port_setup(priv, port);
 	mutex_unlock(&priv->reg_lock);
@@ -4667,6 +4731,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
+	.port_teardown		= yt921x_dsa_port_teardown,
 	.port_setup		= yt921x_dsa_port_setup,
 #if IS_ENABLED(CONFIG_DCB)
 	/* dscp */
@@ -4696,12 +4761,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 	if (!priv)
 		return;
 
-	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
-		struct yt921x_port *pp = &priv->ports[i];
-
-		disable_delayed_work_sync(&pp->mib_read);
-	}
-
 	dsa_unregister_switch(&priv->ds);
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(priv->acl_blks); i++) {
@@ -4749,7 +4808,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 		struct yt921x_port *pp = &priv->ports[i];
 
 		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_mib_poll);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 805febb48683..5bf2d3409f4b 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -913,6 +913,15 @@ struct yt921x_mib_stats {
 	u64 tx_oam;
 };
 
+struct yt921x_mib {
+	struct yt921x_port *port;
+
+	struct delayed_work work;
+	struct yt921x_mib_stats stats;
+	u64 rx_frames;
+	u64 tx_frames;
+};
+
 struct yt921x_acl_entry {
 	u32 key[2];
 	u32 mask[2];
@@ -939,11 +948,6 @@ struct yt921x_port {
 	bool hairpin;
 	bool isolated;
 
-	struct delayed_work mib_read;
-	struct yt921x_mib_stats mib;
-	u64 rx_frames;
-	u64 tx_frames;
-
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	unsigned char led_duty;
 	unsigned short led_cycle;
@@ -953,6 +957,8 @@ struct yt921x_port {
 
 	struct yt921x_led *leds[YT921X_LED_GROUP_NUM];
 #endif
+
+	struct yt921x_mib *mib;
 };
 
 struct yt921x_reg_ops {
-- 
2.53.0

