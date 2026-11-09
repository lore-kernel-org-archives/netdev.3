Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231945;
	b=PkadzR57DBN+NUHw8mUEjnEZG0yeoQCGD+kkqpBfcKNwJhuB1WVt6VWmFX+FAyfRQSYa
	 yzALRyP5GTqw7atd6upLT/UKTmIJlmlxFf4A8iwhlW55jGht1Svo76u+TnEOGTsbhx97h
	 PZsARkQwtseP2bdeP69uvFvZ1gkZtPFZ5p/rE8YeOf7vexf6VPKx75gjD4Idt6kztdFeA
	 wvGXEBKHbwq1eEhOnvoePGnsdpC/vSUR6Kw3fLcxAPr8nCOXMsBc+D3nik1VzB3mXzpaZ
	 mW+hI1Yet42D3YaSuRuYVw5zWpBPalh84P7mhH45rt0Zbs2wqB/jaGudI2dnp8VbVDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j1ZMtmc0X+rFFxcagwNCsvt1nRht/Nzl7/FjH/A2gNk=;
	b=q8Ct60p01OzemJO/JZfxpnoWzqoeb7VXLoQUkwfbIU8FRkF4xiyIIZiM1aJLfLt6hFhp
	 2ClsM4937pKXc/BPSsa3lwunHgcKyajr/rkN07dDbmLKvvDA6vGCNLoyDx+h07q4J3CTY
	 Hw+h7NOCJxH3hjlkT1w9ptcv1JQ/6YryKiupEAdnRse7DbiauJxGCy5JF2wjCvwbweYXt
	 pNXEeDD4vdgZ8j5ugoNvO1bwOmXvG96dwPgrlW1bw+ryUW/8WX2nYs5Wbt3ec5sx5THLV
	 7NYQWzolAr3u4WOww0eUe7HZfbP0YiO+00etQGU0baPIfZVOEBwVvlcYJgB5o1ZSBWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiCxfamE;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F42606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F42606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiCxfamE
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed1414df17so3122025ad.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231943; x=1794836743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1ZMtmc0X+rFFxcagwNCsvt1nRht/Nzl7/FjH/A2gNk=;
        b=YiCxfamEe75bmu023KGA8+OO0tHsSYddW5ghft8/F5LGECPgNonQidpS+xfEIngJm3
         R3uQm2CyOs5n/92oLJ3kjbka7FyEnG9Axg8ZQp7bs5plQkLLd9IfiaPrL6rLYD3vuNDO
         kLJRnFTvKhDQNmPrFmUaZX5Ac8pBO3S8+ViGJaffmcZtWZAgh3CoppK6HXqWbhhZGTP/
         D3CBD5ArZyQJZQ3UORLQIel9OE+eRiIBihnMbLDZX79mpQP5mzpCRC3Ed1MOuLOZXQXR
         v49PgI7h+uMeejXUQVvIwV2vVXU6Bao0SWoRlOR8sdo9cpBEckxdzko0sYKdGZYsVkD8
         UGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231943; x=1794836743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1ZMtmc0X+rFFxcagwNCsvt1nRht/Nzl7/FjH/A2gNk=;
        b=JZTJX+MTIPuFmJHFc8k7jdrwMDYK41sce69welc9IiriWQfmU7YUMAhj7I/BIW/zy0
         TT3wJISsGz8LzSqoC1paFXjYKfFQjXCKl8K1zY7oO0ixIJ+3Bry0SsbsFJdwdvf8pg66
         htuZcyy3mpPjhdO02lHKrCIkGq64dUCwOOlBx8HzsWGrWmXYTxGLHo0pDL+newFfUZeQ
         zD6nTr6lDFJ5nXOo+ICyi0anfRTRGXx/cUC2ci7AMC3s0+EDoT0jMZNjkvlxaogZete0
         OE1NEUNMU1HNS7S0pjv/2WgjI7wJ4z+qZ38EZB1PW2twl4iDJjN/FNgeU6L+SQ4a47zP
         PF7A==
X-Forwarded-Encrypted: i=1; AL+hErGg8vK0oTWAqZeoIaZpPm4vnfFJXvNgIST5RtNrtB96A0bvS1LnxB+sW98TwS5ESYI2GV8MOuo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KFjEmQ5sCZnweJ9DFNQZ0E2b35dYJF0lHi+PP7XKy5Sb2BuVM
	OCo6k8ltM7azQ798pSIfzQSUKq9BJg1UMa9q9Scd3QzTJ20iC3CthVf9
