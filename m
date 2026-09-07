Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835F35838E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752722; cv=none; b=s9EmJssX5wQc9EXr/GTNYj9CJBCVWgfIq36kXguxUv7wFxsqd9ipNrWSogcKUgrRK0TMuu2RGc8soc0c/JDjDOIOkE2b0osZOqQkFk5XwfCZy16GIwtm8t0Mj2YhSeelcLLHtCiGHaOeNQ23Ac03bmz2ftm64VAkO5UNJWthh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752722; c=relaxed/simple;
	bh=0pTtA8upWK02dFZ0yP0XB7/JJ7MEN1jwB45G87JhvOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6pksr2qlutJ+vyiaf86B1I7K5FQYhI651m6ViGICUjp9BuwUgNo9S3ojNw3UJmktKP4vv8tzC5JBYJyG1H7K0fI2JmYMmIFytqOErlEZLFjNO57gE1IucTUIKcboWCDf8gqK9UheNvTw/imeUpUD5y0y8Xgd/zxymWAJTCzsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0j3IBXZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0j3IBXZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2175769a91.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788752720; x=1789357520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0EzdYV+POHnT9TuHWNLPzv6lYbvo3yRcxw8sX8142Hc=;
        b=F0j3IBXZBfSZmiw7rLS0GHp70CMMZEG/3dPfHlnYiIsZJM+0wcIz2ut4YuDq7z5pHW
         CCTnHgfZahnoXQ/euD4Cqf2SDRpC87pYuE3vzeyXO4cTDID3UaQgJk5gLAYzQvaPcu2W
         KwQMzqHB1KecTSk7VjU8FtTXDW/FcQyeQx8BH/Q/QNdLQXevs6aV4NE8aJzh64/OSyM/
         325M8SpvgA0dELdNRxsXuTP/mLJ7DgHnSu06fuzg0EXbgeX7pYwoS9ZXIlrUNWWjuN/X
         wId/Zq7WwPjBZgCJMLJrUlHgVT785vXF2Txbtt+OJnmxb4Fxgfx8lfdiytZjMmIMqup2
         7nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788752720; x=1789357520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0EzdYV+POHnT9TuHWNLPzv6lYbvo3yRcxw8sX8142Hc=;
        b=iEFeuATA5wnkNbHnLd+RXiGVHe1vzUGevNBVjIhmSAWccLOZ9ZeYWv7ltEppi15Y38
         QBzqrla0UNveq507QYkPDwlUM2RWXt8pZeLyHQieo20zvDFQsLKDxyMTJRL0xONfRB4c
         NvZBBy3N6SPzQBbWh1fNi4qnjFQm0Fd3XhmlmclFGRrzgrG7jmfACptu/B0muarW6bWX
         YWhktJbIKReZuyMHSsXeb2BF1KXD7wWXpwD29nsQHxDuxyKPz6WiHIhF6HBR43s3sxQe
         82d8R+2163xjzOxD14MCBJeGlbwWN0oNKx6+vu0rbwKpalo0QPYJW6hP5mw0SIispxZo
         Tigw==
X-Forwarded-Encrypted: i=1; AKwUvBycE2wJrwQyk8HrlBoIgyXPFGfEfvS8BqxuYG0Zha8RFaL+rkK3xRhTOur+NXHzXGhVjkX19xI=@vger.kernel.org
X-Gm-Message-State: AFuF++lZoNKpyUhN9YPF2epLEFU0yC33GUdHG47PN/iDYXqSL2BaYGmI
	GwQ7jTJSzsVPW7E9E68TdlXK/kH4xFKILNHJqchlUUTlgnQlL8kzL3x5
X-Gm-Gg: AYBFou0ri8WrOXV8FFt9eu4nraOxR7a60YNpDKADJ+oU48ZITK2JADY+QcpAgB3V7lb
	WCQd8ENVq6Ym+8W757nsF8A2ncn4iOZ32+7gXB+hO2TxZIXSKZJ/aX/7a35RKKURhrPjzH1tQxa
	7b6ZCjMlVhPI760zeWN9kXD/AVli19FvSrs8mOV1rwDIqRMGU4vviGcoFov06HFZ357SqDfuGE9
	6sENrIBmL8VEUHotfaMvyDUCX+gLDiyK7ZLnx+CddxiSZV/JK9v3kqMPPZtbXZgd+iYdnoWLNkX
	/z9J2F+6U6EOm1gDGhhbuPqOidltMmfJsRG3tuIxPAJ0vJZJemRAP4/RjZ9oNip2pwLOyxts/WE
	kGHWqR1iB9Ii6QsSVlt48l7E86yMZeoHlRX/KxOb/dTvZyB0S3UGzYMqAiVQUrKjzYJ/EDvl4XT
	3ByYeJ9Oop06EP+ZsHqz2+aRVeG3aCcUZVUvUNyPa30qWdI/cIF2HUbufdLUrtHtsf6tBCqZZge
	3H15qmY/AW7aAJUt93rrOiPcrGhFW8uBHW/i+l9D7IE9ABFJ/1AW+HiO3tps95xnhvo7wEtE1ds
	LrhB
