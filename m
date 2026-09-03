Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAC4BAA1E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446294; cv=none; b=uXF+CSImWA5SkKApxNFDgSEMDCPMEcNrg2i4BSMC3dYUuw+iZ9j/6JwAwWep6GSI0LCokRBX7wGCFw/aiTVE8L6l6HHi/DSc5xArIayz1E6eDCXkyJKByO2knxR/FDJ/DrSxlTsd0oBu+0JY4O3zAyLyAwf/8HAARDyHd7w78bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446294; c=relaxed/simple;
	bh=guNcGvme9pNH+ZREWpHwq587dQe1vgHh7nY2c/h7XNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trotHYUtAgpNWBjcG6G8Hxz9G3FwZjCPBfcpDLN9CvfH/JHnCyysNI6UDMxLzVyn3GRbAnuAlaO42MdII2QzrXu2LlNrVJ4iI0UjTqosJI1yfjO0RxA2mrJQ4mPtcu5NDyd8Itjl7whpZiySv8+OTMwUni2y3BkiOTxnMfgtgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yql/8Cuh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yql/8Cuh"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39647184c73so1064755a91.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446286; x=1789051086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sy8LbnDRxw75nK0zcS8DY2JP7kyh+cC4gS7xcoC6dgw=;
        b=Yql/8CuhA6IyhHxw4VVn75iC2Jppv1obROeLP/N1Q+/K3Wvkfo5RASFU5ApPZ6jFMs
         6s7njla3IHOm5YhDungha6cmN3QOeE+7CogI6VbU7FEgw+TH9Lm+Gm2uLYTncUPgyNOC
         O3b+nH65pwemP2yLC666uZcGw5ojzDjX4i5fdR7j5Tnuz4u8X3XwpKF8yFNNsziAjnEA
         4Wy1KEy/Ke8RkZcvQSP54phEh63lnLTcd6Y6AxEzfRZyhRSgfzpg4EE7HmMNO22ORg6n
         83F7w3wVYY6QnoxF+5CNfiD+v4J13kZyvmpTh3OyJVsjHs4NtiZ3IwZ0RptiJ6wWtp6s
         qz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446286; x=1789051086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sy8LbnDRxw75nK0zcS8DY2JP7kyh+cC4gS7xcoC6dgw=;
        b=PMTk/ad1x0BQ99TNBAmdT2kr4Xcmb5KZPA7Xy1t41LJXv73KU46IvUBvaZF88UjqPe
         uOgKiwhf4c0LJSGtgsRsiK4MrrG4Wsu0u9//hqiP849Vu+OvV4z4Ev3N4U+gpyTTeYa+
         SP7jR8nuBXLwsTzwdX+qqW8dgs1vCr7kkqgbJQyqkjnoegLcrVeeqnTz1XPIHc+80C+f
         hzOUJnKLtL5cTgGb26aW1k+qEp5t30xXALjvGn4/LbDAKZdeFNhaDJ15fxm4Gjp54IS5
         KKgAGH7rlKLYVyNWMvYvrgZGTRPyAcpiRbY2FjytzW4fqgXgSj7MKh11/1J5O3J+BHQG
         9leg==
X-Gm-Message-State: AFuF++kJvxmpOo3bYDCZrd61pv8PVOacg5dYAcKHKTplbQPv17TSmjGJ
	Le5idBMK+diNbUsgeSfblXEL9gcm08ZYPLn4Z9KWY/0fpY1nlwqKA8LPrPXbtA==
X-Gm-Gg: AYBFou2IW38YgWkLgbmC/+cJqsK77fCJx9NjVEYAevmlF7l2HT27il6aJxnUKF1axau
	xDVjZ8YEautn63bWaaXk+q6TZBhtajjEY85+m0zxwrTHEOx8rFFJtP/5mqpQ2NzoXhoLbuRGtGC
	79HquEBZN5vPX7ijOSUQbi13rPfyJCKQpokCxZ1juA2Li0S7p4S1ePosXah7e54xzXxhUCOGM4n
	1W/bj2piDdYASnveEUqgs97yupBcSL5e/9jwj9ehp+9F484oT1l5DgIuWApseWDKxyxTMDWl2zE
	bMqNit7fFxWctqjrsk+9bW24uYVIAoEeYWzl7STSL2whcYmalBCO5dZxWPmYNJskRuzFH/A41YI
	pIxwy+JN9Kz27lIgPXfZvh2mCWEOkluMo1x3sp49lZQbf44/aSScUhe0anIdXm5dflu9nbmMu8S
	3MrhJq5pYdX2zCD60vDAVHcJqqf4y0fhhVeIaZLZ77Me6MU2U1NOAwQlpB6pdBPNBbQ1McVIEHV
	JOSIWBPJswuD46jd4LltlguPZDK
