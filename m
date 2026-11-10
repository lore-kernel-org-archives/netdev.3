Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278929;
	b=AirTcqMacqKIw0S1/BXlnTA2p6pTvmwfSkUoMt7g2vDAqlrdJOgUTy3xbQ1RPh4RroT9
	 DT/dM/QYyIw1yg2WUJr1+NRo9d3lO/4ZXTgSNgC9CYKg+GZzmstwlInmlOizhIIU/Mmhq
	 WHUjkgXJPeOlxvCnMdmrBKec3qUX0Hq5QmG2zVmifXSSwIqATinCWqgMsS19CQn9dmdqP
	 lCOsVCkhsX46knV6Lg00TpcJdpL7rSgqZF6dLNeIEgNcDpSpReGTXQe+0W9ppAY28Fo5J
	 IfocWoNIPaFZg+/3njSOn0/nKR8klA7iJYDtaeiFnzAh54SzYfZSuS2fNIhY0+6HuVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=y0Fz9ShYecGTn8SKj3+Bcbc2etgMXSFmyWIWKqoeVAM=;
	b=sdX2m6qA1CH1FZ+kJP26Vu9SXAtHAu9GEJm4hmwe4lgmwZXZCtXTY6BaiDEOhlulfdgM
	 wojlPfQa7FVNGJH6ulBQqSSz46SbfOrNcokimhK5Z7P+xGSaOQT/Hh3K9haL7P18kqNEN
	 PblnT/U605qT9jvJ+ds9D5ox9Z7Nt9AWUwf2qgKVHUqeOysQJjPzC9p80cwxt40B2hjOY
	 PrjIrUB2Qh4/+YS7zHrVMJO88TRtJ0PLHqnLl4TxKz5Lc5Xg3p1KvNmxFTbfolrWg4YC8
	 58FcbmsKb2yAf7247MSJDO1zloIhY7KCrr+4mygDAkE57cjkjk1yg4cSuqaDAPWY9IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKRXevz2;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDE60A2618
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DDE60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKRXevz2
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4d198f1a591so850298b6e.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 18:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278927; x=1794883727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y0Fz9ShYecGTn8SKj3+Bcbc2etgMXSFmyWIWKqoeVAM=;
        b=jKRXevz2ifjYIrEFRKabCSg2CAWNpI+CpMisTezHO+mKGgsQtQS3HP58VAnv9M+Ycx
         MGQ4iGcFYo/NbbbMHZ5y/Wgcd8zB7yzshILt418pX6JuehW+hDJpbx5A+/PHEOwB3QxX
         m75nli7HpldOBsk6CVzA9t/J/WQlA+E4Zlw54SVf5tke+Gqe69MrJ2J8fdnMmaUbLkmg
         06MVJlVUxXm0fG1AeyZ+9FRLnLIvcrWp/3kj6P93+nWsKIbA/hUmlmJ/qBFX4ebjEJY0
         g9Q3ckURUtXLFg5CvDT6bqGScIKmFICGjYwK4WLuivIyaM3cBuTUr2p2jvthDWep9XYx
         UpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278927; x=1794883727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0Fz9ShYecGTn8SKj3+Bcbc2etgMXSFmyWIWKqoeVAM=;
        b=COjzJ+/LhOSkwW+YFDHHrr9vJSh5dchcxzC5NkijsrfVLLzA3cuOe+x3sk+U+0FqVR
         pUzntvA+GwAlLNr6us+sqZbJ4gpcf+TMFpSEyti066vA6BoTeeybKaJ1jWlK+SZrefS6
         e6Z0Nz9+cNjmaXYpMpgA3WoIoOUolGWB1nZzCpNYYf+buqdumoCFPbFzNVG5tvM/X7OX
         FSAFYq0Xw3F4w9XgNfin7H1uvABzNu7amSc0KKQKElXmJ1VIYJS6WLBL9mHhJneAsYUY
         4pw1yhF/qpKx4GeRu9T7AbEbmKxEfyTU/Wm5Dj/XhFHJjUPEf6Fh1v1W2Ax2bbbt2qJZ
         eyjw==
X-Forwarded-Encrypted: i=1; AL+hErHUPdNPu/gONI51uJEsZNK7xFID8DjUDW7xrSSuGyZjwfO50W5hwuGcHM+bbU/pzNh5/UIxm8I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WBEAMrTtZ876TmfLCJwvfbYkj5TA/TGeiN5qptl2kNVQcqsfF
	ql4aenOHDtx6eAXPgHEYEWcoPMaunxGev465ERYBZnH/UGnEQ4sZpl0I
