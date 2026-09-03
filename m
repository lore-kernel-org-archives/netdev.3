Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5364B7143
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446290; cv=none; b=pFxnkLOgbT4n4IaqYZ15mDep1WvgbEral7V2aMiTD+hoVo95k+ziGB43J19QbBbH4yBWtc6ixep00NwvmoMNzVUUIYoaRpSGSA6+A7jFSvQ4UKY/20i3Tm/ZEi2LwimssJ7BLbxpqbX9fKYqxx7co1Z7rbZ814z1MscTDdY/F3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446290; c=relaxed/simple;
	bh=lrHGsnMu75xl8v76dJVetLK23k6vmOupMrZqyuDZRuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/UuXRWDlojU1hUNvUZSC8pwrkk+CBPJnCqb0w3own/Ho1gsSYkdtPZu1OCJ8MdgFLBeOlP+I6M6GWGOdAviVuMInzFnbkrdhf0uJ3QWs6UflTHkD1nUzYB9CKwdvAaAQx+SWDaQfYn2X4buX/VI9lOHAAvQLdcsHeBpvo5V2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSjAXr0r; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSjAXr0r"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso3277858a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446282; x=1789051082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcD5uN5fp5EswiCHXuiZ4B8QQTZVN5ZDP+x7PcjVnFA=;
        b=qSjAXr0rV3h0VC2y1/g5SuslndMREpUnoU5e4EDxoJTfDHlmTvdFGHjrMuQAJan0NJ
         yfUfgew8dvDC8XqEuE4L/KZzYr8scw38MqwJQWV6Kfcad4mUKqh591zge96L26BR0Ur8
         F5c7GC6QqEOUJ2fiHHQlkXlDeZ0vy9yAgXXEVP557lMQF0VTRK6q/5g4cb8buYdwIOUl
         De82q8pDf/6DLDbbOXl8bPvtK05ZPln9mmd+Ef6SgRPE/osMC1TqcTxrx8GEtM9L2Dej
         62MrC8nYVU12All6RAsEZ2clzb5JIaPC7DUTcdQlOVjlljH5OJOeBagxtDyR5+AEuidK
         72Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446282; x=1789051082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NcD5uN5fp5EswiCHXuiZ4B8QQTZVN5ZDP+x7PcjVnFA=;
        b=d8mSUbzH0Yyu97LH2truDE0YpAEg69SY8AvrKqpL8g35JKDeFMFt8+NnTk6deScWJi
         erodgYnkYu+pTYv+1KHumwFtuLu/qClrGBy5aCiP7Bc1yV98qQwYFSXD08Rpdzqn4q+3
         DUSgJooGMHF5VbmOafQTvAG39QAGuYO1DckNDbJ8MFo5sSr8hptSc8R3WK63jTHo9UBe
         PM7KoIxRxJQUbo9fN8dENX//Y+Co2lBtnhbYlgBY0YZh+LHEfZd1BlZ35RUlStw3KgxZ
         TcahUtdKj3dYAGC+A7MFAePCPbWL/yfhZthBSX0N3AVAsicbektULgNKF2TsDwtJTlE+
         3uEw==
X-Gm-Message-State: AFuF++mkN5Wzd07zPT2PxnvZV3FTK6UEA3gW9n9kTGwgk7xgdcMy8Btf
	gnrU7ObHkg8j4RXaVaPwi5O1fqDdTF3pOaDoUhrjh+bw3G9JejU/VkQiT/cRww==
X-Gm-Gg: AYBFou21JZQOx8hIqcsKi6HoF+08cyNPk1yw+CdwirdsVi7xqfdiaae7ObOEZ/q6wIk
	0vAi74wSyKNsJFXTsbtIcbBqG+BRKJ+WAr9JxNIFw9RmYzA0SNTQKcGewHcCk4cqDOLfAg7BCXj
	GuZQq3osYIPWFEPZhh6bv1+qUyjtuZqwzvJZNX5E1h8gvExuVqxuvakCkvpnm5Jx8+7H7cOLSEc
	xW6tFsCfccXO4Xr9ptMpe8bHV0wLVOo5sm917gGoqo0YiD8qxbwy6rvU3DCZSiW7Oae5eC579YS
	AyUkoxJdGNxewSOg/9awpuGj2pWAD51VPq0MlWM6rQbRPCUgsBGxLpMopo9NsE6X5lVrhS5jPCB
	b2OnvWXXRvOhqRBUHTWyitZqtg4dMRLJ4gy+e1hc1LRu0eFO/O2iQ0Y/l3z61CwxspJ68WqWFx1
	9n7XnLy9QQNI+7c51m8m8UgK1VKXHIJW7oiVvg70SWXbPRxiO+Dz9vpAuSfbgYnEYbs1wUrS594
	i5LlVT1/oAgJds=
