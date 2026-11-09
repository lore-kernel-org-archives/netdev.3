Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231928;
	b=EICRU2U93DXuZUaoVIt5LCkZEa84eMi/hQPwsYeTwltswhBXRRf/VfhW0LBcdKAXzv6e
	 N0AbN40C0x2cfUMAK4Uk73fHyxJ+tvymaFmQVO3+lhaJLcpbTTBS/hjhCZjeX1hPnBt/V
	 F7UVqOm2/Hx6kILNxZR4ZP6xApdRsrX2lQzu0dPOEImpsc0j4iaVevouK5dMjRP4b+MrA
	 6g6IInTBrcX2fjoXldigDppMGgPwrLY69rZHFUxQFbHWK/nE6qtFnQsaLuJ7aBMvcarIF
	 b2D0PPxYiaJMM9Iqkmvq1+OYhiFDuKYuzzUPabQnY9bYb7vAHOlFJ1yeEEYQUP3xFNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
	b=QKskPU4OcWrmdVfgpseJ2tWM0Gcm3DIRVzuW4XjwjGTDfUnWXZK+rwm8+YDwl1KsFPB9
	 n10hL3OHKCaoYKV2Bk/yyjRqwTfoQLhnmOP4tq4flbYIug19HoP+dj4sThlDaqwQpj2tu
	 JnoSZScu39IEnpCWWXzVv6GP1JK7cPnf87WHh8IW959UxgcnnrrjriebIZhnqMBlOVKHW
	 0/NhgOPl9n7hACwtcSGGEqw6ZKeq6ZDiylwEH2vCDbHnYRKqAePDBrkPSlrfQK0Tu3QeV
	 6joF4GfRE+Q7uPmU7GyeRhsgmgq9VKvfIQvBBbMo+jAomVp7hST2IIrkNBS4RmYMzSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lntKLG1W;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55C606D804
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 13:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB55C606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lntKLG1W
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so307451a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231927; x=1794836727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=lntKLG1Wz33t5Qj17jC/tC3S0IIMyWb4WPH64F0oOzWRxmWkzGRPHy5SJSuJIMKfZm
         Xjw3giTGvEKF97qFw8CSiRId0IdtdkLIZ1BB2z97PVXdqcWDR7PighHDGpUmoZ7fqG2X
         MDlenkCrXSjTl6R63MZKr06JUwHvyraCtHLF8Dzo4qe+PwPlRzSlrod39B5S69V8TyL9
         xxmXcgvQxUIYgVr0f17mPipJ1Y3RblEwuqLsQGbFJU+nV+S3s5B12GiH49bAeh9n/3mD
         SRl8FJpdCdg8flaAN8vVgmuYKh2yljVGLClNOD4BhBgZQBwbALYG1wnbubo7kOXGhyQE
         ofPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231927; x=1794836727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ROzI5pFKC1DlvyH7PwbH3PaOSQ+SHEt5iuezD/Lo1w=;
        b=i1Vnw20GUyI/YePTyaZvHzbmsToJPxlmQveL2MGaHi1uKmcJKj397QhMjBTXEpBHId
         X5qIVTxVr3wQhxg1bXRGhmZ5Kder1CA/5WJFjESyMqs+o3LKhZ2ng16ihaHYbgrWkWE2
         o+42y0srhWQDM9HO+a2wpK09RheW+Yi/ea0jFEOeV7KsDGddxs6OjDrQBEaohdKEaH8a
         NVmpsr0tspf7HSxa94iqReR0vM5oeVdxM6EG4yEVSkBiipIw/FZYahvQYaSQa3WDH4PA
         U7rVrV4sY9KOFaPWvnNIminoKqtdyoShbKNFEv/EBqA4+xi0MZ0Fs664RIyXtrirlj8A
         LWOg==
X-Forwarded-Encrypted: i=1; AL+hErGMFnzS/RXDPnepag9Nc//vUErd8SpxCDo9B5L+cAuxpcwAmjwR9Y5/jyzH/u5Jl51y6E5kG3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bncoGoIyIDEGBcZmrGW3yhsRNNDD2Q4T2Wu9anaWlJpMnsNwD
	xt9Rv5/la0PbpPVjemZW1ZM93e9dRm959G4lfu/kbWrW81KtaZFXvqO1
X-Gm-Gg: AYBFou2st940O7UJBFOS7jNc9MMlcNuISJQ1UF2G59A9FKe6n3VaatAEmHxR85YqLIV
	vx7useMtYSSGcsiN7U5goRa+mj0aQPjB9viylQTpStx4JVjjMlvcdjDOsmuq7/e0AhCYNTr5Iop
	N5T0l4ANognjZFI2+n/Cv4r9sF378kgpu5hSQN+f0xnwsfj6kbo5GECUC0a4K1k1MwuoZHWcyoG
	vDRe3o3Yo8njJBj8i1KJ45K9O4EDF9j1olm2ehqwGQoYc7OEQ+TWVgGL2jwprrfoi0q0Qz52jq3
	1i0Pjw7qHYnrWgTxKbQ0kpgEHdB7VHUpNcuYtPs85GjDAIi95j7Q3gvmoj/WbOLv4Si+4gd7yx3
	berkFivilhcIv8GKrYpwpiMvP/va6F/rpOUUMcBdfJXKsScf22Ywh0/EaocWWwrk+GkmG5WPYsu
	p+U8CeKtZq/Ejt21AZiBu881zmImq5f9++iM+qUyNkLG2b53cvxoAMp/ff7mqsheoVVVmy7+Mx4
	E5ZLCCMhk1PPT2jWHnKNRaACvg2hzrzNB1X7DEaA8z2LMibX65M9dtidezJM+vxo1l8ncd0RNCg
	PP9FoxD+5NrAKQ7VvqrAZZXFT+F2
X-Received: by 2002:a17:903:3890:b0:2ea:1b9b:b938 with SMTP id d9443c01a7336-2ed83791011mr36027055ad.55.1794231927034;
        Mon, 09 Nov 2026 05:45:27 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81727f9bsm11014285ad.57.2026.11.09.05.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:45:26 -0800 (PST)
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
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v10 1/3] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Mon,  9 Nov 2026 21:45:04 +0800
Message-Id: <20261109134506.2794160-2-zxyan0222@gmail.com>
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