X-Gm-Gg: AYBFou30Qbk5/m1Mkru/EJuQvGndzaFn9KztB76ZyqFZjTvvX9uHSL0exclddWeuCnK
	I9BO4OjkWMxClDcv3CgSqKD4BG+XzuWVMP+y+n5FMHO0vZL0MaXdSjHZj/Eruui5pQSXvO79hXq
	wpiDJEZwsCK5CFzTE5DzBuf23b3ug8s1yFLRE+dQm2et2R17+W3dJkI4OWs3yQbo2tVxE4K0+kw
	wzgCaEuQRwQ4ONnXZsjUlPqJt4DkBpKp5pTLh1M7fcVDJzuvxk/KW2AsbDlBdsd6BObc6aO4Zrb
	K2MH1GgTaPgqvon7JNDsqzwcahMJctU1BQRDO/lQZ2lYnY2LQ/ae3L9eIYbFxAogPS0VCq+Jgch
	Uunf/zeC2WK1wtBTgqXxpIF0MJWDxnkwKYQKIXdLvHMBadP/EBqA56cJeVtzY33Z7elG0JShl1Y
	czSyvxJgLeZofyH6lKK8cT1/YLWECbg6qP2cywEXbGhyavweUHBkbTcZYNawMyfqweknnFxg+a6
	xpBVKJtYT7WKkWlVElMzlN1k+hQ4VS8R37IfUGiWdTBhUnox0hG2KQ92opsLbHTGQRKwMV4NhjO
	QZtL8FRXNBisAPJIo02Irm/7JBCGpt9YFZOQ4kYIJaAFK5Oi3CmFR2YXrqBX1y8xs9AhIE1UTMv
	uGoIZwV/a9JQ7ZXzcS/upOs8mL5TLeFhWDGY4AdtWpvx1TqIkR7xyS6Dmnc3WJsRXv8pb6iyzd0
	NTT3jOE4j5pqjVMll94z/VfpNSGL60UJRjx1eyKZmLcan3GI48gSEu
X-Received: by 2002:a05:6808:f0b:b0:4e8:18ee:eb4d with SMTP id 5614622812f47-5683ccd9f0emr1285378b6e.20.1794278927211;
        Mon, 09 Nov 2026 18:48:47 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f39c60sm943233b6e.14.2026.11.09.18.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:48:46 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 19:48:33 -0700
Subject: [PATCH net-next v3 2/3] net: phy: acx00: report receive statistics
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-submit-acx00-phy-stats-v1-v3-2-fbc6327c5be4@gmail.com>
References: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
In-Reply-To: <20261109-submit-acx00-phy-stats-v1-v3-0-fbc6327c5be4@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Expose receive frame and byte totals through the generic PHY statistics
interface as rx_packets_total and rx_bytes_total, alongside CRC errors in
rx_errors. The packet and byte counters include errored frames as well as
successfully received traffic, so leave the successful-only fields unset.

Collect the free-running 32-bit counters through phylib's update_stats
callback and accumulate wrap-safe deltas in 64-bit totals. AC300 hardware
measurements established a receive-byte modulus of 4,000,000,000, while
the packet and CRC-error counters wrap at 2^32. Reject byte samples at or
above the byte modulus before updating either the baseline or the totals.

Read the high half on either side of the low half to detect a carry.
Limit each counter to three attempts so persistent inconsistency cannot
retain the PHY, package-state and MDIO locks indefinitely. Skip an
unstable snapshot and retry on the next poll: reporting a synthetic
error through update_stats would make phylib take the link down.
Keep incomplete samples distinct from MDIO errors so page-restoration
failures still propagate.

Serialize collection and reporting with the package-state mutex so reads
cannot race reset or power-off, and the totals are safe on 32-bit systems.
Commit a snapshot only after all counter reads, validation and page
restoration succeed. The reporting callback returns cached totals without
accessing MDIO.

Take a best-effort final snapshot before soft reset and suspend. Invalidate
the hardware baseline before reset or power-off, including failed power-off
attempts, and establish a fresh baseline after configuration. Preserve the
software totals across these transitions and retain the live baseline when
resume reconfigures an already active PHY. An unusable initial snapshot can
be retried by the periodic collector without preventing initialization.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/xpowers/acx00.c | 168 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
index d19ba6d8069a..9ab98f617444 100644
--- a/drivers/net/phy/xpowers/acx00.c
+++ b/drivers/net/phy/xpowers/acx00.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
@@ -31,6 +32,7 @@
 #define ACX00_PAGE_2				2
 #define ACX00_PAGE_6				6
 #define ACX00_PAGE_8				8
