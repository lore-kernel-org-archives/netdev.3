Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1109470106
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022701; cv=none; b=s4xBayqjcpTpQtmdLoUNKRs3DVlVQV4IwNfYHSU8vM6vnyCMLUOL9GNEVo+NddABVqau5j9Kei9wxNbSas/JGPmqCee12YjxzRQECmbd91p4GuMqr7cWIVoZr48V9kAB3UWbazy2IWi4GX/nYvsA7Do9ciAFwlajlf08FGcEM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022701; c=relaxed/simple;
	bh=yY4iGfaolqNcXbtbE1oj0vjbXwyoD+x/vZgrNSCo1Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tG0wLraePwgbr1+UgQFBqRLX4GC2uCi1Bg6H9C6xnpvLPHxhHpiUnDi4gGBp0lYii3p2ttjhaWWtphAM0F25oT/SzFMbz01PNF4jCHz1CDUcwQ92SdeO3M5trxUzBQbn/R3se2vD6cflVkWqchYjPbn7hPBnE7QpkhLdsjj/M3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeWQ2/kt; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeWQ2/kt"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so31056705ad.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022698; x=1790627498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oPgXE+60QT4oPBf5ZZ8vbnIhKGd3bdVTICwsd61ah8Y=;
        b=VeWQ2/kt6JrQOrr5sEPxd5CIDJ0RD5JE3Uu1lDFrMQMEe/nI7T43kwN4LM+z/g77sn
         +PtYx2wejQQHEI6SZjMkCyHDLw1w5tDyV0lOVEq0rB4tB7P7BEXA+rMjGRKNMMbWwWVU
         kRw8BN9eQ1Zr1BOPAsTATHaTZGWUimcN5D/w99bPV4AEPYnv+K+lVWVx3yeSA3U4VMo8
         vV1bTfnfNJapGy9NMWxAhJzAD4EYYXF9B8UqmL/aPiSDr+jP/fgpqCsl/DEEIy1d4mto
         mkm7ReHXsbBf1AmUgOvdcczd5wzzV/rqP6kUTO7PHm1aqpYYLPYXkaZiIjjXo0n7S3tE
         P5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022698; x=1790627498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oPgXE+60QT4oPBf5ZZ8vbnIhKGd3bdVTICwsd61ah8Y=;
        b=eQEO8KJ3Zb9LJZ+RQxrDYdFyJL0Pp1dZ863cpwYVVBBgO9Jv1KLHYHjmJU+5Vx3KCa
         SdBFT4vmFpoEfVNViCS4UBb/Fld+cFZY8yb2627rEuUgtHkkx8XuwR6cyZYyKgAoVKxa
         zLO10ZDDRTkSlUPaLphY1oe7DgoGdQdvAwvMwgJ0eKVA7Y9AqOzi8lxUxTBcowM+AEG1
         ZFysfGsmHUAsXlGWmSEMieujKqV8TDl7tLhUtEVbQsu/DWiJV7IvkYNeZw/6VB9N3hZC
         6xxfVQY7maCxfFjGi9RJbc1KGFZ7B5S/5ILPNrG+8S7HxmFODnX6cPGKINmSAPVZvi1e
         fCCg==
X-Gm-Message-State: AFuF++leyf6yzFmagZbLTfOoNWSDslJRtQ5el9bO15T39qcF9qQnHUnW
	8mLwIdvCj+gT5Ixgazu+dknCadtCn+aYV3tjoqz6H6lw/DW8qV6Qe1hWbstjAA==
X-Gm-Gg: AYBFou1wnf/YeOxirncR/DYoLamdXNd4IKJurr8eGhuaQu2mVId+SrHaOn+jmZmKqmb
	hRYIvc3elPpwHAtF0RS5wPpkGCDC/VeYzMqGmYTzXLKlNUfEVrfKunvK21r4VRAFuHgp9ZX3Azv
	CunqSiDtnkRxaL61XT9KOxfEz/Z+UJjrUkL9VOkeCW8ajo9rfzHRGI9O9RCiUDMUvkirCrvUKFC
	OWMaoOrMZMnI1GElzX9AHu8feeKcSOBhh1TbRLDXm0v0vmUXTAtPxGjrHX8dvy2r4j5/cNDcAMM
	rdNdmIrCenZYnIipTGpZyYo4HKkgFFdWW+xU03k9L47lXfbUrrwWfV9ZpNLg1xqn6Z7qefBugUr
	Xm2i/loInBnGnimTfO29ffiid/KwhsWB+4LEHt1432D3mEXMqr0WuCuC0dhFhoqiHVHspDPSjpm
	ni1p8GDrbvRnJkXfKzHYa04gXhn8eF4YScwzZOh77cNp4maiwZh1kGtxovI/+hXc1dLIGXwa0cW
	vRSmgHLjKWbduSTSmMx7NM2
X-Received: by 2002:a17:90b:4f8e:b0:39e:433:23b5 with SMTP id 98e67ed59e1d1-3a06ade9015mr129966a91.5.1790022697947;
        Mon, 21 Sep 2026 13:31:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069918587sm447247a91.4.2026.09.21.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:31:37 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/7] net: dsa: motorcomm: Use u64_stats_t for MIB stats
Date: Tue, 22 Sep 2026 04:30:22 +0800
Message-ID: <20260921203040.1203911-6-mmyangfl@gmail.com>
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

64-bit variables might not be atomic on 32-bit architectures, and could
lead to load/store tearing.

This is a verbatim change that replace every u64 statistics into
u64_stats_t. u64_stats_sync will be equipped in the next commit.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/mib.c | 152 ++++++++++++++++----------------
 drivers/net/dsa/motorcomm/mib.h | 104 +++++++++++-----------
 2 files changed, 131 insertions(+), 125 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
index c2f7d7f83cd9..69b9eb7e5208 100644
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
@@ -206,7 +208,7 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		if (!desc->name)
 			continue;
 
-		data[j] = ((u64 *)mib)[i];
+		data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);
 		j++;
 	}
 }
@@ -245,28 +247,28 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
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
@@ -286,8 +288,8 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
-	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
+	ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
+	ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
 	/* ctrl_stats->UnsupportedOpcodesReceived */
 }
 
@@ -322,26 +324,26 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
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
@@ -357,32 +359,34 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
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
@@ -402,6 +406,6 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
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

