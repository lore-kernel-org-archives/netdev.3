Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8A3C5DDB
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130016; cv=none; b=jCraYPaiwavB9C6RBSeZXjeJQ5EqqTpI38bfceGU3KKGYJC+dz5zzK7lvpMETW2KiltK0GXWP4E8A0KzPBzbR5qHFm8jzh2wbbi+g7rAxEGQR8glKtx1gs4llQ8VXOg2g2y0NFVenpMmCCe1+jfqyvtzX4KF2LsWi512nQ22O5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130016; c=relaxed/simple;
	bh=HfFcwP1D2RUyttUeoq8IjA1MmRVMTSEJngkdTsL1V0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQgYg4yFBnH4oS2z44i6yEea0ukUryZYyQBdN1KNwKkOb9xNQyEhnH69efCj7k+6CSXhKWaQJBlIdOYijwve0VxqFfjfHn0gg3OXuj++KzR1jrFxK2faWlPMajIfqy4iOrqo2/0FQzNzitSQmL3+Nswf3VxkPNXc6thOZ7K1nvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7+f59zc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7+f59zc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-86aecf49833so142424b3a.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791130013; x=1791734813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=udX0aLJE5buUjmfFthe0KYoPHkEaGCxZugwgdrgRnu0=;
        b=i7+f59zcPQBQUl6OgzXn5G5EL83xXichXI44+xLF8eKZivnaEmhJbdw3+FqS/FckGr
         69gWTyCAF31fg5X2U7zZfbqmTLmZFS2EMplWuZm10ZjGFsaR8e4D0pFc8IR9jnKahUhp
         Epdl34IriyAps+CA17ONuH7kN5i0M+Bp2eX54Eas+WjCQuWeaSJlKFkEnanyINYyNaLO
         NBn+scYWxPKzSA9WD5TYstM0+wu3zVzTUreBYUfyY3xFrwH0GHv1cCCUFYdMTWVnQ1QD
         9eX6NM2L43fufd3twLWAb92Hb+qE0JXm8o4I/aW8gaLf/bIP5BnLqC0cPZrIRO95+V28
         Vr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791130013; x=1791734813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=udX0aLJE5buUjmfFthe0KYoPHkEaGCxZugwgdrgRnu0=;
        b=0LQ2ag8QrwtTvx+Ovuh6TPTS4x6J8pG8R1c3YeWVsT+eL1405jis20L27xfgahjY4o
         K/XkMsbaOAooSx5T2SgFMmcdswG7bSZWE1phNiJzozIz1EKIF+3wb9nRC/srVdXbUNSL
         hrPLae6JKBxDPZtF/gMA5EXEnOQnRYXivx9zGKrmxc49hNCs46tcFQvnAW82Qy0Nc0/4
         1pm9vbS0n/Xf8I4m3KZ5AtJUf0wxnAcPKb8sap+nSIyFH3Oea9g4HaG4X2HS9JDBU6GG
         IyZYzBxfm5MnPR9wRojcw0wB6zva/7JWikvE8GxLXhyTuv+TaDl3sSidjfYR+yNkiklO
         GSGg==
X-Gm-Message-State: AFuF++ngNedcbFMlGV0qnieOxbyqfyk4R1tzrsqxS1OijspN/2PDfviR
	ecsb/NS1WQwu1ZazkljWNLD3ElNGgrmLNK/BnWeG+w0ho27ipbWA3vu00ZPf8GBgEj4=
X-Gm-Gg: AYBFou2BQmb1kmXbAEBzqQlZo3hjvzW9BJWFGyRMNqZO2T84XyxFnhsHTvVQ2XBRKpc
	ALg2sXdtql85gvR6eggvwV4iNdy2CJrEogCjUK8qg7nLS5uaxwNQIPpnNZ1nDmMpPJTnAxu9JdF
	FQjuj9hef8txH6wEOrCTPVnxSO13kTjLgapZzyGeTJbdxBIJLKVpkCDsIx+RTmLM007SgQiIKZN
	sKcGtSgRrGuQsUr/ylRv8NwW1ofcdCgHHcpfRS16flzT1jdBKzzEpktpKUz7ki/AJ/vaSzRjyHA
	qkNnVopBDXxM5XApn0R8xunv/Soc4e6U8BGdaQuVtv1DlLS1kQnzLNNLIaWdz6zCwnFQxbAW1JZ
	Tm0zKeWzcOZ4N46CFnJuwfF6KcEf9zgh3gECie6dozm0C4kFZXfgKh0ct07QvGynap5B1w/V3pv
	SQf5GiSJFvF4qmPyPNs9dbWQG0DFim8FI21fAQmSocOusqPmzxmB5VqCWNjPuMsCrrgcX/SWr00
	WGgoS4FeuMwCjUO+wZIT1km5A==
X-Received: by 2002:aa7:88c5:0:b0:880:8fe8:a3f5 with SMTP id d2e1a72fcca58-887fd9348aamr7256433b3a.22.1791130013358;
        Sun, 04 Oct 2026 09:06:53 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2637789b3a.54.2026.10.04.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:06:53 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/6] net: dsa: motorcomm: Use u64_stats_t for MIB stats
Date: Mon,  5 Oct 2026 00:06:19 +0800
Message-ID: <20261004160622.948037-6-mmyangfl@gmail.com>
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

64-bit variables might not be atomic on 32-bit architectures, and could
lead to load/store tearing.

This is a verbatim change that replaces every u64 statistics into
u64_stats_t. This is not a self-contained fix-all commit: u64_stats_sync
is equipped in the next commit for easy reviewing.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/mib.c | 152 ++++++++++++++++----------------
 drivers/net/dsa/motorcomm/mib.h | 104 +++++++++++-----------
 2 files changed, 131 insertions(+), 125 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index fd634c8e2c04..7d83bb3a8a86 100644
--- a/drivers/net/dsa/motorcomm/mib.c
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -89,22 +89,16 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
 	struct yt921x_mib_stats *mib;
+	u64 rx_frames;
+	u64 tx_frames;
 	int res = 0;
 
 	mib = &pm->stats;
 
-	/* Reading of yt921x_mib_stats is not protected by a lock and it's vain
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
 
@@ -113,7 +107,7 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = *valp;
+			u64 old_val = u64_stats_read(valp);
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -127,17 +121,25 @@ static int yt921x_mib_read(struct yt921x_priv *priv, int port)
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
@@ -203,7 +205,7 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		if (!desc->name)
 			continue;
 
-		data[j] = ((u64 *)mib)[i];
+		data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);
 		j++;
 	}
 }
@@ -242,28 +244,28 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
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
@@ -283,8 +285,8 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
-	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
+	ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
+	ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
 	/* ctrl_stats->UnsupportedOpcodesReceived */
 }
 
@@ -319,26 +321,26 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
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
@@ -354,32 +356,34 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
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
@@ -399,6 +403,6 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
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

