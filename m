Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF74195A1
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224477; cv=none; b=A3PALO8QTXEFTv/CFSwmIwcJqvuCE/XP+0yru/QjQ6dtqkn8w+fCrvdFNz4SkgnC+CVogHOfY9WNkQ6BTJ8U8slY6TU8/irbG/cW1SnukAYuPXx3xPZ0AoW1AZbMbaqAYuDwn6FgNCPXgWi58XKdxA4K47FycWHkqdngUH1R/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224477; c=relaxed/simple;
	bh=0Kx8Gd725wpyS63x5QxMhg2JWPdRrXuRnIUd25tfkeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFuYknVQ4qgax+0RmzESb0L+Ym9WoD0gaUU7Qoo/pE9O/Wjqqb4Q+jWfroHh887RPG8mYXF3ntaGKzDG2F65HDJweL9YJIhHEqpTu2U8VQZyqfwXg2TL9aRv+MK+wHB4JKe/AkF7AY286nGSrex+ow6x2BuUqhElcdTdShtEbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTiJcdWF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTiJcdWF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2470082a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224474; x=1787829274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uW/q9Ab1Wexm210w5L+2fH7SlAGlBFRAkle3jNwLoEk=;
        b=eTiJcdWFKYOOOHpzX1of7WTNClMG3XbuzzAt/hFGrNQEvIS2kFX3t4N0SESQAWQcyT
         rIqqr5bGSGun2dr1TJZC0eEesFmGpxIBU7DxvkgBRHQ7FW7KyyS7ejGovDnPvKs1r9yv
         GgnUlfowrCz7c0tmkscbt+csgGi8LIMLj4uBZbmVwId5Cfnjtw2TQEhZqMc8VyJbmaXm
         eq9kgpGx1nPXgfptZlVoDFD3fjYP0w2441CBSd6oqeA3hdyKIaTlsjTg5kx5K88j0tdK
         DFyojIL7a2MYWAgjfu+4vxJNXfJosxGG9kZTGhe7j1301HKOZE2b8QFV7Eo2V4VksRGs
         DfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224474; x=1787829274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uW/q9Ab1Wexm210w5L+2fH7SlAGlBFRAkle3jNwLoEk=;
        b=XEYxuBgy//7d0+hF7MbY+Lys143Cy3k4+sVtG+s2xIOn+1wf21ZqCFHBA5mXl9BH3d
         3VLy6mCFL9Z0DQoBaNbEE2HpzZ5/cVw7nzOLwnvk4TpDhxX14+qb4bCF/X0kVdiICUb1
         Dikrj3LdU+6WUX9uFNPP1pPLldtka3ydXdIEXtRX8nKVviRQ//SazyuEwHr03UfgCjs+
         I0wnxBxjQZ4PNOx9uMX1QWfbgVMNQp/tXypKBSexxH2u6CY96HaS/Z7gFaq6klQR+I5z
         sXD5oA3OVNsNYcOUQe2pYDb597ycyearRf27X1vhAx5pwCc00ivcajiAB1My7rcLGKKj
         r0Eg==
X-Forwarded-Encrypted: i=1; AHgh+Rqh8l0XCdPFeFKiEs/G/cL6S7yfhKG1PZ4zGYSF5KyuKYnJjnPekon1GS1mvlCBtQIGADEOA4s=@vger.kernel.org
X-Gm-Message-State: AFuF++klw4OLpmbYGPWpUqVD4FZpe9mc/eh+t0llzvSu3djjCfeicnWw
	q8bEbHXGV+JqUiGcOw5IC8yKGnqluhIMmZFbEDytJjTJGmHzrM5p3hWr