+#define ACX00_PAGE_9				9
 
 #define ACX00_PAGE0_GLOBAL_CONFIG_REG		0x13
 #define ACX00_PAGE0_XMII_RX_CLOCK_INVERT	BIT(12)
@@ -76,6 +78,30 @@
 	(ACX00_PAGE8_AUTO_CAL_TX_LEVEL_ADJUST_BYPASS | \
 	 ACX00_PAGE8_AUTO_CAL_LOW_CAL_OPAQUE_BITS)
 
+#define ACX00_PAGE9_RX_BYTES_HIGH_REG		0x19
+#define ACX00_PAGE9_RX_PACKETS_HIGH_REG		0x1b
+#define ACX00_PAGE9_RX_CRC_ERRORS_HIGH_REG	0x1d
+
+/*
+ * AC300 hardware testing confirmed that the receive byte counter wraps at
+ * 4,000,000,000 rather than 2^32.
+ */
+#define ACX00_RX_BYTES_WRAP			4000000000ULL
+#define ACX00_COUNTER_READ_ATTEMPTS		3
+
+enum acx00_ephy_stat {
+	ACX00_STAT_RX_BYTES,
+	ACX00_STAT_RX_PACKETS,
+	ACX00_STAT_RX_CRC_ERRORS,
+	ACX00_NUM_STATS,
+};
+
+static const u8 acx00_ephy_stat_regs[ACX00_NUM_STATS] = {
+	[ACX00_STAT_RX_BYTES] = ACX00_PAGE9_RX_BYTES_HIGH_REG,
+	[ACX00_STAT_RX_PACKETS] = ACX00_PAGE9_RX_PACKETS_HIGH_REG,
+	[ACX00_STAT_RX_CRC_ERRORS] = ACX00_PAGE9_RX_CRC_ERRORS_HIGH_REG,
+};
+
 /*
  * Another integration of this exact-ID PHY documents its digital vendor
  * register map, which also matches the observed ACx00 reset values. The ACx00
@@ -86,11 +112,15 @@
 struct acx00_ephy_priv {
 	struct phy_device *phydev;
 	struct acx00_ephy_control *control;
-	/* Serializes package state and multi-register power sequences. */
+	/* Serializes package state, power sequences and statistics. */
 	struct mutex state_lock;
 	bool is_ac300;
 	bool use_low_calibration_tuning;
 	bool xmii_rx_clock_inverted;
+	bool stats_active;
+	bool stats_valid;
+	u32 stats_last[ACX00_NUM_STATS];
+	u64 stats[ACX00_NUM_STATS];
 };
 
 static int acx00_ephy_read_page(struct phy_device *phydev)
@@ -110,6 +140,115 @@ static int acx00_ephy_write_page(struct phy_device *phydev, int page)
 			   FIELD_PREP(ACX00_PAGE_SELECT_MASK, page));
 }
 