X-Received: by 2002:a17:90b:3cc3:b0:398:9bd3:d6d4 with SMTP id 98e67ed59e1d1-39b132d819emr3400707a91.14.1788446284881;
        Thu, 03 Sep 2026 07:38:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3050::4d0:16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae9087d3dsm2741889a91.3.2026.09.03.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:38:04 -0700 (PDT)
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
Subject: [PATCH net-next 3/4] net: dsa: motorcomm: Use u64_stats_t for MIB stats
Date: Thu,  3 Sep 2026 22:35:08 +0800
Message-ID: <20260903143514.532023-4-mmyangfl@gmail.com>
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

64-bit variables might not be atomic on 32-bit architectures, and could
lead to load/store tearing. Use u64_stats_t to ensure consistency.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c |   2 +
 drivers/net/dsa/motorcomm/mib.c  | 196 +++++++++++++++++--------------
 drivers/net/dsa/motorcomm/mib.h  | 110 +++++++++--------
 3 files changed, 172 insertions(+), 136 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d8520c38f9c7..b4059053ef15 100644
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
index ee76cdf216e6..73b2a9f52996 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -91,22 +91,16 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	struct device *dev = to_device(priv);
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	u64 *buf = pm->data;
+	u64 rx_frames;
+	u64 tx_frames;
 	int res = 0;
 
 	mib = &pm->stats;
 
-	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
-	 * to keep its consistency, since we have to read registers one by one
-	 * and there is no way to make a snapshot of MIB stats.
-	 *
-	 * Writing (by this function only) is and should be protected by
-	 * reg_lock.
-	 */
-
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u64 *valp = &((u64 *)mib)[i];
 		u32 val0;
 		u64 val;
 
@@ -115,7 +109,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = *valp;
+			u64 old_val = buf[i];
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -129,17 +123,29 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			val = ((u64)val1 << 32) | val0;
 		}
 
-		WRITE_ONCE(*valp, val);
+		buf[i] = val;
 	}
 
-	pm->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
-			mib->rx_128_255byte + mib->rx_256_511byte +
-			mib->rx_512_1023byte + mib->rx_1024_1518byte +
-			mib->rx_jumbo;
-	pm->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
-			mib->tx_128_255byte + mib->tx_256_511byte +
-			mib->tx_512_1023byte + mib->tx_1024_1518byte +
-			mib->tx_jumbo;
+	u64_stats_update_begin(&pm->syncp);
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
+		u64_stats_set(&((u64_stats_t *)mib)[i], buf[i]);
+	rx_frames = u64_stats_read(&mib->rx_64byte) +
+		    u64_stats_read(&mib->rx_65_127byte) +
+		    u64_stats_read(&mib->rx_128_255byte) +
+		    u64_stats_read(&mib->rx_256_511byte) +
+		    u64_stats_read(&mib->rx_512_1023byte) +
+		    u64_stats_read(&mib->rx_1024_1518byte) +
+		    u64_stats_read(&mib->rx_jumbo);
+	tx_frames = u64_stats_read(&mib->tx_64byte) +
+		    u64_stats_read(&mib->tx_65_127byte) +
+		    u64_stats_read(&mib->tx_128_255byte) +
+		    u64_stats_read(&mib->tx_256_511byte) +
+		    u64_stats_read(&mib->tx_512_1023byte) +
+		    u64_stats_read(&mib->tx_1024_1518byte) +
+		    u64_stats_read(&mib->tx_jumbo);
+	u64_stats_set(&pm->rx_frames, rx_frames);
+	u64_stats_set(&pm->tx_frames, tx_frames);
+	u64_stats_update_end(&pm->syncp);
 
 	if (res)
 		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
@@ -189,15 +195,17 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	u64 *buf;
 	size_t j;
 
 	if (!pm)
 		return;
 	mib = &pm->stats;
+	buf = pm->data;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	j = 0;
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
@@ -206,9 +214,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		if (!desc->name)
 			continue;
 
