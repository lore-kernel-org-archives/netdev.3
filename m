Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856C4766BF
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059687; cv=none; b=qBH2FDyK5mHsGx8kNfMwY1/abxnS0bq0MxcR8aTzmvIIF6YLYD4p59seSFDC8odFy3m7av3ydfU9S0iqQQcCHiNa7nRWJFiDpwprKod/897cjNemWuwkgEs3PdtgpLRJgY0I87UEaQEEMZkorQXySeghnzRda68rCWUR5JryELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059687; c=relaxed/simple;
	bh=hKXgIueQ+cktyJ3NvuIdviR5rHT5VkYLFJZj7Ezv9gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StP7EbSsokJE4uhPnaOkK6prCx3dcjSXI1Feru+7UQwQvswPaBOAJwJBeSEzgLRjkV00ayXSnqZRk1W8j6T5LRpoqUnizWkoBq13PsdFpjmHQ248Dd6Nc1pUo7mehzN8zKNk0HLbB0T3nxreCuQoC/LSfad+StQsJbSbKyAHjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyW9vgPi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyW9vgPi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso1504356f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787059684; x=1787664484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djPZzMb89wYlNjLL6Fty3Ib9LSWHKIU4RnghfXD9YU0=;
        b=GyW9vgPi3VKZAXKWNVwxYUI80wrImrCMojgMewxH/nG41g1H7jZKOPQMg9exZtBdiP
         uvx96KMQlSwdF67gf+vx1JBpMoV6DMPQ2L6mVjOMl4ck09bYO10vb1rDa7eYNcWCpP8t
         dDVYwyPI8bbSBhM4vElVqP2YGbt8Zkru9Xntl/iqgUJLu39V5Q16tXci6A19I6jC1sBA
         YUL56d43p+49xKDw4nqucc9XZDDIZykpISG8Uu8ZZDIUkKDY1J3RM4f9OygOo9NGs8Bt
         m5m9epmcZDViCRTh1LPI8OXDX/95zOGkLzj0wZn9fqkM8R951t5oYw6YGvkVAzy4CPHb
         Ir2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059684; x=1787664484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=djPZzMb89wYlNjLL6Fty3Ib9LSWHKIU4RnghfXD9YU0=;
        b=ewQmJI8zV/i/QeebP9U7Gt0Hq+pyIwb/0VhbFwMP31nyN8oRrwNLj2559m0QWKhGhS
         /8+zpTiTi3FsBl1FyKW0nTG5trLsjh49NnFuX1pykry0QITLnUzLECBpo/8SmPhS2mXo
         bTRWlmD8INzohoWqLijYkTPUEbKKyja1OH53rz9YIj0rWJeZt5UXH2ky4EdQwGGicM/P
         7Ri07G3PuBMuJ0gbq3lLGzwKIUxW8qW+TGPHPPhSik00HGcH2bFT62vBWtZ3IDa19Vq4
         kQbv6P8FUvItKMtX+bF7rlMBi4Rk7XPW8c9nuu4ueE3bKpQvUrTAC6RfQWIFuMXXBBt9
         zKNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdFSc9Nqss14RjNXWqYznpHmunxszB2MQcAC7MvIFZgLXZHCoxCA2yY5Cxat4zlHdp87eAuqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPy1blx3GYHIjXg9eafgpOeogTIaDqeGK4wKgEmDsRTUFNVJs
	O4xBX3B9blT9y3yMMNQ6lSyB34xzi8oRZg+yx6W3sk7uysEu/HT0MjjI
X-Gm-Gg: AR+sD10KiXAHMnhTBpI81XKuvl+x6i+JvPQbmLxt5LK2ZbDf42kQ/gyRL+lFECj9R2X
	Z7v1dKWyAZ5H83qg296zljjplg/1Yh9gGX64EASbRE9Cw+q1W7De4fDNK5u11HyHn3d5pNYazRd
	edJNQOancbwQeFgIC2Ymj6ag27z646nxl7tIGysL8gs0ttjN6sg6b4g7IHNjFIrSFisoChWMc0r
	CEm7CeH29SN5nReOnmM2FOv6LKTo+LPB2neCD4MNd81I4ZpYye7Jzu99dA5P25dLKGTOnF3ArFh
	r5E9D7DSUlGkN5sOijFOZBPHUKiC1f2JGlmoI2pAhK/WGFCijtOmD8vJ3ZzxfWyxhb+IsCz1xcK
	/XMpP6kMEQErXbWkdNcKDIdVpm2DLuCgJkKAtdHoMvr5Kx+J7YAF+SS6usoPf1fFzKnKMoALTzh
	ReIZPrp5yBuszorfdMrBOYsmjMebpPfrGRqi+13yFUXE1m49SiQTPh0AGCmKU=
X-Received: by 2002:a05:6000:1a85:b0:480:c5:d635 with SMTP id ffacd0b85a97d-481606ac8bemr51077592f8f.0.1787059683663;
        Tue, 18 Aug 2026 06:28:03 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c568sm12140145f8f.18.2026.08.18.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:28:03 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v3 2/2] net: stmmac: dwmac-socfpga: mask XGMAC_TSIE during cross-timestamp
Date: Tue, 18 Aug 2026 21:27:22 +0800
Message-Id: <20260818132722.1852876-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818132722.1852876-1-zxyan0222@gmail.com>
References: <20260818132722.1852876-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Agilex5 smtg_crosststamp() handler arms an internal auxiliary
snapshot, toggles GPO0 and then polls XGMAC_INT_STATUS for TSIS in
process context to learn that the snapshot is ready.

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

