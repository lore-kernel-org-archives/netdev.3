Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65C4766A7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022703; cv=none; b=di9s8KJfrZ9Ayez71RZjqzKdumMAhrpL+JevgzCANq8raRSYdsWBEqS9NrdFQ4w2uHHN3P9DD9/kaWhKANXoJV4yc1WUECrwt6tXeBHQ5VX7xNneohoH3lfIGcVMxLe0X3h3PdzJiq7rEyTHZfQkBcn0uahikt8bS6AP2F/T5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022703; c=relaxed/simple;
	bh=RYNIxcDUEwNdN/J8gDD/mi00V9bO7FPW5XmRpz6CyJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAYZdmMt5uf5NMtXqU1+mP1dY4Wk18yUTnyl+j+vZV2K6F1mtC2fuHhD4oS2dUWdc5EJXPpg7avt4qHzZtPQ42i17PCxfgt4BLcDgeEk9z0OktpPqM8u4dMC3RdhgVS+WYF1kIVTm+47+D59wh4FtWgFZXkcUbxm2p7trun8RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMO1emx8; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMO1emx8"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso2899343a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022701; x=1790627501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vkt5IsYlW3mPew+aRkZIweeeFfqxwIBHN8u1e5hZtB0=;
        b=pMO1emx8grF2/bXKVSj0PafC9yVYjket+mcId124QeJ4Zv2gJkHtyXiSafmm0Wsr+g
         8/ibRo/Pn4dxH16yMACOQDLVaG6XNCO6OyLJhr0izMpsy4pY5QjUPFZ23QfFmzR8kH8F
         oiSycvEvCXDpPWVTnQoaj6YFVPI3sEtDg8SYengEpKBlZv96tyTW/HwckobYCEsTOHT9
         +ai+tJpFX1ZN+hqFRcOboEK6KZf/7Qk6Fid6QamLO27ZVkUmsMTh1EIGsSqj+nzKjod+
         2VD810Y6EDawkptbmqePJ5VDvdoays+Y7OzQVL4yvyoHEL4Jf0H0ToYw1jtnv6JThh33
         L5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022701; x=1790627501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vkt5IsYlW3mPew+aRkZIweeeFfqxwIBHN8u1e5hZtB0=;
        b=W8NBG9c9pKB2lM9MqqqZfyEan4Hi/blbUvv53xbpBcUeEUpbQAQhr56G1IX39KIEpW
         5yaL/1wgcYwQlS+vfgIve9GkB5fI5MW+gg1f6rleTDSGfRjYDCIx6sNjJ5DNX4i6doRW
         FVivVpsvZ8cZbBSa2wSL8bDzvIjhKdRmpCtQ4bJjGYcsG4Tll6YuTLyAxzPHX8RvFuNe
         ppZH6a88M+jC+U6MHO0uGoUBdqlvBTwwN0ar7Xcay1No8r6w79uRdWczrSqe3p9r6Sry
         3A6smz/ACcKGUUzFOu1fN/3qw/vU1fEPtEVJuaikMtMNiFWNbBlfe6wKrcQkulk1XkpV
         v59Q==
X-Gm-Message-State: AFuF++nhdJgQSRZ0IGUY7c732DSpO+nmqR2qjqklORKmG5Y8sdKwU9ug
	Jg1uJ3HvggpSrRKSgBMB3BAG1uHCkVpH7vAEATuL01YNu5SZXOiB/ifYMDAtXtWa
X-Gm-Gg: AYBFou1nTcf16+CWpwYYfmbQOGVyaH4D0cMoXTUfuTn8hhANyEsIwuFEcJIlWXTPcZ3
	lRrM/xhDkTnN+IqKINzaFaCD6617phnod3uNCN64sjSnJmyv/7yyK8bl9iNuiFGwhyX6G+q6zvN
	//rYcbndM6h7mkQt0pvaXnbZExrcbQFhmnWMfnMtLpHGwnQRxWXpTUaZZiDUz7JdJbCaAgsRHsQ
	Q666IZtEJ5grVonHJ585NJzBkxtuae6OAZU76iOaEiB6mZrUjIHLfkyv479EHwaNvozmG/1gyvg
	e1A5QFefu5SbffiQJ0puvhE9cb3Voqx7A/HOtutc/8wOGp6I07O8wW+6my+L5Db6J1gPQXkMatE
	nZRN2SkiVHOi5ehv8RLTVxPvRNC+Q3noTzOYROX3GJXnvsHGbjre1YcRkQZkV6q0stQ3ZrcohwV
	mgGfWrmAsKIAK2UiEEN/Yg8gM7hzKoZ1JqbO66VdvSez3y9jDJrVDKZwyScvrf7YRI210MAowhx
	DG1s834msGjHZk27OhsT4n6
