Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB643264F4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862341; cv=none; b=C9Kd+FP1wB2FPQA23PB90iVFYFVcpxWKAE4rg0jbo2o4v/zwebkjrTKymVrEiA9U/0xqnKeTKlLQXQ9Cj3HJrDTGgdV10icBOZUvKH/2ZQEEdC9ICejYpu+Byt+M7TJ3ZmzrctkS98VRhrmMeMvL5R5ICY0SkwzGwWPedaMdcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862341; c=relaxed/simple;
	bh=qxQI7uzcQMRKF9/PAC53ttmhlmDJgApFacEgoHvUa2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXgIhbY5YLPCptbauv8gDu7yKPMfrUCF+JJTAYIcsHR4uA2NZft/Qd9zI3Jn/5VUGrLpvTnJaYrv66OwP8gO9W9g0T6mtYlDe4tL8XF2H53iVzNHvR+iuy3j+oQqn+ctW9HrLoZIHHieMNZuSW8CXY01bT+M3m4q4IEL26fTrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVGpt1m3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVGpt1m3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso1501972a91.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862338; x=1792467138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=appfE2biJzgupkODLWKmH2RCHw/QKJ3ERvS4ShHq1T0=;
        b=QVGpt1m3v4aTh8sl3KolIh3nHxXploSu4u43XF88laGFd4Qp0gskualaMC+9wpRFE0
         wtmCGhri8uJreyZs+CGptvZ9/H8HkBknnmanrCeGcyxUY7e5PbipXlHp8Y8w1G811KIb
         Iq0RPJlxbLYgeb7s0XCKZPFuSHqr2B+HVyoAwYPS+XCIZ2c9nVgn6i9i5QdEnmkXnLNu
         BKI8UDN7I2bvyTLkZeUCFzqCyyKqv16/LZQUccB0b2FjnsIH/wl2jhLQVQDIVk8RE3Y4
         qzlR4FL5IQ5cy5mTki+/7lLVSiFJ+3vXoglF2gICSRycn6b/yId8G0vsJOEcmCOLjOid
         5E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862338; x=1792467138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=appfE2biJzgupkODLWKmH2RCHw/QKJ3ERvS4ShHq1T0=;
        b=CuT1lI1GzR3Hpq3EIn9UyRpdmTx3JFlaKTIxE57hsvgofc7/e913Zz+hX9EnVXQpuc
         mlMFDOU9cGhtwyVTs2fPCUOnKvAam2PqZhSVoz3XlAM3lcEfMTzBLn9tV5uOhWY1lt+7
         v0RGhU+P46mpTDpwm2NuDFvuwKLm5sY/+CenHjtjmzxKYzzUBxZLXI6e8r84F0j08LfN
         AbfBnj6r5efKLIoPwORlblimlUoCQxHhO9NVSg5V0ORXBxfc0tKiAMb239pB89pTxs8j
         PAyyEOGdiSJKVybcsyF+LVVi9sqNo+Fm6oVVLGvcM6vJ6oY3/5GxBYpX6EAvl60LdvHa
         60fw==
X-Forwarded-Encrypted: i=1; AKwUvBx6bSasb/TqYUHR8m7nW0dXj+7fZYpKuFLpQY++CvufKVkyRAum/i/zq+z86O4Sf+QNL7sBhBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpyqloFiZG30xvd77iEfuY8BUeRrO8CbkAzdy3b+vabYUgQWqV
	UwUdXtbWK9czhltXPDqSkTTtxHcMNembGaSMGeLYXiYrkv4OeVUn2GmZ
X-Gm-Gg: AYBFou3Hayfta7fqiz8N4sRH7pwvjUeUOXzWoNt2J64m4qKpnKLNT1xmk5d0vumPDVY
	9Iw1lp2OQORh16/7u2BzgrKmrFOqijv/RFSl4Tbgz97tlwsYZZYWnNUj/MZl6c1loYwBydMp2X2
	bYyP5Snz08DyNmah9mCriBwHjqGEZD4lFnXVeWAjxLHd8ZSQVqyBWeQ56FFmVrJVrkyNWxxgRJF
	P5oi0ZuuSzQAjgjUinT4Am1Mu072rpGx9DxB0VwoyHSGn6A/IukKXPbkq4UJDZ14vDuvwFLi23F
	pxFTFnKgYY/Ou6TFEGKvgQ2pT/7wI9mVlvXEpkbLRoOwa7DA+11nPUR+NIyUqJt/VNhuWJhM4X6
	UAhjleLGAtHJ8GqXOw23qjYSiYLcLk8bsWoU/HgMi0ZNWKqkmsQN1TJ6fiUcgVmJTl5DCEZZ+Dw
	PFlm1HjiogFnktfuidQLPfF1hJ5UO98AXHzsnUtyns6DjaNyBTP60zG4gfAcXHBgk4Ha3XzQ==
X-Received: by 2002:a17:90b:2e86:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3abe5522014mr4067518a91.54.1791862338112;
        Mon, 12 Oct 2026 20:32:18 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36fdc75esm19541303a91.12.2026.10.12.20.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:32:17 -0700 (PDT)
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
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v8 1/3] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Tue, 13 Oct 2026 11:32:05 +0800
Message-Id: <20261013033207.1684328-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013033207.1684328-1-zxyan0222@gmail.com>
References: <20261013033207.1684328-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Hold aux_ts_lock across the whole sequence so a concurrent
PTP_CLK_REQ_EXTTS request cannot flush the FIFO between the poll and
the drain loop.

Fixes: fd8c4f645496 ("net: stmmac: socfpga: Add hardware supported cross-timestamp")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6d4bc1fe8f75..ee79b74bf21b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -337,8 +337,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
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
+		mutex_unlock(&priv->aux_ts_lock);
+		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
+			   __func__);
+		return ret;
+	}
 
 	/* Trigger Internal snapshot signal. Create a rising edge by just toggle
 	 * the GPO0 to low and back to high.
@@ -349,10 +359,14 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
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
+		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
 		return ret;
@@ -364,8 +378,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		.use_nsecs = false,
 	};
 
-	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
-				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
+	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v);
 
 	/* Repeat until the timestamps are from the FIFO last segment */
 	for (i = 0; i < num_snapshot; i++) {
@@ -375,6 +388,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 	}
 
+	mutex_unlock(&priv->aux_ts_lock);
+
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
 	system->cycles = smtg_time;
 
-- 
2.34.1

