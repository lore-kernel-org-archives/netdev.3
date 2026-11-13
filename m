Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590032;
	b=Oq7VQh7zgavSrrq8yAfR6P7CQMyOiYsDcAz6MM72IYVxXr72fklqUuWr9asnR0MK5qcv
	 kK8zBR9PA1LUw3McLIFVf2OKgCNSY4eJ2hDDlIoeNTO5n4AAl5T/dLBr2IKYi5KjAnmmO
	 Ds1zyGYs3e3ZqnXEHzH9gBPv4BXBctDA0c7cOqYeOMZ8+G2GRfavo9LZXL64OuaV0Nzjr
	 ROYKVWht0FV6Sy3MHS0V4mBkMLL9Da3T5D68xP4+WlgnjYfxN4FNXMjsji37ih3XD54P5
	 ms4pXQiC5gYgC3sauxrRoubgoJkaumRqJqN/oaF3yvERfBiDwo3bmSpScAEjwWXWcMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=IjsuiiTiR6xMqMwngFz60LZtzwpdR6j2h8dViSfDc6I=;
	b=HB4AH7WrXefWshKrwTslSTaPx2Q6HUWRN4/PlgBcd/hXyHrf9xfE1bRKfGUB0I6dlNYt
	 S9INObMcZwFD7JIZdUKREUC4Ocf6b4bie9mEf5lWkPgn/CZyty4p7sODeMQQ686Zu7OEe
	 5IdQB6deCIyPcq3A2AoLjRSf9q/1cw6+b9vh/OJW2Fn6NfYBdx5vVMoVt1mjA3Cjto2W1
	 Wf8YXtEv+VDEzUZoS7HynOJXBY73DdiAyzmEQHsN6TvIm9bO7nEwTMLnOXLU+If/5j4Qn
	 m3Vl7ODOSPdOpXUkvL6AuY42Ui4LEYMJtPx/AK77HzgLvb6zYpjeHhEgE23xjZmz26Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ul3ip3DP;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8ED60A383D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF8ED60A383D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ul3ip3DP
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-843ea301d60so1453490a34.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590031; x=1795194831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjsuiiTiR6xMqMwngFz60LZtzwpdR6j2h8dViSfDc6I=;
        b=ul3ip3DPxFHlU0JH4+yG0ObUuN+sJTfO8I0uRNME7mhmAweqg7cOCzrfRyCIYxbEsc
         bVe93Y7GaAxLBqg3P2mZXMI0F/K7iAAloPwa8n31Ze4DhV7N9F6xvKSuxJUOFRCCcozv
         i2Ie9yZXiWlMom9oYSMHOYk55n1wbl6r1B3tNiv50RmHCfD0sdh+w9T1cqAMToDGsB/M
         Uz60DdKD2v1qcJh0Nf2GcBqhOZwN/M9sbe/y5FjO2PY7d6yNIOgt56OvGZQrKifme6k+
         ICO2+4EQdsP2qnPUqvdKgNqXFKf1/PdhwehuHykxLr5HNc6oDMGetRMda8F9Zha9h7ww
         IncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590031; x=1795194831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjsuiiTiR6xMqMwngFz60LZtzwpdR6j2h8dViSfDc6I=;
        b=FvxyGbNCqmrLH9zetxOcANFJYFWuVCs+3POvKITO6N2L+54l+q6kuizi4GwrB0F3Bq
         TAauT7+OHwIEQ7WOGj3FGT3qRYZsKD/9fUbSXDWFH7vpK0VJA1UtzDP34a1Ny6GP7ESk
         PE/CqbQDWuLdeIEYC2nxdqgNYW/U959AVxJZOCBG0HfMUnDj9sy6XWjVgEcXlJFbHsvM
         +0vszHu2xQcOJ4m8FnzUjxvOY5aEKCjFSaQLddN2N3VPe2Qgy0BzhLyQWIbbw6Yt/s1n
         zCDRE+UVn5zaDOh0KCS/S2PGlHrNgZcImnD+en+u0fjzFtX91ApuQ2xCfS5BsLYGRXJY
         GO7g==
