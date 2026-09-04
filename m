Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CC470426
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519362; cv=none; b=ovf5OieM4oA/dCNfS6RGNcpTpb+E1x3VgtPW8jYoMVvZAwElm01RqJJWOz6UFTbKdKZkEAZHX+BfJjmus1mBoG5Q8YlPBethNwHYHO3hiUHRCXrvyvivIba1st97sePFVCJg8KSV8WEPIEoA2l91f22E0ZVunVZvqDC6MLQXfV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519362; c=relaxed/simple;
	bh=v/kjOdY5Lu1zx1XvZRZFRlrggOLQEbcgXqmMq7HMqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uawznGlmXX9DrtXVAttCia3v7ckqirPIb6Q6mJhgOls4HsgSoDkox5r2Fk4YpN4L5NdqK3jPlLSsEArFi1L4LZ426NbKuzKBQxDAleO9tOasC6u1LuSIB1v5YrvO3KUO0zbSUWKWN1M8MitUjop+W+qt4d00232MqsKxauCQ21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvtWzbst; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvtWzbst"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-395cf2535acso951632a91.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519359; x=1789124159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VKYmUlTOqIu/1cBSCueueKVNw/xbCQqglwL7pQcSE8g=;
        b=RvtWzbstjTqLvkEiFx0fZfqyw50Y/66L5Ph72ANnoag967aBk+QGAGV0lODjMniCSU
         GRIzyDsG2Qg1Hh9WwdG4ccB2Ijmt3DWJo+zOytJJaeT7NCrsiJ8bis84rAMU+o/V49/3
         Vk1QaPxx2JWufg/voxftEFitFXopdVB2NNXzIg8kpwFlNqMXvIbLdIU2qAECOAT4fSa7
         jSx9L1K9xHUAIhl2lKTkW2tZmgAgbPx+JVdteg5PPIDtr3Qd7QgqO6c+aPSLos9awxHj
         k3u46LQj3gyscvq/7fiR/SqkZ+2+A2/FFq3yixcXrQKrxvBgCVfTtY9kwb2SIFOv+NYb
         fh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519359; x=1789124159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKYmUlTOqIu/1cBSCueueKVNw/xbCQqglwL7pQcSE8g=;
        b=pPtj5UKUIGHYEWqiCXGmbCIpWKYbQ/hwgQg6ouSIa78fb9VO0+iD8tqr10ytgcWfv8
         qceuWPQK5rPyQjpurUVAHcR35ZV1yi/+cBBC68CtUgWRgf2APLeYazI/UBO9G3OOQPUD
         Jk1C1ZfH2/si5ss3NXsa+K6Dg8NvrYRhuEvYzIut1xwVSGPKUlHx+i76TqDMi0jUVmBX
         N3o5ALrrP5AquWmIvjrEX4qVqMlVpocy3UZIQz8YIJcA016N6Bli0Rqw9dVoxi4+LjjZ
         +qSwPoJNvHvA+X3Pz3uaF7lXdIZJfGzxfXhyQVaVBhLJWmF9IP2b5oWCt0ulLDYterxB
         gmLw==
X-Forwarded-Encrypted: i=1; AKwUvBzJloe4gWFlmXR3licqU1Wzbo2eEduH+wysQ3rO/n/w5mRfTQGKlY/Xe0IkCHTUi+Yamnc1eOo=@vger.kernel.org
X-Gm-Message-State: AFuF++l52aEAGEGq+xx4Ad3WF4C6Ac3r+pVKT7X29UBQvr+2Ug6qZhEa
	LXsSnWOXOVj4osZI1PDAvpjj/HMF7TVAs2uGNMqbeaMCNanxjSyWQKTf
X-Gm-Gg: AYBFou3QOR733ZWRauc0V13lFaEkHsE4DtOBy24lIv3r7hbcMWwMjRb1GGQNtFFTKN5
	1hz8/r8Fy7Q39A1ANK8dXwnSJ0RQh4pmIQPeOXcgqvqYgWRavyznpnlteLDfHI3yY+5NESg4gJ5
	mdoXbLDShv7K+3r3/8gBVF4XEKj2m6ziaZJ28WCe62obnuu+jL6/dv/sUqTAXE9LrUSMSE+tib/
	VPXCQdAZkJkrYVfu1jdyz5OizwC1ywVei6CVbUwN+LWzCHlkMgLqLYW7OWY9lZ3n9Yf48u3voDQ
	dcCvJRijDdmpYJwDa5VIy0/Y/B3ZKkqBzCafBEN33G3+EZe4sentOLoOmkBst0UF2p57P29FySl
	4yMnjepDYqM8CpWpkutnxhYb7iQFj/myvow6k2tjMWUG/0UCD9ChGS4/HiuZNS9cMmdsjLzvM9k
	IfYlit3HW/YIXhe/Jzlh6Uy3MMcUFjncqxPwE1+x0nrbeED3vbJHDDrE1VE8ro4SyKfoNcawnZU
	rGvuINU8jVpIm1nFBnxkB2s496oezbBYnxiMU3teUwuJp5pO0YZcdxoD1C78nG2JElDhJlNlW/5
	q42YJvIUSl7Bllr3
X-Received: by 2002:a17:90b:3b41:b0:398:9bd3:d6d2 with SMTP id 98e67ed59e1d1-39b27ea25b9mr3194454a91.12.1788519358927;
        Fri, 04 Sep 2026 03:55:58 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612ba2bsm3842279a91.14.2026.09.04.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:55:58 -0700 (PDT)
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
	Stephen Boyd <swboyd@chromium.org>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net v3] net: fec: Propagate PTP initialization errors
Date: Fri,  4 Sep 2026 17:55:42 +0700
Message-ID: <20260904105542.70540-1-phucduc.bui@gmail.com>
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

Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional() to avoid error message")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Link v1: 
https://lore.kernel.org/all/20260820111416.97917-1-phucduc.bui@gmail.com/
Link v2:
https://lore.kernel.org/all/20260903092430.354186-1-phucduc.bui@gmail.com/
Changes in v2:
 - Squash the two patches into one.
 - Add error handling for platform_get_irq_byname_optional().
 - Fix error handling for ptp_clock_register().
Changes in v3:
 - Retarget the patch to the net tree instead of net-next.
 - Add error handling for platform_get_irq_byname_optional() 
   in fec_probe() for the fec_enet_interrupt IRQ.

 drivers/net/ethernet/freescale/fec.h      |  2 +-
 drivers/net/ethernet/freescale/fec_main.c | 11 ++++++++---
 drivers/net/ethernet/freescale/fec_ptp.c  | 22 ++++++++++++++--------
 3 files changed, 23 insertions(+), 12 deletions(-)

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
index 794ec427b0ee..a9a458703547 100644
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
@@ -5394,7 +5397,9 @@ fec_probe(struct platform_device *pdev)
 	for (i = 0; i < irq_cnt; i++) {
 		snprintf(irq_name, sizeof(irq_name), "int%d", i);
 		irq = platform_get_irq_byname_optional(pdev, irq_name);
-		if (irq < 0)
+		if (irq < 0 && irq != -ENXIO)
+			return irq;
+		if (irq == -ENXIO)
 			irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
 			ret = irq;
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

