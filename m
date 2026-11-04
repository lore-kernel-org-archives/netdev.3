Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796644;
	b=xRT4prDERqbfEZq+3LU/bXRu3fCsi35PspI0R31ysQXStK1kEIi/bncx16n5Ie2urpvP
	 NO4ms5EjHJ4V2JKdF7h3BVfhD4BZ0w6HZX0DQ1yky4iMFEcQAYp8eAhNAjJsQmmQLVG/4
	 40yYNZxxCxBjZldTsnJcyTG05j2mtssjz234xf5ja9RufPDJi2d/2fHWoGg4PkcoPSMfG
	 RR71t15EETntib0IAL3R0x7msxleIeyeUZ1Qwl5oH5TgoH7aKFq52AvR8E8QdPzAksKYy
	 wwK6KI5HNRhiBpshqEvtrg2dKW9Lh/+IOxlOp+nU205Mo1pMUjFpfjG/PSVLs7Sbc2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
	b=IwIjOhWypqGWf/4ADj6eO3SXKhIWHdqXVgpeQ6tP8uB6MmjUofz04XNUJaOycpSzAkCz
	 M+FWdTVtEMty/Z1QLh65UF/EmbiYmmao0UfK2cHEJ2z9AMRJsdEp6fYXsIw5KSrRJe4gL
	 X4MNeUX+YUios7H6QS9OKh62jMpsXF4cs3Ar2vupYbyhkfp2vB0/1j16/EniM9BDX2GNU
	 iQ/ZxY/40Oij+vQ2HAxn+qzFdd9KgNpdvLcuMwqgQTjZ8fNoKxE49QdNdjUyvTy024UQv
	 6yCekMbdN0tKyy+YjC6qCtdTu+77a2+YKdA/nnjOxrzEr/yb56os7OsDcDbD/xdp9Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMFbhM2y;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B256606A33F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B256606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMFbhM2y
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso430882a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793796643; x=1794401443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=sMFbhM2yZqNp1QsenblfNuflgzQqV1qIObFqoNvDmLTQFwizMshMoTwqd8c4j1nWgZ
         9Gp9IJfRt46fUxRXrTIak+2sUq4S47NY9nxJfxRMpK8imKTNijaiNhaw+2yJMJOEsZFd
         VUawj8RRrkmetGzGGDk0flaVR2vTq6H2HA78cfwxkFN1qycwxpZ2YFu7VgMZpiQKyaiD
         ILfLXOB9ZC92ffaonCtnpKqFmonnZonmbaFltOqJfl7BZKMCRQlkb0rXVLgbLWizU0K/
         Dv3V41nHfiKuMxTcoPr6OH3+53EAvEPhOwTuWXayNZRvm0Kca6vSCVav8JoPO+45nmhZ
         pw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793796643; x=1794401443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=VqaBTR44IFzv8GZpsg6XjNKvghOkahnA53aClQu/KH3l7EdCtv3WcSaEKIClHYl8Jh
         v4cSlrD2M5pV0L4f5ymyX80qfcIJWFPtJiqP5MxN6CZGSpVHMyBXq4JvkQx7ELpSVH9e
         YBLNlhKb5RRDIR0oS/Kh0ipNq1/1BjrtCO3LvgWbnPzHm7ad0hKzCnn+xr8I0pYom2w+
         u7DM/ZswopT/PIo26JgLv9qV+XFXY4dkktLJ/lSZN3x8ADNdFFAZQdDXUFakTCSk38Sq
         jbQUgZUb9ydc+fFw3jkCeV9mk/LzxMRAtP8EYx1zxnU+PAun+m+IsLP9zLR6JdAoNjLZ
         gsgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMOgIm/6ggjOwRRjaM1hvLAWAdZFdWeq0PHA3NBZDaTqYHg1Z52K5JXHtNsdyzLJU0bhXffYE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8L2ymQgIMvDvtIQj2VjiZzZwnqGmuedYh1IYZyxUVS32sms6KR
	9UtwGpxSbpb840+qBnAgFHDnzUDUCBqArEteiRoYaa89xLN6lU9Knx16
X-Gm-Gg: AYBFou28MnSOimXmHWsknhcRKeXBnR+O/CQof6rOHZO4DPPdp+pstTS4RLWBsl+YOb5
	F7GtTauOMy6ruMIhK1XNTL9y0nxu2q46/ZHSlD0O4b9jDwWM4WuapWSq4tatIM1fgwGLnC8eAQf
	KZWMnqOlBr5FHua9M9kULgDPUtfnd4ifLQj/G6mJ1XnxNDFs4GGpeMzwaY1fxxwnhzYZJfQqNiF
	pzMTkjehxkrWNF+5cddMInXOA1/QwV8vrGnX20xsTc6wxOnTDF/Qs5tOgo+MGYv5kvpuYnySWMx
	Da/S9mv9NiKHsCkrw2554ys0GN7fC9YazAtPprBfD7pcVGIK1V6TMatSfMdm4+9wftafDSp2TGj
	l4hOGPoqEnpqQKhFHpDp0VJxY1nbEfgERObWoBxyORaBEKvaGh50ZnRPS0v5fr+i2IU05rGL15U
	Sh3d7h4Z/GkRqO3f42d49Q4TKv3oyxsRsCdBCkOWsYF299QEgeGK5nVSdQzQYITKQxxr9pahi8A
	QSwMqHwffxboUUJaiDU2DSp01iRtAWOwIfRV04CzNGPh63u8f6z7Mn61SxdikiKoEeBs7KRLdcS
	0eJ7ANtDZ4UDRRqz4cxfDuK4UZjw
