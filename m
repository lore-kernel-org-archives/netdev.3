Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792931744;
	b=qajYusmF7FbqFGCQNqpoa9+Nfn3Z4RSEpeWSPqZXiY1n5vVzOnDN/m+urz89PCiK3dKs
	 T62mRKd1XiZ9MDPjk89WuxT0qTNrocAvaHkiRsNp9BFN+x1nNt74vTfNnrnFen8T4dXCT
	 RJyxoIiRCgyTZnjQ6/vzpDeegffDjxTHi0xSut7lrQHn6b+A+b4/MY6QRBnkwLDBtU0cv
	 3XQgDxyxz1Fxsf85thBrBqpY3Io33MqeBnuLifEUaNOMUVfDvSnNNL7IUMvqlKgSq5Afn
	 NIXcRniJhc/gQLPYcZLKWJRwc2016+yB/cBB2MlreuRtEy/EIFF/LlBVDKPJ68l5Jzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=9/A+575MKRk7GA5uUGQCk986GQEMOzFS8Mn/MJQXXRo=;
	b=NWz0qjngA/qC1m6S5F7LOs4N2rkFrabn7z2R1E5FQ7bNRbZRdQNfuSwVovn2w9ftRT9R
	 ypcXhShwrxgIn87imGRBBKcXI0BInDm2RJS1Xj2EZPZDa45Rb9Z0UIFaX7QzFzSARJHJq
	 NZvmFqVvKiknX84i5bPoQoJ6UmTVS0Im21p96ieYigHHAB2plpGrDrdy/gBJN5qfU1Pid
	 1gybARRp2/t/qztF8ktiUxYqqgwjWWx8rni33qs1dRrsvnIFIiCkVptdnA0YHJb6F/IUc
	 /ILnKhSbunOrZyRqXSQJO//lkGHnGp/odUpV/Hbm4Guyx3h1HLwzXzzl1w6/AM43Q8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tobzealy;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0173D606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 12:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0173D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tobzealy
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-823e4047037so1760983a34.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792931743; x=1793536543; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9/A+575MKRk7GA5uUGQCk986GQEMOzFS8Mn/MJQXXRo=;
        b=TobzealyoKc+QExgkY3TCVSTk5jug3m2cY9Y235nTo3Puld9D/WjC2EDwo0NxU4J2u
         YH4v81J7ScG69QWmERv4SbnrWdMNt9dW8ZJ2NFIKObtAQwOhTR7/TVoPQDHR63qICDut
         lO0Iz0ci3bjZ8vb2RhkV3dVfppRf3R6ziFDbwV7irlFUI8trMO/EzViwRLveGusYD0ec
         xMHGpI/6l2LXk2Ndamwu3hC8HwR8CQXs5VVjcdx621FXr8YHR5d1j793dWj2MXBJ/JtL
         GCjbCs9haGaCaT1CKON56IZLJ65+81kPm6R8oW2cQiPHMvlfzMp8INi2Uyx/ipdZYSBF
         G6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792931743; x=1793536543;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9/A+575MKRk7GA5uUGQCk986GQEMOzFS8Mn/MJQXXRo=;
        b=OSRNYriYst87W2mktF69ME+VYtG6IvAqGEwBk6U1e6BJ+U9H4SDJ6cVCbDcoVviD0K
         2FdEWXBZNEDACjLSvCpj8TFCd9nnS1bm9Rk2Aq/pKEKag40f7j2iXGcfWcAeUl+6SDE9
         bYlTDA1yO07QqbSw09RVZcm0uczmrHcvCjnEjBI+jvc+9GwtVgLlS6uiLBthxCw1Njod
         yKZpMJ5aZ5ygVhMG4p4tHwTbUXVoaqK9zD/Wo3kUJOun9xQQEkyKMIoQD38551r+w8fT
         f68AKNHBhUiisgFgS3A0XvkRZJF51yLYJ0ATg4r5cHzkxkhXfwCDW63NPVv7SvU04McD
         VHAw==
