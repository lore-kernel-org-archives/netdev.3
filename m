Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F433CF210
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700483; cv=none; b=QOAAm0owyuX3uN/u3GgiZ2rz4SkdULQ8yEfz6yYGspQmn2BPvaAZ9uqaotLSkKy2YAJiy3HQgK423TEtYW6TVQ0UXJ6spftjCo9yvadw1AqjXxwfX7q/yiOF+S43YvFeWwARXH/thWBrZzTfKDy0X/CI10UTpkPBLs5B4+0e44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700483; c=relaxed/simple;
	bh=3/1JZMbTWgfSzun6AalSqiQUykhAqGZcOfOW789r6CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6uNaNdMyoEKViebFt2NiGJ/ZOrTsRTZ5gkINlV/+PYfZNj+FNj10fQvAAezdNtvIQbeGGyTvH5h8D1TxklToJMRjp+MPlB2etze1olK+HoN1W1zYQzPUT5+aQQ1GDd7AJP3Wv+dVOXlQL2whsV0SifYjmNN3c0S78Q6QeDUT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpK44EZ+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpK44EZ+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d5cad1a6baso22621845ad.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 06:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788700480; x=1789305280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=91ueGDtOnVPC2I4VVf41azWOjMFfy242Vqh8cgagWKs=;
        b=qpK44EZ+44ROWHmsYXQLQtm3ENnskGq9bXYTMiSdxB5LvtJr1YMgKG1ttSKIHi6gls
         PuEt+h0VII3yyULKPy3SdWa5+Cs4yj/E5czOEIQs/g06+aZV8WtgMdFWT3BvHMKNmCIL
         S4vjkZl6R52QgTzK4gTtSLUsqqQce/GfKK9zHhQfUgag1odtF1oBUM4Qd1eubFQQesJx
         wPibYdvteIwIGcq6fsX4wwhCUiKpE9Pwi96rDHF43xz5qhAHEUXVpLTrjoZxDLrhHywQ
         qURmxGP0vZFBs41LFRChgs5vR1X3ZN1cqZ5HaY+ynCqXxUbgJqgjxwmc4eoPX32IjYES
         l2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788700480; x=1789305280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=91ueGDtOnVPC2I4VVf41azWOjMFfy242Vqh8cgagWKs=;
        b=msHFY7b68IIIxPaHRX1KMK/qnvzqoLyH4rYFgnOMczPmWoFEOd3SniCenMFChVnhm8
         lqfZ2ust5Bdcyq5HtFIXkfkP1zRpu8qQwjT5fY3p9ZCq2Zj8m5ceSCUoXGf4JOVtRUZ7
         fPH+8HbkSFfeQ7PYorM3BtTbXN/3raurIz033DAwoQaq8y06HTanyC7X1gUH/GFOF4Vs
         xMTfE1v+UlYwlnAHX2B218cCoHnjGX1U/ecU0lAGHbeDr2647Cka5xV95tQMmPOpj9zY
         cRCR+9dO5SXXuTmPmOGITc9FC4jEOuuNmb7Y29sKkw3lDbh/j9IYU9ynGzSoqmuiubB5
         BelA==
X-Gm-Message-State: AFuF++m4a41u9c1DaXWDNMD1xccpm/MTV3wwP/EPPPZc1AXNrptwZ67b
	Ef6l7IBKOD1fH7ZIG1IZkZGWmG0RgG0mdoP9dqKBP6rFpFv8iNJdyAsrNvuZyM7Q
X-Gm-Gg: AYBFou1rzWXuMmHTVRFdFuxVDj4qV/fPJkKBRIU4QJh5Im7dSYG8X67CIlGJdFFLil6
	AxioDBsz+lNyBglt6vdVjxU0PyeWpxKt9RDjSk3xkFo58Y9DM2KqC31zhlKW1XahxB/5xJ4ehkz
	YU0UWnlstMOda5ZR5ZN3Np2EfEk3uMWK6DCdKOc5vNMpoSNug8kiam7hxsOWXqjJAdoSPKN4m2Z
	86G85q5k/j5K+UAyWyVZc328a8kr9FKf1zG2XJtZQh8n/XkohUFe/Oq7mSODkVB7uAvvO/VF7o5
	TKQ9eK+urnlIWoPJzbF0CeFaCQEzQFoLJYtNrXHB1A5PfC2tWMchAepu5BzAJm5rBHMpKZvNfzS
	yr37Fq+IhWJDcKUijo3ULZLpesU0R2/3qmtNcXKmJPFkoCXmiUigcqHKco2k/73Hk0cdlUK/rwj
	81c90Qd8Da0FI5ubQ9Y4Hj0sqL8QHET2s2jr1++gfAMY1zmnaQgL9YMOWO00fmtd/7FCqNFzUbY
	FyZ+IF+Nocyiw==
X-Received: by 2002:a17:903:46cd:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2db125c332fmr296916955ad.12.1788700480431;
        Sun, 06 Sep 2026 06:14:40 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4d0:7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495b2f8sm32259965ad.21.2026.09.06.06.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:14:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 4/6] net: dsa: motorcomm: Use u64_stats_t for MIB stats
