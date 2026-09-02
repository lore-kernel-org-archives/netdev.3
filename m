Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE237756F
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354924; cv=none; b=RQgFW5nLDRzq6WEC5v9O/FjmaeWFe+dtTDsTBwWETuYTZUaLacr3zrYNEb0FGjclaU229BL9E5+t/kcYEssemIjWc6OBLdHUyJV/WG6dW21lFpZMO0fx0OeimXAYdoDMl9aC6iSGscaIM7JyWXA1DvEboMwR/mqMcQim1aYT77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354924; c=relaxed/simple;
	bh=F9fzgHhX7KmLU7fZe0wIbc7xU5PLz76eTaG+y6Qicy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ea/7UJq1du7XknqAV5lYjdDCmtayPfwyMJGw0hL4NRkkr+Azs0+a739zn5axOjJ6s9g004HWFZSPTER9l54JYD1QrpHUQcy23B2s986IoCCI08iMk4IRbau9RTabSJ67JPbU5Aq9xt+3t4luh+PsnrjUtDfoS1/zcUJFdik73NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sy0KlJ41; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sy0KlJ41"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8557c3f270eso501104b3a.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788354921; x=1788959721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cejd0cZegTiU5eLrTw8z7B4m6z4YgdNMNLU4CE0opBk=;
        b=sy0KlJ41e/2wD4qyxI8BudEND+i9+Lw9Ts6HSM7ANhS5F/rsxq65/rbpxnSGBcdwE3
         PrHI1Er2mpVncRPkvJKSR2vmkcSThB9o/DOalRf1Ui9km/61+a8rbH55L3HN9lYATTzb
         PurPEaUbU0eSTzuCakXdtoO0GZQg54qfE3sS+mX5dovQ0ymf2drl5wDD7Kefz7LwtzPC
         JIiroLiPBj0nxCL9oTa0OQbpqqsOt7WmkPN2vkchYdnPI+5qed0jqmuxWRb7cL8ggQaB
         5Dj1fX0XY8S8A4OqOh38hKqdywHy/2zcjGT5zR1spVbqRL8tYPmXufvbh8UT3lL11vqr
         oQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354921; x=1788959721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cejd0cZegTiU5eLrTw8z7B4m6z4YgdNMNLU4CE0opBk=;
        b=Lkqb43qzvaXd5kGsnkg2xMlXPVYlRkFLxwSD3VjCiWcsEvyZQBH7nXiEuo15w/mIOT
         WEAsNeoDBkpSqPigl/Xk/aFJ+Xkc6ACgcoXpqRIfbSCM2kzFq8c5aIWqiqOtbEEYDAKw
         k6PM6YyOvMVwbsJOAbePhWHloDYz9xG4Ov4nXCp29To9Yg2G5EWDFYN0xLOlwCf2crgJ
         kR+RrnKqBNGPDCxG2VH3GsPcnexBFqOosBf6uAZKAZdgE000OvGtUAMn/W1/J3CIu0/R
         /wTTzNH3eF/QOIP1owwYRki3CDcAJtW1kOoiYNqJkxGoMK//1FcKue5Hq4Xr1MODbc8z
         gvJg==
X-Forwarded-Encrypted: i=1; AKwUvBxCcDYL1KrNJzQZsIZogFJ1vvKSu6nrxNmI6vtKMvaTfimgEOm9eEU+EkZ2vq1+A4YhQyuY148=@vger.kernel.org
X-Gm-Message-State: AFuF++lcCGAwUD75CRP4AtGsmw6E5M/Rpfpo4iG6H1BwWqcRT4SDhV0Z
	yQ4zlqkMjnVhnIv/HYqW8AFBv5/yNTjGJg+1Qem40qqnoMn+wLSqlmS/AR3HgaK9
