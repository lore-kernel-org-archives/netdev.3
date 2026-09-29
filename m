Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69E36B918
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667439; cv=none; b=VVjt/3KZKnRCp0+AO3POQBuQnoVUGr55xFtAnirKyvnPrk6xkLi9gzsTf5qDWa+HxNSw5FRWA2ndzNTFb7JImR1A25s/K4ACzpWethPTjHE9wJbNL/ykqa6RUeLfNse4RFAk5WlWqoTcbk1j8R5skNnE10XVufbmgD4kark+n8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667439; c=relaxed/simple;
	bh=+Q5KrLa+RYUVXTCmo/Pl8dhHC3ruyrmu7q7LsWKI10k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2fnfm45JiF/EJnoLfSJeKQf7lOwZXyKpW6Bk8PxrbwT2IuE5rNGDSrRPOMFuocTjAvP8vsqtu0E/9CIC1Ak+zNvOatTTj4ffAv65Dq7K26Apitpyr6Rmqm3uxIgz3zm81BeElrrib6nmtb/AZQPREB6+dMNu22COUguyWRH6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXHMLy59; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXHMLy59"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1dedso1117014a12.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790667434; x=1791272234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTEYOw9n/f+CuyLaWuC1D1eq7TsF3FBxSGnXYETmVL4=;
        b=pXHMLy59CGs73+DmrA1D0zs2/nEzcu9D+iqgGcE+AYC9hJPzEsmMsA9vZe1xdyrQ1f
         YH6RPX+FJSdG1/5GyqOY1OYlKOSHscEFIGRJ6eHWlg1MsGqNMPCIwsfSQSt+BcqOLBXW
         yJ8r+gFYdUfi9fABMJlLyfi1H7HXOnoUqV3dzFKKHD4Oo7VBtNW5i2qNK1AFS/qeYrZ9
         H7hRp4YNCutKQ1sNdzA39ikCILPV64nDgcAX3fhJgITrA7+McTQNPqfDaDDafZ/ZmWjT
         BmqqUeUieM7rgfnSX021DWkB+uPr4gHRNDrTioyG3MvzQI14eXowMCaREM6UbtRRqEar
         45DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667434; x=1791272234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FTEYOw9n/f+CuyLaWuC1D1eq7TsF3FBxSGnXYETmVL4=;
        b=n0fw16efp6TFgjdKUN4vFPmAut4vBXoU35EvUPf2dQor9LiPAjicYsjDKJh5qYnCHY
         YaxjJ2QRodjtSKqOotWRiOsGGj6FZFfQQHkzSSAG/81lKA9eUKHspasaac1sDdPksT+f
         F7s3VXZlgNyM5w3/XKbVp6cFCq6fSAoSLwkSwW5ugVpPs6Xd1Gj+R7ag9RX49/Mxw3M7
         W2Q8iLaWpcjoGpCpmqu80IwqtzpCl512eLsr7wI7HubYVofB2tg9KuNL7aZcJoapnM2r
         UcetchmtmED9yJ60vLmPUq/oIGWtQeuWJpVkMIU2YLgo1zBtgfZKY22fO9L/dpx4dKgd
         V3jg==
X-Forwarded-Encrypted: i=1; AKwUvBzzyEEss1zYxFwqD3wr+NqIVRFDfzKwVJa0Lb74KoEEgVDLGjz+9m1jHYF0zulZjFUAS8qSXZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFH7aVRQ+0fP2JG9PyVUaCppHlWKXgVvmJWdICOFXHhUa0ox/a
	/OL7k+xnKaGnRunilGMPVLVdfiTFYFBhdRa1ndOC0NljHCd+SD+9lyno
X-Gm-Gg: AYBFou1+p+waDNu1yV6CnlEhzWepbZ9vBuLVnoiEV3aPF36ARty5H5VmF8LvQ+JxwVP
	pDkXJ4vEUm293wSzPvUGgPTPrL4oKjse6yi4gxlvapZuUnqpXr+RWm4GUicLAzQ5W50cp2Cd8Ro
	rVKXwN5umfgsdbcS6N8/zhS6/b5rGtY8rQjrLHFHa3uS3BCTdKIqAzLBZBWwZDPYXpNDT41bFA2
	KufSgfN3W3fLBVfhKgYiQWlcpRk/JWYRyXfLKmwiLE/d/hApwFAb1e6qJMv7MBD0l1iYleo4mwM
	Cy4ij8jApS0S1ZHLXjj47XSLuK6w1snl4BolTkqZgCioomVQptC39HeELNp3ABc+XSab908Xc8W
	hfhdYnGfu4VGQUYwhj/lncWJ/UfjP0mbX9ohteUChkIjch0LUC6iosZ576hnDQA5hMOTOW7IQ44
	ymGfuO5FkmuOG6/iJN07/nIAEmnw9bCwQ/nBtTvkacNbChckkk/qI4CveZ2Vyz7Sz1oOisrQ==