X-Gm-Gg: AYBFou0pSkxCDnqCjtESXATZRriSdumcnd14t0+Y8WNWHhdxjDzY+Ci710x3KQ/N51T
	vypV6ochYkxHCOuAtanwzvgLSbBWsgrnIYspNtvgIpEadvTZuP3WTPs1PlJRy9KuKP88M30gFHY
	zeJXMilpzEWphinoePt0Q97N4sy8COksZEvkvJQsGo5c7UNW9q+G+GqXA0apkee9qUAVq22/wqV
	ZF/Ie3NqEqZQSI0YLuITsMWJ1uGAYSFtsVXUEiSjSfIUhuhJlMHLRUiSP13YgOuHPbQLreNvFa7
	CoVDkifsNiT557schA3g0CYs0eawI3UHHYT9wmc92kwCUmD8j67IXvrUETzjDTe9FkOVemMb48i
	d474h+8gJsdwSyWV6sYfmph8p88BSZvhUV1HC2biHDzBQXIT/Xq9/4MUOcbop5HrUgQsxBeeSjz
	lKg1k7Tgj6ZpAfPmbpUFgYw4qpV5VwWGAd7H1gcs6QCbyBWcMwqWufb7EfK9CyUKBJyMntIhL6O
	IqgeMG8iZ6BgcZmUDJ6zheGpOCHNyBA1GL4QC8k1MsXUKwTJXHAv20bucMJSVL5q2+EanIX0yvB
	0fxQk6doVGmDfneCoN4Pw05Qzo4jfQ==
X-Received: by 2002:a17:902:cec2:b0:2e9:cd03:b432 with SMTP id d9443c01a7336-2ed837b0177mr43653715ad.60.1794231943020;
        Mon, 09 Nov 2026 05:45:43 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81727f9bsm11014285ad.57.2026.11.09.05.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:45:42 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	rmk+kernel@armlinux.org.uk,
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v10 3/3] net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support
Date: Mon,  9 Nov 2026 21:45:06 +0800
Message-Id: <20261109134506.2794160-4-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109134506.2794160-1-zxyan0222@gmail.com>
References: <20261109134506.2794160-1-zxyan0222@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DWXGMAC2 hwif entries use the generic stmmac_ptp hwtimestamp ops,
whose timestamp_interrupt callback reads the dwmac4 register instead of
the XGMAC one and whose enable mask omits XGMAC_TSIE.  The PTP clock
still advertises the auxiliary snapshot channels, so PTP_EXTTS_REQUEST
succeeds but no PTP_CLOCK_EXTTS event is ever delivered.

Add a DWXGMAC2 handler that reads XGMAC_TIMESTAMP_STATUS and reports
the pending auxiliary snapshots as PTP_CLOCK_EXTTS events.  It
deliberately does not gate on XGMAC_INT_TSIS: TSIS is an aggregate,
read-to-clear bit that the TX timestamp completion path clears before
the handler can observe it, while the ATSNS count and the FIFO still
hold the events, so a dwmac4-style TSIS gate would drop them.

XGMAC_TSIE is not re-added to XGMAC_INT_DEFAULT_EN.  It is armed on
demand from the PTP_CLK_REQ_EXTTS enable/disable path through a new
optional stmmac_ops->timestamp_interrupt_cfg() callback implemented
only for DWXGMAC2/DWXLGMAC2, since stmmac_enable() is shared with
dwmac4/dwmac5, whose timestamp interrupt stays always-enabled and is
relied upon by intel_crosststamp().  The driver keeps a single
enabled EXTTS channel at a time: an enable for a channel other than the
armed one is rejected with -EBUSY, a disable for a channel other than
the armed one is a no-op, and re-enabling the armed channel stays
idempotent, disarming the interrupt across the FIFO clear like a first
enable.  stmmac_ptp_register() clamps the advertised channel count to
the four PTP_ACR ATSEN bits, which also covers any core whose
AUXSNAPNUM capability reports more than four auxiliary snapshots;
n_ext_ts reports the hardware channels, the driver serialises their
use.  Requests are also refused while an internal cross-timestamp
owns the FIFO, so the PTP_ACR programming cannot disarm its trigger.
intel_crosststamp() holds aux_ts_lock across its whole body, like
smtg_crosststamp(), and disarms its internal snapshot trigger on the
way out, on a timeout and on an interrupted wait alike, so it cannot
wipe a channel that stmmac_enable() just armed, nor leave the mask
armed behind the software state; it also refuses to run once the clock
has been invalidated by unregister, and skips the disarm write
afterwards.

The handler drains the FIFO only while XGMAC_TSIE is enabled: it runs
on every MAC interrupt, and PTP_ACR_ATSFC is only ever set while
XGMAC_TSIE is disabled, so this both keeps it off the FIFO on unrelated
interrupts and stops it racing a FIFO flush.  The interrupt is armed
only after the FIFO clear has completed, with aux_ts_lock held across
the whole enable so the arm cannot interleave with a disarm under the
same lock.
A failed enable is rolled back in hardware and software, leaving the
interrupt disarmed.