X-Received: by 2002:a17:90b:1845:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-39b22e6bb12mr202436a91.2.1788446281446;
        Thu, 03 Sep 2026 07:38:01 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3050::4d0:16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae9087d3dsm2741889a91.3.2026.09.03.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:38:01 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] net: dsa: motorcomm: Split MIB buffers
Date: Thu,  3 Sep 2026 22:35:07 +0800
Message-ID: <20260903143514.532023-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903143514.532023-1-mmyangfl@gmail.com>
References: <20260903143514.532023-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/motorcomm/chip.c | 42 +++++++++++++++----
 drivers/net/dsa/motorcomm/chip.h | 63 ++--------------------------
 drivers/net/dsa/motorcomm/mib.c  | 70 ++++++++++++++++++++++++--------
 drivers/net/dsa/motorcomm/mib.h  | 61 ++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 86 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 77440bf5fa7a..d8520c38f9c7 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3591,11 +3591,14 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
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
@@ -3614,6 +3617,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_mib *pm;
 	int port = dp->index;
 	int res;
 
@@ -3626,7 +3630,9 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
 			port, res);
 
-	schedule_delayed_work(&priv->ports[port].mib_read, 0);
+	pm = priv->ports[port].mib;
+	if (pm)
+		schedule_delayed_work(&pm->work, 0);
 }
 
 static void
@@ -3746,11 +3752,35 @@ yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
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
 
