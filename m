Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDA441623
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022699; cv=none; b=d313RXFdJiDAaR5Yjcj6T3XH4l80LuUM1P7Fl3yxsqnGmDU4eCaVLdrTjodp0vvQsXcuaA7JujL2PN5dHs749jY9f0BXtKXrSGAx8PJZObCy8w/SNVh4DqTxgQKXItq4SjOadJA2pMFWLxwHSSYjZEbP+pENDSzkUZODosyKypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022699; c=relaxed/simple;
	bh=AwKKiho82111IrPhVfVqNS+YDUf3xYYzLkEfU743KFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEnhHB1W+AVUMqQSkoYlQzaGw3yFN0nHsYkIQwZ+Qjc66mCf5r6/NBvJFYiXeF8YRE6J+RklWlKwPiluZyHGqgaTsqm83qUf2JLjkMF3O3Au9tMRTSdU3VoSzWxCDqCi8NaGNXNj6C+bM0JmsW34rbeZ2Tg/jPEMf+xe6K+quV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rb1Q8D+A; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rb1Q8D+A"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so2660392a91.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022695; x=1790627495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riLXlmu0KZL9/Now9lygvGKlCPtBFxJ/9eGrQ5SKHqQ=;
        b=rb1Q8D+ACGqx29XtiJ5L5ywIulhV+K795BCHsbBopvimuZjXHNiM1DWm43um4tNpRv
         fMT0CIDQw77YCOeXI53Cwl6LlsHgY9U5jj6xbF9aB77pNnZXIKBcgRZdp3z2EOHdAgXR
         AHEPfcAFUD5oljTJkoG2KPhDvx8Fgr+wxSWzV90SkVEmRGkFkq9kJasZwgRuMLkKJHzU
         /PZjo3tINxgDxN6k9Nn5tHn99+eT0TYqrLZdCsF1UATzr7By2iSkOhJyZZ8Y8+9bo5Zv
         6XvNeYX+/0WzGPTV+yu075rNyHKlB269bMRi1Wghfu1vLGYpEC2Q/P4nPc0F6ByHOplP
         uHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022695; x=1790627495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=riLXlmu0KZL9/Now9lygvGKlCPtBFxJ/9eGrQ5SKHqQ=;
        b=SF/KZvL/CDDg85oioOwfEPSQtppie8keuPYwYqVG4mdodLgw3pp7m99pFyxfcAg8JY
         /QDlcxnM7EHsHsyvJYi7D9EyOTsudzBSJakoi67XBSe8VeiUxkJzp/4vNqoxqkZ/Muzk
         3vq0voyuyOBDdWUziRtKGO8pry9jwEekW1OtQBDqne44ZcDFa3fhYRCrkzJCeGTFXkED
         RQ2DNPfzDJcmVMfUSufouXooNnuKxezAajXXmaRnMwnm3p0VqRHbktNnzqmU6eoT6XsF
         GyDLmt+m7GgAM7n34v0tmZcl1el1SypL9sVW7ClJ8rFxotuhCpB+UbPR7S2zglnpzkbI
         DSEA==
X-Gm-Message-State: AFuF++ly3ARX2U0awp1ZF7xwz6gBQO6T77ThCOuhVIND2ns21oaqxZqH
	RCN8ZrX6i7wbxLG4U/Yx7RnKeJ+FiPY3OlP1l38baE529+aNBjGUMFzK/iQNBA==
X-Gm-Gg: AYBFou2GQy3fs/cqhyTeNfrOMZcMKu0maaLLP8KouGBlM1RE7dPeQ1QlsmhdNVz9OHm
	1/bYEOEah6HDldfrj292oQQ7zda49bS7aOi3ORT6qIOOpnORzNGdty0361C1kY5zsgpJDQ2k+EK
	Im283TjiUTBClRHIroRabXSIm3z0uGCOrIFkLkpNBXju19hZ+0DYKT/8Y0GJ851uQ/+bR9AeKrW
	Dup8Q08Frl0/tHoby5PoRFS5ZHhvdI3D7nFy8SvK6ndRo/Y7U6ws1KNOqJoTl2bVqQBEMniDlvG
	dqXleIz/qXEIh1wNPmLTdGgjKLjmY5vg6GIbhL1Dz0YBtnmt38XrwhVFbTxtCSTctFGJjnvqvPN
	TDQAiGheaBkecjmDlruxy6GnIStugRs1HvBGBG5tJSYH7ojE69NTTfNa+gIfxuoeCu+U2hfg2eo
	Ml62Y/YeRChTCevfSC+a1MTP/dWzbxaAnacrLURNhLvCgw4idJAv+M4cyAfqVKSSa5jPPuXR5SQ
	F8KcnO2HzFC0PkLvxKJOcTg