While an internal cross-timestamp owns the FIFO
(STMMAC_FLAG_INT_SNAPSHOT_EN, raised and dropped under aux_ts_lock),
the handler only clears the interrupt source.  smtg_crosststamp() calls
stmmac_sync_timestamp_irq() after raising the flag and the disable path
calls it after disarming, so no handler that is already past its check
can still use the FIFO.

aux_ts_lock is initialised in probe and destroyed in remove, so it is
valid for the whole device lifetime.  At unregister the clock is
invalidated under the lock before ptp_clock_unregister(), after which
the enable path and smtg_crosststamp() refuse to arm.

On resume stmmac_rearm_timestamp_irq() reprograms the enabled channel
under aux_ts_lock and re-arms the interrupt only if the FIFO flush
completed; otherwise, and whenever the timestamping setup cannot be
redone, the recorded EXTTS channel is dropped and its trigger
disarmed, so no stale channel survives.  Both that drop and the
unregister disarm the hardware trigger as well: PTP_ACR on the cores
whose EXTTS requests go through stmmac_enable(), and PTP_TCR on
MAC100/GMAC, whose requests go through dwmac1000_ptp_enable(), so a
leftover or re-armed trigger bit cannot reject later requests or keep
the FIFO latching behind the software state.
stmmac_suspend() disarms the interrupt and drains an in-flight handler
under aux_ts_lock before the clocks are gated.

Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  46 ++++--
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  22 ++-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  62 ++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   6 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   2 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  12 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 138 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 107 +++++++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.h  |   2 +
 include/linux/stmmac.h                        |   1 +
 11 files changed, 363 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 4308dccbf257..3f0889c30a70 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -370,19 +370,23 @@ static int intel_crosststamp(ktime_t *device,
 	u32 num_snapshot;
 	u32 gpio_value;
 	u32 acr_value;
-	int i;
+	int ret, i;
 
 	intel_priv = priv->plat->bsp_priv;
 
+	mutex_lock(&priv->aux_ts_lock);
 	/* Both internal crosstimestamping and external triggered event
-	 * timestamping cannot be run concurrently.
+	 * timestamping cannot be run concurrently: the PTP_ACR mask
+	 * programming below would disarm an external channel.
 	 */
-	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
-		return -EBUSY;
+	if ((priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) ||
+	    !priv->ptp_clock) {
+		mutex_unlock(&priv->aux_ts_lock);
+		return priv->ptp_clock ? -EBUSY : -ENODEV;
+	}
 
 	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;
 
-	mutex_lock(&priv->aux_ts_lock);
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value &= ~PTP_ACR_MASK;
@@ -400,8 +404,8 @@ static int intel_crosststamp(ktime_t *device,
 		acr_value |= PTP_ACR_ATSEN3;
 		break;
 	default:
-		mutex_unlock(&priv->aux_ts_lock);
 		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
+		mutex_unlock(&priv->aux_ts_lock);
 		return -EINVAL;
 	}
 	writel(acr_value, ptpaddr + PTP_ACR);
@@ -410,8 +414,6 @@ static int intel_crosststamp(ktime_t *device,
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value |= PTP_ACR_ATSFC;
 	writel(acr_value, ptpaddr + PTP_ACR);
-	/* Release the mutex */
-	mutex_unlock(&priv->aux_ts_lock);
 
 	/* Trigger Internal snapshot signal
 	 * Create a rising edge by just toggle the GPO1 to low
@@ -424,11 +426,22 @@ static int intel_crosststamp(ktime_t *device,
 	writel(gpio_value, ioaddr + GMAC_GPIO_STATUS);
 
 	/* Time sync done Indication - Interrupt method */
-	if (!wait_event_interruptible_timeout(priv->tstamp_busy_wait,
-					      stmmac_cross_ts_isr(priv),
-					      HZ / 100)) {
+	ret = wait_event_interruptible_timeout(priv->tstamp_busy_wait,
+					       stmmac_cross_ts_isr(priv),
+					       HZ / 100);
+	if (ret <= 0) {
+		/* Disarm the trigger on a timeout or an interrupted
+		 * wait, but do not touch the hardware once the clock has
+		 * been invalidated by an interface teardown.
+		 */
+		if (priv->ptp_clock) {
+			acr_value = readl(ptpaddr + PTP_ACR);
+			acr_value &= ~PTP_ACR_MASK;
+			writel(acr_value, ptpaddr + PTP_ACR);
+		}
 		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
-		return -ETIMEDOUT;
+		mutex_unlock(&priv->aux_ts_lock);
+		return ret ? ret : -ETIMEDOUT;
 	}
 
 	*system = (struct system_counterval_t) {
@@ -453,7 +466,16 @@ static int intel_crosststamp(ktime_t *device,
 
 	system->cycles *= intel_priv->crossts_adj;
 
+	/* Disarm the internal snapshot trigger, so it does not stay armed
+	 * in PTP_ACR after the cross-timestamp.
+	 */
+	if (priv->ptp_clock) {
+		acr_value = readl(ptpaddr + PTP_ACR);
+		acr_value &= ~PTP_ACR_MASK;
+		writel(acr_value, ptpaddr + PTP_ACR);
+	}
 	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
+	mutex_unlock(&priv->aux_ts_lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 2d3c6702e203..212aabbf1a19 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -305,14 +305,21 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	u32 v;
 
 	mutex_lock(&priv->aux_ts_lock);
-	/* Both internal crosstimestamping and external triggered event
-	 * timestamping cannot be run concurrently: the PTP_ACR mask
-	 * programming below would disarm an external channel.
+	/* Internal crosstimestamping and external triggered event
+	 * timestamping cannot run concurrently: the PTP_ACR mask
+	 * programming below would disarm an external channel.  Refuse to
+	 * arm once the clock has been invalidated by unregister.
 	 */
-	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) {
+	if ((priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) ||
+	    !priv->ptp_clock) {
 		mutex_unlock(&priv->aux_ts_lock);
-		return -EBUSY;
+		return priv->ptp_clock ? -EBUSY : -ENODEV;
 	}
+	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;
+	/* Wait for a handler that is already past the flag check before
+	 * taking over the snapshot FIFO.
+	 */
+	stmmac_sync_timestamp_irq(priv);
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value &= ~PTP_ACR_MASK;
@@ -330,6 +337,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		acr_value |= PTP_ACR_ATSEN3;
 		break;
 	default:
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		return -EINVAL;
 	}
@@ -349,6 +357,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		acr_value = readl(ptpaddr + PTP_ACR);
 		acr_value &= ~PTP_ACR_MASK;
 		writel(acr_value, ptpaddr + PTP_ACR);
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
 			   __func__);
@@ -374,6 +383,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		acr_value = readl(ptpaddr + PTP_ACR);
 		acr_value &= ~PTP_ACR_MASK;
 		writel(acr_value, ptpaddr + PTP_ACR);
+		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
@@ -403,6 +413,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	acr_value &= ~PTP_ACR_MASK;
 	writel(acr_value, ptpaddr + PTP_ACR);
 
+	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
+
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
 	system->cycles = smtg_time;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..ff2956bb89e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -42,6 +42,12 @@ static void dwxgmac2_irq_modify(struct mac_device_info *hw, u32 disable,
 	spin_unlock_irqrestore(&hw->irq_ctrl_lock, flags);
 }
 
+static void dwxgmac2_timestamp_interrupt_cfg(struct stmmac_priv *priv, bool en)
+{
+	stmmac_mac_irq_modify(priv, en ? 0 : XGMAC_TSIE,
+			      en ? XGMAC_TSIE : 0);
+}
+
 static void dwxgmac2_update_caps(struct stmmac_priv *priv)
 {
 	if (!priv->dma_cap.mbps_10_100)
@@ -1154,6 +1160,60 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
 	return 0;
 }
 
+void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
+{
+	u32 ts_status, pending_snapshots, acr_value, channel;
+	struct ptp_clock_event event;
+	unsigned long flags;
+	u64 ptp_time;
+	int i;
+
+	/* Runs on every MAC interrupt: only touch the FIFO when the
+	 * timestamp interrupt was armed, and leave it to the
+	 * cross-timestamp path while that owns it.
+	 */
+	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
+		readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
+		return;
+	}
+
+	if (!(readl(priv->ioaddr + XGMAC_INT_EN) & XGMAC_TSIE))
+		return;
+
+	/* Reading XGMAC_TIMESTAMP_STATUS clears TSIS, so use the ATSNS
+	 * count to see the pending snapshots.
+	 */
+	ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
+
+	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) ||
+	    !priv->ptp_clock)
+		return;
+
+	pending_snapshots = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, ts_status);
+	if (!pending_snapshots)
+		return;
+
+	acr_value = readl(priv->ptpaddr + PTP_ACR);
+	/* Entries observed while the FIFO is being flushed are stale. */
+	if (acr_value & PTP_ACR_ATSFC)
+		return;
+	channel = FIELD_GET(PTP_ACR_MASK, acr_value);
+	if (!channel)
+		return;
+	channel = ilog2(channel);
+
+	for (i = 0; i < pending_snapshots; i++) {
+		read_lock_irqsave(&priv->ptp_lock, flags);
+		stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);
+		read_unlock_irqrestore(&priv->ptp_lock, flags);
+
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = channel;
+		event.timestamp = ptp_time;
+		ptp_clock_event(priv->ptp_clock, &event);
+	}
+}
+
 static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 				    struct stmmac_pps_cfg *cfg, bool enable,
 				    u32 sub_second_inc, u32 systime_flags)