X-Gm-Gg: AYBFou0osdmI2n+/UPQPUGwc7Nn+R2rsZKOygOD51OoEzm459qw4b43ad/mzoI2++/1
	7nWcRnmTt84PjPavEj6V/E9NXS0dMplX6lEovWl4CiUe2IUTeGg4K17U6VRSTCp9QUWtM+5on3c
	opXNAFyi0NbgwaLtzwUWaVwQIbEsCfkrOtfjfSp+N5MKXhTecidDtJuPrp780ycXv0bCan4Q06F
	0zodMvo2I/li+bfrDxvRN0RS474nzBnf0rnBg4eyxLGf1H1xqkmzmRTlmB3A2hOIgLMu+KIGIYC
	mnJ7GEJEof33R/tvMrhYG7OH/q9V6AY0m5s622Xg1cdfdQdi6VCisLDEbUleuaIGD8nnekhDo++
	lx8vkOrxZM/1CHlHZCbh1qV3s3JStsVVjC90T0It+ieLyB8DrckdieT2JHgcVWqVtpBZpg9BolL
	yY150Ea8RfQShE7tfwt7/4HUFYvmMJig9GtaX4Yvr1S5Cuh1zKqCG8QN2Y4cM=
X-Received: by 2002:a05:6a00:6c99:b0:84c:4b58:2cec with SMTP id d2e1a72fcca58-85ed8ed8ca3mr7824675b3a.15.1788354920846;
        Wed, 02 Sep 2026 06:15:20 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85da342023asm1398533b3a.0.2026.09.02.06.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:15:20 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	maxime.chevallier@bootlin.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v4 2/2] net: stmmac: dwmac-socfpga: mask XGMAC_TSIE during cross-timestamp
Date: Wed,  2 Sep 2026 21:14:41 +0800
Message-Id: <20260902131441.322167-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902131441.322167-1-zxyan0222@gmail.com>
References: <20260902131441.322167-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Agilex5 smtg_crosststamp() handler arms an internal auxiliary
snapshot, toggles GPO0 and then polls XGMAC_INT_STATUS for TSIS in
process context to learn that the snapshot is ready.  Unlike the Intel
cross-timestamp path it does not set STMMAC_FLAG_INT_SNAPSHOT_EN, so it
relies on nothing else consuming TSIS.

Once XGMAC_TSIE is unmasked (done by a companion change that enables it
in XGMAC_INT_DEFAULT_EN), the DWXGMAC2 timestamp interrupt handler runs
from hardirq on every timestamp event and clears TSIS by reading
XGMAC_TIMESTAMP_STATUS.  That read can win the race against the poll
loop, which then times out and makes PTP_SYS_OFFSET_PRECISE fail with
"Wait for time sync operation timeout".

Mask XGMAC_TSIE around the snapshot trigger and FIFO read so the hardirq
handler cannot clear TSIS while smtg_crosststamp() owns it, and restore
it on every return path.

Tested-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..a4d00bf81423 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -310,6 +310,13 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
 		return -EBUSY;
 
+	/* The XGMAC timestamp interrupt handler clears TSIS by reading
+	 * XGMAC_TIMESTAMP_STATUS, which would race with the TSIS poll
+	 * below.  Mask XGMAC_TSIE for the duration of the cross-timestamp
+	 * so the handler does not run while we own the snapshot FIFO.
+	 */
+	stmmac_mac_irq_modify(priv, XGMAC_TSIE, 0);
+
 	mutex_lock(&priv->aux_ts_lock);
 	/* Enable Internal snapshot trigger */
 	acr_value = readl(ptpaddr + PTP_ACR);
@@ -329,6 +336,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		break;
 	default:
 		mutex_unlock(&priv->aux_ts_lock);
+		stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
 		return -EINVAL;
 	}
 	writel(acr_value, ptpaddr + PTP_ACR);
@@ -353,6 +361,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
 				 (v & XGMAC_INT_TSIS), 100, 10000);
 	if (ret) {
+		stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
 		return ret;
@@ -375,6 +384,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 	}
 
+	stmmac_mac_irq_modify(priv, 0, XGMAC_TSIE);
+
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
 	system->cycles = smtg_time;
 
-- 
2.34.1

