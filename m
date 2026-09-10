Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF33A7F54
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027836; cv=none; b=e8dSovS2B6n9qfRu/1E/7a05yF/xhnXSI7aLD7yQ1g4dGHHl2M4+EVxQS2/xVY43gfbrS3Up6aaspJ2OfcKaHUfZgVHZNn1tNz0dH7KM70vbEnrogx23MN0bJWv7szXZS0yqWy17nmzap3HN3t0guHWQ14ocw59tlEOLByCqqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027836; c=relaxed/simple;
	bh=7A+U+74WGkXsYGVAmxIitnef1L1YpX9QdK0dK/NlEMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hc1sy7i/w6HivMjHKRetPi92pLt5Q5qe/G/ScWSp/5eY8j7B5+fArw4vQVSezImxCKBpjUx+62FkgKWG3KBKYq31KFXT87g85TCiCv1TwfVw4pxl8cFxMA7o74N9IgLPAZMjkIsy6kNImXQfcGajvo4iBoWqgmP0exbWK9Gma+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kosq5C2r; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kosq5C2r"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so5473896a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789027834; x=1789632634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31zePXVLBWNEdCU+Xr18Au8ugINcScI/iDLGt4y6SQ0=;
        b=Kosq5C2rlL8LfUgyjd9vm3IYVSY7Iq4dygWi4aGgKoQLmoPmYqkZEasKLH5w+uF1Ui
         EEs4ofaSNYqS/QlKDpUPXJxJRhhCDzb4zS8qjzA5g3D3+7Gwm6i+NDveSxtOueHSTbMK
         t/pP5q2vMP9tMWSAHu8xLGXFiesPAL1AxCvk0CZ49IH2MKTnx+g2nXTkigGOSUBon9Ss
         /fiEb5t5bvraftAb+/TldzUgBjwpATgEGa+maCRJ5PcUZlBQFHvhnH1e9v+tzNcqGKvd
         xvVK5veRu1HlKbYLO49F+S06e/0RR39Zvoz2tkGz9jJNzVm6pqhHyFUeLgaQ9y4qXoh6
         ugbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027834; x=1789632634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=31zePXVLBWNEdCU+Xr18Au8ugINcScI/iDLGt4y6SQ0=;
        b=aQ5VjZoAwkwX4A37I02cVaAwZMC+fXTv7QNddy6BX64cjVx5rLRfCiDTWMQLnU9j6r
         SMRWRVdomFoLeX3jHIM8faCx1KvwY+lZNYs6m9hkat5+OtV7z27t98P4E4rjDO4p13pR
         M6U5phTS5PqL+wnshm2XcQ4eyV5+troP8Q7/LnaOtQfRkHFQWCWu7W+x+SigZRtFTP9v
         bZjSXY6Opi1o09GZWegv4fNjet47VlSGJuDwZzXUXbDb4yJnXPi3AffrOVSnmAOKdk/e
         BM0p0TUa5qyfC3BdxMyV1fdB0+NaW3GXW73J4QZMoHoZRpXnaHoZeyxNbIG+5tSnkluz
         81lA==
X-Forwarded-Encrypted: i=1; AKwUvBz2Wd1y8wSjxwcRbnNmRgNSu82Hp1NbEdAOb5Y3PZnJpUnA+6uU5g83SjPago4VrfTg07lMKr8=@vger.kernel.org
X-Gm-Message-State: AFuF++ngx5OmEEEajNqF4+h9DiSdewqs7qlF4DFDnyccJD8EGtwN5tJJ
	zDWNESkyNxkj0C92qiRl+IbsRU0D3qW4oE0vvknyAolFTgT2JD60loDP
