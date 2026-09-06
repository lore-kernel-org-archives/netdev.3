Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301C3C4544
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700487; cv=none; b=ujWdJ0w1G4sfeDaBVLZuw474rBe7WiyQimGx4v99iSbbQVQgzdRRcm1JJIkKvVZtngjFlr4iYm2f7PI/0RIaYAyIOBMNxN88DKkxpASAtUwxgUfyV+WkQM5hYqkqpODoOF1dnut0EaHTaHWXWRddmYHhZIc96V+zd5EBGg/bt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700487; c=relaxed/simple;
	bh=9Jb8n7vDY4dJwr6pHHqajfSV1mPdB7IBVsl7iVfr27s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6+8IxoXK7oS3R57FcIXkXscGSGr3w7ZeRy3j8R4hoOsk54handBGQlhkozDSg+Hx5jBds2GTF4ZaQX+7Yz9hYca2j2ttwAYnz73IUa0DINvUu05tEsra6gLxwO+r+WB893Kp5PWg9iPqvp2H7tnfcGr6G5TKWiBAm3pALntVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO5Yogiw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO5Yogiw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d91518a63fso18590375ad.0
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788700485; x=1789305285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6gElCsnArSbZd6G/RahklGwF6i5infvyLxA5U9uKzQ=;
        b=oO5YogiwPvMS8Og8MSaeJnz3qg9fkujmRYOSp0WoyKGaopvWhaoPMGU+yxTvPNKLED
         CBIEwEjXLQQdkjInwQOm5DoBai9V33R1NFUkknM/8S6Gi81+zDAhsT1BcMKAz3b5LmFo
         XIB9XHO3NV1YVomwqX+qudQUjGcOGEM4D8O+8YmThh+b81TJNU3qBdaZJKBUXfYCMwFB
         i4LRNeuGrRBPI/4hfOfPP39itwmlNEZHUOKHRkzQ0XZQ3P+DQ2FZMmnSA8t1qQz7u7H0
         1Z49rLrHM7yUyk2Ml8oKr+UaFWy/IG7njSmXGjvOcBsBxYA6sXByyL2/g90QzppAA5aU
         kNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788700485; x=1789305285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6gElCsnArSbZd6G/RahklGwF6i5infvyLxA5U9uKzQ=;
        b=kUeExoqG2ieq/SO/PiHIN83OL+HymlWlcYTaL/ZTDqDCcKg1hQ4vDD2PhfUA2pSKiO
         rFRBqaCps3k5U9CDAgrf5139q+aRBKfqePF8odoBir2gRI+l+b9vtSkBEhrIwRTweIIA
         LQCFwF1Wlaf8innCjcgLtCWSBpPiCGmBVDfJFGBSGkNTarvujDkK6DGmArTUoZLPvlOC
         gqt6mK7H8BFcZaxjVxYdvk23qbl8pdH2UKo39vapa+WlI9THCjoJuyZoxyMaqUOyMB37
         ZoR0BRgHX5lIri0aCKRXge6441B4c55vtc8UbV6tQ5JkFhdIV7OLScrPxrB8cs1xqIWp
         5u7A==
X-Gm-Message-State: AFuF++mccPVuL2WCtuk9tKLZ8sHdELiu7uDj/4+3lMUjvPOzHGQuTE7K
	obROrTumDVEXkXkOp5igO/2fPArsN1IsblztAY4HYbwG4oXtHencM8ojIHkyh8W7
X-Gm-Gg: AYBFou0lQ+fc0/LKCyScX5dzdDy7qw6kGTrm2wyuxP8cEHTU9wdDqXy8RVlxHCv3/WO
	q01InKLn5ErJccmfM0ECWWdNcz0AD3alqXTAWWDo8jFhfQsZn9UDi79FVpDE18kLhEq5fy32PfY
	qm5+LdnoZEOJbygEkc0I3c/M7+BLs185+GfQXo5skALZAYOz/8QbeCEut0wrUDOHI1a/YhOX5/r
	RNfbuW535TKN+cJUDzmzSG9b4G/YIfn7PuLffvz6+v6+0lC++bujynvdDFqfMUGnC/nFwJ3QGBy
	vkPDrnG0RDwEJ5crt/TgGtxd4ty6D4F2sKV8k10o1gfD5xiHwt5iwdPvYOdHFSreecbTbM532Gp
	QRlrVpLt30wjzWK3+iVF24+Ejh4W4UJqqoFGJIGdw4OcS6FtXteQ01u+X8GSRIlbrzBDv6wMSXN
	tJSMPl5otQnb1ItaeRfuxEP4lWIt3KGPl+6taLBo1itZfMIC2osh+0C2DIwfEMdOc/fTe9ZB3HV
	1q+/XM7gFI0eQ==