X-Received: by 2002:a17:90b:4b12:b0:39e:6c6a:4b78 with SMTP id 98e67ed59e1d1-3a098e43c20mr13687872a91.66.1790667434388;
        Tue, 29 Sep 2026 00:37:14 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498ecc986sm1328708a91.3.2026.09.29.00.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:37:14 -0700 (PDT)
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
Subject: [PATCH net-next v6 1/3] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Tue, 29 Sep 2026 15:35:51 +0800
Message-Id: <20260929073553.4136336-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929073553.4136336-1-zxyan0222@gmail.com>
References: <20260929073553.4136336-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Agilex5 smtg_crosststamp() handler arms an internal auxiliary
snapshot, toggles GPO0 and then polls XGMAC_INT_STATUS for TSIS to
learn that the snapshot is ready.  TSIS is a transient, read-to-clear
status bit: it is set by any MAC timestamp event and cleared the moment
XGMAC_TIMESTAMP_STATUS is read.

That makes the TSIS poll racy in two ways.  A stale TSIS latched by an
unrelated event satisfies the poll immediately, before the auxiliary
snapshot is latched, so the FIFO comes back empty and *device is never
written even though the call returns 0.  Conversely a concurrent reader
of XGMAC_TIMESTAMP_STATUS, such as the TX timestamp completion path, can
clear TSIS while the poll is waiting and make it time out with "Wait for
time sync operation timeout".

The auxiliary snapshot FIFO level is also reported by the ATSNS count
in XGMAC_TIMESTAMP_STATUS.  Reading XGMAC_TIMESTAMP_STATUS does not
affect ATSNS, so the destructive reads above cannot disturb it.  Poll
ATSNS instead of TSIS, and wait for the PTP_ACR_ATSFC FIFO clear to
complete first so a stale ATSNS from a previous snapshot cannot satisfy
the poll before the new snapshot is latched.

Hold aux_ts_lock across the whole sequence instead of dropping it
right after arming, so a concurrent PTP_CLK_REQ_EXTTS request cannot
set PTP_ACR_ATSFC and flush the FIFO between the poll and the drain
loop, which would leave *device filled from an empty FIFO.

Fixes: fd8c4f645496 ("net: stmmac: socfpga: Add hardware supported cross-timestamp")
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..c5f71bfc7cf4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -337,8 +337,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	acr_value = readl(ptpaddr + PTP_ACR);
 	acr_value |= PTP_ACR_ATSFC;
 	writel(acr_value, ptpaddr + PTP_ACR);
-	/* Release the mutex */
-	mutex_unlock(&priv->aux_ts_lock);
+
+	/* Wait for the FIFO clear to complete, so the poll below only
+	 * observes snapshots latched by this trigger.
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
@@ -349,10 +359,16 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	gpio_value |= XGMAC_GPIO_GPO0;
 	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
 
-	/* Poll for time sync operation done */
-	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
-				 (v & XGMAC_INT_TSIS), 100, 10000);
+	/* Wait for the auxiliary snapshot to be latched: the ATSNS count
+	 * is the FIFO level and is not affected by reading
+	 * XGMAC_TIMESTAMP_STATUS, so concurrent readers cannot disturb
+	 * the poll.
+	 */
+	ret = readl_poll_timeout(ioaddr + XGMAC_TIMESTAMP_STATUS, v,
+				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
+				 100, 10000);
 	if (ret) {
+		mutex_unlock(&priv->aux_ts_lock);
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
 		return ret;
@@ -364,8 +380,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		.use_nsecs = false,
 	};
 
-	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
-				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
+	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v);
 
 	/* Repeat until the timestamps are from the FIFO last segment */
 	for (i = 0; i < num_snapshot; i++) {
@@ -375,6 +390,8 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 	}
 
+	mutex_unlock(&priv->aux_ts_lock);
+
 	get_smtgtime(priv->mii, SMTG_MDIO_ADDR, &smtg_time);
 	system->cycles = smtg_time;
 
-- 
2.34.1