@@ -1413,6 +1473,7 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.irq_modify = dwxgmac2_irq_modify,
+	.timestamp_interrupt_cfg = dwxgmac2_timestamp_interrupt_cfg,
 	.update_caps = dwxgmac2_update_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
@@ -1468,6 +1529,7 @@ static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
 const struct stmmac_ops dwxlgmac2_ops = {
 	.core_init = dwxgmac2_core_init,
 	.irq_modify = dwxgmac2_irq_modify,
+	.timestamp_interrupt_cfg = dwxgmac2_timestamp_interrupt_cfg,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxlgmac2_rx_queue_enable,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 265671170bf6..eba87410f985 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -258,7 +258,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxgmac210_ops,
 		.vlan = &dwxgmac210_vlan_ops,
-		.hwtimestamp = &stmmac_ptp,
+		.hwtimestamp = &dwxgmac2_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
@@ -280,7 +280,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxlgmac2_ops,
 		.vlan = &dwxlgmac2_vlan_ops,
-		.hwtimestamp = &stmmac_ptp,
+		.hwtimestamp = &dwxgmac2_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 8ae95e91a36a..f077c1465a0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -317,6 +317,8 @@ struct stmmac_ops {
 	void (*update_caps)(struct stmmac_priv *priv);
 	/* Change the interrupt enable setting. Enable takes precedence. */
 	void (*irq_modify)(struct mac_device_info *hw, u32 disable, u32 enable);
+	/* Arm or disarm the timestamp interrupt on demand (optional) */
+	void (*timestamp_interrupt_cfg)(struct stmmac_priv *priv, bool en);
 	/* Enable the MAC RX/TX */
 	void (*set_mac)(void __iomem *ioaddr, bool enable);
 	/* Enable and verify that the IPC module is supported */
@@ -420,6 +422,9 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, update_caps, __priv)
 #define stmmac_mac_irq_modify(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, irq_modify, (__priv)->hw, __args)
+#define stmmac_mac_timestamp_interrupt_cfg(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, timestamp_interrupt_cfg, \
+				__priv, __args)
 #define stmmac_mac_set(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_mac, __args)
 #define stmmac_rx_ipc(__priv, __args...) \
