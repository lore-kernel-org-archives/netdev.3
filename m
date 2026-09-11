Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7E246BCD
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099388; cv=none; b=NMLbFuVR1QX5OPAWuzsXkOxhaCOAZSgijWD7DzIxYe8qkfCPh2jBAWszC1F3f9RIGz2QE1SDOcsTZXlluViA3CnIToe6/odOw1zYrIKEgoUN0SlcfWzBzJOUKTVP+C0YAyqc1JRcm8TXa8DGEQ9LjZdF6ypNvYka15SHhJZMyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099388; c=relaxed/simple;
	bh=IgwObzddcAie/4ssXOHw1non08WFLdP49gahv5W1gZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAL131QlkPeSrhlg+sXtAho8nwUC1zWBBq0xJPJxOw4JYfSVRFzVCQ7ENCx+YQQpwSCuiMjDMIf1kQ3375dLIBhbGJEpzco1i98H4sJds2asfAzIo/hbByp35ioQSC5rzC1sCtKOvVsKhEuUte4Z4YWFKivjfvthkelywgUqdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7AJLMwF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7AJLMwF"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9865so3256335ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789099386; x=1789704186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl/50LVPPebfYkiCoTtA5M0k+XWm+DREmFNMY14yWU8=;
        b=a7AJLMwFsswUbr04Q4Fj2x5nrm7i3fxQBWauKDBW4OgK4662FyMD790uM+OZSjUwSK
         E60+HBPw0eCnzm6w7cTauDAkRzx7jZEB27NZNzPsSoNPwIdnZhdj2RR8/wc8fLXhpS3g
         kDNzh4yd5n0qQ65biOYLgMtBhPufMY4fOAOZudFKRkdBhuYVPcujmjyhjN3OynHDF6wN
         Jg2C/qYcB7qBepSTLLLwZFxubhrvPZss+L1ORs64qcImgIeQWDASndrNkAzeJkSOceWN
         EcQAuhYsPffBv0Hjrz0rF/K14ovGBXXmsxy/faZb0xJBaw1VVuudsdjJnG3M8KRYlFwb
         /fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789099386; x=1789704186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl/50LVPPebfYkiCoTtA5M0k+XWm+DREmFNMY14yWU8=;
        b=QWIGA1YdAaaGWkxMxkrWZu52dnBz5ldeJ2zsnL+wOdsgTcrtbkGj4mG6GeGlNOdAhz
         PqgiVLgkP08TQkyxPQ6lGo4NZ7nS4C2tBa4c5fkDarPQQZpjgLCRt6+CQMSFcUQeQD83
         PRFOUHSTVlsx30TkzkQc3ZcYVstgnXBR8rcMJ6odjL8KEJcacHczTfOh9UvM9LfYfTO9
         6lcrrgdZZdAnASYhoI6ocCOfA7yh5FbLWbLOghzN9mznDsl5wYScyBXso67V9sbAib/B
         0C4WrIw7KKaGjp+GnXu6+eihCPzXAfiAEdGf77sPX1LPBdKZ8Sr4rp4cg4WH7oy3qKBt
         221A==
X-Forwarded-Encrypted: i=1; AKwUvBxBzLfZ0CbImkgsib+ma4WqG6vNgFKlqjPeJdUNn5uevPMwvio+4S/PxbYwFFGnssXvlXszfKs=@vger.kernel.org
X-Gm-Message-State: AFuF++kANoftpm91hvGbaPLCQbE9Ftgw7na71iM/bogO0Tro5/GZC+nQ
	T0hgvfh/DepnH5t1GUtCJrC78N/5lIQ1nVbOT+IzdvGgzM2UvrNuYr+/
X-Gm-Gg: AYBFou2rQXXoWngW84BUK9xwqmdaG4WfAqIa4xW4EESrBFS+wB4CoSEFQWwS7b5ZOyw
	doKRiAcPGkPnnJ0r2kCHw9+LNcGMOJuF0LHERNfMogPSJQNd+AVAbXPh/cqXKo/c6ANTNnVnTyX
	YrpM776sloK4d5wCBwoqbRPV1rHAOMMKoGlCR1yUmwr2b+Yn4u/uDSgoS/R2BBf4vQ/efYlad5A
	IVGl8N7W65LQzu//6JpJxSvskPS7eBQjKqxUtQHVYyfZCaB29Uivq3/QXkltkag0mo4O55sqcnW
	OVQ/GglcDbSGUeC8A+5jxnOqUWkYCiVVfErAuv7CvqvR9+hgK/15WKrV1kD8ttwe1dGz6U5IS/T
	WL6sG+GB1VjhaCEMzj5a81BAbBx1XzQNi9GidgNGIYEbrZE6CQjPHY1RN7vMxDVt7nN1WfYkAOz
	1+LciqtTOBX5RY1cve9O1QJYkuvtRwO7SXL6fBqjhf/KJoRVDyCIHtzn97phU4w4u9YGrKbVyo1
	Ia8PLggr9gZhznfhlI2W47C8/VZzTDjBjS4v7cDGbcXkir8C5OfC58f1Ei+4qfknoa73d1GpSr4
	oDD9MAgg05Tz/Tc=
X-Received: by 2002:a17:903:2451:b0:2db:7269:38ef with SMTP id d9443c01a7336-2dd2a3362camr46154855ad.14.1789099385731;
        Thu, 10 Sep 2026 21:03:05 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc2d3bsm4670925ad.48.2026.09.10.21.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:03:05 -0700 (PDT)
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
Subject: [PATCH net-next v6 1/2] net: fec: Propagate PTP initialization errors
Date: Fri, 11 Sep 2026 11:00:20 +0700
Message-ID: <20260911040021.12289-1-phucduc.bui@gmail.com>
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

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1:
https://lore.kernel.org/all/20260820111416.97917-1-phucduc.bui@gmail.com/
Link v2:
https://lore.kernel.org/all/20260903092430.354186-1-phucduc.bui@gmail.com/
Link v3:
https://lore.kernel.org/all/20260904105542.70540-1-phucduc.bui@gmail.com/
Link v4:
https://lore.kernel.org/all/20260907034502.12619-1-phucduc.bui@gmail.com/
Link v5: 
https://lore.kernel.org/all/20260909064712.22539-1-phucduc.bui@gmail.com/

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
Changes in v5:
 - Split the optional IRQ handling in fec_main.c into a separate patch.
Changes in v6:
 - Add a KDoc comment for fec_ptp_init().
 - Repost this series for net-next without the Fixes: tags.


 drivers/net/ethernet/freescale/fec.h      |  2 +-
 drivers/net/ethernet/freescale/fec_main.c |  7 +++++--
 drivers/net/ethernet/freescale/fec_ptp.c  | 24 +++++++++++++++--------
 3 files changed, 22 insertions(+), 11 deletions(-)

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
index 794ec427b0ee..c6e29b5c2abb 100644
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
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..0574a1a18702 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -734,9 +734,11 @@ static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
  * This function performs the required steps for enabling ptp
  * support. If ptp support has already been loaded it simply calls the
  * cyclecounter init routine and exits.
+ *
+ * Return: 0 on success, or a negative error code on failure.
  */
 
-void fec_ptp_init(struct platform_device *pdev, int irq_idx)
+int fec_ptp_init(struct platform_device *pdev, int irq_idx)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -779,26 +781,32 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
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

