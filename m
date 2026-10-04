Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED63BAD95
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130014; cv=none; b=oE9SjUE05iGQx7nv5Aad6lY8h74zNtZDbpB9268SCyUZWj53PQ8kDzBs8stlR/MHZsZpdxxVd08A2XN4SDc2CR5wfpxFDGKpIh6+sCgvU4CAb0Duj6H2I20CRqw8DF0fRVbFREXm5pPMUFRKjdiM8VEB20KzoWbPMFYK8TyuXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130014; c=relaxed/simple;
	bh=f9eve82AUhVa6cIECa80q5v0NYh+EyqZNvxmP33719Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqgUAY6BklXPJq4kwfwcuuaccAHbK0V16eVMFsUs0Q4RxUfFTx2atIPVY8jLeQPSsoKqh0dJ0wlJr/qMsPwZrzJRv8BDDTzSk4BlO1VMUcAxwlgw2gjRUV1y62FcKxZ4Pxgv8mPbzuqxHTt6YtkYI9flT9WLPS7ndr+CEvNgHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnjxoTSo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnjxoTSo"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-873a4edb243so738427b3a.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791130010; x=1791734810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYByjftfoWirUzA2hcju+/blIiCv2wNpTVehTw9Qd9g=;
        b=OnjxoTSoGjudVGSk8CXdbu3mfhBDtd9iqPAdq09IFWOc615wlztDclPrZlQYHFTko3
         wPPGtrxldCi0hw6f1WRYsyHhWq88LwY8hrh4TNTCiT86YCQsh8RM6Rm9aBZArnauioPP
         mNLkACDjMNnbxdod3Xi7NDgKSRoWknoFEblvIGVGjbCa7aWTsqDRzrvKDPsdvR8sEXKR
         ysWr0f/lRalENW+8cMg7MgIMpX2zWyFEW/lTm/nO/2rNyaKRhTqlhwovkKqy9k0UV0UF
         /yTkXZTSwmrunrkRQkGV5HSnEyIWHz91IfTqTvOwG76WfGyjOnfEEnT0UqcZD6GdkKh3
         8yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791130010; x=1791734810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYByjftfoWirUzA2hcju+/blIiCv2wNpTVehTw9Qd9g=;
        b=NIwauh+eZzilixL6/U5XmNCV9twLUKQdrt1hrD5PFM1+tPUMHrlGZy7wXFIx1KAkNG
         cHfwM+R4ZWpeDSFWL72Rq5QUZFpzYxHiirqdbFC4zeN44MNZWcCBR04SL8A1wLddIgAZ
         ZOdutpjKFdXPEqEU3naJWu2GTOsiGhQUOECkZPcOkioqc4mjp51yKz5agfco+oBG76Cz
         67L8dmyTwB3RDVfMgu0W5w6Xtrrz5s0swPsb/ciNYRS0lIHAbZ5+V3lO/x7I5m0FcSBD
         TfkeIQrmJOJVQjowZMe5VrTmKQLj+qOXtgvysM7ri8/a4kqZGWKIWAWlvFQfFutBsAGp
         jgAg==
X-Gm-Message-State: AFuF++lWu88GCpVFxEb3vrjTDfpxPu42z+1hOxZZer7y4JMf/MHjpXrC
	1QWO3grzdkFiL2i7LWNrbJ2Lojd8pK1oe4lrTgznYGnb3gWSs12zjH9Bg1wg9ibz20Q=
X-Gm-Gg: AYBFou2YiAvY33eZNJu2U/U6vsRnUS8jeT9XIavZlWswnvpg3O6t3ZwCzg8KIypL+Cf
	bQyRaiPFom5D8Get94MKyDbYVksYMiairTFQHF0pND95j5zcVOc1ENOjq4w03pu7NI5oa9IBths
	ABKwsdzWw2ZKjPHNqnb55FHioBD+ti8xT+HMp7vZB2xKPa4JsevH8wEPUgCgTnQamXCsaXeERaf
	2SbvtBRX98TN3ajB/Ddg7+SYChMWZ/aPci7Q7Zh5Lco7C+BxG9q33PSgUktj8Pn45v4PoWS2uCS
	ZHc0mX08p/11V92nhg4TIRFjrRDT6lHQhunmad/+op0f29uy9aAW/VqNLiXiS1gJUk0fctMO4rz
	qBN55EON1bx2Lxlzp1pzIdJROsuiBKrC1iCCXHtCNz5wGoEfnDOE/ARCi1NOkZZfjZP+yqUlbQa
	Ml0VhPE4hlya395nLSx/bVSywIJwzyfVsIOAz50bwQbKYt0IOCeKRaXWCrYVd1OAAh0W+tQF3Xc
	tmFUtW9yVuxCbAM6LIe7rNXgQ==
X-Received: by 2002:a05:6a00:4c87:b0:881:a5b6:7954 with SMTP id d2e1a72fcca58-88c64739f47mr4493508b3a.39.1791130009739;
        Sun, 04 Oct 2026 09:06:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2637789b3a.54.2026.10.04.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:06:49 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/6] net: dsa: motorcomm: Split MIB module
Date: Mon,  5 Oct 2026 00:06:18 +0800
Message-ID: <20261004160622.948037-5-mmyangfl@gmail.com>
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

yt922x is going to use a different MIB scheme, split it to reduce the
length of chip.c.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/Makefile |   1 +
 drivers/net/dsa/motorcomm/chip.c   | 397 +---------------------------
 drivers/net/dsa/motorcomm/chip.h   | 124 ---------
 drivers/net/dsa/motorcomm/mib.c    | 404 +++++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/mib.h    | 159 ++++++++++++
 5 files changed, 565 insertions(+), 520 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mib.c
 create mode 100644 drivers/net/dsa/motorcomm/mib.h

diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index 1d2c1b3064c4..9c1e3d538d21 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
 yt921x-objs := chip.o
 yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
 yt921x-objs += mdio_bus.o
+yt921x-objs += mib.o
 yt921x-objs += pcs-921x.o
 yt921x-objs += smi.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 8341d4d1c784..9e3be08b3465 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -28,76 +28,10 @@
 #include "chip.h"
 #include "leds.h"
 #include "mdio_bus.h"
+#include "mib.h"
 #include "pcs.h"
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
 static const struct yt921x_info yt921x_infos[] = {
 	{
 		"YT9215SC", YT9215_MAJOR, 1, 0,
@@ -146,14 +80,6 @@ static const struct yt921x_info yt921x_infos[] = {
 
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
@@ -265,327 +191,6 @@ static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
 
 /* TODO: SPI/I2C */
 
-/* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
-static int yt921x_mib_read(struct yt921x_priv *priv, int port)
-{
-	struct device *dev = yt921x_priv_to_device(priv);
-	struct yt921x_port *pp = &priv->ports[port];
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
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
-	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
index d1764b635630..25ff77054de3 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -163,69 +163,6 @@ enum yt921x_speed {
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
@@ -833,67 +770,6 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_NAME	"yt921x"
 
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
index 000000000000..fd634c8e2c04
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/mib.c
@@ -0,0 +1,404 @@
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
+/* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
+static int yt921x_mib_read(struct yt921x_priv *priv, int port)
+{
+	struct device *dev = yt921x_priv_to_device(priv);
+	struct yt921x_port *pp = &priv->ports[port];
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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