Date: Sun,  6 Sep 2026 21:14:09 +0800
Message-ID: <20260906131414.2683362-5-mmyangfl@gmail.com>
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

64-bit variables might not be atomic on 32-bit architectures, and could
lead to load/store tearing.

This is a verbatim change that replace every u64 statistics into
u64_stats_t. u64_stats_sync will be equipped in the next commit.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/mib.c | 152 ++++++++++++++++----------------
 drivers/net/dsa/motorcomm/mib.h | 104 +++++++++++-----------
 2 files changed, 131 insertions(+), 125 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index b1296f224cf6..f5d39d22215d 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -92,22 +92,16 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	struct device *dev = to_device(priv);
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
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
+		u64_stats_t *valp = &((u64_stats_t *)mib)[i];
 		u32 val0;
 		u64 val;
 
@@ -116,7 +110,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = *valp;
+			u64 old_val = u64_stats_read(valp);
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -130,17 +124,25 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			val = ((u64)val1 << 32) | val0;
 		}
 
-		WRITE_ONCE(*valp, val);
+		u64_stats_set(valp, val);
 	}
 
-	pm->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
-			mib->rx_128_255byte + mib->rx_256_511byte +
-			mib->rx_512_1023byte + mib->rx_1024_1518byte +
-			mib->rx_jumbo;
-	pm->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
-			mib->tx_128_255byte + mib->tx_256_511byte +
-			mib->tx_512_1023byte + mib->tx_1024_1518byte +
-			mib->tx_jumbo;
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
 
 	if (res)
 		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
@@ -207,7 +209,7 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		if (!desc->name)
 			continue;
 
-		data[j] = ((u64 *)mib)[i];
+		data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);
 		j++;
 	}
 }
@@ -246,28 +248,28 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
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
 }
 
 void
@@ -287,8 +289,8 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
-	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
+	ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
+	ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
 	/* ctrl_stats->UnsupportedOpcodesReceived */
 }
 
@@ -323,26 +325,26 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
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
 }
 
 void
@@ -358,32 +360,34 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 		return;
 	mib = &pm->stats;
 
-	stats->rx_length_errors = mib->rx_undersize_errors +
-				  mib->rx_fragment_errors;
-	stats->rx_over_errors = mib->rx_oversize_errors;
-	stats->rx_crc_errors = mib->rx_crc_errors;
-	stats->rx_frame_errors = mib->rx_alignment_errors;
+	stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
+				  u64_stats_read(&mib->rx_fragment_errors);
+	stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
+	stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
+	stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
 	/* stats->rx_fifo_errors */
 	/* stats->rx_missed_errors */
 
-	stats->tx_aborted_errors = mib->tx_aborted_errors;
+	stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
 	/* stats->tx_carrier_errors */
-	stats->tx_fifo_errors = mib->tx_undersize_errors;
+	stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
 	/* stats->tx_heartbeat_errors */
-	stats->tx_window_errors = mib->tx_late_collisions;
-
-	stats->rx_packets = pm->rx_frames;
-	stats->tx_packets = pm->tx_frames;
-	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
-	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
+	stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
+
+	stats->rx_packets = u64_stats_read(&pm->rx_frames);
+	stats->tx_packets = u64_stats_read(&pm->tx_frames);
+	stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
+			  ETH_FCS_LEN * stats->rx_packets;
+	stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
+			  ETH_FCS_LEN * stats->tx_packets;
 	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
 			   stats->rx_crc_errors + stats->rx_frame_errors;
 	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
 			   stats->tx_window_errors;
-	stats->rx_dropped = mib->rx_dropped;
+	stats->rx_dropped = u64_stats_read(&mib->rx_dropped);
 	/* stats->tx_dropped */
-	stats->multicast = mib->rx_multicast;
-	stats->collisions = mib->tx_collisions;
+	stats->multicast = u64_stats_read(&mib->rx_multicast);
+	stats->collisions = u64_stats_read(&mib->tx_collisions);
 }
 
 void
@@ -403,6 +407,6 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	pause_stats->tx_pause_frames = mib->tx_pause;
-	pause_stats->rx_pause_frames = mib->rx_pause;
+	pause_stats->tx_pause_frames = u64_stats_read(&mib->tx_pause);
+	pause_stats->rx_pause_frames = u64_stats_read(&mib->rx_pause);
 }
diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
index cfad0665baae..d84ae2f449ac 100644
--- a/drivers/net/dsa/motorcomm/mib.h
+++ b/drivers/net/dsa/motorcomm/mib.h
@@ -6,6 +6,8 @@
 #ifndef _YT_MIB_H
 #define _YT_MIB_H
 
+#include <linux/u64_stats_sync.h>
+
 #include <net/dsa.h>
 
 #define YT921X_MIB_CTRL			0xc0004
@@ -72,55 +74,55 @@
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
 
 struct yt921x_mib {
@@ -128,8 +130,8 @@ struct yt921x_mib {
 
 	struct delayed_work work;
 	struct yt921x_mib_stats stats;
-	u64 rx_frames;
-	u64 tx_frames;
+	u64_stats_t rx_frames;
+	u64_stats_t tx_frames;
 };
 
 void yt921x_mib_poll(struct work_struct *work);
-- 
2.53.0

