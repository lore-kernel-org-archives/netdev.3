Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB83B14AA
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789537734; cv=none; b=kBKS9KZ5vzzR6wYUpsJvh4SMokOBAC9BzNOD+gOPxaEUb2gOPgyBJPzbUyjpEK9qt+B2EiNpj2nAqMrCGBsX9rT/4Avg5IWbS8owmH1lh+1/p6RQ1xPqBeKbhrgO9Ee3JgLmJZlgfc5cEE+4Bmdp874OYCdz8AGv4n60Z6NTFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789537734; c=relaxed/simple;
	bh=94nvxhOshxi6ufqrH6q/eu2eWcit7hP31npYKzDwW8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbwfoYcrr0PEebphYw5tU/iyFepfiY+EakzH5wKhZSPoW2Q0ssA2VnY147bZo9me3oPqTKVmeKAh/FLCWGGqGztBUD/6sl4H2H3lKMnBUqeefJQtY+pgSdvv2nAez8AcMyOLI46raM8zbKdJExq/cCBBOjAtuudho1ubxY0RRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar95APX2; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar95APX2"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so72899a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789537731; x=1790142531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ygYLSmyhlt34Q/MQJdhd0/XySuEC8UfGpdbWkhO4AAw=;
        b=Ar95APX29F+IVRPFYanadFUuihZ/nv1mYpYiqon6PaXZ56+1C2/ZmXKCCo95M6URNF
         QvBFBu83bpMrEUgIzduQ1dfNW+f3eQtv5XBmEfZXK5vieHjQqgaGViZDa28+LhtWL7Wh
         yJNbk4/FarrwB78kHgNiiOsE1cB+u9g6jPHClW7+33A01N1/F0JGrjUDrl//BR7TEdbK
         H7vieXiqE8IHyC3/0d29K2ZRLezPY+7lvLOur2ogBe3yawWa7/1yf0fHRHVsOrqt7sv/
         Se6iovtdyfHS9pMX4FildGV20T9kNZ9Qqaz6b2XwMOahb7UoXN1NsUXcmfNraxAht2kM
         4vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789537731; x=1790142531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ygYLSmyhlt34Q/MQJdhd0/XySuEC8UfGpdbWkhO4AAw=;
        b=YWdzY02QBeKs5Q5iICTZrG8Rtm9Oghki1N6kwmCAtlgwh96NwR0jVnV9KXw3YCPt01
         IdgycGFwA9l1ESM9faODxKp6J1QyeajAHhlTYvWIM0n1JSGJ/VABdWyY5Rv09CPr8A9M
         2hYfsIs2BsoukYh4KcZ0VC71mxRawi/f3s92jLDdt8PInTgNG5z25E1vi20yKjMnZoJw
         h2PXy5erdl4MIlMYtmLtlQBTkJis3RZLFV1i7S4j8tMJ2Yn7oRyL5k3rMXD/GNIhdC6C
         k/gyXl6ANmPYPWd8b8ufXN6iV82apelGRpdybfFkwduu51+HES88Btjn59yxT5EOuuly
         GEjw==
X-Forwarded-Encrypted: i=1; AKwUvByF7yVpVIh0kaKb0M6vcL1i9Jitg9wtVg40CGFo6UCNem5YiG/iLmKI3Huv/XO/Q7fdx9W9RFU=@vger.kernel.org
X-Gm-Message-State: AFuF++nc13cJ/0xvOZdEnRend8jK0x5+ZMr7DIhw8E0UXKgNhqMWo4tO
	6RmWo2zemcZ/Jhmq/lBWdS2+TCUrM723M6b5w8/5xduVDGPmSHCFsi64
X-Gm-Gg: AYBFou2INKWgx9hTz1zdiMsX5fh3UCYhELecqZnhTxtl7YEom+7DUEqCliX33XRHjqx
	Cl0fOfnMUuVTmEGkLx0CwC8Ini6Kf9Z28rJtFElP8lfJ9RGaOYY2vUMfNDhxyUkcphPVs1gIcDm
	7PC9IAb5HK2YPv+elfB56m1oE1Nsnmqc1T/VWrPNwA+AR97g+giMUpDvAmx8Bc5YME9obx67a/h
	Aoyfyp5n5MVcZ9kr8sG6ljrwVyb25uwFGB0XLsPU3KQg2Dzh1YzcXHopyFsdnr6mfp4yInV62ID
	c9cCliGL6AUr9/T12/qvxLg9B29BgNbOPE6Aul1fgTig125vxT8l9L5XA3SonpojTDXy378j8i4
	kMwrTfRgvF7qclOyDMztEZfs0xq37fznBaET75FzF/+KJXZxwYVzo9ZgqozOMzSxo78qpUkq4VW
	zXbNd04hDJxGMudw2hgc1WXKbCfikBcOJ/LN1H9HwmuImPSkb00RDYIg==