X-Gm-Message-State: AFq9FYLYGvaVrSZ97MZco8he5p3N2tRKewUcdOivaaaaQ/J4wRlwQ3pm
	WzuxjO2nWDWMpUzen9gyznWiJY829ZCk3mkht6DZLCI66QWrz7dEoSE5
X-Gm-Gg: AYBFou27SvafodcBeSfK8qhDNtcnKaoLxoQD10g/rH8hkexUkEguIUPojvPmbm5ktRW
	N42WQnNv8rgL6fUdi7/8apNMDnmbA4TcAku81nelaQ3v95XQ4r8H324QvM9+odNLRDWEHfWQIKf
	fb0yPAPh1KIHGbBXCGn7iaunFEpK7cDWgMXdqfE+cVWn/yNy0wjYSOW6w6fqB7ffK4irmTcdCL1
	aBC1bKN8OXU6oV45m4LYtyijibHT8O3JVzjSnMIT9EBrko6zMTS0uLqI7z1/sOTI2CmF10EXT63
	0pxX1s1qUPNV5LfYJ23vuq5xAQlns7JH77+aVj5XHg8gvXEnGw6CQWFzfFg/cFJxcjpMRJPjPPc
	c0pw2R34TdjePLEPghuFEQk1kotk2npFVGrrhBeNgD9GakWPiKCL2s/+8eZg5eRbNRy6OAplcnv
	W+3Wi51iHMxNWiSFvh/NNL7/scCSBxLysAvQ36KGVXeqxENWkwSJ13qp8UbTr+eAmpFPD/I9VIx
	65t877ZeZ1LHv8tWB0Qhf2BpZupnjSzRKHmcTYIQIZbgYAyYrEAPasCOM7OB56808CffeXfZJMU
	nFNGlYb0V717ZjhrwYdz7yIRt+6I3hg7baC/3e/p4BRLU+LqAKdy31MHCgFC19G5SYSW4vTv4tH
	NcnhE+fHquSfxq4cgGunNnzPw8qZEmwhbUVtCKoYv3ciYgKp2AsL+zQRemijccxRnwIIFC/15yQ
	Wbi8iCW2tqmPG6KzS4BJAGGGA=
X-Received: by 2002:a05:6830:441e:b0:81f:827a:b1cf with SMTP id 46e09a7af769-850ff0a53d1mr3579687a34.22.1792931742819;
        Sun, 25 Oct 2026 05:35:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0749cfsm5095788a34.9.2026.10.25.05.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 05:35:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 25 Oct 2026 06:35:17 -0600
Subject: [PATCH net-next] net: phy: acx00: report receive statistics
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
Message-Id: <20261025-submit-acx00-phy-stats-v1-v1-1-d3d461e46db0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMwQ6CMBBEf4Xs2Y2lNkL8FeOhLYtdEyrpVoIh/
 LutxuPMvHkbCCUmgUuzQaKFhZ+xhPbQgA823gl5KBm00udWaYPychNntH5VCufwRsk2Cy4tDv2
 pH7vOGEM9lP+caOT1675CpIyR1gy331I0D/K5qivrrBC6ZKMPtfrTx8lyhH3/AMf3bBanAAAA
X-Change-ID: 20261024-submit-acx00-phy-stats-v1-d838f77444e8
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Expose receive frame and byte totals through the generic PHY statistics
interface as rx_packets and rx_bytes, alongside CRC errors in rx_errors.
Report the hardware totals directly: the packet and byte counters include
errored frames as well as successfully received traffic.

Collect the free-running 32-bit counters through phylib's
update_stats callback and accumulate wrap-safe deltas in 64-bit totals.
Read the high half on either side of the low half and retry until both
high-half reads agree.

Hardware testing confirmed that the receive-byte counter wraps at
4,000,000,000, while the receive-packet and CRC-error counters wrap at
2^32. Use the corresponding modulus for each counter so rollover does
not inflate the software totals.

Serialize collection and reporting with the package-state mutex so reads
cannot race reset or power-off, and the totals are safe on 32-bit systems.
Commit a sample only after all counter reads and page restoration succeed.
The reporting callback returns cached totals without accessing MDIO.

