Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF321FF29
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115577; cv=none; b=QYMAm6tVh2YHfgzud1+wINT/yzJam4pQPasulFyBEZ8jzJAWk4DihSMyCtygZR/VC4RYqBAPxbZywKs4XbvQpClSABQwqpCdqjRXhSCWOmQBWZzP9qYw9KilRMrsPcOmfZfp9A+lVV7v4Rbcm5vM/8gqypJl0f7ETDFSy3lcQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115577; c=relaxed/simple;
	bh=+Q5KrLa+RYUVXTCmo/Pl8dhHC3ruyrmu7q7LsWKI10k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoCjQu0u8N6RFUmhNyrqVJFV0HnKmIj1ZUF8nTp5sMAt+w5qH5esT+Os3U0L5PdVVLdgUjOcK7WbY7I66BjpX8AMWhB/VqWovxZMgObmewFUi8su3H2qAYeXIGUwSVnsnpF/wJoM9940B3dM/MAd2PsHp3XCEG8/y5HTgj2eTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCEJoVpo; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCEJoVpo"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a7906f463dso685616a91.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791115573; x=1791720373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTEYOw9n/f+CuyLaWuC1D1eq7TsF3FBxSGnXYETmVL4=;
        b=CCEJoVponTE+tgiGu/XbkZBHE2IncsNHA99ygPNqALXt9F5lm8URTuh///KZkIZKGG
         TWH20tnIgXhD13IzmnZ+2HtfDWkeqwqvQJo3kr6gUR2A373tI9uzymgFkNuT9ntn+m6w
         xieFBKZx5hB73HNRKpE/5mzlQ1Sitp5SNrxrvMnlDVzP+N7T6olvJWRRMceSdwNWG2fZ
         5L6usJxtJV/DYkpIdiUGNZIo6BPCZsa7QE7YBpp1RmR5cVueZsycKBzk5UMSsBvRcpVR
         MWaTz9V6hR4pe2kYgq9Ybqq7gPQCWE/Shi7BgWiHox5JJDYRfRnBXxckHCl9leJE5tNI
         TdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791115573; x=1791720373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FTEYOw9n/f+CuyLaWuC1D1eq7TsF3FBxSGnXYETmVL4=;
        b=a9XrFQgKwj+LvJhtbVp6kMmHUQ8SHngusPv7l8Snptl8gKWGumiow+Uhtcihz3bbvz
         H4RJi26pZ4EsTrgcuuHpOTTpgSodzeerpk0lsZNfVV6kxZEQBbK2wz6G6i9lw0uTGiNO
         4YwNnhqssZcgDNhNvRFejW17E8erXcLHQnzjaauCvxgMLZcDJWbf9UaSd+q6DLl8xP/b
         TQEUspPa+uKQRIq3sqqagHKJysezrb1cHX1MSLlRqnz+Z0mijamx+CUjqggCMw46bbJ/
         096ANNPLKDCuSGN2fTMWQpjaLFfRB/7Ng49CIWccjmmsuK0GxjlENJ3c1HNef8d8ebsR
         mGjg==
X-Forwarded-Encrypted: i=1; AKwUvBwPe3+HbDv8zFsGP8QA5TDWITHmA4vRcjzOhe+rUJY4pqZ8pqfEBEsZ9M84M5Y8h4VOTnJ59JQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlBG/FNo46NdhFCZSvGFld88DbAED4t2hP1q0BTsYN9mcEMcdq
	FeY/6PinoLm5wrF2UvDx4xmjb62Lia5epwjHXq2YaPmHAK4IvZG4BKVL
X-Gm-Gg: AYBFou3Ka88sknZFdqOfNtO0loqUJn/enN8bx24KLc6EXdQ8VlMCitJyGUvwGwwcgZU
	2ew6lFedkKjVNEwzzGHqlSZQjtrb3JMm7dtBrfgo2xAKkz4oobRSguE5a5RO1q2PO4zrCu+t8Vu
	1G8knSFprpskaRs4wa2Cb2fj5gupbGI9XIpTYtSoiH4TBS6AwZzQhUgDiVH0Q5JGK5h9bHTWQmB
	J6Sx9G/V/XtjwNKXC1ErDVP1ZFfS4lRhaFad4FhzgeCSl877W3Q9N2kDC6Qp+ygZEksmU1kL6Kz
	JKJxAN0Q/gSRjWzKahBhPG5EcZUTUdlbC453QkiGAu160a8sBvk+8UnO5kRB5fwTE4yn4XOOHd6
	nQDuhM5kJnuwcmXbBbtwr4X6fGx23GXe14u2M5E4wIUT9CkZrQjsxrGYDD85hmK3sp7HtPf6bsH
	IKvA0NQBUbMI17r6qOashGzTlcKE2BHiwGaCT/aCAgT0z2qNo5y/EFFtOx6I67t3Vi61bkwQ==
X-Received: by 2002:a17:90b:518d:b0:3a4:b418:94cf with SMTP id 98e67ed59e1d1-3a6cec143d7mr6861879a91.14.1791115572650;
        Sun, 04 Oct 2026 05:06:12 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79e7c243csm2603661a91.0.2026.10.04.05.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 05:06:12 -0700 (PDT)
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
Subject: [PATCH net-next v7 1/3] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Sun,  4 Oct 2026 20:05:24 +0800
Message-Id: <20261004120526.2728564-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261004120526.2728564-1-zxyan0222@gmail.com>
References: <20261004120526.2728564-1-zxyan0222@gmail.com>
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