-		data[j] = ((u64 *)mib)[i];
+		data[j] = buf[i];
 		j++;
 	}
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
@@ -242,31 +252,33 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
-	mac_stats->FramesTransmittedOK = pm->tx_frames;
-	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
-	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
-	mac_stats->FramesReceivedOK = pm->rx_frames;
-	mac_stats->FrameCheckSequenceErrors = mib->rx_crc_errors;
-	mac_stats->AlignmentErrors = mib->rx_alignment_errors;
-	mac_stats->OctetsTransmittedOK = mib->tx_good_bytes;
-	mac_stats->FramesWithDeferredXmissions = mib->tx_deferred;
-	mac_stats->LateCollisions = mib->tx_late_collisions;
-	mac_stats->FramesAbortedDueToXSColls = mib->tx_aborted_errors;
+	mac_stats->FramesTransmittedOK = u64_stats_read(&pm->tx_frames);
+	mac_stats->SingleCollisionFrames = u64_stats_read(&mib->tx_single_collisions);
+	mac_stats->MultipleCollisionFrames = u64_stats_read(&mib->tx_multiple_collisions);
+	mac_stats->FramesReceivedOK = u64_stats_read(&pm->rx_frames);
+	mac_stats->FrameCheckSequenceErrors = u64_stats_read(&mib->rx_crc_errors);
+	mac_stats->AlignmentErrors = u64_stats_read(&mib->rx_alignment_errors);
+	mac_stats->OctetsTransmittedOK = u64_stats_read(&mib->tx_good_bytes);
+	mac_stats->FramesWithDeferredXmissions = u64_stats_read(&mib->tx_deferred);
+	mac_stats->LateCollisions = u64_stats_read(&mib->tx_late_collisions);
+	mac_stats->FramesAbortedDueToXSColls = u64_stats_read(&mib->tx_aborted_errors);
 	/* mac_stats->FramesLostDueToIntMACXmitError */
 	/* mac_stats->CarrierSenseErrors */
-	mac_stats->OctetsReceivedOK = mib->rx_good_bytes;
+	mac_stats->OctetsReceivedOK = u64_stats_read(&mib->rx_good_bytes);
 	/* mac_stats->FramesLostDueToIntMACRcvError */
-	mac_stats->MulticastFramesXmittedOK = mib->tx_multicast;
-	mac_stats->BroadcastFramesXmittedOK = mib->tx_broadcast;
+	mac_stats->MulticastFramesXmittedOK = u64_stats_read(&mib->tx_multicast);
+	mac_stats->BroadcastFramesXmittedOK = u64_stats_read(&mib->tx_broadcast);
 	/* mac_stats->FramesWithExcessiveDeferral */
-	mac_stats->MulticastFramesReceivedOK = mib->rx_multicast;
-	mac_stats->BroadcastFramesReceivedOK = mib->rx_broadcast;
+	mac_stats->MulticastFramesReceivedOK = u64_stats_read(&mib->rx_multicast);
+	mac_stats->BroadcastFramesReceivedOK = u64_stats_read(&mib->rx_broadcast);
 	/* mac_stats->InRangeLengthErrors */
 	/* mac_stats->OutOfRangeLengthField */
-	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
+	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -283,12 +295,14 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
-	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
-	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
+	ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
+	ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
 	/* ctrl_stats->UnsupportedOpcodesReceived */
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
@@ -317,31 +331,33 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	*ranges = yt921x_rmon_ranges;
 
-	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
-	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
-	rmon_stats->fragments = mib->rx_alignment_errors;
+	rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
+	rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
+	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
 	/* rmon_stats->jabbers */
 
-	rmon_stats->hist[0] = mib->rx_64byte;
-	rmon_stats->hist[1] = mib->rx_65_127byte;
-	rmon_stats->hist[2] = mib->rx_128_255byte;
-	rmon_stats->hist[3] = mib->rx_256_511byte;
-	rmon_stats->hist[4] = mib->rx_512_1023byte;
-	rmon_stats->hist[5] = mib->rx_1024_1518byte;
-	rmon_stats->hist[6] = mib->rx_jumbo;
-
-	rmon_stats->hist_tx[0] = mib->tx_64byte;
-	rmon_stats->hist_tx[1] = mib->tx_65_127byte;
-	rmon_stats->hist_tx[2] = mib->tx_128_255byte;
-	rmon_stats->hist_tx[3] = mib->tx_256_511byte;
-	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
-	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
-	rmon_stats->hist_tx[6] = mib->tx_jumbo;
+	rmon_stats->hist[0] = u64_stats_read(&mib->rx_64byte);
+	rmon_stats->hist[1] = u64_stats_read(&mib->rx_65_127byte);
+	rmon_stats->hist[2] = u64_stats_read(&mib->rx_128_255byte);
+	rmon_stats->hist[3] = u64_stats_read(&mib->rx_256_511byte);
+	rmon_stats->hist[4] = u64_stats_read(&mib->rx_512_1023byte);
+	rmon_stats->hist[5] = u64_stats_read(&mib->rx_1024_1518byte);
+	rmon_stats->hist[6] = u64_stats_read(&mib->rx_jumbo);
+
+	rmon_stats->hist_tx[0] = u64_stats_read(&mib->tx_64byte);
+	rmon_stats->hist_tx[1] = u64_stats_read(&mib->tx_65_127byte);
+	rmon_stats->hist_tx[2] = u64_stats_read(&mib->tx_128_255byte);
+	rmon_stats->hist_tx[3] = u64_stats_read(&mib->tx_256_511byte);
+	rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
+	rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
+	rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 void
@@ -352,37 +368,45 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	unsigned int start;
 
 	if (!pm)
 		return;
 	mib = &pm->stats;
 