X-Gm-Gg: AYBFou21aC8X4F5INuTe5D6SmPGjEJlpcZa5tPIh6RspN5vn+6By5PtCxJmS4RRtN2G
	so5CPXoLE9KcqRLOjA12sNX5UrtsVt5SvoJe/CExljOnZgvFOytIlFqW1IuQHHLBcsTm0s+7dI9
	5L4ag2S3Ao9xQ5/F8V42/Iu7JLD9vqLF1ArLaeJCf4V+dbKpNDODwCTGASOxFk3jcX3pROdwI/6
	suUARzjiUKW7sQOUeHPNTa0HEwZrGAI8NXD37mVwTxy0W5NHLzT+qEoOVsWyuOAfRwC+oEB7X/R
	KXbU+9ODj9QhbR9soUCRoRmjQobUnQvqwup7/ri+NPaqVbd3xEEvtNcNbCDxRW9BrRkn2OulA2E
	tmzBaiPYVlikBlynVliaYGeUZP0ZvwJlKecXWwqnEx6JzoIW7WC8TOkKjkIwxXG/jX8oFxnqdAf
	EpWS64pgtO6idn92QbDfzPfng24wi0oqNLP/ugq3IKsln+o6IWFS4RpifX2vUes6rcsGzrboi8Y
	G9ajjWD
X-Received: by 2002:a17:90b:1d52:b0:398:dcef:c040 with SMTP id 98e67ed59e1d1-39b26242a20mr59997599a91.19.1789027834038;
        Thu, 10 Sep 2026 01:10:34 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770bc9f5sm4442434a91.2.2026.09.10.01.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:10:32 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/2] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Thu, 10 Sep 2026 16:10:19 +0800
Message-Id: <20260910081020.86227-2-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910081020.86227-1-zxyan0222@gmail.com>
References: <20260910081020.86227-1-zxyan0222@gmail.com>
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

The auxiliary snapshot FIFO is also reported by the persistent ATSNS
count in XGMAC_TIMESTAMP_STATUS.  ATSNS is cleared only when the FIFO
clear bit (PTP_ACR_ATSFC) is set, so it is immune to the destructive
reads above.  Poll ATSNS instead of TSIS, wait for the ATSFC clear to
complete first so a stale ATSNS cannot be observed, and derive the
count for the FIFO pop loop from the value the poll read back so it is
guaranteed non-zero on the success path.

Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..ee6f28637878 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -340,6 +340,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	/* Release the mutex */
 	mutex_unlock(&priv->aux_ts_lock);
 
+	/* Wait for the FIFO clear to complete so a stale ATSNS count from
+	 * a previous snapshot cannot satisfy the poll below before the new
+	 * snapshot is latched.
+	 */
+	ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
+				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
+	if (ret) {
+		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
+			   __func__);
+		return ret;
+	}
+
 	/* Trigger Internal snapshot signal. Create a rising edge by just toggle
 	 * the GPO0 to low and back to high.
 	 */
@@ -349,9 +361,17 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 	gpio_value |= XGMAC_GPIO_GPO0;
 	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
 
-	/* Poll for time sync operation done */
-	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
-				 (v & XGMAC_INT_TSIS), 100, 10000);
+	/* Wait for the auxiliary snapshot to be latched.  TSIS is a
+	 * transient status bit that is set by any MAC timestamp event and
+	 * cleared by reading XGMAC_TIMESTAMP_STATUS, so it is not a
+	 * reliable completion condition.  Poll the persistent ATSNS count
+	 * instead: it is cleared only by setting PTP_ACR_ATSFC, so
+	 * nothing can clear it while we wait, and it reflects exactly the
+	 * snapshot latched by this trigger.
+	 */
+	ret = readl_poll_timeout(ioaddr + XGMAC_TIMESTAMP_STATUS, v,
+				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
+				 100, 10000);
 	if (ret) {
 		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
 			   __func__);
@@ -364,8 +384,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
 		.use_nsecs = false,
 	};
 
-	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
-				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
+	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v);
 
 	/* Repeat until the timestamps are from the FIFO last segment */
 	for (i = 0; i < num_snapshot; i++) {
-- 
2.34.1