X-Received: by 2002:a17:90b:17cd:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3ae89851212mr12650512a91.61.1793796642926;
        Wed, 04 Nov 2026 04:50:42 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm3920799a91.9.2026.11.04.04.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:50:42 -0800 (PST)
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
	o.rempel@pengutronix.de,
	wojciech.drewek@intel.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v9 1/3] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Wed,  4 Nov 2026 20:50:28 +0800
Message-Id: <20261104125030.1183146-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104125030.1183146-1-zxyan0222@gmail.com>
References: <20261104125030.1183146-1-zxyan0222@gmail.com>
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

The Agilex5 smtg_crosststamp() handler polls XGMAC_INT_STATUS for TSIS
to learn that the auxiliary snapshot is latched.  TSIS is a transient,
read-to-clear status bit, so the poll is racy in two ways: a stale TSIS
from an unrelated event satisfies it before the snapshot is latched,
leaving *device unwritten while the call reports success, and a
concurrent reader of XGMAC_TIMESTAMP_STATUS can clear it and make the
poll time out.

The FIFO level is also reported by the ATSNS count in
XGMAC_TIMESTAMP_STATUS, which reading the register does not disturb.
Poll ATSNS instead of TSIS, after waiting for the PTP_ACR_ATSFC FIFO
clear, so a stale ATSNS cannot satisfy the poll before the new snapshot
is latched.

Hold aux_ts_lock across the whole sequence, and refuse the request
with -EBUSY while a channel is enabled, so the PTP_ACR mask
programming cannot disarm it and a concurrent request cannot flush the
FIFO between the poll and the drain loop.  The lock is held across the
SMTG register reads as well, so a concurrent PTP_SYS_OFFSET_PRECISE
cannot retrigger GPO0 while they run.  The internal snapshot trigger
is disarmed on the way out, including the error paths, so it does not
stay armed in PTP_ACR after the cross-timestamp.

Fixes: fd8c4f645496 ("net: stmmac: socfpga: Add hardware supported cross-timestamp")
Cc: stable@vger.kernel.org
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 52 +++++++++++++++----
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6d4bc1fe8f75..2d3c6702e203 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -304,13 +304,15 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	int i, ret;
 	u32 v;
 
+	mutex_lock(&priv->aux_ts_lock);
 	/* Both internal crosstimestamping and external triggered event
-	 * timestamping cannot be run concurrently.
+	 * timestamping cannot be run concurrently: the PTP_ACR mask
+	 * programming below would disarm an external channel.
 	 */
-	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
+	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) {
+		mutex_unlock(&priv->aux_ts_lock);
 		return -EBUSY;
-
-	mutex_lock(&priv->aux_ts_lock);
+	}
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value &= ~PTP_ACR_MASK;
@@ -337,8 +339,21 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value |= PTP_ACR_ATSFC;
 	writel(acr_value, ptpaddr + PTP_ACR);
-	/* Release the mutex */
-	mutex_unlock(&priv->aux_ts_lock);
+
+	/* Wait for the FIFO clear, so the poll only sees snapshots from
+	 * this trigger.
+	 */
+	ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
+				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
+	if (ret) {
+		acr_value = readl(ptpaddr + PTP_ACR);
+		acr_value &= ~PTP_ACR_MASK;
+		writel(acr_value, ptpaddr + PTP_ACR);
+		mutex_unlock(&priv->aux_ts_lock);
+		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
+			   __func__);
+		return ret;
+	}
 
 	/* Trigger Internal snapshot signal. Create a rising edge by just toggle
 	 * the GPO0 to low and back to high.
@@ -349,10 +364,17 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	gpio_value |= XGMAC_GPIO_GPO0;
 	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
 
-	/* Poll for time sync operation done */
-	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
-				 (v & XGMAC_INT_TSIS), 100, 10000);
+	/* Poll ATSNS instead of the transient TSIS: the ATSNS count is
+	 * the FIFO level and is not cleared by reading the register.
+	 */
+	ret = readl_poll_timeout(ioaddr + XGMAC_TIMESTAMP_STATUS, v,
+				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
+				 100, 10000);
 	if (ret) {
+		acr_value = readl(ptpaddr + PTP_ACR);
+		acr_value &= ~PTP_ACR_MASK;
+		writel(acr_value, ptpaddr + PTP_ACR);
+		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
 		return ret;
@@ -364,8 +386,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		.use_nsecs = false,
 	};
 
-	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
-				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
+	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v);
 
 	/* Repeat until the timestamps are from the FIFO last segment */
 	for (i = 0; i < num_snapshot; i++) {
@@ -375,9 +396,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 	}
 
+	/* Disarm the internal snapshot trigger, so the PTP_ACR mask does
+	 * not stay armed behind the software state.
+	 */
+	acr_value = readl(ptpaddr + PTP_ACR);
+	acr_value &= ~PTP_ACR_MASK;
+	writel(acr_value, ptpaddr + PTP_ACR);
+
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
 	system->cycles = smtg_time;
 
+	mutex_unlock(&priv->aux_ts_lock);
+
 	return 0;
 }
 
-- 
2.34.1