Take a best-effort final snapshot before soft reset and suspend. Invalidate
the hardware baseline before reset or power-off, including failed power-off
attempts, and establish a fresh baseline after configuration. Preserve the
software totals across these transitions and retain the live baseline when
resume reconfigures an already active PHY. A failed initial snapshot can be
retried by the periodic collector without preventing initialization.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/xpowers/acx00.c | 157 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
index d19ba6d8069a..1375784d2837 100644
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
@@ -76,6 +78,29 @@
 	(ACX00_PAGE8_AUTO_CAL_TX_LEVEL_ADJUST_BYPASS | \
 	 ACX00_PAGE8_AUTO_CAL_LOW_CAL_OPAQUE_BITS)
 
+#define ACX00_PAGE9_RX_BYTES_HIGH_REG		0x19
+#define ACX00_PAGE9_RX_PACKETS_HIGH_REG		0x1b
+#define ACX00_PAGE9_RX_CRC_ERRORS_HIGH_REG	0x1d
+
+/*
+ * Hardware testing confirmed that the receive byte counter wraps at
+ * 4,000,000,000 rather than 2^32.
+ */
+#define ACX00_RX_BYTES_WRAP			4000000000ULL
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
@@ -86,11 +111,15 @@
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
@@ -110,6 +139,105 @@ static int acx00_ephy_write_page(struct phy_device *phydev, int page)
 			   FIELD_PREP(ACX00_PAGE_SELECT_MASK, page));
 }
 
+static int acx00_ephy_read_counter(struct phy_device *phydev, u8 reg, u32 *count)
+{
+	int high, low, check;
+
+	/* The free-running counter can carry while its two halves are read. */
+	do {
+		high = __phy_read(phydev, reg);
+		if (high < 0)
+			return high;
+		low = __phy_read(phydev, reg + 1);
+		if (low < 0)
+			return low;
+		check = __phy_read(phydev, reg);
+		if (check < 0)
+			return check;
+	} while (high != check);
+
+	*count = (u32)high << 16 | low;
+	return 0;
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
+	if (ret)
+		return ret;
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
+	stats->rx_packets = priv->stats[ACX00_STAT_RX_PACKETS];
+	stats->rx_bytes = priv->stats[ACX00_STAT_RX_BYTES];
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
@@ -122,6 +250,10 @@ static int acx00_ephy_control_power_off(struct acx00_ephy_priv *priv)
 {
 	lockdep_assert_held(&priv->state_lock);
 
+	/* Even a failed power-off can have reset the hardware counter. */
+	priv->stats_active = false;
+	priv->stats_valid = false;
+
 	return priv->control->power_off(priv->control);
 }
 
@@ -350,6 +482,10 @@ static int acx00_ephy_soft_reset(struct phy_device *phydev)
 
 	mutex_lock(&priv->state_lock);
 
+	acx00_ephy_snapshot_stats(phydev);
+	priv->stats_active = false;
+	priv->stats_valid = false;
+
 	ret = acx00_ephy_set_interface(phydev);
 	if (ret)
 		goto out_power_off;
@@ -475,10 +611,21 @@ static int __acx00_ephy_config_init(struct phy_device *phydev)
 
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
@@ -550,6 +697,8 @@ static int acx00_ephy_suspend(struct phy_device *phydev)
 	mutex_lock(&phydev->lock);
 	mutex_lock(&priv->state_lock);
 
+	acx00_ephy_snapshot_stats(phydev);
+
 	ret = genphy_suspend(phydev);
 	if (ret)
 		goto out_unlock;
@@ -616,6 +765,8 @@ static struct phy_driver acx00_ephy_driver[] = {
 		.soft_reset = acx00_ephy_soft_reset,
 		.config_init = acx00_ephy_config_init,
 		.disable_autonomous_eee = acx00_ephy_disable_autonomous_eee,
+		.get_phy_stats = acx00_ephy_get_phy_stats,
+		.update_stats = acx00_ephy_update_stats,
 		.suspend = acx00_ephy_suspend,
 		.resume = acx00_ephy_resume,
 	},

---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261024-submit-acx00-phy-stats-v1-d838f77444e8

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