+	if (!pm && !(BIT(port) & (priv->info->internal_mask |
+		     priv->info->external_mask))) {
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
@@ -4305,6 +4335,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
+	.port_teardown		= yt921x_dsa_port_teardown,
 	.port_setup		= yt921x_dsa_port_setup,
 #if IS_ENABLED(CONFIG_DCB)
 	/* dscp */
@@ -4334,12 +4365,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
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
@@ -4387,7 +4412,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 		struct yt921x_port *pp = &priv->ports[i];
 
 		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_mib_poll);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 84c7065b1cd4..ce2015026849 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -798,58 +798,6 @@ enum yt921x_fdb_entry_status {
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
 
-struct yt921x_mib {
-	u64 rx_broadcast;
-	u64 rx_pause;
-	u64 rx_multicast;
-	u64 rx_crc_errors;
-
-	u64 rx_alignment_errors;
-	u64 rx_undersize_errors;
-	u64 rx_fragment_errors;
-	u64 rx_64byte;
-
-	u64 rx_65_127byte;
-	u64 rx_128_255byte;
-	u64 rx_256_511byte;
-	u64 rx_512_1023byte;
-
-	u64 rx_1024_1518byte;
-	u64 rx_jumbo;
-	u64 rx_good_bytes;
-
-	u64 rx_bad_bytes;
-	u64 rx_oversize_errors;
-
-	u64 rx_dropped;
-	u64 tx_broadcast;
-	u64 tx_pause;
-	u64 tx_multicast;
-
-	u64 tx_undersize_errors;
-	u64 tx_64byte;
-	u64 tx_65_127byte;
-	u64 tx_128_255byte;
-
-	u64 tx_256_511byte;
-	u64 tx_512_1023byte;
-	u64 tx_1024_1518byte;
-	u64 tx_jumbo;
-
-	u64 tx_good_bytes;
-	u64 tx_collisions;
-
-	u64 tx_aborted_errors;
-	u64 tx_multiple_collisions;
-	u64 tx_single_collisions;
-	u64 tx_good;
-
-	u64 tx_deferred;
-	u64 tx_late_collisions;
-	u64 rx_oam;
-	u64 tx_oam;
-};
-
 struct yt921x_acl_entry {
 	u32 key[2];
 	u32 mask[2];
@@ -873,13 +821,8 @@ struct yt921x_acl_blk {
 struct yt921x_port {
 	unsigned char index;
 
-	bool hairpin;
-	bool isolated;
-
-	struct delayed_work mib_read;
-	struct yt921x_mib mib;
-	u64 rx_frames;
-	u64 tx_frames;
+	bool hairpin:1;
+	bool isolated:1;
 
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	unsigned char led_duty;
@@ -890,6 +833,8 @@ struct yt921x_port {
 
 	struct yt921x_led *leds[YT921X_LED_GROUP_NUM];
 #endif
+
+	struct yt921x_mib *mib;
 };
 
 struct yt921x_reg_ops {
diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 74728b1ed777..ee76cdf216e6 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -89,9 +89,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
 	struct device *dev = to_device(priv);
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
 	int res = 0;
 
+	mib = &pm->stats;
+
 	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
 	 * to keep its consistency, since we have to read registers one by one
 	 * and there is no way to make a snapshot of MIB stats.
@@ -129,11 +132,11 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
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
@@ -146,10 +149,11 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 
 void yt921x_mib_poll(struct work_struct *work)
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
@@ -160,7 +164,7 @@ void yt921x_mib_poll(struct work_struct *work)
 	if (res)
 		delay *= 4;
 
-	schedule_delayed_work(&pp->mib_read, delay);
+	schedule_delayed_work(&pm->work, delay);
 }
 
 void
@@ -183,9 +187,14 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
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
@@ -225,16 +234,21 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
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
@@ -261,7 +275,12 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
@@ -290,7 +309,12 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
@@ -326,7 +350,12 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
@@ -342,8 +371,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	/* stats->tx_heartbeat_errors */
 	stats->tx_window_errors = mib->tx_late_collisions;
 
-	stats->rx_packets = pp->rx_frames;
-	stats->tx_packets = pp->tx_frames;
+	stats->rx_packets = pm->rx_frames;
+	stats->tx_packets = pm->tx_frames;
 	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
 	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
 	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
@@ -362,7 +391,12 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_mib_read(priv, port);
diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
index c6728366df6e..cfad0665baae 100644
--- a/drivers/net/dsa/motorcomm/mib.h
+++ b/drivers/net/dsa/motorcomm/mib.h
@@ -71,6 +71,67 @@
 #define  YT921X_MIB_DATA_RX_OAM			0xa8
 #define  YT921X_MIB_DATA_TX_OAM			0xac
 
+struct yt921x_mib_stats {
+	u64 rx_broadcast;
+	u64 rx_pause;
+	u64 rx_multicast;
+	u64 rx_crc_errors;
+
+	u64 rx_alignment_errors;
+	u64 rx_undersize_errors;
+	u64 rx_fragment_errors;
+	u64 rx_64byte;
+
+	u64 rx_65_127byte;
+	u64 rx_128_255byte;
+	u64 rx_256_511byte;
+	u64 rx_512_1023byte;
+
+	u64 rx_1024_1518byte;
+	u64 rx_jumbo;
+	u64 rx_good_bytes;
+
+	u64 rx_bad_bytes;
+	u64 rx_oversize_errors;
+
+	u64 rx_dropped;
+	u64 tx_broadcast;
+	u64 tx_pause;
+	u64 tx_multicast;
+
+	u64 tx_undersize_errors;
+	u64 tx_64byte;
+	u64 tx_65_127byte;
+	u64 tx_128_255byte;
+
+	u64 tx_256_511byte;
+	u64 tx_512_1023byte;
+	u64 tx_1024_1518byte;
+	u64 tx_jumbo;
+
+	u64 tx_good_bytes;
+	u64 tx_collisions;
+
+	u64 tx_aborted_errors;
+	u64 tx_multiple_collisions;
+	u64 tx_single_collisions;
+	u64 tx_good;
+
+	u64 tx_deferred;
+	u64 tx_late_collisions;
+	u64 rx_oam;
+	u64 tx_oam;
+};
+
+struct yt921x_mib {
+	struct yt921x_port *port;
+
+	struct delayed_work work;
+	struct yt921x_mib_stats stats;
+	u64 rx_frames;
+	u64 tx_frames;
+};
+
 void yt921x_mib_poll(struct work_struct *work);
 void
 yt921x_dsa_get_strings(struct dsa_switch *ds, int port, u32 stringset,
-- 
2.53.0