@@ -675,6 +680,7 @@ extern const struct stmmac_desc_ops ndesc_ops;
 
 extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_hwtimestamp dwmac1000_ptp;
+extern const struct stmmac_hwtimestamp dwxgmac2_ptp;
 
 extern const struct stmmac_mode_ops ring_mode_ops;
 extern const struct stmmac_mode_ops chain_mode_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b76acfe0d958..5cde6720590e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -410,6 +410,8 @@ int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
 void stmmac_mdio_lock(struct stmmac_priv *priv);
 void stmmac_mdio_unlock(struct stmmac_priv *priv);
+void stmmac_sync_timestamp_irq(struct stmmac_priv *priv);
+void stmmac_drop_hw_extts(struct stmmac_priv *priv);
 int stmmac_pcs_setup(struct net_device *ndev);
 void stmmac_pcs_clean(struct net_device *ndev);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index fd1142344950..40476fa32ec1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -283,3 +283,15 @@ const struct stmmac_hwtimestamp dwmac1000_ptp = {
 	.get_ptptime = dwmac1000_get_ptptime,
 	.timestamp_interrupt = dwmac1000_timestamp_interrupt,
 };
+
+const struct stmmac_hwtimestamp dwxgmac2_ptp = {
+	.config_hw_tstamping = config_hw_tstamping,
+	.init_systime = init_systime,
+	.config_sub_second_increment = config_sub_second_increment,
+	.config_addend = config_addend,
+	.adjust_systime = adjust_systime,
+	.get_systime = get_systime,
+	.get_ptptime = get_ptptime,
+	.timestamp_interrupt = dwxgmac2_timestamp_interrupt,
+	.hwtstamp_correct_latency = hwtstamp_correct_latency,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a2177777727e..1abc7c696cf7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/skbuff.h>
@@ -895,6 +896,117 @@ static int stmmac_init_ptp_clk_freq(struct stmmac_priv *priv)
 	return 0;
 }
 
