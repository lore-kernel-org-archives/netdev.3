Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4113C8731
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130020; cv=none; b=ScBR47wUYRDJSyAf0qtaJGZJa6Mz1oaElJ2ga+EW4+rcfbHJXWGKibkUu36zmfEbbYpePvXHnPmee0tIYrmMzYz6dgN8Lc9C7MsTwrWoevFm5onC05r8q4SNKea2UURnKC4mUqyZmp+pr8sn6Gu0lm5fogNCWSmFZYhqtflkTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130020; c=relaxed/simple;
	bh=N4j9mUQ9kKwEyeZ19kxZmCmehCfwPI9rk+96VrDrbhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnvUNYc58qmhO5AuzexX5G+mmP2mbXOCpaddUCTtvq6MQ3WNodlic4Kk2QH0pxdD50nvbSlYuvehKu7jlTnEP91MXRBr2Rf0bEfQV3MUCTCxsLukBzAtEEzHgMWJgm/nSTmWbR9Fekw7Yp9RL/8JFWPA7sNFE1+Kcj8AXsh0vgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxnN4xZX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxnN4xZX"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-885cd98d226so103756b3a.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791130018; x=1791734818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+WD/+WOZsLck0hbL3vk2APghYN4RnLg8p48OsjV8s4=;
        b=SxnN4xZXRgPtac7g0E3FR1M2mgze0/E6trg84Nh8wLzH6ZdvsWT9XOpIbvgA/CjSVy
         abKtQys72pChX3iFt/TzgH0d7uqSC2wYNyXNPpJ4ggnWaciD/4kUcQzENgod8pXRdT/B
         /ZyovWrDqhIwQQhmyBM0kDJu2ONWUi7A24yrpcytGwT8hH9ckebixKFA00yIo1YyZvrp
         la80gMaP5UHeCnGix0jMGF+VPpCa2YZVPFvcDYLXREy6f15LaFGjJ7/g9EzTPBCpAp4S
         RyW4nD457WYfytULVq8WpRxfmnyUnyETtNscmmza3mZA5NFeLAhN3Nzcn80AjArMF0EG
         Pl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791130018; x=1791734818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+WD/+WOZsLck0hbL3vk2APghYN4RnLg8p48OsjV8s4=;
        b=AgvwgZZcCYQwbef6n5yIZh4mPtqGjk+KHOOp/BfgN/dYPbzZFCfBizahA3gOoxhXgI
         A5K0yD7ecur34sPdzSJo5k75ecrVNl9bQMkzosXzzGk875yu/uBJUUpxFGC3Y/oemtEu
         QC6mbssL8kz/YLxI9tZqnerSJs+BY1aD+sudESxNpR7COwNALsvzqKZ8qvtG0tJ3gg5F
         z/HLq8/TFAz2DAB5Ks+UL3BLr//NmaL2b5xiSIX/QG+XP69FaNwwrVvt+gIczLmC7yKY
         lRfSn1ZBTOOUZJBqsFUqIjLJ0FTLIrrfuMutFHeI2fBfT9yPFx8s1kYxfeyBHf/LU+DV
         I7fw==
X-Gm-Message-State: AFuF++nDwDY8mrxTbS+jn4PNy5HSYs2eWI10XODuS4thsYcfFPsTGb5B
	Xpc+K39jiO/dp3j2dIeNMydo7MLbskMvjDW9pYjwWTrTE6I/J7dO9lToFSxg1uctHAA=
X-Gm-Gg: AYBFou3FXvTF6xhmWCHiedv9APHXmBo4la9PLKkT7ZroQvp7gLiyavOq0XKyE7+ipVr
	DwlsxR3B4lCRmsFc+3mHfMTogCs178zrirTqbRUtcysWhUn3GLfPEVqzS0NzFHTZ2YBZ1flf9cV
	SFJ7XAVHQgZpfsTYZ+jphLxX5poruNQFypTiwxKLF5CB/vOBJwQZ3GSnwAJXlugRjpuDvCbL0TA
	njxBO/JXkUdhmdcPtPLW3KRVvVGR+Nk/XrQtaBjMPAdxMLzvTPQoXATTY4OWCHB8DCkZ7JU7P+T
	+IJ+v9merXf3FrPaZ0MJITylfWoN+hKFXv545/1NUdvkFne+8phoJjruyTAAQsZufjUynMgakMC
	pKl0wLU1Wza6NZDCME4GgQ4phH/HtuJCKMjYvQiXPOvbIYt+4rvUQbfgsNxUCF15X1+2expcwF0
	CqLBCa/PubzLzMOIsn64yPswAEKPxbhzkmq/nfviJvDbbh1g6T64BfEJ5wO5PcpgV4mx0oUS+bA
	IBbalE6LLSCpxCv5c8CA6Uv88pCMGehEMOmew==