X-Received: by 2002:a17:90b:4fc5:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-39b26190c25mr31416637a91.6.1788752720474;
        Sun, 06 Sep 2026 20:45:20 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm28237273a91.14.2026.09.06.20.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:45:20 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <swboyd@chromium.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net v4] net: fec: Propagate PTP initialization errors
Date: Mon,  7 Sep 2026 10:45:01 +0700
Message-ID: <20260907034502.12619-1-phucduc.bui@gmail.com>
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
In particular, silently ignoring -EPROBE_DEFER can cause the driver to
continue probing instead of deferring as required.

Also propagate failures from devm_request_irq() and ptp_clock_register().

Update the function declaration in fec.h accordingly.

Found by manual code inspection.

Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional() to avoid error message")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1: 
https://lore.kernel.org/all/20260820111416.97917-1-phucduc.bui@gmail.com/
Link v2:
https://lore.kernel.org/all/20260903092430.354186-1-phucduc.bui@gmail.com/
Link v3:
https://lore.kernel.org/all/20260904105542.70540-1-phucduc.bui@gmail.com/

Changes in v2:
 - Squash the two patches into one.
 - Add error handling for platform_get_irq_byname_optional().
 - Fix error handling for ptp_clock_register().
Changes in v3:
 - Retarget the patch to the net tree instead of net-next.
 - Add error handling for platform_get_irq_byname_optional() 
   in fec_probe() for the fec_enet_interrupt IRQ.
Changes in v4:
 - Use a goto label for cleanup instead of returning directly on errors 
   from platform_get_irq_byname_optional() in probe().
 - Update the commit message.


 drivers/net/ethernet/freescale/fec.h      |  2 +-
 drivers/net/ethernet/freescale/fec_main.c | 18 +++++++++++++-----
 drivers/net/ethernet/freescale/fec_ptp.c  | 22 ++++++++++++++--------
 3 files changed, 28 insertions(+), 14 deletions(-)

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
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 794ec427b0ee..f7636f23d1eb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5384,8 +5384,11 @@ fec_probe(struct platform_device *pdev)
 		goto failed_reset;
 
 	irq_cnt = fec_enet_get_irq_cnt(pdev);
-	if (fep->bufdesc_ex)
-		fec_ptp_init(pdev, irq_cnt);
+	if (fep->bufdesc_ex) {
+		ret = fec_ptp_init(pdev, irq_cnt);
+		if (ret)
+			goto failed_reset;
+	}
 
 	ret = fec_enet_init(ndev);
 	if (ret)
@@ -5394,12 +5397,17 @@ fec_probe(struct platform_device *pdev)
 	for (i = 0; i < irq_cnt; i++) {
 		snprintf(irq_name, sizeof(irq_name), "int%d", i);
 		irq = platform_get_irq_byname_optional(pdev, irq_name);
-		if (irq < 0)
-			irq = platform_get_irq(pdev, i);
-		if (irq < 0) {
+		if (irq < 0 && irq != -ENXIO) {
 			ret = irq;
 			goto failed_irq;
 		}
+		if (irq == -ENXIO) {
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0) {
+				ret = irq;
+				goto failed_irq;
+			}
+		}
 		ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
 				       0, pdev->name, ndev);
 		if (ret)
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..557a76797eba 100644
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
@@ -779,26 +779,32 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 		      HRTIMER_MODE_REL);
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
-	if (irq < 0)
+	if (irq < 0 && irq != -ENXIO)
+		return irq;
+	if (irq == -ENXIO) {
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
+		ret = PTR_ERR(fep->ptp_clock);
 		fep->ptp_clock = NULL;
 		dev_err(&pdev->dev, "ptp_clock_register failed\n");
+		return ret;
 	}
 
 	schedule_delayed_work(&fep->time_keep, HZ);
+
+	return 0;
 }
 
 void fec_ptp_save_state(struct fec_enet_private *fep)
-- 
2.43.0