X-Received: by 2002:a17:90b:55c6:b0:39e:238a:be0a with SMTP id 98e67ed59e1d1-39e238ac14bmr758249a91.16.1789537731220;
        Tue, 15 Sep 2026 22:48:51 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b712ea3sm2659622a91.9.2026.09.15.22.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:48:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Byungho An <bh74.an@samsung.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siva Reddy <siva.kallam@samsung.com>,
	Vipul Pandya <vipul.pandya@samsung.com>,
	Girish K S <ks.giri@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: sxgbe: dispose IRQ mappings on device removal
Date: Wed, 16 Sep 2026 13:48:41 +0800
Message-ID: <20260916054841.2908429-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sxgbe_platform_probe() creates interrupt mappings for the common,
TX, RX and LPI interrupts with irq_of_parse_and_map().

The probe failure path disposes the common, TX and RX mappings with
irq_dispose_mapping(). However, after a successful probe, the mappings
are never disposed when the device is removed.

Register a devres action for each IRQ mapping immediately after it is
created. This also guarantees that devres-managed IRQ handlers are
released before their mappings are disposed.

This issue was found by manual code inspection.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 .../ethernet/samsung/sxgbe/sxgbe_platform.c   | 41 +++++++++++++------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
index e4701b29e1a0..cd8d39a1afff 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
@@ -67,6 +67,13 @@ static int sxgbe_probe_config_dt(struct platform_device *pdev,
 }
 #endif /* CONFIG_OF */
 
+static void sxgbe_irq_dispose_mapping(void *data)
+{
+	unsigned int irq = (unsigned int)(unsigned long)data;
+
+	irq_dispose_mapping(irq);
+}
+
 /**
  * sxgbe_platform_probe
  * @pdev: platform device pointer
@@ -116,6 +123,11 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 		goto err_drv_remove;
 	}
 
+	ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
+				       (void *)(unsigned long)priv->irq);
+	if (ret)
+		goto err_drv_remove;
+
 	/* Get MAC address if available (DT) */
 	of_get_ethdev_address(node, priv->dev);
 
@@ -124,38 +136,43 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 		priv->txq[i]->irq_no = irq_of_parse_and_map(node, chan++);
 		if (priv->txq[i]->irq_no <= 0) {
 			dev_err(dev, "sxgbe tx irq parsing failed\n");
-			goto err_tx_irq_unmap;
+			goto err_drv_remove;
 		}
+		ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
+					       (void *)(unsigned long)
+					       priv->txq[i]->irq_no);
+		if (ret)
+			goto err_drv_remove;
 	}
 
 	for (i = 0; i < SXGBE_RX_QUEUES; i++) {
 		priv->rxq[i]->irq_no = irq_of_parse_and_map(node, chan++);
 		if (priv->rxq[i]->irq_no <= 0) {
 			dev_err(dev, "sxgbe rx irq parsing failed\n");
-			goto err_rx_irq_unmap;
+			goto err_drv_remove;
 		}
+		ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
+					       (void *)(unsigned long)
+				       priv->rxq[i]->irq_no);
+		if (ret)
+			goto err_drv_remove;
 	}
 
 	priv->lpi_irq = irq_of_parse_and_map(node, chan);
 	if (priv->lpi_irq <= 0) {
 		dev_err(dev, "sxgbe lpi irq parsing failed\n");
-		goto err_rx_irq_unmap;
+		goto err_drv_remove;
 	}
-
+	ret = devm_add_action_or_reset(dev, sxgbe_irq_dispose_mapping,
+				       (void *)(unsigned long)priv->lpi_irq);
+	if (ret)
+		goto err_drv_remove;
 	platform_set_drvdata(pdev, priv->dev);
 
 	pr_debug("platform driver registration completed\n");
 
 	return 0;
 
-err_rx_irq_unmap:
-	while (i--)
-		irq_dispose_mapping(priv->rxq[i]->irq_no);
-	i = SXGBE_TX_QUEUES;
-err_tx_irq_unmap:
-	while (i--)
-		irq_dispose_mapping(priv->txq[i]->irq_no);
-	irq_dispose_mapping(priv->irq);
 err_drv_remove:
 	sxgbe_drv_remove(priv->dev);
 err_out:
-- 
2.43.0