X-Received: by 2002:a05:6a00:b42:b0:874:72b6:7dac with SMTP id d2e1a72fcca58-887fe8bbf01mr7602717b3a.39.1791130018037;
        Sun, 04 Oct 2026 09:06:58 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2637789b3a.54.2026.10.04.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:06:57 -0700 (PDT)
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
Subject: [PATCH net-next v5 6/6] net: dsa: motorcomm: Fix MIB synchronization
Date: Mon,  5 Oct 2026 00:06:20 +0800
Message-ID: <20261004160622.948037-7-mmyangfl@gmail.com>
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

The previous MIB sync was based on the false assumption that 64-bit
variables are always atomic. To fix that:

  * .get_stats64() uses u64_stats_sync, together with u64_stats_t;
  * others take the free mutex lock if possible.

To minimize time of the write side of u64_stats_sync, a per-port buffer
is used so that all the stat can be written back altogether after all IO
operations.

The odds of this issue are very low and it does not affect the control
flow, while fixing it would require a thorough refactoring (together with
the previous commit), so it may not be worth backporting.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c |  2 +
 drivers/net/dsa/motorcomm/mib.c  | 93 ++++++++++++++++++++------------
 drivers/net/dsa/motorcomm/mib.h  |  6 +++
 3 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 9e3be08b3465..91cc5647f2b6 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -19,6 +19,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/sort.h>
+#include <linux/u64_stats_sync.h>
 
 #include <net/dsa.h>
 #include <net/dscp.h>
@@ -3472,6 +3473,7 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 		pp->mib = pm;
 
 		pm->port = pp;
+		u64_stats_init(&pm->syncp);
 		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
 		/* Start disabled, so that the enable below always pairs with
 		 * either this disable or the one from a previous teardown
diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 7d83bb3a8a86..6b170fc6e187 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -74,6 +74,8 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
 	MIB_DESC(1, YT921X_MIB_DATA_TX_OAM, "TxOAM"),
 };
 
+static_assert(ARRAY_SIZE(yt921x_mib_descs) == YT921X_MIB_STAT_NUM);
+
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
  *
  * Until we can read MIBs from stats64 call directly (i.e. sleep
@@ -89,6 +91,8 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	u64 *buf = pm->data;
+	unsigned long flags;
 	u64 rx_frames;
 	u64 tx_frames;
 	int res = 0;
@@ -98,7 +102,6 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u64_stats_t *valp = &((u64_stats_t *)mib)[i];
 		u32 val0;
 		u64 val;
 
@@ -107,7 +110,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = u64_stats_read(valp);
+			u64 old_val = buf[i];
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -121,9 +124,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			val = ((u64)val1 << 32) | val0;
 		}
 
-		u64_stats_set(valp, val);
+		buf[i] = val;
 	}
 
+	flags = u64_stats_update_begin_irqsave(&pm->syncp);
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
+		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);
 	rx_frames = u64_stats_read(&mib->rx_64byte) +
 		    u64_stats_read(&mib->rx_65_127byte) +
 		    u64_stats_read(&mib->rx_128_255byte) +
@@ -140,6 +146,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		    u64_stats_read(&mib->tx_jumbo);
 	u64_stats_set(&pm->rx_frames, rx_frames);
 	u64_stats_set(&pm->tx_frames, tx_frames);
+	u64_stats_update_end_irqrestore(&pm->syncp, flags);
 
 	if (res)
 		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
@@ -187,16 +194,16 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
+	u64 *buf;
 	size_t j;
 
 	if (!pm)
 		return;
-	mib = &pm->stats;
+	buf = pm->data;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	j = 0;
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
@@ -205,9 +212,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		if (!desc->name)
 			continue;
 
-		data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);
+		data[j] = buf[i];
 		j++;
 	}
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
@@ -241,8 +250,8 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	mac_stats->FramesTransmittedOK = u64_stats_read(&pm->tx_frames);
 	mac_stats->SingleCollisionFrames = u64_stats_read(&mib->tx_single_collisions);
@@ -266,6 +275,8 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	/* mac_stats->InRangeLengthErrors */
 	/* mac_stats->OutOfRangeLengthField */
 	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -282,12 +293,14 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
 	ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
 	/* ctrl_stats->UnsupportedOpcodesReceived */
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
@@ -316,8 +329,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	*ranges = yt921x_rmon_ranges;
 