X-Received: by 2002:a17:90a:d648:b0:39e:6c6a:4b6f with SMTP id 98e67ed59e1d1-39e6c6a5502mr10216010a91.57.1790022695090;
        Mon, 21 Sep 2026 13:31:35 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069918587sm447247a91.4.2026.09.21.13.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:31:34 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/7] net: dsa: motorcomm: Split MIB module
Date: Tue, 22 Sep 2026 04:30:21 +0800
Message-ID: <20260921203040.1203911-5-mmyangfl@gmail.com>
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

yt922x is going to use a different MIB scheme, split it to reduce the
length of chip.c.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 397 +---------------------------
 drivers/net/dsa/motorcomm/chip.h   | 124 ---------
 drivers/net/dsa/motorcomm/mib.c    | 407 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/mib.h    | 159 +++++++++++
 5 files changed, 568 insertions(+), 520 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mib.c
 create mode 100644 drivers/net/dsa/motorcomm/mib.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index aeb12cb91f93..5c2d34ec05fc 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
 yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
+yt921x-objs += mib.o
 yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index ad06d894b001..34dbbdcea135 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -27,75 +27,9 @@
 
 #include "chip.h"
 #include "leds.h"
+#include "mib.h"
 #include "smi.h"
 
-struct yt921x_mib_desc {
-	unsigned int size;
-	unsigned int offset;
-	const char *name;
-};
-
-#define MIB_DESC(_size, _offset, _name) \
-	{_size, _offset, _name}
-
-/* Must agree with yt921x_mib_stats
- *
- * Unstructured fields (name != NULL) will appear in get_ethtool_stats(),
- * structured go to their *_stats() methods, but we need their sizes and offsets
- * to perform 32bit MIB overflow wraparound.
- */
-static const struct yt921x_mib_desc yt921x_mib_descs[] = {
-	MIB_DESC(1, YT921X_MIB_DATA_RX_BROADCAST, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PAUSE, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_MULTICAST, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_CRC_ERR, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_RX_ALIGN_ERR, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_UNDERSIZE_ERR, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_FRAG_ERR, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_64, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_65_TO_127, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_128_TO_255, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_256_TO_511, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_512_TO_1023, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_1024_TO_1518, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_1519_TO_MAX, NULL),
-	MIB_DESC(2, YT921X_MIB_DATA_RX_GOOD_BYTES, NULL),
-
-	MIB_DESC(2, YT921X_MIB_DATA_RX_BAD_BYTES, "RxBadBytes"),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_OVERSIZE_ERR, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_RX_DROPPED, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_BROADCAST, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PAUSE, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_MULTICAST, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_TX_UNDERSIZE_ERR, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_64, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_65_TO_127, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_128_TO_255, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_256_TO_511, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_512_TO_1023, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_1024_TO_1518, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_1519_TO_MAX, NULL),
-
-	MIB_DESC(2, YT921X_MIB_DATA_TX_GOOD_BYTES, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_COLLISION, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_TX_EXCESSIVE_COLLISION, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_MULTIPLE_COLLISION, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_SINGLE_COLLISION, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT, NULL),
-
-	MIB_DESC(1, YT921X_MIB_DATA_TX_DEFERRED, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_LATE_COLLISION, NULL),
-	MIB_DESC(1, YT921X_MIB_DATA_RX_OAM, "RxOAM"),
-	MIB_DESC(1, YT921X_MIB_DATA_TX_OAM, "TxOAM"),
-};
-
 struct yt921x_info {
 	const char *name;
 	u16 major;
@@ -154,14 +88,6 @@ static const struct yt921x_info yt921x_infos[] = {
 
 #define YT921X_VID_UNWARE	4095
 
-/* The interval should be small enough to avoid overflow of 32bit MIBs.
- *
- * Until we can read MIBs from stats64 call directly (i.e. sleep
- * there), we have to poll stats more frequently then it is actually needed.
- * For overflow protection, normally, 100 sec interval should have been OK.
- */
-#define YT921X_STATS_INTERVAL_JIFFIES	(3 * HZ)
-
 struct yt921x_reg_mdio {
 	struct mii_bus *bus;
 	int addr;
@@ -544,327 +470,6 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
 	return 0;
 }
 
-/* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
-static int yt921x_mib_read(struct yt921x_priv *priv, int port)
-{
-	struct yt921x_port *pp = &priv->ports[port];
-	struct device *dev = to_device(priv);
-	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
-	int res = 0;
-
-	mib = &pm->stats;
-
-	/* Reading of yt921x_mib_stats is not protected by a lock and it's vain
-	 * to keep its consistency, since we have to read registers one by one
-	 * and there is no way to make a snapshot of MIB stats.
-	 *
-	 * Writing (by this function only) is and should be protected by
-	 * reg_lock.
-	 */
-
-	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
-		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
-		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u64 *valp = &((u64 *)mib)[i];
-		u32 val0;
-		u64 val;
-
-		res = yt921x_reg_read(priv, reg, &val0);
-		if (res)
-			break;
-
-		if (desc->size <= 1) {
-			u64 old_val = *valp;
-
-			val = (old_val & ~(u64)U32_MAX) | val0;
-			if (val < old_val)
-				val += 1ull << 32;
-		} else {
-			u32 val1;
-
-			res = yt921x_reg_read(priv, reg + 4, &val1);
-			if (res)
-				break;
-			val = ((u64)val1 << 32) | val0;
-		}
-
-		WRITE_ONCE(*valp, val);
-	}
-
-	pm->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
-			mib->rx_128_255byte + mib->rx_256_511byte +
-			mib->rx_512_1023byte + mib->rx_1024_1518byte +
-			mib->rx_jumbo;
-	pm->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
-			mib->tx_128_255byte + mib->tx_256_511byte +
-			mib->tx_512_1023byte + mib->tx_1024_1518byte +
-			mib->tx_jumbo;
-
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
-	return res;
-}
-
-static void yt921x_mib_poll(struct work_struct *work)
-{
-	struct yt921x_mib *pm = container_of_const(work, struct yt921x_mib,
-						   work.work);
-	struct yt921x_port *pp = pm->port;
-	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
-	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
-	int port = pp->index;
-	int res;
-
-	mutex_lock(&priv->reg_lock);
-	res = yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
-	if (res)
-		delay *= 4;
-
-	schedule_delayed_work(&pm->work, delay);
-}
-
-static void
-yt921x_dsa_get_strings(struct dsa_switch *ds, int port, u32 stringset,
-		       uint8_t *data)
-{
-	if (stringset != ETH_SS_STATS)
-		return;
-
-	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
-		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
-
-		if (desc->name)
-			ethtool_puts(&data, desc->name);
-	}
-}
-
-static void
-yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
-{
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
-	size_t j;
-
-	if (!pm)
-		return;
-	mib = &pm->stats;
-
-	mutex_lock(&priv->reg_lock);
-	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
-
-	j = 0;
-	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
-		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
-
-		if (!desc->name)
-			continue;
-
-		data[j] = ((u64 *)mib)[i];
-		j++;
-	}
-}
-
-static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
-{
-	int cnt = 0;
-
-	if (sset != ETH_SS_STATS)
-		return 0;
-
-	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
-		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
-
-		if (desc->name)
-			cnt++;
-	}
-
-	return cnt;
-}
-
-static void
-yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
-			     struct ethtool_eth_mac_stats *mac_stats)
-{
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
-
-	if (!pm)
-		return;
-	mib = &pm->stats;
-
-	mutex_lock(&priv->reg_lock);
-	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
-
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
-	/* mac_stats->FramesLostDueToIntMACXmitError */
-	/* mac_stats->CarrierSenseErrors */
-	mac_stats->OctetsReceivedOK = mib->rx_good_bytes;
-	/* mac_stats->FramesLostDueToIntMACRcvError */
-	mac_stats->MulticastFramesXmittedOK = mib->tx_multicast;
-	mac_stats->BroadcastFramesXmittedOK = mib->tx_broadcast;
-	/* mac_stats->FramesWithExcessiveDeferral */
-	mac_stats->MulticastFramesReceivedOK = mib->rx_multicast;
-	mac_stats->BroadcastFramesReceivedOK = mib->rx_broadcast;
-	/* mac_stats->InRangeLengthErrors */
-	/* mac_stats->OutOfRangeLengthField */
-	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
-}
-
-static void
-yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
-			      struct ethtool_eth_ctrl_stats *ctrl_stats)
-{
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
-
-	if (!pm)
-		return;
-	mib = &pm->stats;
-
-	mutex_lock(&priv->reg_lock);
-	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
-
-	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
-	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
-	/* ctrl_stats->UnsupportedOpcodesReceived */
-}
-
-static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
-	{ 0, 64 },
-	{ 65, 127 },
-	{ 128, 255 },
-	{ 256, 511 },
-	{ 512, 1023 },
-	{ 1024, 1518 },
-	{ 1519, YT921X_FRAME_SIZE_MAX },
-	{}
-};
-
-static void
-yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
-			  struct ethtool_rmon_stats *rmon_stats,
-			  const struct ethtool_rmon_hist_range **ranges)
-{
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
-
-	if (!pm)
-		return;
-	mib = &pm->stats;
-
-	mutex_lock(&priv->reg_lock);
-	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
-
-	*ranges = yt921x_rmon_ranges;
-
-	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
-	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
-	rmon_stats->fragments = mib->rx_alignment_errors;
-	/* rmon_stats->jabbers */
-
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
-}
-
-static void
-yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
-		       struct rtnl_link_stats64 *stats)
-{
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
-
-	if (!pm)
-		return;
-	mib = &pm->stats;
-
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
-	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
-			   stats->rx_crc_errors + stats->rx_frame_errors;
-	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
-			   stats->tx_window_errors;
-	stats->rx_dropped = mib->rx_dropped;
-	/* stats->tx_dropped */
-	stats->multicast = mib->rx_multicast;
-	stats->collisions = mib->tx_collisions;
-}
-
-static void
-yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
-			   struct ethtool_pause_stats *pause_stats)
-{
-	struct yt921x_priv *priv = to_yt921x_priv(ds);
-	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *pm = pp->mib;
-	struct yt921x_mib_stats *mib;
-
-	if (!pm)
-		return;
-	mib = &pm->stats;
-
-	mutex_lock(&priv->reg_lock);
-	yt921x_mib_read(priv, port);
-	mutex_unlock(&priv->reg_lock);
-
-	pause_stats->tx_pause_frames = mib->tx_pause;
-	pause_stats->rx_pause_frames = mib->rx_pause;
-}
-
 static int
 yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
 {
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 9f3c8af4f638..b2e39b70bf61 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -167,69 +167,6 @@
 #define YT921X_EEE_CTRL			0xb0000
 #define  YT921X_EEE_CTRL_ENn(port)		BIT(port)
 
-#define YT921X_MIB_CTRL			0xc0004
-#define  YT921X_MIB_CTRL_CLEAN			BIT(30)
-#define  YT921X_MIB_CTRL_PORT_M			GENMASK(6, 3)
-#define   YT921X_MIB_CTRL_PORT(x)			FIELD_PREP(YT921X_MIB_CTRL_PORT_M, (x))
-#define  YT921X_MIB_CTRL_ONE_PORT		BIT(1)
-#define  YT921X_MIB_CTRL_ALL_PORT		BIT(0)
-#define YT921X_MIBn_DATA0(port)		(0xc0100 + 0x100 * (port))
-#define YT921X_MIBn_DATAm(port, x)	(YT921X_MIBn_DATA0(port) + 4 * (x))
-#define  YT921X_MIB_DATA_RX_BROADCAST		0x00
-#define  YT921X_MIB_DATA_RX_PAUSE		0x04
-#define  YT921X_MIB_DATA_RX_MULTICAST		0x08
-#define  YT921X_MIB_DATA_RX_CRC_ERR		0x0c
-
-#define  YT921X_MIB_DATA_RX_ALIGN_ERR		0x10
-#define  YT921X_MIB_DATA_RX_UNDERSIZE_ERR	0x14
-#define  YT921X_MIB_DATA_RX_FRAG_ERR		0x18
-#define  YT921X_MIB_DATA_RX_PKT_SZ_64		0x1c
-
-#define  YT921X_MIB_DATA_RX_PKT_SZ_65_TO_127	0x20
-#define  YT921X_MIB_DATA_RX_PKT_SZ_128_TO_255	0x24
-#define  YT921X_MIB_DATA_RX_PKT_SZ_256_TO_511	0x28
-#define  YT921X_MIB_DATA_RX_PKT_SZ_512_TO_1023	0x2c
-
-#define  YT921X_MIB_DATA_RX_PKT_SZ_1024_TO_1518	0x30
-#define  YT921X_MIB_DATA_RX_PKT_SZ_1519_TO_MAX	0x34
-/* 0x38: unused */
-#define  YT921X_MIB_DATA_RX_GOOD_BYTES		0x3c
-
-/* 0x40: 64 bytes */
-#define  YT921X_MIB_DATA_RX_BAD_BYTES		0x44
-/* 0x48: 64 bytes */
-#define  YT921X_MIB_DATA_RX_OVERSIZE_ERR	0x4c
-
-#define  YT921X_MIB_DATA_RX_DROPPED		0x50
-#define  YT921X_MIB_DATA_TX_BROADCAST		0x54
-#define  YT921X_MIB_DATA_TX_PAUSE		0x58
-#define  YT921X_MIB_DATA_TX_MULTICAST		0x5c
-
-#define  YT921X_MIB_DATA_TX_UNDERSIZE_ERR	0x60
-#define  YT921X_MIB_DATA_TX_PKT_SZ_64		0x64
-#define  YT921X_MIB_DATA_TX_PKT_SZ_65_TO_127	0x68
-#define  YT921X_MIB_DATA_TX_PKT_SZ_128_TO_255	0x6c
-
-#define  YT921X_MIB_DATA_TX_PKT_SZ_256_TO_511	0x70
-#define  YT921X_MIB_DATA_TX_PKT_SZ_512_TO_1023	0x74
-#define  YT921X_MIB_DATA_TX_PKT_SZ_1024_TO_1518	0x78
-#define  YT921X_MIB_DATA_TX_PKT_SZ_1519_TO_MAX	0x7c
-
-/* 0x80: unused */
-#define  YT921X_MIB_DATA_TX_GOOD_BYTES		0x84
-/* 0x88: 64 bytes */
-#define  YT921X_MIB_DATA_TX_COLLISION		0x8c
-
-#define  YT921X_MIB_DATA_TX_EXCESSIVE_COLLISION	0x90
-#define  YT921X_MIB_DATA_TX_MULTIPLE_COLLISION	0x94
-#define  YT921X_MIB_DATA_TX_SINGLE_COLLISION	0x98
-#define  YT921X_MIB_DATA_TX_PKT			0x9c
-
-#define  YT921X_MIB_DATA_TX_DEFERRED		0xa0
-#define  YT921X_MIB_DATA_TX_LATE_COLLISION	0xa4
-#define  YT921X_MIB_DATA_RX_OAM			0xa8
-#define  YT921X_MIB_DATA_TX_OAM			0xac
-
 #define YT921X_EDATA_CTRL		0xe0000
 #define  YT921X_EDATA_CTRL_ADDR_M		GENMASK(15, 8)
 #define   YT921X_EDATA_CTRL_ADDR(x)			FIELD_PREP(YT921X_EDATA_CTRL_ADDR_M, (x))
@@ -861,67 +798,6 @@ enum yt921x_fdb_entry_status {
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
 
-struct yt921x_mib_stats {
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
-struct yt921x_mib {
-	struct yt921x_port *port;
-
-	struct delayed_work work;
-	struct yt921x_mib_stats stats;
-	u64 rx_frames;
-	u64 tx_frames;
-};
-
 struct yt921x_acl_entry {
 	u32 key[2];
 	u32 mask[2];
diff --git a/drivers/net/dsa/motorcomm/mib.c b/drivers/net/dsa/motorcomm/mib.c
new file mode 100644
index 000000000000..c2f7d7f83cd9
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#include "chip.h"
+#include "mib.h"
+#include "smi.h"
+
+struct yt921x_mib_desc {
+	unsigned int size;
+	unsigned int offset;
+	const char *name;
+};
+
+#define MIB_DESC(_size, _offset, _name) \
+	{_size, _offset, _name}
+
+/* Must agree with yt921x_mib_stats
+ *
+ * Unstructured fields (name != NULL) will appear in get_ethtool_stats(),
+ * structured go to their *_stats() methods, but we need their sizes and offsets
+ * to perform 32bit MIB overflow wraparound.
+ */
+static const struct yt921x_mib_desc yt921x_mib_descs[] = {
+	MIB_DESC(1, YT921X_MIB_DATA_RX_BROADCAST, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PAUSE, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_MULTICAST, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_CRC_ERR, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_ALIGN_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_UNDERSIZE_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_FRAG_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_64, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_65_TO_127, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_128_TO_255, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_256_TO_511, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_512_TO_1023, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_1024_TO_1518, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_PKT_SZ_1519_TO_MAX, NULL),
+	MIB_DESC(2, YT921X_MIB_DATA_RX_GOOD_BYTES, NULL),
+
+	MIB_DESC(2, YT921X_MIB_DATA_RX_BAD_BYTES, "RxBadBytes"),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_OVERSIZE_ERR, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_RX_DROPPED, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_BROADCAST, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PAUSE, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_MULTICAST, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_UNDERSIZE_ERR, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_64, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_65_TO_127, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_128_TO_255, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_256_TO_511, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_512_TO_1023, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_1024_TO_1518, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT_SZ_1519_TO_MAX, NULL),
+
+	MIB_DESC(2, YT921X_MIB_DATA_TX_GOOD_BYTES, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_COLLISION, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_EXCESSIVE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_MULTIPLE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_SINGLE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_PKT, NULL),
+
+	MIB_DESC(1, YT921X_MIB_DATA_TX_DEFERRED, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_LATE_COLLISION, NULL),
+	MIB_DESC(1, YT921X_MIB_DATA_RX_OAM, "RxOAM"),
+	MIB_DESC(1, YT921X_MIB_DATA_TX_OAM, "TxOAM"),
+};
+
+/* The interval should be small enough to avoid overflow of 32bit MIBs.
+ *
+ * Until we can read MIBs from stats64 call directly (i.e. sleep
+ * there), we have to poll stats more frequently then it is actually needed.
+ * For overflow protection, normally, 100 sec interval should have been OK.
+ */
+#define YT921X_STATS_INTERVAL_JIFFIES	(3 * HZ)
+
+#define to_yt921x_priv(_ds) container_of_const(_ds, struct yt921x_priv, ds)
+#define to_device(priv) ((priv)->ds.dev)
+
+/* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
+static int yt921x_mib_read(struct yt921x_priv *priv, int port)
+{
+	struct yt921x_port *pp = &priv->ports[port];
+	struct device *dev = to_device(priv);
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+	int res = 0;
+
+	mib = &pm->stats;
+
+	/* Reading of yt921x_mib_stats is not protected by a lock and it's vain
+	 * to keep its consistency, since we have to read registers one by one
+	 * and there is no way to make a snapshot of MIB stats.
+	 *
+	 * Writing (by this function only) is and should be protected by
+	 * reg_lock.
+	 */
+
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
+		u64 *valp = &((u64 *)mib)[i];
+		u32 val0;
+		u64 val;
+
+		res = yt921x_reg_read(priv, reg, &val0);
+		if (res)
+			break;
+
+		if (desc->size <= 1) {
+			u64 old_val = *valp;
+
+			val = (old_val & ~(u64)U32_MAX) | val0;
+			if (val < old_val)
+				val += 1ull << 32;
+		} else {
+			u32 val1;
+
+			res = yt921x_reg_read(priv, reg + 4, &val1);
+			if (res)
+				break;
+			val = ((u64)val1 << 32) | val0;
+		}
+
+		WRITE_ONCE(*valp, val);
+	}
+
+	pm->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
+			mib->rx_128_255byte + mib->rx_256_511byte +
+			mib->rx_512_1023byte + mib->rx_1024_1518byte +
+			mib->rx_jumbo;
+	pm->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
+			mib->tx_128_255byte + mib->tx_256_511byte +
+			mib->tx_512_1023byte + mib->tx_1024_1518byte +
+			mib->tx_jumbo;
+
+	if (res)
+		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
+			port, res);
+	return res;
+}
+
+void yt921x_mib_poll(struct work_struct *work)
+{
+	struct yt921x_mib *pm = container_of_const(work, struct yt921x_mib,
+						   work.work);
+	struct yt921x_port *pp = pm->port;
+	unsigned long delay = YT921X_STATS_INTERVAL_JIFFIES;
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	int port = pp->index;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_mib_read(priv, port);
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		delay *= 4;
+
+	schedule_delayed_work(&pm->work, delay);
+}
+
+void
+yt921x_dsa_get_strings(struct dsa_switch *ds, int port, u32 stringset,
+		       uint8_t *data)
+{
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+
+		if (desc->name)
+			ethtool_puts(&data, desc->name);
+	}
+}
+
+void
+yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+	size_t j;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
+
+	mutex_lock(&priv->reg_lock);
+	yt921x_mib_read(priv, port);
+	mutex_unlock(&priv->reg_lock);
+
+	j = 0;
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+
+		if (!desc->name)
+			continue;
+
+		data[j] = ((u64 *)mib)[i];
+		j++;
+	}
+}
+
+int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
+{
+	int cnt = 0;
+
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+
+		if (desc->name)
+			cnt++;
+	}
+
+	return cnt;
+}
+
+void
+yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
+			     struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
+
+	mutex_lock(&priv->reg_lock);
+	yt921x_mib_read(priv, port);
+	mutex_unlock(&priv->reg_lock);
+
+	mac_stats->FramesTransmittedOK = pm->tx_frames;
+	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
+	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
+	mac_stats->FramesReceivedOK = pm->rx_frames;
+	mac_stats->FrameCheckSequenceErrors = mib->rx_crc_errors;
+	mac_stats->AlignmentErrors = mib->rx_alignment_errors;
+	mac_stats->OctetsTransmittedOK = mib->tx_good_bytes;
+	mac_stats->FramesWithDeferredXmissions = mib->tx_deferred;
+	mac_stats->LateCollisions = mib->tx_late_collisions;
+	mac_stats->FramesAbortedDueToXSColls = mib->tx_aborted_errors;
+	/* mac_stats->FramesLostDueToIntMACXmitError */
+	/* mac_stats->CarrierSenseErrors */
+	mac_stats->OctetsReceivedOK = mib->rx_good_bytes;
+	/* mac_stats->FramesLostDueToIntMACRcvError */
+	mac_stats->MulticastFramesXmittedOK = mib->tx_multicast;
+	mac_stats->BroadcastFramesXmittedOK = mib->tx_broadcast;
+	/* mac_stats->FramesWithExcessiveDeferral */
+	mac_stats->MulticastFramesReceivedOK = mib->rx_multicast;
+	mac_stats->BroadcastFramesReceivedOK = mib->rx_broadcast;
+	/* mac_stats->InRangeLengthErrors */
+	/* mac_stats->OutOfRangeLengthField */
+	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
+}
+
+void
+yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
+
+	mutex_lock(&priv->reg_lock);
+	yt921x_mib_read(priv, port);
+	mutex_unlock(&priv->reg_lock);
+
+	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
+	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
+	/* ctrl_stats->UnsupportedOpcodesReceived */
+}
+
+static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
+	{ 0, 64 },
+	{ 65, 127 },
+	{ 128, 255 },
+	{ 256, 511 },
+	{ 512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, YT921X_FRAME_SIZE_MAX },
+	{}
+};
+
+void
+yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
+			  struct ethtool_rmon_stats *rmon_stats,
+			  const struct ethtool_rmon_hist_range **ranges)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
+
+	mutex_lock(&priv->reg_lock);
+	yt921x_mib_read(priv, port);
+	mutex_unlock(&priv->reg_lock);
+
+	*ranges = yt921x_rmon_ranges;
+
+	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
+	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
+	rmon_stats->fragments = mib->rx_alignment_errors;
+	/* rmon_stats->jabbers */
+
+	rmon_stats->hist[0] = mib->rx_64byte;
+	rmon_stats->hist[1] = mib->rx_65_127byte;
+	rmon_stats->hist[2] = mib->rx_128_255byte;
+	rmon_stats->hist[3] = mib->rx_256_511byte;
+	rmon_stats->hist[4] = mib->rx_512_1023byte;
+	rmon_stats->hist[5] = mib->rx_1024_1518byte;
+	rmon_stats->hist[6] = mib->rx_jumbo;
+
+	rmon_stats->hist_tx[0] = mib->tx_64byte;
+	rmon_stats->hist_tx[1] = mib->tx_65_127byte;
+	rmon_stats->hist_tx[2] = mib->tx_128_255byte;
+	rmon_stats->hist_tx[3] = mib->tx_256_511byte;
+	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
+	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
+	rmon_stats->hist_tx[6] = mib->tx_jumbo;
+}
+
+void
+yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
+		       struct rtnl_link_stats64 *stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
+
+	stats->rx_length_errors = mib->rx_undersize_errors +
+				  mib->rx_fragment_errors;
+	stats->rx_over_errors = mib->rx_oversize_errors;
+	stats->rx_crc_errors = mib->rx_crc_errors;
+	stats->rx_frame_errors = mib->rx_alignment_errors;
+	/* stats->rx_fifo_errors */
+	/* stats->rx_missed_errors */
+
+	stats->tx_aborted_errors = mib->tx_aborted_errors;
+	/* stats->tx_carrier_errors */
+	stats->tx_fifo_errors = mib->tx_undersize_errors;
+	/* stats->tx_heartbeat_errors */
+	stats->tx_window_errors = mib->tx_late_collisions;
+
+	stats->rx_packets = pm->rx_frames;
+	stats->tx_packets = pm->tx_frames;
+	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
+	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
+	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
+			   stats->rx_crc_errors + stats->rx_frame_errors;
+	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
+			   stats->tx_window_errors;
+	stats->rx_dropped = mib->rx_dropped;
+	/* stats->tx_dropped */
+	stats->multicast = mib->rx_multicast;
+	stats->collisions = mib->tx_collisions;
+}
+
+void
+yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
+			   struct ethtool_pause_stats *pause_stats)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib_stats *mib;
+
+	if (!pm)
+		return;
+	mib = &pm->stats;
+
+	mutex_lock(&priv->reg_lock);
+	yt921x_mib_read(priv, port);
+	mutex_unlock(&priv->reg_lock);
+
+	pause_stats->tx_pause_frames = mib->tx_pause;
+	pause_stats->rx_pause_frames = mib->rx_pause;
+}
diff --git a/drivers/net/dsa/motorcomm/mib.h b/drivers/net/dsa/motorcomm/mib.h
new file mode 100644
index 000000000000..cfad0665baae
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/mib.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 David Yang
+ */
+
+#ifndef _YT_MIB_H
+#define _YT_MIB_H
+
+#include <net/dsa.h>
+
+#define YT921X_MIB_CTRL			0xc0004
+#define  YT921X_MIB_CTRL_CLEAN			BIT(30)
+#define  YT921X_MIB_CTRL_PORT_M			GENMASK(6, 3)
+#define   YT921X_MIB_CTRL_PORT(x)			FIELD_PREP(YT921X_MIB_CTRL_PORT_M, (x))
+#define  YT921X_MIB_CTRL_ONE_PORT		BIT(1)
+#define  YT921X_MIB_CTRL_ALL_PORT		BIT(0)
+#define YT921X_MIBn_DATA0(port)		(0xc0100 + 0x100 * (port))
+#define YT921X_MIBn_DATAm(port, x)	(YT921X_MIBn_DATA0(port) + 4 * (x))
+#define  YT921X_MIB_DATA_RX_BROADCAST		0x00
+#define  YT921X_MIB_DATA_RX_PAUSE		0x04
+#define  YT921X_MIB_DATA_RX_MULTICAST		0x08
+#define  YT921X_MIB_DATA_RX_CRC_ERR		0x0c
+
+#define  YT921X_MIB_DATA_RX_ALIGN_ERR		0x10
+#define  YT921X_MIB_DATA_RX_UNDERSIZE_ERR	0x14
+#define  YT921X_MIB_DATA_RX_FRAG_ERR		0x18
+#define  YT921X_MIB_DATA_RX_PKT_SZ_64		0x1c
+
+#define  YT921X_MIB_DATA_RX_PKT_SZ_65_TO_127	0x20
+#define  YT921X_MIB_DATA_RX_PKT_SZ_128_TO_255	0x24
+#define  YT921X_MIB_DATA_RX_PKT_SZ_256_TO_511	0x28
+#define  YT921X_MIB_DATA_RX_PKT_SZ_512_TO_1023	0x2c
+
+#define  YT921X_MIB_DATA_RX_PKT_SZ_1024_TO_1518	0x30
+#define  YT921X_MIB_DATA_RX_PKT_SZ_1519_TO_MAX	0x34
+/* 0x38: unused */
+#define  YT921X_MIB_DATA_RX_GOOD_BYTES		0x3c
+
+/* 0x40: 64 bytes */
+#define  YT921X_MIB_DATA_RX_BAD_BYTES		0x44
+/* 0x48: 64 bytes */
+#define  YT921X_MIB_DATA_RX_OVERSIZE_ERR	0x4c
+
+#define  YT921X_MIB_DATA_RX_DROPPED		0x50
+#define  YT921X_MIB_DATA_TX_BROADCAST		0x54
+#define  YT921X_MIB_DATA_TX_PAUSE		0x58
+#define  YT921X_MIB_DATA_TX_MULTICAST		0x5c
+
+#define  YT921X_MIB_DATA_TX_UNDERSIZE_ERR	0x60
+#define  YT921X_MIB_DATA_TX_PKT_SZ_64		0x64
+#define  YT921X_MIB_DATA_TX_PKT_SZ_65_TO_127	0x68
+#define  YT921X_MIB_DATA_TX_PKT_SZ_128_TO_255	0x6c
+
+#define  YT921X_MIB_DATA_TX_PKT_SZ_256_TO_511	0x70
+#define  YT921X_MIB_DATA_TX_PKT_SZ_512_TO_1023	0x74
+#define  YT921X_MIB_DATA_TX_PKT_SZ_1024_TO_1518	0x78
+#define  YT921X_MIB_DATA_TX_PKT_SZ_1519_TO_MAX	0x7c
+
+/* 0x80: unused */
+#define  YT921X_MIB_DATA_TX_GOOD_BYTES		0x84
+/* 0x88: 64 bytes */
+#define  YT921X_MIB_DATA_TX_COLLISION		0x8c
+
+#define  YT921X_MIB_DATA_TX_EXCESSIVE_COLLISION	0x90
+#define  YT921X_MIB_DATA_TX_MULTIPLE_COLLISION	0x94
+#define  YT921X_MIB_DATA_TX_SINGLE_COLLISION	0x98
+#define  YT921X_MIB_DATA_TX_PKT			0x9c
+
+#define  YT921X_MIB_DATA_TX_DEFERRED		0xa0
+#define  YT921X_MIB_DATA_TX_LATE_COLLISION	0xa4
+#define  YT921X_MIB_DATA_RX_OAM			0xa8
+#define  YT921X_MIB_DATA_TX_OAM			0xac
+
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
+void yt921x_mib_poll(struct work_struct *work);
+void
+yt921x_dsa_get_strings(struct dsa_switch *ds, int port, u32 stringset,
+		       uint8_t *data);
+void
+yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data);
+int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset);
+void
+yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
+			     struct ethtool_eth_mac_stats *mac_stats);
+void
+yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
+			      struct ethtool_eth_ctrl_stats *ctrl_stats);
+void
+yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
+			  struct ethtool_rmon_stats *rmon_stats,
+			  const struct ethtool_rmon_hist_range **ranges);
+void
+yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
+		       struct rtnl_link_stats64 *stats);
+void
+yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
+			   struct ethtool_pause_stats *pause_stats);
+
+#endif
-- 
2.53.0