+/**
+ * stmmac_sync_timestamp_irq - wait for an in-flight timestamp handler
+ * @priv: driver private structure
+ * Description: called after the timestamp interrupt has been disarmed or
+ * handed over, to make sure a handler that is already past its checks has
+ * finished before the caller takes over the auxiliary snapshot FIFO.
+ */
+void stmmac_sync_timestamp_irq(struct stmmac_priv *priv)
+{
+	synchronize_irq(priv->dev->irq);
+	if (priv->wol_irq > 0 && priv->wol_irq != priv->dev->irq)
+		synchronize_irq(priv->wol_irq);
+}
+EXPORT_SYMBOL_GPL(stmmac_sync_timestamp_irq);
+
+/**
+ * stmmac_drop_hw_extts - disarm the recorded EXTTS channel in hardware
+ * @priv: driver private structure
+ * Description: clears the auxiliary snapshot trigger, in PTP_ACR for
+ * the cores whose EXTTS requests go through stmmac_enable() and in
+ * PTP_TCR for MAC100/GMAC, whose requests go through
+ * dwmac1000_ptp_enable().
+ */
+void stmmac_drop_hw_extts(struct stmmac_priv *priv)
+{
+	u32 value;
+
+	if (priv->plat->core_type == DWMAC_CORE_MAC100 ||
+	    priv->plat->core_type == DWMAC_CORE_GMAC) {
+		value = readl(priv->ptpaddr + PTP_TCR);
+		value &= ~GMAC_PTP_TCR_ATSEN0;
+		writel(value, priv->ptpaddr + PTP_TCR);
+		return;
+	}
+
+	value = readl(priv->ptpaddr + PTP_ACR);
+	value &= ~PTP_ACR_MASK;
+	writel(value, priv->ptpaddr + PTP_ACR);
+}
+
+/**
+ * stmmac_drop_extts_state - drop the recorded EXTTS channel
+ * @priv: driver private structure
+ * Description: clears the recorded EXTTS channel and disarms its
+ * trigger, so no event is reported for it and a later enable starts
+ * from a clean state.
+ */
+static void stmmac_drop_extts_state(struct stmmac_priv *priv)
+{
+	mutex_lock(&priv->aux_ts_lock);
+	stmmac_drop_hw_extts(priv);
+	priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+	priv->plat->ext_snapshot_num = -1;
+	mutex_unlock(&priv->aux_ts_lock);
+	netdev_err(priv->dev,
+		   "Dropped the enabled auxiliary snapshot channel\n");
+}
+
+/**
+ * stmmac_rearm_timestamp_irq - re-arm the timestamp interrupt
+ * @priv: driver private structure
+ * Description: this re-arms the on-demand timestamp interrupt if an
+ * auxiliary snapshot channel was left enabled.
+ */
+static void stmmac_rearm_timestamp_irq(struct stmmac_priv *priv)
+{
+	u32 acr_value;
+	int ret, num;
+
+	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) ||
+	    !priv->ptp_clock)
+		return;
+
+	/* Flush the FIFO, re-program the enabled auxiliary snapshot
+	 * trigger and re-arm the interrupt only if the flush completed.
+	 */
+	if (priv->plat->core_type != DWMAC_CORE_XGMAC)
+		return;
+
+	mutex_lock(&priv->aux_ts_lock);
+	/* Snapshot the channel under the lock: a concurrent disable may
+	 * have cleared it.
+	 */
+	num = priv->plat->ext_snapshot_num;
+	if (num < 0) {
+		mutex_unlock(&priv->aux_ts_lock);
+		return;
+	}
+	acr_value = readl(priv->ptpaddr + PTP_ACR);
+	acr_value &= ~PTP_ACR_MASK;
+	acr_value |= PTP_ACR_ATSFC;
+	writel(acr_value, priv->ptpaddr + PTP_ACR);
+	ret = readl_poll_timeout(priv->ptpaddr + PTP_ACR, acr_value,
+				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
+	if (!ret) {
+		acr_value |= PTP_ACR_ATSEN(num);
+		writel(acr_value, priv->ptpaddr + PTP_ACR);
+		stmmac_mac_timestamp_interrupt_cfg(priv, true);
+	} else {
+		/* The trigger could not be restored, so drop the software
+		 * state rather than advertise a dead channel.
+		 */
+		priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+		priv->plat->ext_snapshot_num = -1;
+		netdev_err(priv->dev,
+			   "%s: Failed to restore auxiliary snapshot channel\n",
+			   __func__);
+	}
+	mutex_unlock(&priv->aux_ts_lock);
+}
+
 /**
  * stmmac_init_timestamping - initialise timestamping
  * @priv: driver private structure
@@ -954,6 +1066,9 @@ static int stmmac_setup_ptp(struct stmmac_priv *priv)
 		return 0;
 	}
 
+	/* No EXTTS channel is recorded until one is enabled. */
+	priv->plat->ext_snapshot_num = -1;
+
 	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
 	if (ret < 0) {
 		netdev_warn(priv->dev,
@@ -8246,6 +8361,7 @@ static int __stmmac_dvr_probe(struct device *device,
 
 	mutex_init(&priv->lock);
 	mutex_init(&priv->est_lock);
+	mutex_init(&priv->aux_ts_lock);
 	rwlock_init(&priv->ptp_lock);
 
 	stmmac_fpe_init(priv);
@@ -8380,6 +8496,7 @@ void stmmac_dvr_remove(struct device *dev)
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	mutex_destroy(&priv->est_lock);
+	mutex_destroy(&priv->aux_ts_lock);
 	bitmap_free(priv->af_xdp_zc_qps);
 
 	pm_runtime_disable(dev);
@@ -8434,6 +8551,17 @@ int stmmac_suspend(struct device *dev)
 		pinctrl_pm_select_sleep_state(priv->device);
 	}
 
+	/* Disarm the timestamp interrupt while suspended and drain an
+	 * in-flight handler before the clocks are gated;
+	 * stmmac_rearm_timestamp_irq() restores it on resume.
+	 */
+	mutex_lock(&priv->aux_ts_lock);
+	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) {
+		stmmac_mac_timestamp_interrupt_cfg(priv, false);
+		stmmac_sync_timestamp_irq(priv);
+	}
+	mutex_unlock(&priv->aux_ts_lock);
+
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
@@ -8556,16 +8684,22 @@ int stmmac_resume(struct device *dev)
 	}
 
 	if (priv->ptp_enabled) {
-		if (stmmac_init_ptp_clk_freq(priv))
+		if (stmmac_init_ptp_clk_freq(priv)) {
+			stmmac_drop_extts_state(priv);
 			goto init_coalesce;
+		}
 
 		ret = stmmac_init_timestamping(priv);
-		if (ret)
+		if (ret) {
+			stmmac_drop_extts_state(priv);
 			goto error_stop_dma;
+		}
 
 		ret = stmmac_setup_est(priv);
 		if (ret)
 			goto error_stop_dma;
+
+		stmmac_rearm_timestamp_irq(priv);
 	}
 
 init_coalesce:
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index a37405534beb..4486c800fa71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -201,35 +201,98 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		u8 channel;
 
 		mutex_lock(&priv->aux_ts_lock);
