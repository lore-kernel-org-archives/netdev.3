Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291B3C9ED6
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130007; cv=none; b=raFpfshK9rRqoKg45HNnlqfAt4MHJ5XYhiiem/LLwaPcHeJ1jVgsGcCGrNx4lPaUnFy8utqS4NrjIxml+uvzVmTQTM7eoP6y2xwVqg7azrqW8XD7vl+p3NQbDKeMJzcUMHi0LFTBr6qGYHGNy4TP66NQ7Vv8Inr4vHvsguvZZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130007; c=relaxed/simple;
	bh=VooV3JwsW9yXVHw6azs8gPGTYXD8vRYlcI8YH6GPU/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQo29NugsG3mZ/y5ZnBa+XKTeyhxMSyCUVXd8QyhtHY6NZnuU2R22yFvYlEpydme5EgToHvRxPADeuoPBy/1MFx1OZyOqYpPTuYJMNgS2oYvVehFjZxsLs5neKrArIzpThrJT2caEcJ+tFqqstbnwQ4sKTKe/GC+hlNRP/1/4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRmFsXSe; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRmFsXSe"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-88e8f5a5de2so75643b3a.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791130005; x=1791734805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmSanoQANogxt1xJb6FXY7g5PjS88j7pCYVrEOwfDRQ=;
        b=eRmFsXSeDNPfsKGiEAF9vJbjaXRVSpXOkEgslKh64oPN1051qj2FQ5+7PgdEoyXcGS
         dCkIFWleaMrbZAM62AhZMSnE2UleofWPlRyXghVZp+I0TXwcGyNantRXdcriXk0vlD5r
         u/yKN5OuwwuACGb37fUN+07HPgVAf6ZHzRUGOfD+UWv3vHiWh8U9Ahws5kRIAjyn28Qb
         bP6xFwPYLk1Yd/wSkrpeehKH8Kt1OnAKq8kfZvXEudU5ZOPFAEnmtt3g2i+yLE6tphdj
         hvHn/LJIPdmvxWxL/ceSGeNZO+Ay/2dBy37ny4vKH3l3ugLPeFQwNqOS7Q+556JWEHY6
         MmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791130005; x=1791734805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmSanoQANogxt1xJb6FXY7g5PjS88j7pCYVrEOwfDRQ=;
        b=gU2dhqrxQ44FFg+TaduKDgFnOsYgPrEZ5qE3++s5jpMHhyL2onp4h/4UD2Ucv1SMwu
         QXZwel9iCcWk+NGTmBlULOXg+FPm5fikegzA+XTYdNjfed0vlUYdtpzk30x4esz/HbcW
         M+kt5QKBD1eaJXbwbKReYVwhtrSN/66ZD37EzDsZ19Z4X9YDyV9DtmpS67NywXNTozop
         lvBRzDvC+fSB6HPYAiLcM8+yjv5Jpu8u8v6ItZ3y0LDz9Yr7mt79yYJgmB5PXAGkKuq3
         32uMWx5ZEKtI34jRW5RpNJaF8Ymtj2i+IMHC6zJDrnOpK0R1y/qWyMCOwiRyaZ4KN2id
         iL/g==
X-Gm-Message-State: AFuF++l+0UwCCCiUSYqUDlSkKhTkVgSfhlFcoCBqJx/5F+taVNrdDTAp
	29P2Iintd9n7yWdtTU8G27Tjow2X7KwrDEJUta0TAJRPs0b/eAzl0gf70FoavNNbrDE=
X-Gm-Gg: AYBFou3EBXrfuU8gwSi1yuf9LKZnEiA0V4/LAXKd3A0NWnMp1JkKJ5T0alVKWZYxIrU
	4PPQy57UL9ZqcWE2itrsPAyxMq4b5DB6LbSTOtbVrCqVhN4kHYKk76DmZacGlXpSKP/l8HYC4+J
	X0Iy7iu2qJ5iIPvkOtCu5U4tn/QsdL8CtGsifIcZ1tq2FK1a3w0GQdheysXh8GTHSXUnibZfTn/
	siqf5UJYvahI+JAI2e+Qr9N3GVmXups9/OPX5zLsJzhUVlbP6mLfDtiOfbakErxd7MsZP+rPoiz
	d+3qef9F4JpzPOIkbopqiRGVj1t3jg4pyGTZKUQzcqOGrK+AzvQyJgg7KnpsweSnsk+dbQjouK5
	7uSmzc1mjeojGag2NTVJzeSn/o2O7rX9nS/IC3Z5cJcE0s8blZ5sR46Ru/XxeigZG6j+5DiZMei
	lWS1Gn+BmeNn/qVyBmS83WDXTrhB9trKGOEOMsZOzVb1FdgISXswLTq5+9h50q+YMYuhkQ4mIRJ
	q1tO/8QfR0ALFFfQXCgaY4d1w==
X-Received: by 2002:a05:6a00:138f:b0:883:96f0:da3b with SMTP id d2e1a72fcca58-88af6658e79mr6949737b3a.22.1791130005403;
        Sun, 04 Oct 2026 09:06:45 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2637789b3a.54.2026.10.04.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:06:45 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/6] net: dsa: motorcomm: Split MIB buffers