+/* Return 0 on success, 1 for an unstable sample, or a negative MDIO error. */
+static int acx00_ephy_read_counter(struct phy_device *phydev, u8 reg, u32 *count)
+{
+	int high, low, check;
+	int i;
+
+	/* The free-running counter can carry while its two halves are read. */
+	for (i = 0; i < ACX00_COUNTER_READ_ATTEMPTS; i++) {
+		high = __phy_read(phydev, reg);
+		if (high < 0)
+			return high;
+		low = __phy_read(phydev, reg + 1);
+		if (low < 0)
+			return low;
+		check = __phy_read(phydev, reg);
+		if (check < 0)
+			return check;
+		if (high != check)
+			continue;
+
+		*count = (u32)high << 16 | low;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int __acx00_ephy_update_stats(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+	u32 counts[ACX00_NUM_STATS];
+	int oldpage;
+	int ret;
+	int i;
+
+	lockdep_assert_held(&priv->state_lock);
+
+	if (!priv->stats_active)
+		return 0;
+
+	oldpage = phy_select_page(phydev, ACX00_PAGE_9);
+	if (oldpage < 0)
+		return phy_restore_page(phydev, oldpage, oldpage);
+
+	for (i = 0; i < ACX00_NUM_STATS; i++) {
+		ret = acx00_ephy_read_counter(phydev, acx00_ephy_stat_regs[i],
+					      &counts[i]);
+		if (ret)
+			break;
+	}
+	ret = phy_restore_page(phydev, oldpage, ret);
+	if (ret < 0)
+		return ret;
+
+	/* Skip unusable samples without turning a statistics miss into a link error. */
+	if (ret || counts[ACX00_STAT_RX_BYTES] >= ACX00_RX_BYTES_WRAP)
+		return 0;
+
+	for (i = 0; i < ACX00_NUM_STATS; i++) {
+		u64 count = counts[i];
+
+		if (priv->stats_valid) {
+			if (count < priv->stats_last[i])
+				count += i == ACX00_STAT_RX_BYTES ?
+					ACX00_RX_BYTES_WRAP : BIT_ULL(32);
+			priv->stats[i] += count - priv->stats_last[i];
+		}
+		priv->stats_last[i] = counts[i];
+	}
+	priv->stats_valid = true;
+
+	return 0;
+}
+
+static int acx00_ephy_update_stats(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+	int ret;
+
+	mutex_lock(&priv->state_lock);
+	ret = __acx00_ephy_update_stats(phydev);
+	mutex_unlock(&priv->state_lock);
+
+	return ret;
+}
+
+static void acx00_ephy_get_phy_stats(struct phy_device *phydev,
+				     struct ethtool_eth_phy_stats *eth_stats,
+				     struct ethtool_phy_stats *stats)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+
+	mutex_lock(&priv->state_lock);
+	stats->rx_packets_total = priv->stats[ACX00_STAT_RX_PACKETS];
+	stats->rx_bytes_total = priv->stats[ACX00_STAT_RX_BYTES];
+	stats->rx_errors = priv->stats[ACX00_STAT_RX_CRC_ERRORS];
+	mutex_unlock(&priv->state_lock);
+}
+
+static void acx00_ephy_snapshot_stats(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Statistics collection must not prevent reset or power management. */
+	ret = __acx00_ephy_update_stats(phydev);
+	if (ret)
+		phydev_dbg(phydev, "failed to snapshot statistics: %pe\n", ERR_PTR(ret));
+}
+
 static int acx00_ephy_control_power_on(struct acx00_ephy_priv *priv)
 {
 	lockdep_assert_held(&priv->state_lock);
@@ -122,6 +261,10 @@ static int acx00_ephy_control_power_off(struct acx00_ephy_priv *priv)
 {
 	lockdep_assert_held(&priv->state_lock);
 
+	/* Even a failed power-off can have reset the hardware counter. */
+	priv->stats_active = false;
+	priv->stats_valid = false;
+
 	return priv->control->power_off(priv->control);
 }
 
@@ -350,6 +493,10 @@ static int acx00_ephy_soft_reset(struct phy_device *phydev)
 
 	mutex_lock(&priv->state_lock);
 
+	acx00_ephy_snapshot_stats(phydev);
+	priv->stats_active = false;
+	priv->stats_valid = false;
+
 	ret = acx00_ephy_set_interface(phydev);
 	if (ret)
 		goto out_power_off;
@@ -475,10 +622,21 @@ static int __acx00_ephy_config_init(struct phy_device *phydev)
 
 	/* Restore the standard EEE policy retained by phylib across resets. */
 	ret = genphy_c45_an_config_eee_aneg(phydev);
-	if (ret <= 0)
+	if (ret < 0)
 		return ret;
+	if (ret > 0) {
+		ret = genphy_restart_aneg(phydev);
+		if (ret)
+			return ret;
+	}
 
-	return genphy_restart_aneg(phydev);
+	if (!priv->stats_active) {
+		/* Establish a new baseline after reset, retaining the software total. */
+		priv->stats_active = true;
+		acx00_ephy_snapshot_stats(phydev);
+	}
+
+	return 0;
 }
 
 static int acx00_ephy_config_init(struct phy_device *phydev)
@@ -550,6 +708,8 @@ static int acx00_ephy_suspend(struct phy_device *phydev)
 	mutex_lock(&phydev->lock);
 	mutex_lock(&priv->state_lock);
 
+	acx00_ephy_snapshot_stats(phydev);
+
 	ret = genphy_suspend(phydev);
 	if (ret)
 		goto out_unlock;
@@ -616,6 +776,8 @@ static struct phy_driver acx00_ephy_driver[] = {
 		.soft_reset = acx00_ephy_soft_reset,
 		.config_init = acx00_ephy_config_init,
 		.disable_autonomous_eee = acx00_ephy_disable_autonomous_eee,
+		.get_phy_stats = acx00_ephy_get_phy_stats,
+		.update_stats = acx00_ephy_update_stats,
 		.suspend = acx00_ephy_suspend,
 		.resume = acx00_ephy_resume,
 	},

-- 
2.53.0