X-Received: by 2002:a17:90b:518b:b0:39e:6c69:7778 with SMTP id 98e67ed59e1d1-39e6c697984mr12897667a91.33.1790022700737;
        Mon, 21 Sep 2026 13:31:40 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069918587sm447247a91.4.2026.09.21.13.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:31:40 -0700 (PDT)
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
Subject: [PATCH net-next v4 6/7] net: dsa: motorcomm: Fix MIB synchronization
Date: Tue, 22 Sep 2026 04:30:23 +0800
Message-ID: <20260921203040.1203911-7-mmyangfl@gmail.com>
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

The previous MIB sync was based on the false assumption that 64-bit
variables are always atomic. To fix that:

  * .get_stats64() uses u64_stats_sync, together with u64_stats_t;
  * others take the free mutex lock if possible.

To minimize time of the write side of u64_stats_sync, a per-port buffer
is used so that all the stat can be written back altogether after IO
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c |  2 +
 drivers/net/dsa/motorcomm/mib.c  | 93 ++++++++++++++++++++------------
 drivers/net/dsa/motorcomm/mib.h  |  6 +++
 3 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 34dbbdcea135..292a43f5d442 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -19,6 +19,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/sort.h>
+#include <linux/u64_stats_sync.h>
 
 #include <net/dsa.h>
 #include <net/dscp.h>
@@ -3783,6 +3784,7 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 		pp->mib = pm;
 
 		pm->port = pp;
+		u64_stats_init(&pm->syncp);
 		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
 	}
 
diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index 69b9eb7e5208..f5197c1d2d7f 100644
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
@@ -92,6 +94,8 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	struct device *dev = to_device(priv);
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	u64 *buf = pm->data;
+	unsigned long flags;
 	u64 rx_frames;
 	u64 tx_frames;
 	int res = 0;
@@ -101,7 +105,6 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u64_stats_t *valp = &((u64_stats_t *)mib)[i];
 		u32 val0;
 		u64 val;
 
@@ -110,7 +113,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = u64_stats_read(valp);
+			u64 old_val = buf[i];
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -124,9 +127,12 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
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
@@ -143,6 +149,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 		    u64_stats_read(&mib->tx_jumbo);
 	u64_stats_set(&pm->rx_frames, rx_frames);
 	u64_stats_set(&pm->tx_frames, tx_frames);
+	u64_stats_update_end_irqrestore(&pm->syncp, flags);
 
 	if (res)
 		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
@@ -190,16 +197,16 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
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
@@ -208,9 +215,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
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
@@ -244,8 +253,8 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	mac_stats->FramesTransmittedOK = u64_stats_read(&pm->tx_frames);
 	mac_stats->SingleCollisionFrames = u64_stats_read(&mib->tx_single_collisions);
@@ -269,6 +278,8 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	/* mac_stats->InRangeLengthErrors */
 	/* mac_stats->OutOfRangeLengthField */
 	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -285,12 +296,14 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
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
@@ -319,8 +332,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	*ranges = yt921x_rmon_ranges;
 
@@ -344,6 +357,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
 	rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
 	rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -354,39 +369,45 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
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
@@ -403,9 +424,11 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
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
index d84ae2f449ac..55719c29992b 100644
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
+	/* protected by syncp OR priv->reg_lock */
 	struct yt921x_mib_stats stats;
 	u64_stats_t rx_frames;
 	u64_stats_t tx_frames;
+	/* protected by priv->reg_lock */
+	u64 data[YT921X_MIB_STAT_NUM];
 };
 
 void yt921x_mib_poll(struct work_struct *work);
-- 
2.53.0