X-Forwarded-Encrypted: i=1; AL+hErEdwzUTq6HucspeE7Lvgu6E+001vZxBot0wIqNjrYDyCCEN6SPJF+xTtPQ5cCTiIgD7KlVT5bM=@vger.kernel.org
X-Gm-Message-State: APuU4Z89jTeGZe9mz69rHJfAxgYEwHJZDLaDFytg6YAhERv34/dkwEY5
	VIaMq1q15pcyo8qmjqdkl9mkInZ3VH7bnax4Jb2y6JJ71b7je7Qz24BxlYqJ2lJl
X-Gm-Gg: AYBFou3pOP/LFP0aFFK1Bt2ae24wOJDgGC3euSMj1ZyNY0tL/UH5EQjkV6MNmx/Puud
	6s4iu/xYZY0ktUO2QuzOaTOPXt5kMg3s6qsUPJ8GgHm6IMAmYsBAmaujgrjabAOikh8s2IzweC+
	cNpnNgokSRzIh8WluH4qSzJfegOEj2xTskEm0z9cSsv/Uy4aTq6lgCPIxVHcghHkH3JTK0Z9pRg
	WvPhnZKYRgWgrI5GqnGrTaG1D7PYxaKXRguPoTjiqO1PwKH8dDXlSepvkBqAvLeO2XBIEy8y9dF
	2Tv2s2Y/N491oKA3HxApV/QMAib+hHLzT+Cb4yWH/eGPFCmeS+kpanuQfUhgjaADj/VuSK2Z/gH
	05jHIbKb1Hyndq+l7PAhKWf4lKnY1TSSVhDwzxzinVARqIkNiktdfEGhMmQoSIlGGGy/c7d1uSd
	t+Bf3RKOnBOgIeiXz8izhtVg6R0nWeouLb7NZzYDRPhFdcNgnIMrxUfPV6T3kEEHxQOXPT0jQny
	aUu3QdiWrk5XtcLIm5v1GztbCcLUOvCJAjU0ZWrBCBJuA6ZaZeiM9MAM7pzdSygX4MPFqg3Zsb5
	hrkTthaYpDVsDfNEgiFBwulUMSvQ7nfSHu7ASIw0I262Dupck75qwm+w8KMVZfiDyuyyGvJGxN7
	AGE4czyGR/hwiQeN8W5mSaOYsJZhgQ1cShpJTKJhjgu1L4oXE2sQZnwTCimLRdRMpnxVkPlv3EH
	FI7DRa/NWV2/zMh3S4Rd+y1pPAv3jxnV9VpaWqDKbeaLHhLJni+3yK
X-Received: by 2002:a05:6808:30a2:b0:567:f627:67f9 with SMTP id 5614622812f47-56e60065b98mr2702702b6e.5.1794590030688;
        Fri, 13 Nov 2026 09:13:50 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7044690dsm2565805b6e.9.2026.11.13.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:13:49 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 10:12:06 -0700
Subject: [PATCH net-next v4 2/3] net: phy: acx00: report receive statistics
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
Message-Id: <20261113-submit-acx00-phy-stats-v1-v4-2-986b8a4a1871@gmail.com>
References: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
In-Reply-To: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
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
callback and accumulate wrap-adjusted deltas in 64-bit totals. Hardware
measurements on AC200 and AC300 established a receive-byte modulus of
4,000,000,000. The byte counts include Ethernet headers, padding and FCS,
but exclude preamble and SFD. The packet and CRC-error counters wrap at
2^32. Reject byte samples at or above the byte modulus before updating
either the baseline or the totals.

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

Take a best-effort final snapshot before suspend, but invalidate the
baseline at entry to soft_reset: phylib may already have reset the PHY
through BMCR or its reset signal. Sampling against the previous baseline
then would count the cleared registers as a wrap. Invalidate it before
power-off too, including failed power-off attempts.

Start a new collection interval on resume, including when WoL kept the
PHY powered while polling stopped. Also discard deltas spanning at least
320 seconds, the minimum time for a full byte-counter cycle at 100 Mb/s.
Measure that interval with boottime, including system sleep and register
read duration, since the MDIO sleep path can bypass the PHY PM callbacks.
Retain previously accumulated totals, but do not account for traffic in
these unobserved intervals: complete counter cycles cannot be recovered
from the endpoint values. An unusable initial snapshot is retried by the
periodic collector without preventing initialization.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/xpowers/acx00.c | 184 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
index cee6c7ff0278..fb53bac12195 100644
--- a/drivers/net/phy/xpowers/acx00.c
+++ b/drivers/net/phy/xpowers/acx00.c
@@ -8,12 +8,14 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 
 #include "../phylib.h"
 #include "acx00.h"