+		/* Refuse to arm once the clock has been invalidated by
+		 * unregister, or while an internal cross-timestamp owns the
+		 * FIFO: the PTP_ACR programming below would disarm its
+		 * trigger.
+		 */
+		if (!priv->ptp_clock) {
+			mutex_unlock(&priv->aux_ts_lock);
+			return -ENODEV;
+		}
+		if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
+			mutex_unlock(&priv->aux_ts_lock);
+			return -EBUSY;
+		}
 		acr_value = readl(ptpaddr + PTP_ACR);
-		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
-		acr_value &= ~PTP_ACR_MASK;
+		channel = FIELD_GET(PTP_ACR_MASK, acr_value);
 
 		if (on) {
-			if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
+			if (channel && rq->extts.index != ilog2(channel)) {
 				netdev_err(priv->dev,
 					   "Cannot enable auxiliary snapshot %d as auxiliary snapshot %d is already enabled",
-					rq->extts.index, channel);
+					rq->extts.index, ilog2(channel));
 				mutex_unlock(&priv->aux_ts_lock);
 				return -EBUSY;
 			}
 
+			if (rq->extts.index >= PTP_ACR_ATSEN_NUM) {
+				mutex_unlock(&priv->aux_ts_lock);
+				return -EINVAL;
+			}
+
+			/* A re-enable of the armed channel re-arms the
+			 * interrupt as well; disarm it across the FIFO
+			 * clear below and drain the handler that is
+			 * already past its checks, so no one touches the
+			 * FIFO while it is flushed.
+			 */
+			if (channel) {
+				stmmac_mac_timestamp_interrupt_cfg(priv, false);
+				stmmac_sync_timestamp_irq(priv);
+			}
+
 			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
+			priv->plat->ext_snapshot_num = rq->extts.index;
 
 			/* Enable External snapshot trigger */
 			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
 			acr_value |= PTP_ACR_ATSFC;
+		} else if (channel) {
+			/* A disable request for a channel that is not the
+			 * armed one is a no-op: the requested channel is
+			 * not armed.
+			 */
+			if (rq->extts.index != ilog2(channel)) {
+				mutex_unlock(&priv->aux_ts_lock);
+				return 0;
+			}
+
+			acr_value &= ~PTP_ACR_MASK;
+			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+			priv->plat->ext_snapshot_num = -1;
 		} else {
 			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+			priv->plat->ext_snapshot_num = -1;
 		}
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
 			   rq->extts.index, on ? "enabled" : "disabled");
 		writel(acr_value, ptpaddr + PTP_ACR);
-		mutex_unlock(&priv->aux_ts_lock);
-		/* wait for auxts fifo clear to finish */
+		/* Keep the lock across the FIFO clear so the arm below
+		 * cannot interleave with a suspend.
+		 */
 		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
 					 !(acr_value & PTP_ACR_ATSFC),
 					 10, 10000);
