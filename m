Received: from mail-pz2-f13.google.com (mail-pz2-f13.google.com [74.125.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A504446F5
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022694; cv=none; b=OkSpkFJJCkwnj9RR9xw1bNY4wZwjcw/8QqGCZ0QOJ2BYYLwqgcHsIFrSJynHcTAIQS/ihU0w8/ZmBXATppi+GbhpIfN+/EPKpRMvLjRh11uB61ZF7qT7flSfX/HF3Bz4uB62thLV6UEgNpMUTUJOM3HU3USSIxM0F1RrSEnHfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022694; c=relaxed/simple;
	bh=BO8JwmBV7M12ZjIAPttKH9Od+v3YjgSk2L+BNnMqJ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+lT1ZJEgqqtOo5mPmypYhrMfsqY5xqqpATSeyuhFbhuexdS8tJCsRQ2gHC0vVEhveFeqtJy1hcQohAniyl1FieyQ5YQ2UMxXrMvEUWxpJexc0/YBozkqWCKa1yXGhne3L+jA8xsmSdm/FV5DLHJyvUoSWl6d49OUYwPbdyvu6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnQmFrOP; arc=none smtp.client-ip=74.125.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnQmFrOP"
Received: by mail-pz2-f13.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so2162709a12.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022692; x=1790627492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7X0mZcKDU1sVxFSU71+VLAMsKKyq9GSDr8CZcLYgm68=;
        b=dnQmFrOPktpiIaGPLVBDQ6XB7vNizVx/OzhIAPONMPGQ6NTG8/1jVjE87A65IoXk3m
         c8K/og1pDX9cL6iTm/25jS+XNq1r9WJBIrGc8sODr1cDJHoXxau/j9dfwH9jrkDKLU8d
         y/ABrOgmVL+qSp/gfVeRNywwpy1qk/XrSMB5lC769Qes66K42+1crcPBEjpLDhfiDfb8
         63geUTdVcTqjWUJ6XakEgLpo3XOZSQuLLtk3gB8lfQzhKMlWP5rk+n4UJE9wAkcEKOZ9
         b4oA3FoithOsSsp73DdmueZiVCzqJ+Sy8C18PN9EWjQfQwzyNCB0uA6luSS62TYx5fsI
         RAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022692; x=1790627492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7X0mZcKDU1sVxFSU71+VLAMsKKyq9GSDr8CZcLYgm68=;
        b=ORuH6ysGEinsbYr7756ZN4NnqXW6Pyb72zPIWhxfSu5/lYs+8gvnq/run8EcnpKRCd
         WhmfrAdVV8cP+D76uNZW1/eBOHy3uZ8J9kUsZ7g+6mChm+3y9UYAaV65blxM24aGeAcR
         dmq4QTYpWqTeUukb68SaceVgPBomK/YLCBJaB2uwXyKx8+zatKj7H30O8AAXppNb2ESd
         cpQKEzZog7NbBuadlYnfj22wKa5aKQ6MjnYkKx3EaqpJYv9G/eiu9jYn0kN+iWo4323D
         rkhE8diCLNpJgkrrd5kdMmfZ5SVj8eP477p/7T8ce6OsQZBzFcTL/0ZU2yXQeEGRTWTt
         PvRg==
X-Gm-Message-State: AFuF++lX8sjKxR+ZF/XwCIg4JbS79UNuKtCOASDE0lAWRhmuY3AFGF2B
	y6wHip7uCjpprAya3V0JlcoZSnPUoX9B6blM6UagugMDKMrSbMrevbo5kAkN5goZ
X-Gm-Gg: AYBFou3Rz0wa0aZn+LUNMhVBRriZetn8SoBk9Whcg9QA1fctkUX8z+hqfEIdWzz8ucQ
	uBBuhCfBTxXN/H95//mrqo7cCZ0w0jcA139E4UGtL9ajxXQu0C08RlMBdnBBm0btv0tsqCpfwQk
	fr76eznbhNTJKqslCldTSgcrLB/a8UqcqhPjIuNDIQJWVOUuNtLeR5Rn2F6qpuCw8hg8AwMH75A
	UoqKgLFpCKYcTTVu0Zh69cSzy2A0mOrCoprP2JAdrQsL9M4WxJXX27Z7X415UlR2BqQ0mb1GtLE
	TRnYk34kqGw8uozuBBQEiXOKtbZCM5IaJ4GLPvK2HTXLe0dM+GCR76Bc+SP0kJMu5zdZ1ZPMjQd
	Jtrsop0GZxVZK0YHJOPWkxTv5poeefpxxh/sPY+3o6ZfVc9zqSNCahQ0BaESlmTj2LDlm+aVKRo
	1GaPnPrNe2lcl+KUhExheiXBZY/Lob+8T1QYhYFhlAvnMurOB8f9gKgTaZ71FArOPcUWwLIoS23
	Mr3ZMKskhIUX2V1j57Vo8//
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:2092 with SMTP id 98e67ed59e1d1-39e6c6a2289mr10102247a91.51.1790022691555;
        Mon, 21 Sep 2026 13:31:31 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069918587sm447247a91.4.2026.09.21.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:31:31 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/7] net: dsa: motorcomm: Split MIB buffers
Date: Tue, 22 Sep 2026 04:30:20 +0800
Message-ID: <20260921203040.1203911-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921203040.1203911-1-mmyangfl@gmail.com>
References: <20260921203040.1203911-1-mmyangfl@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 115 ++++++++++++++++++++++++-------
 drivers/net/dsa/motorcomm/chip.h |  16 +++--
 2 files changed, 100 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d0b25ded2447..ad06d894b001 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -549,10 +549,13 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
 	struct device *dev = to_device(priv);
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
@@ -606,8 +609,9 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 
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
@@ -619,7 +623,7 @@ static void yt921x_mib_poll(struct work_struct *work)
 	if (res)
 		delay *= 4;
 
-	schedule_delayed_work(&pp->mib_read, delay);
+	schedule_delayed_work(&pm->work, delay);
 }
 
 static void