@@ -31,6 +33,7 @@
 #define ACX00_PAGE_2				2
 #define ACX00_PAGE_6				6
 #define ACX00_PAGE_8				8
+#define ACX00_PAGE_9				9
 
 #define ACX00_PAGE0_GLOBAL_CONFIG_REG		0x13
 #define ACX00_PAGE0_XMII_RX_CLOCK_INVERT	BIT(12)
@@ -76,6 +79,32 @@
 	(ACX00_PAGE8_AUTO_CAL_TX_LEVEL_ADJUST_BYPASS | \
 	 ACX00_PAGE8_AUTO_CAL_LOW_CAL_OPAQUE_BITS)
 
+#define ACX00_PAGE9_RX_BYTES_HIGH_REG		0x19
+#define ACX00_PAGE9_RX_PACKETS_HIGH_REG		0x1b
+#define ACX00_PAGE9_RX_CRC_ERRORS_HIGH_REG	0x1d
+
+/*
+ * AC200 and AC300 hardware testing confirmed that the receive byte counter
+ * wraps at 4,000,000,000 rather than 2^32.
+ */
+#define ACX00_RX_BYTES_WRAP			4000000000ULL
+/* At 100 Mb/s, a full byte-counter cycle takes at least 320 seconds. */
+#define ACX00_STATS_MAX_INTERVAL_MS		(ACX00_RX_BYTES_WRAP * 8 / (SPEED_100 * 1000))
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
@@ -86,11 +115,16 @@
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
+	ktime_t stats_start;
+	u32 stats_last[ACX00_NUM_STATS];
+	u64 stats[ACX00_NUM_STATS];
 };
 
 static int acx00_ephy_read_page(struct phy_device *phydev)
@@ -110,6 +144,124 @@ static int acx00_ephy_write_page(struct phy_device *phydev, int page)
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
+	ktime_t start;
+	int oldpage;
+	int ret;
+	int i;
+
+	lockdep_assert_held(&priv->state_lock);
+
+	if (!priv->stats_active)
+		return 0;
+
+	start = ktime_get_boottime();
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
+	/* Include sleep and read time; complete unseen cycles cannot be recovered. */
+	if (priv->stats_valid &&
+	    ktime_ms_delta(ktime_get_boottime(), priv->stats_start) >=
+	    (s64)ACX00_STATS_MAX_INTERVAL_MS)
+		priv->stats_valid = false;
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
+	priv->stats_start = start;
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
@@ -122,6 +274,10 @@ static int acx00_ephy_control_power_off(struct acx00_ephy_priv *priv)
 {
 	lockdep_assert_held(&priv->state_lock);
 
+	/* Even a failed power-off can have reset the hardware counter. */
+	priv->stats_active = false;
+	priv->stats_valid = false;
+
 	return priv->control->power_off(priv->control);
 }
 
@@ -350,6 +506,10 @@ static int acx00_ephy_soft_reset(struct phy_device *phydev)
 
 	mutex_lock(&priv->state_lock);
 
+	/* phylib may already have reset the counters before calling us. */
+	priv->stats_active = false;
+	priv->stats_valid = false;
+
 	ret = acx00_ephy_set_interface(phydev);
 	if (ret)
 		goto out_power_off;
@@ -475,10 +635,21 @@ static int __acx00_ephy_config_init(struct phy_device *phydev)
 
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
@@ -534,6 +705,9 @@ static int acx00_ephy_resume(struct phy_device *phydev)
 	int ret;
 
 	mutex_lock(&priv->state_lock);
+	/* WoL can keep the PHY counting while phylib polling is stopped. */
+	priv->stats_active = false;
+	priv->stats_valid = false;
 	ret = __acx00_ephy_power_on_and_resume(phydev);
 	mutex_unlock(&priv->state_lock);
 
@@ -550,6 +724,8 @@ static int acx00_ephy_suspend(struct phy_device *phydev)
 	mutex_lock(&phydev->lock);
 	mutex_lock(&priv->state_lock);
 
+	acx00_ephy_snapshot_stats(phydev);
+
 	ret = genphy_suspend(phydev);
 	if (ret)
 		goto out_unlock;
@@ -616,6 +792,8 @@ static struct phy_driver acx00_ephy_driver[] = {
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