+		if (ret && on) {
+			/* Roll the failed enable back so no half-enabled
+			 * channel is left.
+			 */
+			acr_value = readl(ptpaddr + PTP_ACR);
+			acr_value &= ~PTP_ACR_ATSEN(rq->extts.index);
+			writel(acr_value, ptpaddr + PTP_ACR);
+			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+			priv->plat->ext_snapshot_num = -1;
+		}
+		/* Arm the timestamp interrupt only after the FIFO clear,
+		 * so the handler cannot see a snapshot that is about to be
+		 * discarded.
+		 */
+		stmmac_mac_timestamp_interrupt_cfg(priv, on && !ret);
+		/* Drain an in-flight handler before the channel is freed. */
+		if (!on)
+			stmmac_sync_timestamp_irq(priv);
+		mutex_unlock(&priv->aux_ts_lock);
 		break;
 	}
 
@@ -330,7 +393,7 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (pps_out_num)
 		priv->ptp_clock_ops.n_per_out = pps_out_num;
 
-	n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	n_ext_ts = min(priv->dma_cap.aux_snapshot_n, PTP_ACR_ATSEN_NUM);
 	if (n_ext_ts)
 		priv->ptp_clock_ops.n_ext_ts = n_ext_ts;
 
@@ -340,8 +403,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (priv->plat->crosststamp)
 		priv->ptp_clock_ops.getcrosststamp = stmmac_getcrosststamp;
 
-	mutex_init(&priv->aux_ts_lock);
-
 	priv->ptp_clock = ptp_clock_register(&priv->ptp_clock_ops,
 					     priv->device);
 	if (IS_ERR(priv->ptp_clock)) {
@@ -351,8 +412,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 
 	if (priv->ptp_clock)
 		netdev_info(priv->dev, "registered PTP clock\n");
-	else
-		mutex_destroy(&priv->aux_ts_lock);
 }
 
 /**
@@ -363,12 +422,24 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
  */
 void stmmac_ptp_unregister(struct stmmac_priv *priv)
 {
-	if (priv->ptp_clock) {
-		ptp_clock_unregister(priv->ptp_clock);
-		priv->ptp_clock = NULL;
-		pr_debug("Removed PTP HW clock successfully on %s\n",
-			 priv->dev->name);
+	struct ptp_clock *clock;
 
-		mutex_destroy(&priv->aux_ts_lock);
-	}
+	if (!priv->ptp_clock)
+		return;
+
+	/* Tear the hardware state down and invalidate the clock before
+	 * releasing the lock, so a concurrent request cannot re-arm a
+	 * clock that is going away.
+	 */
+	mutex_lock(&priv->aux_ts_lock);
+	clock = priv->ptp_clock;
+	priv->ptp_clock = NULL;
+	stmmac_mac_timestamp_interrupt_cfg(priv, false);
+	stmmac_drop_hw_extts(priv);
+	priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
+	priv->plat->ext_snapshot_num = -1;
+	mutex_unlock(&priv->aux_ts_lock);
+
+	ptp_clock_unregister(clock);
+	pr_debug("Removed PTP HW clock successfully on %s\n", priv->dev->name);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index 3fe0e3a80e80..a2082e1299b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -81,6 +81,7 @@
 #define	PTP_ACR_ATSEN3		BIT(7)	/* Auxiliary Snapshot 3 Enable */
 #define	PTP_ACR_ATSEN(index)	(PTP_ACR_ATSEN0 << (index))
 #define	PTP_ACR_MASK		GENMASK(7, 4)	/* Aux Snapshot Mask */
+#define	PTP_ACR_ATSEN_NUM	4	/* Aux Snapshot 0-3 */
 #define	PMC_ART_VALUE0		0x01	/* PMC_ART[15:0] timer value */
 #define	PMC_ART_VALUE1		0x02	/* PMC_ART[31:16] timer value */
 #define	PMC_ART_VALUE2		0x03	/* PMC_ART[47:32] timer value */
@@ -103,6 +104,7 @@ int dwmac1000_ptp_enable(struct ptp_clock_info *ptp,
 
 void dwmac1000_get_ptptime(void __iomem *ptpaddr, u64 *ptp_time);
 void dwmac1000_timestamp_interrupt(struct stmmac_priv *priv);
+void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv);
 
 extern const struct ptp_clock_info stmmac_ptp_clock_ops;
 extern const struct ptp_clock_info dwmac1000_ptp_clock_ops;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 00be2df63d22..487dd492c4b1 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -351,6 +351,7 @@ struct plat_stmmacenet_data {
 	u8 vlan_fail_q;
 	bool provide_bus_info;
 	int int_snapshot_num;
+	int ext_snapshot_num;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_sfty_ce_vec;
-- 
2.34.1

