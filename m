Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E450AC14
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539486; cv=none; b=QNDpWY9BAJO5RY1ZWL07MXc2Ssyc/FeBhhXu+DaCj4Zyl4td5FwDX9XoJYVMgdDMGQlCRzTH2ZjliKfpalcWXXu7x1FKgIK0TikfHQDyIIxPKy8xaE1hJIvvv+j3McQuLQVDL7Ur5q2dTovNbZjjGQR5kkCDRJ2EkdjXmG5IIyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539486; c=relaxed/simple;
	bh=h2Bg8T4+bwTo3agItf9Pq+cGyjUAYAXOx+KCR2ysFhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRdNPZy9zTJdurhjMbTiozdx/Lg/uRGUw1hnzEFDy56WBIG3JYqq3ZtpgjqYSipwJindQYAQs57ReiPU0xLo3eTOuzZcoHHD93XHRQWlhL6BKlN6pfFGM5GMQQhzGLAU/0FCNkiYKOX/bUrzDIjMPsIe23k7F1ik9TJz823x9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju+nfzXD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju+nfzXD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso956617a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788539483; x=1789144283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCkRuirMIy2dg12kFXX5FXk2nrjUCv9nerEL84PWiVc=;
        b=ju+nfzXDOyZ3cpI+u769sfpUkRPOjuEPpRX3OIH/OBvy7gUAMZ+Ex1w5SZzYyXxK9p
         vw/c2Iq2cjtzWPCZQJsSVBgp8mlA2pt+/Y6NpfzIiFMG/MfSmhpRcRKKkuVGUCYMgybK
         okyEAzG5x/qeR2w+F5akBHSS9/l5CThiIaR2Ic2cpPYQSVEBipjNYkxAnLNLgWocEQfN
         EImOgt83C8oimusPFXuPgU67zkLN4iTqAtci89LDRzLrkbSuvXG4LZYRyJ0GwsYeR42v
         eCyZtBoCl0cekLtUMHU66COTAwX89mWlJwMBt07P440/iIe3I1ZTgX7xU4AE2atcPUId
         yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539483; x=1789144283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCkRuirMIy2dg12kFXX5FXk2nrjUCv9nerEL84PWiVc=;
        b=e97kJmMq2gQuZPF1sy1MM0THq3rtJWGxA+ywsOJyA+1+HVj/7wrpKHKUCGIJLUUGFw
         Gub5IXaIh6egRAWrxZ7ZHwRQ+Kf0/uatJXb8/Sty1B9G7C69rOpp/0zE9tQqH3eVNzOJ
         aCr3CcNkxBT8hY3R9cxra8RPPHEMgXWlXSHj8VozknGapm/N9EdjtNxcMwPFrZ/SqZ8H
         yl55ghNlrZRQjqNZIQWzZUMzAlIsplcGTjSkuRSj2ynhKDMvMC8wMEOoptCA2grSn6aH
         pb2Qut8hR0gd3UidfT59N3FfUFKCAisDuAg0NFd8+W8EznqnF8ucsqkcFNjO4yk9WDML
         F5sw==
X-Gm-Message-State: AFuF++kCGwf+yHcmF0bmFnd1sJAaW5TwK8sps2eGjROKKZrn89Henkmd
	epMcpDSG9so2lYrbzSKyNi+3KSe8mK+rkvq1qoFF0Xj/CY54RDvVG7MMiyvaeEgn
X-Gm-Gg: AYBFou1+qEeUNFI2kIvWtJJnrmQBSA6bbLQlUJrY9a5inO/XujukqOFPvoXlajcypRz
	A/sKVJ8LdWQF9u3r43nfdg9//1EnfJQeyFD6arl50c8C9ZkYLnS4HlpHOJveyXTBKn9VYYekAol
	N4F7bGb+51m6EBY4MS0SLguPsREOQgXdfL586jy1Ug/igolgjSp54vz5pekz3YpVzdKXeRPPydq
	74IaMrCVgZyWqdSHSvJS1EQ+Lsxwp9yRWR4hUxRDs+i5N5Iw2HoGwlRQG2qGiOBdufRP8/IBAoo
	rrjSskhDOUjaY86vXafr+D3OXu65CZGDkz4pOYMNXIvJx9EC+JNb8OGhEMxde+XoqoxpvDnYNqI
	74dVIO/l7C48pWnQJ88zyknnOcOMyAqnNGzOcTQpx4e60vAFEQYH6R4vUKNv383rrpb1JCzq0j8
	ltfK85t4Beue7eLG83uXU7DA/Gtg2ToYKXockuzNzaMXHSyYiCQxPcdIiJGUbk3IbePAKJthZga
	IdFnm3GHkIfWW0=
X-Received: by 2002:a17:90b:2681:b0:38f:5801:dc0e with SMTP id 98e67ed59e1d1-39b261d52a4mr10220549a91.15.1788539483303;
        Fri, 04 Sep 2026 09:31:23 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3050::4d0:46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25c974cfsm5383010a91.0.2026.09.04.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:31:22 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/6] net: dsa: motorcomm: Fix MIB synchronization
Date: Sat,  5 Sep 2026 00:29:47 +0800
Message-ID: <20260904162952.709368-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904162952.709368-1-mmyangfl@gmail.com>
References: <20260904162952.709368-1-mmyangfl@gmail.com>
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
index d8a564d83bad..31d86c3122c7 100644
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
 
 const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
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