X-Gm-Gg: AR+sD10cz3CHS/oVIV1ulZpoLg9/22bxfqzvuFBGShHf/BD0JezQyg8wVXqgosifKV9
	aa8wDlz+8l5a3cbkp3QavftxQgOMcYl1W7Z43xHfpZ1d6i1EUBKF4ONicJS3LIw05enRCu7z9Wf
	KUOE4MFM0Qny5HBW0Kk2QOtQ9ldDk4OdGMRZGFqqu9zKi923PJpOaFgCDZkZjjNU0Hs6lk/dGxI
	lTt4VZenrAwRt4gWKxFOtgZJmRKqv0X3nz7WsUzIJqiStiFVJpIZBDRR0C2uHIzKxKpOM4HMVnL
	AsqCx/kv9kmI2UQ3SVtfqq1E0+uEGBGRoMUGTK3EafTc0LejrnSLrJhNN1XA2W2ALINycnQsk9R
	xjIk8c9ORXcYpNi9QwkN5tJMAuIDGRIVLwxfRtTX7cApZ82v/dvcL2G0Z7LSX6xygX50DtG+Ws1
	/kETNs1H1Xnt6TInIf3ntZHXeQBwDI6HMI4bwr/WCMwZGUpYIoS38x2M4NJkpGJxnkPHAjWEvdL
	Cy79EMUXTWsMrcEfvIzCTFdLjMMp8tke2YP+R1hrUT1pHkO+N6xLhvd8OKPxlnk08KiRl/Wms77
	Ol86
X-Received: by 2002:a17:90b:3c8f:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395810e9626mr24040537a91.15.1787224474148;
        Thu, 20 Aug 2026 04:14:34 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395ada57c39sm719965a91.3.2026.08.20.04.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:14:33 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/2] net: fec: Propagate PTP initialization errors
Date: Thu, 20 Aug 2026 18:14:15 +0700
Message-ID: <20260820111416.97917-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Change fec_ptp_init() to return an error code instead of silently
ignoring failures during PTP initialization.

The PPS IRQ is not required for the FEC/PTP functionality, so its
absence should not make the probe fail. However, an unavailable
optional IRQ should be distinguished from an actual error returned
during the IRQ lookup.

If a platform does not support the PPS IRQ, it can omit the IRQ from
its device tree and the optional lookup will return -ENXIO. Propagate
other errors from the IRQ lookup instead of silently ignoring them.

Also propagate failures from devm_request_irq() and ptp_clock_register().

Update the function declaration in fec.h accordingly.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/freescale/fec.h     |  2 +-
 drivers/net/ethernet/freescale/fec_ptp.c | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7176803146f3..8831da37326b 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -692,7 +692,7 @@ struct fec_enet_private {
 	u64 ethtool_stats[];
 };
 
-void fec_ptp_init(struct platform_device *pdev, int irq_idx);
+int fec_ptp_init(struct platform_device *pdev, int irq_idx);
 void fec_ptp_restore_state(struct fec_enet_private *fep);
 void fec_ptp_save_state(struct fec_enet_private *fep);
 void fec_ptp_stop(struct platform_device *pdev);
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..8ad680411b0c 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -736,7 +736,7 @@ static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
  * cyclecounter init routine and exits.
  */
 
-void fec_ptp_init(struct platform_device *pdev, int irq_idx)
+int fec_ptp_init(struct platform_device *pdev, int irq_idx)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -779,26 +779,29 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 		      HRTIMER_MODE_REL);
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
-	if (irq < 0)
+	if (irq < 0) {
 		irq = platform_get_irq_optional(pdev, irq_idx);
-	/* Failure to get an irq is not fatal,
-	 * only the PTP_CLOCK_PPS clock events should stop
-	 */
-	if (irq >= 0) {
+		if (irq < 0 && irq != -ENXIO)
+			return irq;
+	}
+
+	if (irq > 0) {
 		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
 				       0, pdev->name, ndev);
 		if (ret < 0)
-			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
-				 ret);
+			return ret;
 	}
 
 	fep->ptp_clock = ptp_clock_register(&fep->ptp_caps, &pdev->dev);
 	if (IS_ERR(fep->ptp_clock)) {
 		fep->ptp_clock = NULL;
 		dev_err(&pdev->dev, "ptp_clock_register failed\n");
+		return PTR_ERR(fep->ptp_clock);
 	}
 
 	schedule_delayed_work(&fep->time_keep, HZ);
+
+	return 0;
 }
 
 void fec_ptp_save_state(struct fec_enet_private *fep)
-- 
2.43.0