-	stats->rx_length_errors = mib->rx_undersize_errors +
-				  mib->rx_fragment_errors;
-	stats->rx_over_errors = mib->rx_oversize_errors;
-	stats->rx_crc_errors = mib->rx_crc_errors;
-	stats->rx_frame_errors = mib->rx_alignment_errors;
-	/* stats->rx_fifo_errors */
-	/* stats->rx_missed_errors */
-
-	stats->tx_aborted_errors = mib->tx_aborted_errors;
-	/* stats->tx_carrier_errors */
-	stats->tx_fifo_errors = mib->tx_undersize_errors;
-	/* stats->tx_heartbeat_errors */
-	stats->tx_window_errors = mib->tx_late_collisions;
-
-	stats->rx_packets = pm->rx_frames;
-	stats->tx_packets = pm->tx_frames;
-	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
-	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
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
-	stats->rx_dropped = mib->rx_dropped;
-	/* stats->tx_dropped */
-	stats->multicast = mib->rx_multicast;
-	stats->collisions = mib->tx_collisions;
 }
 
 void
@@ -399,9 +423,11 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 	mib = &pm->stats;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
-	pause_stats->tx_pause_frames = mib->tx_pause;
-	pause_stats->rx_pause_frames = mib->rx_pause;
+	pause_stats->tx_pause_frames = u64_stats_read(&mib->tx_pause);
+	pause_stats->rx_pause_frames = u64_stats_read(&mib->rx_pause);
+
+	mutex_unlock(&priv->reg_lock);
 }
diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
index cfad0665baae..33992a5f9bdc 100644
--- a/drivers/net/dsa/motorcomm/mib.h
+++ b/drivers/net/dsa/motorcomm/mib.h
@@ -6,6 +6,8 @@
 #ifndef _YT_MIB_H
 #define _YT_MIB_H
 
+#include <linux/u64_stats_sync.h>
+
 #include <net/dsa.h>
 
 #define YT921X_MIB_CTRL			0xc0004
@@ -72,64 +74,70 @@
 #define  YT921X_MIB_DATA_TX_OAM			0xac
 
 struct yt921x_mib_stats {
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
+	u64_stats_t rx_broadcast;
+	u64_stats_t rx_pause;
+	u64_stats_t rx_multicast;
+	u64_stats_t rx_crc_errors;
+
+	u64_stats_t rx_alignment_errors;
+	u64_stats_t rx_undersize_errors;
+	u64_stats_t rx_fragment_errors;
+	u64_stats_t rx_64byte;
+
+	u64_stats_t rx_65_127byte;
+	u64_stats_t rx_128_255byte;
+	u64_stats_t rx_256_511byte;
+	u64_stats_t rx_512_1023byte;
+
+	u64_stats_t rx_1024_1518byte;
+	u64_stats_t rx_jumbo;
+	u64_stats_t rx_good_bytes;
+
+	u64_stats_t rx_bad_bytes;
+	u64_stats_t rx_oversize_errors;
+
+	u64_stats_t rx_dropped;
+	u64_stats_t tx_broadcast;
+	u64_stats_t tx_pause;
+	u64_stats_t tx_multicast;
+
+	u64_stats_t tx_undersize_errors;
+	u64_stats_t tx_64byte;
+	u64_stats_t tx_65_127byte;
+	u64_stats_t tx_128_255byte;
+
+	u64_stats_t tx_256_511byte;
+	u64_stats_t tx_512_1023byte;
+	u64_stats_t tx_1024_1518byte;
+	u64_stats_t tx_jumbo;
+
+	u64_stats_t tx_good_bytes;
+	u64_stats_t tx_collisions;
+
+	u64_stats_t tx_aborted_errors;
+	u64_stats_t tx_multiple_collisions;
+	u64_stats_t tx_single_collisions;
+	u64_stats_t tx_good;
+
+	u64_stats_t tx_deferred;
+	u64_stats_t tx_late_collisions;
+	u64_stats_t rx_oam;
+	u64_stats_t tx_oam;
 };
 
+#define YT921X_MIB_NUM	(sizeof(struct yt921x_mib_stats) / sizeof(u64_stats_t))
+
 struct yt921x_mib {
 	struct yt921x_port *port;
 
 	struct delayed_work work;
+	struct u64_stats_sync syncp;
+	/* protected by syncp OR priv->reg_lock */
 	struct yt921x_mib_stats stats;
-	u64 rx_frames;
-	u64 tx_frames;
+	u64_stats_t rx_frames;
+	u64_stats_t tx_frames;
+	/* protected by priv->reg_lock */
+	u64 data[YT921X_MIB_NUM];
 };
 
 void yt921x_mib_poll(struct work_struct *work);
-- 
2.53.0