@@ -341,6 +354,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
 	rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
 	rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -351,39 +366,45 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	unsigned int start;
 
 	if (!pm)
 		return;
 	mib = &pm->stats;
 
-	stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
-				  u64_stats_read(&mib->rx_fragment_errors);
-	stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
-	stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
-	stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
-	/* stats->rx_fifo_errors */
-	/* stats->rx_missed_errors */
-
-	stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
-	/* stats->tx_carrier_errors */
-	stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
-	/* stats->tx_heartbeat_errors */
-	stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
-
-	stats->rx_packets = u64_stats_read(&pm->rx_frames);
-	stats->tx_packets = u64_stats_read(&pm->tx_frames);
-	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
-			  ETH_FCS_LEN * stats->rx_packets;
-	stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
-			  ETH_FCS_LEN * stats->tx_packets;
+	do {
+		start = u64_stats_fetch_begin(&pm->syncp);
+
+		stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
+					  u64_stats_read(&mib->rx_fragment_errors);
+		stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
+		stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
+		stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
+		/* stats->rx_fifo_errors */
+		/* stats->rx_missed_errors */
+
+		stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
+		/* stats->tx_carrier_errors */
+		stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
+		/* stats->tx_heartbeat_errors */
+		stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
+
+		stats->rx_packets = u64_stats_read(&pm->rx_frames);
+		stats->tx_packets = u64_stats_read(&pm->tx_frames);
+		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
+				  ETH_FCS_LEN * stats->rx_packets;
+		stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
+				  ETH_FCS_LEN * stats->tx_packets;
+		stats->rx_dropped = u64_stats_read(&mib->rx_dropped);
+		/* stats->tx_dropped */
+		stats->multicast = u64_stats_read(&mib->rx_multicast);
+		stats->collisions = u64_stats_read(&mib->tx_collisions);
+	} while (u64_stats_fetch_retry(&pm->syncp, start));
+
 	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
 			   stats->rx_crc_errors + stats->rx_frame_errors;
 	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
 			   stats->tx_window_errors;
-	stats->rx_dropped = u64_stats_read(&mib->rx_dropped);
-	/* stats->tx_dropped */
-	stats->multicast = u64_stats_read(&mib->rx_multicast);
-	stats->collisions = u64_stats_read(&mib->tx_collisions);
 }
 
 void
@@ -400,9 +421,11 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	pause_stats->tx_pause_frames = u64_stats_read(&mib->tx_pause);
 	pause_stats->rx_pause_frames = u64_stats_read(&mib->rx_pause);
+
+	mutex_unlock(&priv->reg_lock);
 }
diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
index d84ae2f449ac..9c24a52d46cc 100644
--- a/drivers/net/dsa/motorcomm/mib.h
+++ b/drivers/net/dsa/motorcomm/mib.h
@@ -125,13 +125,19 @@ struct yt921x_mib_stats {
 	u64_stats_t tx_oam;
 };
 
+#define YT921X_MIB_STAT_NUM	(sizeof(struct yt921x_mib_stats) / sizeof(u64_stats_t))
+
 struct yt921x_mib {
 	struct yt921x_port *port;
 
 	struct delayed_work work;
+	struct u64_stats_sync syncp;
+	/* writers: priv->reg_lock + syncp; readers: priv->reg_lock or syncp */
 	struct yt921x_mib_stats stats;
 	u64_stats_t rx_frames;
 	u64_stats_t tx_frames;
+	/* protected by priv->reg_lock */
+	u64 data[YT921X_MIB_STAT_NUM];
 };
 
 void yt921x_mib_poll(struct work_struct *work);
-- 
2.53.0