X-Received: by 2002:a17:902:d586:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2db125f0cf2mr252283275ad.10.1788700484824;
        Sun, 06 Sep 2026 06:14:44 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b2f8sm32259965ad.21.2026.09.06.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:14:44 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/6] net: dsa: motorcomm: Fix MIB synchronization
Date: Sun,  6 Sep 2026 21:14:10 +0800
Message-ID: <20260906131414.2683362-6-mmyangfl@gmail.com>
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

The previous MIB sync was based on the false assumption that 64-bit
variables are always atomic. To fix that:

  * .get_stats64() uses u64_stats_sync, together with u64_stats_t;
  * others take the free mutex lock if possible.

To minimize time of the write side of u64_stats_sync, a per-port buffer
is used so that all the stat can be written back altogether after IO
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c |  2 +
 drivers/net/dsa/motorcomm/mib.c  | 90 +++++++++++++++++++-------------
 drivers/net/dsa/motorcomm/mib.h  |  6 +++
 3 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index e9730b9f8c62..392bf44d409e 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -19,6 +19,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/sort.h>
+#include <linux/u64_stats_sync.h>
 
 #include <net/dsa.h>
 #include <net/dscp.h>
@@ -3778,6 +3779,7 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 		pp->mib = pm;
 
 		pm->port = pp;
+		u64_stats_init(&pm->syncp);
 		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
 	}
 
diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index f5d39d22215d..8601d25fe988 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -92,6 +92,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	struct device *dev = to_device(priv);
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	u64 *buf = pm->data;
 	u64 rx_frames;
 	u64 tx_frames;
 	int res = 0;
@@ -101,7 +102,6 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u64_stats_t *valp = &((u64_stats_t *)mib)[i];
 		u32 val0;
 		u64 val;
 
@@ -110,7 +110,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = u64_stats_read(valp);
+			u64 old_val = buf[i];
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -124,9 +124,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			val = ((u64)val1 << 32) | val0;
 		}
 
-		u64_stats_set(valp, val);
+		buf[i] = val;
 	}
 
+	u64_stats_update_begin(&pm->syncp);
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
+		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);
 	rx_frames = u64_stats_read(&mib->rx_64byte) +
 		    u64_stats_read(&mib->rx_65_127byte) +
 		    u64_stats_read(&mib->rx_128_255byte) +
@@ -143,6 +146,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		    u64_stats_read(&mib->tx_jumbo);
 	u64_stats_set(&pm->rx_frames, rx_frames);
 	u64_stats_set(&pm->tx_frames, tx_frames);
+	u64_stats_update_end(&pm->syncp);
 
 	if (res)
 		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
@@ -191,16 +195,16 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
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
@@ -209,9 +213,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
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
@@ -245,8 +251,8 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	mac_stats->FramesTransmittedOK = u64_stats_read(&pm->tx_frames);
 	mac_stats->SingleCollisionFrames = u64_stats_read(&mib->tx_single_collisions);
@@ -270,6 +276,8 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	/* mac_stats->InRangeLengthErrors */
 	/* mac_stats->OutOfRangeLengthField */
 	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -286,12 +294,14 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
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
@@ -320,8 +330,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	*ranges = yt921x_rmon_ranges;
 
@@ -345,6 +355,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
 	rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
 	rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -355,39 +367,45 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
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
@@ -404,9 +422,11 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
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
index d84ae2f449ac..33992a5f9bdc 100644
--- a/drivers/net/dsa/motorcomm/mib.h
+++ b/drivers/net/dsa/motorcomm/mib.h
@@ -125,13 +125,19 @@ struct yt921x_mib_stats {
 	u64_stats_t tx_oam;
 };
 
+#define YT921X_MIB_NUM	(sizeof(struct yt921x_mib_stats) / sizeof(u64_stats_t))
+
 struct yt921x_mib {
 	struct yt921x_port *port;
 
 	struct delayed_work work;
+	struct u64_stats_sync syncp;
+	/* protected by syncp OR priv->reg_lock */
 	struct yt921x_mib_stats stats;
 	u64_stats_t rx_frames;
 	u64_stats_t tx_frames;
+	/* protected by priv->reg_lock */
+	u64 data[YT921X_MIB_NUM];
 };
 
 void yt921x_mib_poll(struct work_struct *work);
-- 
2.53.0