Date: Mon,  5 Oct 2026 00:06:17 +0800
Message-ID: <20261004160622.948037-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004160622.948037-1-mmyangfl@gmail.com>
References: <20261004160622.948037-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With MIB improvement introduced later, struct yt921x_priv will be over
20 KiB which is not very good for a single kmalloc(). Dynamically
allocate the MIB structures to reduce the size of struct yt921x_priv
(and adjust polling work lifecycle), and do not waste memory on dummy
ports.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 124 ++++++++++++++++++++++++-------
 drivers/net/dsa/motorcomm/chip.h |  20 +++--
 2 files changed, 112 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 690ee0eb5192..8341d4d1c784 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -270,10 +270,13 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib_stats *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
 	int res = 0;
 
-	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
+	mib = &pm->stats;
+
+	/* Reading of yt921x_mib_stats is not protected by a lock and it's vain
 	 * to keep its consistency, since we have to read registers one by one
 	 * and there is no way to make a snapshot of MIB stats.
 	 *
@@ -310,11 +313,11 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
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
@@ -327,8 +330,9 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 
 static void yt921x_mib_poll(struct work_struct *work)
 {
-	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
-						    mib_read.work);
+	struct yt921x_mib *pm = container_of_const(work, struct yt921x_mib,
+						   work.work);
+	struct yt921x_port *pp = pm->port;
 	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
 	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
 	int port = pp->index;
@@ -340,7 +344,7 @@ static void yt921x_mib_poll(struct work_struct *work)
 	if (res)
 		delay *= 4;
 
-	schedule_delayed_work(&pp->mib_read, delay);
+	schedule_delayed_work(&pm->work, delay);
 }
 
 static void
@@ -363,9 +367,14 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
@@ -405,16 +414,21 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
@@ -441,7 +455,12 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
@@ -470,7 +489,12 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
@@ -506,7 +530,12 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
@@ -522,8 +551,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	/* stats->tx_heartbeat_errors */
 	stats->tx_window_errors = mib->tx_late_collisions;
 
-	stats->rx_packets = pp->rx_frames;
-	stats->tx_packets = pp->tx_frames;
+	stats->rx_packets = pm->rx_frames;
+	stats->tx_packets = pm->tx_frames;
 	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
 	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
 	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
@@ -542,7 +571,12 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
@@ -3649,11 +3683,14 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
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
@@ -3672,6 +3709,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
+	struct yt921x_mib *pm;
 	int port = dp->index;
 	int res;
 
@@ -3684,7 +3722,9 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
 			port, res);
 
-	schedule_delayed_work(&priv->ports[port].mib_read, 0);
+	pm = priv->ports[port].mib;
+	if (pm)
+		schedule_delayed_work(&pm->work, 0);
 }
 
 static void
@@ -3798,16 +3838,52 @@ yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
 	return DSA_TAG_PROTO_YT921X;
 }
 
+static void yt921x_dsa_port_teardown(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+
+	/* get_stats64() might not be synchronized with port_teardown(), hold
+	 * the MIB block till the device teardown
+	 */
+	if (pm)
+		disable_delayed_work_sync(&pm->work);
+}
+
 static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	const struct yt921x_info *info = priv->info;
+	struct device *dev = yt921x_priv_to_device(priv);
+	struct yt921x_mib *pm = pp->mib;
 	int res;
 
+	if (!pm && (BIT(port) & yt921x_info_ports_mask(info))) {
+		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
+		if (!pm)
+			return -ENOMEM;
+		pp->mib = pm;
+
+		pm->port = pp;
+		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
+		/* Start disabled, so that the enable below always pairs with
+		 * either this disable or the one from a previous teardown
+		 */
+		disable_delayed_work_sync(&pm->work);
+	}
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_port_setup(priv, port);
 	mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
 
-	return res;
+	if (pm)
+		enable_delayed_work(&pm->work);
+
+	return 0;
 }
 
 /* Not "port" - DSCP mapping is global */
@@ -4382,6 +4458,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
+	.port_teardown		= yt921x_dsa_port_teardown,
 	.port_setup		= yt921x_dsa_port_setup,
 #if IS_ENABLED(CONFIG_DCB)
 	/* dscp */
@@ -4411,12 +4488,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
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
@@ -4464,7 +4535,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 		struct yt921x_port *pp = &priv->ports[i];
 
 		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_mib_poll);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index c1b24b6d1d97..d1764b635630 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -885,6 +885,15 @@ struct yt921x_mib_stats {
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
@@ -917,11 +926,6 @@ struct yt921x_port {
 	/* BR_ISOLATED */
 	bool isolated:1;
 
-	struct delayed_work mib_read;
-	struct yt921x_mib_stats mib;
-	u64 rx_frames;
-	u64 tx_frames;
-
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	unsigned char led_duty;
 	unsigned short led_cycle;
@@ -932,6 +936,7 @@ struct yt921x_port {
 	struct yt921x_led *leds[YT921X_LED_GROUP_NUM];
 #endif
 
+	struct yt921x_mib *mib;
 	struct phylink_pcs pcs;
 };
 
@@ -955,6 +960,11 @@ struct yt921x_info {
 	u16 serdes_mask;
 };
 
+static inline u16 yt921x_info_ports_mask(const struct yt921x_info *info)
+{
+	return info->internal_mask | info->xmii_mask | info->serdes_mask;
+}
+
 struct yt921x_priv {
 	struct dsa_switch ds;
 
-- 
2.53.0