@@ -642,9 +646,14 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
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
@@ -684,16 +693,21 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
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
@@ -720,7 +734,12 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
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
@@ -749,7 +768,12 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
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
@@ -785,7 +809,12 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
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
@@ -801,8 +830,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	/* stats->tx_heartbeat_errors */
 	stats->tx_window_errors = mib->tx_late_collisions;
 
-	stats->rx_packets = pp->rx_frames;
-	stats->tx_packets = pp->tx_frames;
+	stats->rx_packets = pm->rx_frames;
+	stats->tx_packets = pm->tx_frames;
 	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
 	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
 	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
@@ -821,7 +850,12 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
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
@@ -3952,11 +3986,14 @@ yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
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
@@ -3975,6 +4012,7 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	struct yt921x_mib *pm;
 	int port = dp->index;
 	int res;
 
@@ -3987,7 +4025,9 @@ yt921x_phylink_mac_link_up(struct phylink_config *config,
 		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
 			port, res);
 
-	schedule_delayed_work(&priv->ports[port].mib_read, 0);
+	pm = priv->ports[port].mib;
+	if (pm)
+		schedule_delayed_work(&pm->work, 0);
 }
 
 static void
@@ -4107,11 +4147,40 @@ yt921x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
 	return DSA_TAG_PROTO_YT921X;
 }
 
+static void yt921x_dsa_port_teardown(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
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
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct device *dev = to_device(priv);
+	struct yt921x_mib *pm = pp->mib;
 	int res;
 
+	if (pm) {
+		enable_delayed_work(&pm->work);
+	} else if (BIT(port) & (priv->info->internal_mask |
+				priv->info->external_mask)) {
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
@@ -4666,6 +4735,7 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	/* port */
 	.get_tag_protocol	= yt921x_dsa_get_tag_protocol,
 	.phylink_get_caps	= yt921x_dsa_phylink_get_caps,
+	.port_teardown		= yt921x_dsa_port_teardown,
 	.port_setup		= yt921x_dsa_port_setup,
 #if IS_ENABLED(CONFIG_DCB)
 	/* dscp */
@@ -4695,12 +4765,6 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
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
@@ -4748,7 +4812,6 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 		struct yt921x_port *pp = &priv->ports[i];
 
 		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_mib_poll);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 9205be423e39..9f3c8af4f638 100644
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

